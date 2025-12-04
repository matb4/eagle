import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/bird_model.dart';
import '../models/training_model.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late Future<List<Bird>> _birdsFuture;

  @override
  void initState() {
    super.initState();
    _birdsFuture = DatabaseHelper.instance.getBirds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحليلات الأداء'),
      ),
      body: FutureBuilder<List<Bird>>(
        future: _birdsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final birds = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildKeyMetrics(birds),
              const SizedBox(height: 30),
              _buildComparisonChart(birds),
            ],
          );
        },
      ),
    );
  }

  Widget _buildKeyMetrics(List<Bird> birds) {
    return FutureBuilder<List<Training>>(
      future: Future.wait(birds.map((b) => DatabaseHelper.instance.getTrainings(b.id!))).then((tts) => tts.expand((t) => t).toList()),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final allTrainings = snapshot.data!;
        final totalSessions = allTrainings.length;
        final avgSuccess = totalSessions > 0 ? allTrainings.map((t) => t.successRate ?? 0).reduce((a, b) => a + b) / totalSessions : 0;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            _buildMetricCard('متوسط النجاح', '${avgSuccess.toStringAsFixed(1)}%', Colors.blue),
            _buildMetricCard('إجمالي الجلسات', totalSessions.toString(), Colors.amber),
            _buildMetricCard('الطيور النشطة', birds.length.toString(), Colors.purple),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Card(elevation: 2, child: Padding(padding: const EdgeInsets.all(8.0), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)), const SizedBox(height: 4), Text(title, textAlign: TextAlign.center)])));
  }

  Widget _buildComparisonChart(List<Bird> birds) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('مقارنة عدد جلسات التدريب', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 1.5,
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<Map<int, int>>(
                future: _getTrainingCounts(birds),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final trainingCounts = snapshot.data!;
                  return BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barGroups: birds.asMap().entries.map((entry) {
                        final index = entry.key;
                        final bird = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [BarChartRodData(toY: trainingCounts[bird.id!]?.toDouble() ?? 0, color: Colors.amber, width: 16)],
                        );
                      }).toList(),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => Text(birds[value.toInt()].name, style: const TextStyle(fontSize: 10)), reservedSize: 30)),
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Map<int, int>> _getTrainingCounts(List<Bird> birds) async {
    Map<int, int> counts = {};
    for (var bird in birds) {
      final trainings = await DatabaseHelper.instance.getTrainings(bird.id!);
      counts[bird.id!] = trainings.length;
    }
    return counts;
  }
}
