import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/training_model.dart';

class AddTrainingPage extends StatefulWidget {
  final int birdId;

  const AddTrainingPage({Key? key, required this.birdId}) : super(key: key);

  @override
  State<AddTrainingPage> createState() => _AddTrainingPageState();
}

class _AddTrainingPageState extends State<AddTrainingPage> {
  int _currentStep = 0;
  String? _selectedTrainingType;
  final _formKey = GlobalKey<FormState>();
  final _dailyWeightController = TextEditingController();
  final _foodAmountController = TextEditingController();
  final _notesController = TextEditingController();
  double _successRate = 80.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة سجل تدريب'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            _addTraining();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          _buildStep1(),
          _buildStep2(),
          _buildStep3(),
        ],
      ),
    );
  }

  Step _buildStep1() {
    return Step(
      title: const Text('اختر نوع التدريب'),
      content: _buildTrainingTypeSelector(),
      isActive: _currentStep >= 0,
    );
  }

  Step _buildStep2() {
    return Step(
      title: const Text('أدخل البيانات'),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _dailyWeightController,
              decoration: const InputDecoration(labelText: 'الوزن اليومي (جرام)'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'الرجاء إدخال الوزن' : null,
            ),
            TextFormField(
              controller: _foodAmountController,
              decoration: const InputDecoration(labelText: 'كمية الأكل (جرام)'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'الرجاء إدخال كمية الأكل' : null,
            ),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'ملاحظات (اختياري)'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Text('تقييم نجاح الجلسة: ${_successRate.toInt()}%'),
            Slider(
              value: _successRate,
              min: 0,
              max: 100,
              divisions: 100,
              label: '${_successRate.toInt()}%',
              onChanged: (double value) {
                setState(() {
                  _successRate = value;
                });
              },
            ),
          ],
        ),
      ),
      isActive: _currentStep >= 1,
    );
  }

  Step _buildStep3() {
    return Step(
      title: const Text('الملخص'),
      content: _buildSummary(),
      isActive: _currentStep >= 2,
    );
  }

  Widget _buildTrainingTypeSelector() {
    final types = {
      'دعُو': Icons.record_voice_over,
      'تلواح': Icons.track_changes,
      'صيد': Icons.catching_pokemon,
      'تدهيل': Icons.pets,
      'تخفيف الوزن': Icons.monitor_weight,
    };

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5),
      itemCount: types.length,
      itemBuilder: (context, index) {
        final type = types.keys.elementAt(index);
        return Card(
          color: _selectedTrainingType == type ? Colors.blue.shade100 : null,
          child: InkWell(
            onTap: () => setState(() => _selectedTrainingType = type),
            child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(types[type]), const SizedBox(width: 8), Text(type)]))
          ),
        );
      },
    );
  }

  Widget _buildSummary() {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('نوع التدريب: ${_selectedTrainingType ?? 'لم يتم الاختيار'}'),
        Text('الوزن اليومي: ${_dailyWeightController.text} جرام'),
        Text('كمية الأكل: ${_foodAmountController.text} جرام'),
        Text('نسبة النجاح: ${_successRate.toInt()}%'),
        Text('ملاحظات: ${_notesController.text.isNotEmpty ? _notesController.text : 'لا يوجد'}'),
      ],
    );
  }

  void _addTraining() async {
    if (_formKey.currentState!.validate() && _selectedTrainingType != null) {
      final newTraining = Training(
        birdId: widget.birdId,
        trainingType: _selectedTrainingType!,
        dailyWeight: double.parse(_dailyWeightController.text),
        foodAmount: double.parse(_foodAmountController.text),
        notes: _notesController.text,
        date: DateTime.now(),
        successRate: _successRate.toInt(),
      );
      await DatabaseHelper.instance.addTraining(newTraining);
      if (mounted) Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرجاء اختيار نوع التدريب والمتابعة.')));
    }
  }
}
