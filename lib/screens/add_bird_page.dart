import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/database_helper.dart';
import '../models/bird_model.dart';

class AddBirdPage extends StatefulWidget {
  const AddBirdPage({super.key});

  @override
  State<AddBirdPage> createState() => _AddBirdPageState();
}

class _AddBirdPageState extends State<AddBirdPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _weightController = TextEditingController();
  final _sexController = TextEditingController();
  final _notesController = TextEditingController();
  final _healthRecordsController = TextEditingController();
  final _behavioralNotesController = TextEditingController();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة طائر جديد'),
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
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'الاسم'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'النوع (صقر/عقاب)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال النوع';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'الوزن الأولي (بالجرام)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الوزن';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sexController,
                decoration: const InputDecoration(labelText: 'الجنس'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الجنس';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'ملاحظات عامة (اختياري)'),
              ),
              TextFormField(
                controller: _healthRecordsController,
                decoration: const InputDecoration(labelText: 'السجل الصحي (اختياري)'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _behavioralNotesController,
                decoration: const InputDecoration(labelText: 'ملاحظات سلوكية (اختياري)'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addBird,
                child: const Text('إضافة الطائر'),
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
            width: 150,
            height: 150,
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

  void _addBird() async {
    if (_formKey.currentState!.validate()) {
      final newBird = Bird(
        name: _nameController.text,
        type: _typeController.text,
        initialWeight: double.parse(_weightController.text),
        sex: _sexController.text,
        notes: _notesController.text,
        dateCreated: DateTime.now(),
        healthRecords: _healthRecordsController.text,
        behavioralNotes: _behavioralNotesController.text,
        photoPath: _imageFile?.path,
      );
      await DatabaseHelper.instance.addBird(newBird);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
