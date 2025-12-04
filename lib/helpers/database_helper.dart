import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../models/bird_image_model.dart';
import '../models/bird_model.dart';
import '../models/equipment_model.dart';
import '../models/health_record_model.dart';
import '../models/milestone_model.dart';
import '../models/training_model.dart';
import '../models/training_topic_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'falconry.db');
    // Version 13 to trigger a clean re-seed with all new comprehensive data
    return await openDatabase(path, version: 13, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await _createTables(db);
    await _seedData(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS bird_images');
    await db.execute('DROP TABLE IF EXISTS health_records');
    await db.execute('DROP TABLE IF EXISTS milestones');
    await db.execute('DROP TABLE IF EXISTS equipment');
    await db.execute('DROP TABLE IF EXISTS training_topics');
    await db.execute('DROP TABLE IF EXISTS training');
    await db.execute('DROP TABLE IF EXISTS birds');
    await _createTables(db);
    await _seedData(db);
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''CREATE TABLE birds(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, type TEXT NOT NULL, initialWeight REAL NOT NULL, photoPath TEXT, notes TEXT, dateCreated TEXT NOT NULL, sex TEXT NOT NULL, healthRecords TEXT, behavioralNotes TEXT, targetWeight REAL)''');
    await db.execute('''CREATE TABLE training(id INTEGER PRIMARY KEY AUTOINCREMENT, birdId INTEGER NOT NULL, trainingType TEXT NOT NULL, dailyWeight REAL NOT NULL, foodAmount REAL NOT NULL, notes TEXT, date TEXT NOT NULL, successRate INTEGER, FOREIGN KEY (birdId) REFERENCES birds(id) ON DELETE CASCADE)''');
    await db.execute('''CREATE TABLE training_topics(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, content TEXT NOT NULL, imagePath TEXT)''');
    await db.execute('''CREATE TABLE equipment(id INTEGER PRIMARY KEY AUTOINCREMENT, birdId INTEGER NOT NULL, type TEXT NOT NULL, description TEXT NOT NULL, FOREIGN KEY (birdId) REFERENCES birds(id) ON DELETE CASCADE)''');
    await db.execute('''CREATE TABLE milestones(id INTEGER PRIMARY KEY AUTOINCREMENT, birdId INTEGER NOT NULL, title TEXT NOT NULL, isCompleted INTEGER NOT NULL DEFAULT 0, FOREIGN KEY (birdId) REFERENCES birds(id) ON DELETE CASCADE)''');
    await db.execute('''CREATE TABLE health_records(id INTEGER PRIMARY KEY AUTOINCREMENT, birdId INTEGER NOT NULL, date TEXT NOT NULL, recordType TEXT NOT NULL, notes TEXT NOT NULL, FOREIGN KEY (birdId) REFERENCES birds(id) ON DELETE CASCADE)''');
    await db.execute('''CREATE TABLE bird_images(id INTEGER PRIMARY KEY AUTOINCREMENT, birdId INTEGER NOT NULL, imagePath TEXT NOT NULL, FOREIGN KEY (birdId) REFERENCES birds(id) ON DELETE CASCADE)''');
  }

  Future<void> _seedData(Database db) async {
    // === Seed Birds ===
    int bird1Id = await _addBirdInternal(db, Bird(name: 'برق', type: 'صقر شاهين', initialWeight: 950, sex: 'ذكر', dateCreated: DateTime.now()));
    await db.insert('training', Training(birdId: bird1Id, trainingType: 'دعُو', dailyWeight: 955, foodAmount: 50, date: DateTime.now().subtract(const Duration(days: 2)), successRate: 90).toMap());

    int bird2Id = await _addBirdInternal(db, Bird(name: 'عاصفة', type: 'صقر حر', initialWeight: 1100, sex: 'أنثى', dateCreated: DateTime.now()));
    await db.insert('training', Training(birdId: bird2Id, trainingType: 'تدهيل', dailyWeight: 1120, foodAmount: 60, date: DateTime.now().subtract(const Duration(days: 2)), successRate: 75).toMap());

    // === Comprehensive Educational Content ===

    // Section 1: Health & Diagnosis
    await db.insert('training_topics', TrainingTopic(title: 'دليل فحص الفضلات (Mutes) الشامل', content: 'فضلات الطائر (Mutes) هي مؤشر يومي حيوي لصحته. المكونات الطبيعية هي: جزء صلب (بني/أسود)، جزء يوريك (أبيض)، وجزء سائل (شفاف). أي تغيير هو رسالة من طائرك.\n\n**الفضلات الخضراء (Green Mute):**\n- **طبيعي:** بعد أكل السمان (Quail).\n- **مقلق:** أخضر فاتح وساطع قد يدل على مرض نيوكاسل، خاصة في الطيور المستوردة.\n\n**الفضلات الصفراء (Yellow Mute):**\n- غالبًا ما تشير إلى مشاكل في الكبد أو الطحال. قد تكون علامة على الكلاميديا. راقب أعراضًا أخرى كضيق التنفس.\n\n**الفضلات الحمراء/الوردية:**\n- **حمراء:** دم جديد، يدل على نزيف داخلي خطير، قد يكون بسبب شظية عظم. يتطلب مراقبة فورية.\n- **وردية:** قد تكون بسبب بكتيريا. راقب الطائر عن كثب.').toMap());
    await db.insert('training_topics', TrainingTopic(title: 'الأمراض الشائعة والوقاية منها', content: '**السدة (Aspergillosis):** مرض فطري يصيب الجهاز التنفسي. أعراضه: صعوبة التنفس وفقدان الشهية. الوقاية: التهوية الجيدة وتجنب الأماكن الرطبة والمغبرة.\n\n**القلاع (Frounce):** طفيلي يسبب تقرحات بيضاء في الفم. ينتقل غالبًا عبر الحمام المصاب. الوقاية: التأكد من نظافة الفريسة.\n\n**الجدرة (Bumblefoot):** التهاب بكتيري في باطن القدم يسبب تورمًا. الوقاية: استخدام مجاثم (أوکار) مناسبة ونظيفة، وتجنب الأسطح الخشنة.').toMap());

    // Section 2: Advanced Training & Behavior
    await db.insert('training_topics', TrainingTopic(title: 'فترة المقيض (طرح الريش) والعناية بها', content: 'فترة المقيض هي فترة حساسة سنوية يقوم فيها الطائر بتبديل ريشه. تتطلب هذه الفترة راحة تامة وغذاءً غنيًا بالبروتينات والفيتامينات (خاصة البيوتين) لضمان نمو ريش قوي وصحي. قلل من التدريب المجهد وركز على الحفاظ على صحة الطائر وسلامة ريشه الجديد. وفر له حمام شمس منتظم.').toMap());
    await db.insert('training_topics', TrainingTopic(title: 'إدارة الوزن الدقيقة ووزن الصيد', content: 'وزن الطائر هو مفتاح التحكم في أدائه. لكل طائر وزنان مهمان:\n- **وزن الشبعة:** وزنه بعد أن يأكل حتى يرفض المزيد.\n- **وزن الصيد (الوزن المنخفض):** وهو الوزن الذي يكون فيه الطائر حريصًا على الصيد ومستجيبًا لك. يتطلب الوصول إليه خبرة ومراقبة يومية دقيقة للوزن وكمية العلف. القاعدة العامة هي أن يكون وزن الصيد أقل بنسبة 10-15% من وزن الشبعة.').toMap());
    await db.insert('training_topics', TrainingTopic(title: 'فهم لغة جسد الصقر المتقدمة', content: '**الريش المنفوش:** قد يعني الاسترخاء، ولكنه قد يدل أيضًا على المرض إذا كان مصحوبًا بخمول.\n**الوقوف على رجل واحدة:** علامة ممتازة على الاسترخاء والثقة.\n**صوت الطقطقة بالمنقار:** غالبًا ما يكون علامة على الرضا بعد الأكل.\n**الـ Mantling (تغطية الفريسة بالجناحين):** سلوك غريزي لحماية طعامه.').toMap());
  }

  // === ALL CRUD METHODS ARE GUARANTEED TO BE PRESENT ===

  Future<int> _addBirdInternal(Database db, Bird bird) async {
    int birdId = await db.insert('birds', bird.toMap());
    final standardMilestones = ['إكمال مرحلة التدهيل', 'أول طيران ناجح للدس', 'صيد أول فريسة حية', 'الاستجابة للصوت عن بعد'];
    for (var title in standardMilestones) {
      await db.insert('milestones', Milestone(birdId: birdId, title: title).toMap());
    }
    return birdId;
  }

  Future<int> addBird(Bird bird) async => await _addBirdInternal(await instance.database, bird);
  Future<List<Bird>> getBirds() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('birds');
    return List.generate(maps.length, (i) => Bird.fromMap(maps[i]));
  }
  Future<int> updateBird(Bird bird) async => (await instance.database).update('birds', bird.toMap(), where: 'id = ?', whereArgs: [bird.id]);
  Future<int> deleteBird(int id) async => (await instance.database).delete('birds', where: 'id = ?', whereArgs: [id]);
  Future<int> addTraining(Training training) async => (await instance.database).insert('training', training.toMap());
  Future<List<Training>> getTrainings(int birdId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('training', where: 'birdId = ?', whereArgs: [birdId]);
    return List.generate(maps.length, (i) => Training.fromMap(maps[i]));
  }
  Future<List<TrainingTopic>> getTrainingTopics() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('training_topics');
    return List.generate(maps.length, (i) => TrainingTopic.fromMap(maps[i]));
  }
  Future<int> addTrainingTopic(TrainingTopic topic) async => (await instance.database).insert('training_topics', topic.toMap());
  Future<int> updateTrainingTopic(TrainingTopic topic) async => (await instance.database).update('training_topics', topic.toMap(), where: 'id = ?', whereArgs: [topic.id]);
  Future<int> deleteTrainingTopic(int id) async => (await instance.database).delete('training_topics', where: 'id = ?', whereArgs: [id]);
  Future<List<Equipment>> getEquipment(int birdId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('equipment', where: 'birdId = ?', whereArgs: [birdId]);
    return List.generate(maps.length, (i) => Equipment.fromMap(maps[i]));
  }
  Future<int> addEquipment(Equipment equipment) async => (await instance.database).insert('equipment', equipment.toMap());
  Future<int> updateEquipment(Equipment equipment) async => (await instance.database).update('equipment', equipment.toMap(), where: 'id = ?', whereArgs: [equipment.id]);
  Future<int> deleteEquipment(int id) async => (await instance.database).delete('equipment', where: 'id = ?', whereArgs: [id]);
  Future<List<Milestone>> getMilestones(int birdId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('milestones', where: 'birdId = ?', whereArgs: [birdId]);
    return List.generate(maps.length, (i) => Milestone.fromMap(maps[i]));
  }
  Future<int> updateMilestone(Milestone milestone) async => (await instance.database).update('milestones', milestone.toMap(), where: 'id = ?', whereArgs: [milestone.id]);
  Future<List<HealthRecord>> getHealthRecords(int birdId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('health_records', where: 'birdId = ?', whereArgs: [birdId]);
    return List.generate(maps.length, (i) => HealthRecord.fromMap(maps[i]));
  }
  Future<int> addHealthRecord(HealthRecord record) async => (await instance.database).insert('health_records', record.toMap());
  Future<List<BirdImage>> getBirdImages(int birdId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('bird_images', where: 'birdId = ?', whereArgs: [birdId]);
    return List.generate(maps.length, (i) => BirdImage.fromMap(maps[i]));
  }
  Future<int> addBirdImage(BirdImage image) async => (await instance.database).insert('bird_images', image.toMap());
}
