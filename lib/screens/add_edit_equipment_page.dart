import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/equipment_model.dart';

class AddEditEquipmentPage extends StatefulWidget {
  final int birdId;
  final Equipment? equipment;

  const AddEditEquipmentPage({Key? key, required this.birdId, this.equipment}) : super(key: key);

  @override
  State<AddEditEquipmentPage> createState() => _AddEditEquipmentPageState();
}

class _AddEditEquipmentPageState extends State<AddEditEquipmentPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _typeController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.equipment?.type);
    _descriptionController = TextEditingController(text: widget.equipment?.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipment == null ? 'إضافة معدات جديدة' : 'تعديل المعدات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'نوع المعدات (مثال: برقع، دس)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال نوع المعدات';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'الوصف (مثال: جلد غزال، مقاس M)'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الوصف';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEquipment,
                child: const Text('حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveEquipment() async {
    if (_formKey.currentState!.validate()) {
      if (widget.equipment == null) {
        // Add new equipment
        final newEquipment = Equipment(
          birdId: widget.birdId,
          type: _typeController.text,
          description: _descriptionController.text,
        );
        await DatabaseHelper.instance.addEquipment(newEquipment);
      } else {
        // Update existing equipment
        final updatedEquipment = Equipment(
          id: widget.equipment!.id,
          birdId: widget.birdId,
          type: _typeController.text,
          description: _descriptionController.text,
        );
        await DatabaseHelper.instance.updateEquipment(updatedEquipment);
      }

      if (mounted) {
        Navigator.pop(context, true); // Return true to indicate success
      }
    }
  }
}
