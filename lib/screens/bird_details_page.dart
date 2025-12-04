import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/database_helper.dart';
import '../models/bird_image_model.dart';
import '../models/bird_model.dart';
import '../models/equipment_model.dart';
import '../models/health_record_model.dart';
import '../models/milestone_model.dart';
import '../models/training_model.dart';
import 'add_edit_equipment_page.dart';
import 'add_edit_health_record_page.dart';
import 'add_training_page.dart';
import 'edit_bird_page.dart';

class BirdDetailsPage extends StatefulWidget {
  final Bird bird;

  const BirdDetailsPage({Key? key, required this.bird}) : super(key: key);

  @override
  State<BirdDetailsPage> createState() => _BirdDetailsPageState();
}

class _BirdDetailsPageState extends State<BirdDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Training>> _trainingFuture;
  late Future<List<Equipment>> _equipmentFuture;
  late Future<List<Milestone>> _milestonesFuture;
  late Future<List<HealthRecord>> _healthRecordsFuture;
  late Future<List<BirdImage>> _imagesFuture;
  late Bird _currentBird;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() => setState(() {}));
    _currentBird = widget.bird;
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _trainingFuture = DatabaseHelper.instance.getTrainings(_currentBird.id!);
      _equipmentFuture = DatabaseHelper.instance.getEquipment(_currentBird.id!);
      _milestonesFuture = DatabaseHelper.instance.getMilestones(_currentBird.id!);
      _healthRecordsFuture = DatabaseHelper.instance.getHealthRecords(_currentBird.id!);
      _imagesFuture = DatabaseHelper.instance.getBirdImages(_currentBird.id!);
    });
  }

  void _updateBird(Bird updatedBird) {
    setState(() {
      _currentBird = updatedBird;
    });
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد أنك تريد حذف هذا الطائر؟ سيتم حذف جميع بياناته بشكل نهائي.'),
          actions: <Widget>[
            TextButton(child: const Text('إلغاء'), onPressed: () => Navigator.of(context).pop()),
            TextButton(
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                await DatabaseHelper.instance.deleteBird(_currentBird.id!);
                if (mounted) {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back to home
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
        title: Text(_currentBird.name),
        actions: [
          IconButton(icon: const Icon(Icons.edit), tooltip: 'تعديل بيانات الطائر', onPressed: () async {
            final updatedBird = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditBirdPage(bird: _currentBird)));
            if (updatedBird != null) _updateBird(updatedBird);
          }),
          IconButton(icon: const Icon(Icons.delete, color: Colors.red), tooltip: 'حذف الطائر', onPressed: _showDeleteConfirmationDialog),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [Tab(text: 'نظرة عامة'), Tab(text: 'السجل الصحي'), Tab(text: 'سجل التدريب'), Tab(text: 'معرض الصور'), Tab(text: 'المعدات')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildOverviewTab(), _buildHealthTab(), _buildTrainingTab(), _buildGalleryTab(), _buildEquipmentTab()],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
  
  Widget? _buildFloatingActionButton() {
    if (_tabController.index == 1) {
      return FloatingActionButton(onPressed: _addHealthRecord, child: const Icon(Icons.add), tooltip: 'إضافة سجل صحي');
    } else if (_tabController.index == 2) {
       return FloatingActionButton(onPressed: _addTraining, child: const Icon(Icons.add), tooltip: 'إضافة سجل تدريب');
    } else if (_tabController.index == 3) {
       return FloatingActionButton(onPressed: _addImage, child: const Icon(Icons.add_a_photo), tooltip: 'إضافة صورة');
    } else if (_tabController.index == 4) {
       return FloatingActionButton(onPressed: _addEquipment, child: const Icon(Icons.add), tooltip: 'إضافة معدات');
    }
    return null;
  }

  // FAB Actions
  void _addHealthRecord() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditHealthRecordPage(birdId: _currentBird.id!)));
    if (result == true) _refreshData();
  }
  void _addTraining() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTrainingPage(birdId: _currentBird.id!)));
    _refreshData();
  }
  void _addImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await DatabaseHelper.instance.addBirdImage(BirdImage(birdId: _currentBird.id!, imagePath: image.path));
      _refreshData();
    }
  }
  void _addEquipment() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditEquipmentPage(birdId: _currentBird.id!)));
    if (result == true) _refreshData();
  }

  // === ALL BUILD METHODS ARE NOW RESTORED ===

  Widget _buildOverviewTab() {
    return ListView(padding: const EdgeInsets.all(16), children: [_buildImage(), const SizedBox(height: 16), _buildDetailsCard(), const SizedBox(height: 20), const Text('مراحل التدريب (الإنجازات)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), _buildMilestonesCard()]);
  }
  
  Widget _buildHealthTab() {
    return FutureBuilder<List<HealthRecord>>(
      future: _healthRecordsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text('لا توجد سجلات صحية.'));
        return ListView.builder(padding: const EdgeInsets.all(8), itemCount: snapshot.data!.length, itemBuilder: (context, index) => Card(child: ListTile(title: Text(snapshot.data![index].recordType), subtitle: Text(snapshot.data![index].notes))));
      },
    );
  }
  
  Widget _buildTrainingTab() {
    return FutureBuilder<List<Training>>(
      future: _trainingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text('لا يوجد سجل تدريبي.'));
        return _buildTrainingHistory(snapshot.data!);
      },
    );
  }
  
  Widget _buildGalleryTab() {
    return FutureBuilder<List<BirdImage>>(
      future: _imagesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text('لا توجد صور في المعرض.'));
        return GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: snapshot.data!.length, itemBuilder: (context, index) => Image.file(File(snapshot.data![index].imagePath), fit: BoxFit.cover));
      },
    );
  }

  Widget _buildEquipmentTab() {
    return FutureBuilder<List<Equipment>>(
      future: _equipmentFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text('لا توجد معدات مضافة.'));
        return ListView.builder(padding: const EdgeInsets.all(8), itemCount: snapshot.data!.length, itemBuilder: (context, index) => Card(child: ListTile(title: Text(snapshot.data![index].type), subtitle: Text(snapshot.data![index].description))));
      },
    );
  }
  
  Widget _buildImage() => Center(child: Container(width: 200, height: 200, child: _currentBird.photoPath != null && _currentBird.photoPath!.isNotEmpty ? Image.file(File(_currentBird.photoPath!), fit: BoxFit.cover) : const Icon(Icons.camera_alt, size: 80, color: Colors.grey)));

  Widget _buildDetailsCard() => Card(child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildDetailRow('النوع', _currentBird.type), _buildDetailRow('الجنس', _currentBird.sex)])));

  Widget _buildMilestonesCard() {
    return FutureBuilder<List<Milestone>>(
      future: _milestonesFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return Card(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: snapshot.data!.map((milestone) => CheckboxListTile(title: Text(milestone.title), value: milestone.isCompleted, onChanged: (value) {
          DatabaseHelper.instance.updateMilestone(Milestone(id: milestone.id, birdId: milestone.birdId, title: milestone.title, isCompleted: value ?? false));
          _refreshData();
        })).toList())));
      },
    );
  }

  Widget _buildDetailRow(String label, String? value) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text('$label: ${value ?? 'N/A'}'));

  Widget _buildTrainingHistory(List<Training> trainings) {
    return ListView.builder(padding: const EdgeInsets.all(8), itemCount: trainings.length, itemBuilder: (context, index) => Card(child: ListTile(title: Text(trainings[index].trainingType), subtitle: Text('${trainings[index].date} - ${trainings[index].dailyWeight}g'))));
  }
}
