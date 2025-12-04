import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/database_helper.dart';
import '../models/bird_model.dart';

class EditBirdPage extends StatefulWidget {
  final Bird bird;

  const EditBirdPage({Key? key, required this.bird}) : super(key: key);

  @override
  State<EditBirdPage> createState() => _EditBirdPageState();
}

class _EditBirdPageState extends State<EditBirdPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _weightController;
  late TextEditingController _sexController;
  late TextEditingController _notesController;
  late TextEditingController _healthRecordsController;
  late TextEditingController _behavioralNotesController;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.bird.name);
    _typeController = TextEditingController(text: widget.bird.type);
    _weightController = TextEditingController(text: widget.bird.initialWeight.toString());
    _sexController = TextEditingController(text: widget.bird.sex);
    _notesController = TextEditingController(text: widget.bird.notes);
    _healthRecordsController = TextEditingController(text: widget.bird.healthRecords);
    _behavioralNotesController = TextEditingController(text: widget.bird.behavioralNotes);
    if (widget.bird.photoPath != null && widget.bird.photoPath!.isNotEmpty) {
      _imageFile = XFile(widget.bird.photoPath!);
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
        title: const Text('تعديل بيانات الطائر'),
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
                onPressed: _updateBird,
                child: const Text('حفظ التعديلات'),
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
            label: const Text('تغيير الصورة'),
            onPressed: _pickImage,
          ),
        ],
      ),
    );
  }

  void _updateBird() async {
    if (_formKey.currentState!.validate()) {
      final updatedBird = Bird(
        id: widget.bird.id,
        name: _nameController.text,
        type: _typeController.text,
        initialWeight: double.parse(_weightController.text),
        sex: _sexController.text,
        notes: _notesController.text,
        dateCreated: widget.bird.dateCreated,
        healthRecords: _healthRecordsController.text,
        behavioralNotes: _behavioralNotesController.text,
        photoPath: _imageFile?.path,
      );
      await DatabaseHelper.instance.updateBird(updatedBird);
      if (mounted) {
        Navigator.pop(context, updatedBird);
      }
    }
  }
}
