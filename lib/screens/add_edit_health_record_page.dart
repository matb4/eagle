import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/health_record_model.dart';

class AddEditHealthRecordPage extends StatefulWidget {
  final int birdId;
  final HealthRecord? record;

  const AddEditHealthRecordPage({Key? key, required this.birdId, this.record}) : super(key: key);

  @override
  State<AddEditHealthRecordPage> createState() => _AddEditHealthRecordPageState();
}

class _AddEditHealthRecordPageState extends State<AddEditHealthRecordPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dateController;
  late TextEditingController _recordTypeController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.record?.date);
    _recordTypeController = TextEditingController(text: widget.record?.recordType);
    _notesController = TextEditingController(text: widget.record?.notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.record == null ? 'إضافة سجل صحي' : 'تعديل السجل الصحي'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'التاريخ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال التاريخ';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
                  if (picked != null) {
                    _dateController.text = picked.toIso8601String().split('T')[0];
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _recordTypeController,
                decoration: const InputDecoration(labelText: 'نوع السجل (مثال: فحص، علاج)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال نوع السجل';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'الملاحظات'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الملاحظات';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecord,
                child: const Text('حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveRecord() async {
    if (_formKey.currentState!.validate()) {
      // For now, we only support adding new records
      final newRecord = HealthRecord(
        birdId: widget.birdId,
        date: _dateController.text,
        recordType: _recordTypeController.text,
        notes: _notesController.text,
      );
      await DatabaseHelper.instance.addHealthRecord(newRecord);
      
      if (mounted) {
        Navigator.pop(context, true); // Return true to indicate success
      }
    }
  }
}
