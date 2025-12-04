import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'helpers/database_helper.dart';
import 'models/bird_model.dart';
import 'screens/add_bird_page.dart';
import 'screens/analytics_page.dart';
import 'screens/bird_details_page.dart';
import 'screens/hood_pattern_generator_page.dart';
import 'screens/training_guide_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مدرب الصقور',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // Arabic
      ],
      locale: const Locale('ar', 'AE'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Tajawal', // Using a nice Arabic font is recommended
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Bird>> _birdsFuture;

  @override
  void initState() {
    super.initState();
    _refreshBirds();
  }

  void _refreshBirds() {
    setState(() {
      _birdsFuture = DatabaseHelper.instance.getBirds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طيوري'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            tooltip: 'تحليلات الأداء',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnalyticsPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.style),
            tooltip: 'مولد تصميم البرقع',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HoodPatternGeneratorPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.book),
            tooltip: 'دليل التدريب',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TrainingGuidePage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Bird>>(
        future: _birdsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لم يتم إضافة طيور بعد.'));
          } else {
            final birds = snapshot.data!;
            return ListView.builder(
              itemCount: birds.length,
              itemBuilder: (context, index) {
                final bird = birds[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Text(bird.name),
                    subtitle: Text(bird.type),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BirdDetailsPage(bird: bird),
                        ),
                      );
                      _refreshBirds();
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBirdPage()),
          );
          _refreshBirds();
        },
        child: const Icon(Icons.add),
        tooltip: 'إضافة طائر جديد',
      ),
    );
  }
}
