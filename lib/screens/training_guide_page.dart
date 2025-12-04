import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/training_topic_model.dart';
import 'add_edit_training_topic_page.dart';
import 'training_topic_details_page.dart';

class TrainingGuidePage extends StatefulWidget {
  const TrainingGuidePage({Key? key}) : super(key: key);

  @override
  State<TrainingGuidePage> createState() => _TrainingGuidePageState();
}

class _TrainingGuidePageState extends State<TrainingGuidePage> {
  late Future<List<TrainingTopic>> _topicsFuture;

  @override
  void initState() {
    super.initState();
    _refreshTopics();
  }

  void _refreshTopics() {
    setState(() {
      _topicsFuture = DatabaseHelper.instance.getTrainingTopics();
    });
  }

  Future<void> _showDeleteConfirmationDialog(TrainingTopic topic) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: Text('هل أنت متأكد أنك تريد حذف \"${topic.title}\"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                await DatabaseHelper.instance.deleteTrainingTopic(topic.id!);
                if (mounted) {
                  Navigator.of(context).pop(); // Close the dialog
                  _refreshTopics(); // Refresh the list
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل التدريب'),
      ),
      body: FutureBuilder<List<TrainingTopic>>(
        future: _topicsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد مواضيع بعد.'));
          } else {
            final topics = snapshot.data!;
            return ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () => _showDeleteConfirmationDialog(topic),
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainingTopicDetailsPage(topic: topic),
                        ),
                      );
                      _refreshTopics();
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
            MaterialPageRoute(builder: (context) => const AddEditTrainingTopicPage()),
          );
          _refreshTopics();
        },
        child: const Icon(Icons.add),
        tooltip: 'إضافة موضوع جديد',
      ),
    );
  }
}
