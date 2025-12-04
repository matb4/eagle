class Training {
  final int? id;
  final int birdId;
  final String trainingType;
  final double dailyWeight;
  final double foodAmount;
  final String? notes;
  final DateTime date;
  final int? successRate; // New field

  Training({
    this.id,
    required this.birdId,
    required this.trainingType,
    required this.dailyWeight,
    required this.foodAmount,
    this.notes,
    required this.date,
    this.successRate, // New field
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'birdId': birdId,
      'trainingType': trainingType,
      'dailyWeight': dailyWeight,
      'foodAmount': foodAmount,
      'notes': notes,
      'date': date.toIso8601String(),
      'successRate': successRate, // New field
    };
  }

  factory Training.fromMap(Map<String, dynamic> map) {
    return Training(
      id: map['id'],
      birdId: map['birdId'],
      trainingType: map['trainingType'],
      dailyWeight: map['dailyWeight'],
      foodAmount: map['foodAmount'],
      notes: map['notes'],
      date: DateTime.parse(map['date']),
      successRate: map['successRate'], // New field
    );
  }
}
