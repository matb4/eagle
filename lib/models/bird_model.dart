class Bird {
  final int? id;
  final String name;
  final String type;
  final double initialWeight;
  final String? photoPath;
  final String? notes;
  final DateTime dateCreated;
  final String sex;
  final String? healthRecords;
  final String? behavioralNotes;
  final double? targetWeight; // New field

  Bird({
    this.id,
    required this.name,
    required this.type,
    required this.initialWeight,
    this.photoPath,
    this.notes,
    required this.dateCreated,
    required this.sex,
    this.healthRecords,
    this.behavioralNotes,
    this.targetWeight, // New field
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'initialWeight': initialWeight,
      'photoPath': photoPath,
      'notes': notes,
      'dateCreated': dateCreated.toIso8601String(),
      'sex': sex,
      'healthRecords': healthRecords,
      'behavioralNotes': behavioralNotes,
      'targetWeight': targetWeight, // New field
    };
  }

  factory Bird.fromMap(Map<String, dynamic> map) {
    return Bird(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      initialWeight: map['initialWeight'],
      photoPath: map['photoPath'],
      notes: map['notes'],
      dateCreated: DateTime.parse(map['dateCreated']),
      sex: map['sex'],
      healthRecords: map['healthRecords'],
      behavioralNotes: map['behavioralNotes'],
      targetWeight: map['targetWeight'], // New field
    );
  }
}
