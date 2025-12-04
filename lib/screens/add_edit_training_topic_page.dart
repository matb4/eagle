import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/database_helper.dart';
import '../models/training_topic_model.dart';

class AddEditTrainingTopicPage extends StatefulWidget {
  final TrainingTopic? topic;

  const AddEditTrainingTopicPage({Key? key, this.topic}) : super(key: key);

  @override
  State<AddEditTrainingTopicPage> createState() => _AddEditTrainingTopicPageState();
}

class _AddEditTrainingTopicPageState extends State<AddEditTrainingTopicPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.topic?.title);
    _contentController = TextEditingController(text: widget.topic?.content);
    if (widget.topic?.imagePath != null) {
      _imageFile = XFile(widget.topic!.imagePath!);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic == null ? 'إضافة موضوع جديد' : 'تعديل الموضوع'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildImagePicker(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'العنوان'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال العنوان';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'المحتوى'),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال المحتوى';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTopic,
                child: const Text('حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _imageFile != null
                ? Image.file(File(_imageFile!.path), fit: BoxFit.cover)
                : const Icon(Icons.camera_alt, size: 50, color: Colors.grey),
          ),
          TextButton.icon(
            icon: const Icon(Icons.image),
            label: const Text('اختيار صورة'),
            onPressed: _pickImage,
          ),
        ],
      ),
    );
  }

  void _saveTopic() async {
    if (_formKey.currentState!.validate()) {
      if (widget.topic == null) {
        // Add new topic
        final newTopic = TrainingTopic(
          title: _titleController.text,
          content: _contentController.text,
          imagePath: _imageFile?.path,
        );
        await DatabaseHelper.instance.addTrainingTopic(newTopic);
      } else {
        // Update existing topic
        final updatedTopic = TrainingTopic(
          id: widget.topic!.id,
          title: _titleController.text,
          content: _contentController.text,
          imagePath: _imageFile?.path,
        );
        await DatabaseHelper.instance.updateTrainingTopic(updatedTopic);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
