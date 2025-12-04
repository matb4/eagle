class Equipment {
  final int? id;
  final int birdId;
  final String type;
  final String description;

  Equipment({
    this.id,
    required this.birdId,
    required this.type,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'birdId': birdId,
      'type': type,
      'description': description,
    };
  }

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
      id: map['id'],
      birdId: map['birdId'],
      type: map['type'],
      description: map['description'],
    );
  }
}
