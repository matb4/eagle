import 'dart:io';
import 'package:flutter/material.dart';
import '../models/training_topic_model.dart';
import 'add_edit_training_topic_page.dart';

class TrainingTopicDetailsPage extends StatefulWidget {
  final TrainingTopic topic;

  const TrainingTopicDetailsPage({Key? key, required this.topic}) : super(key: key);

  @override
  State<TrainingTopicDetailsPage> createState() => _TrainingTopicDetailsPageState();
}

class _TrainingTopicDetailsPageState extends State<TrainingTopicDetailsPage> {
  late TrainingTopic _currentTopic;

  @override
  void initState() {
    super.initState();
    _currentTopic = widget.topic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTopic.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditTrainingTopicPage(topic: _currentTopic),
                ),
              );
              // We can add a refresh logic here if needed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_currentTopic.imagePath != null && _currentTopic.imagePath!.isNotEmpty)
              Image.file(File(_currentTopic.imagePath!)),
            const SizedBox(height: 16),
            Text(
              _currentTopic.content,
              style: const TextStyle(fontSize: 18, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
