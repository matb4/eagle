class HealthRecord {
  final int? id;
  final int birdId;
  final String date;
  final String recordType;
  final String notes;

  HealthRecord({
    this.id,
    required this.birdId,
    required this.date,
    required this.recordType,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'birdId': birdId,
      'date': date,
      'recordType': recordType,
      'notes': notes,
    };
  }

  factory HealthRecord.fromMap(Map<String, dynamic> map) {
    return HealthRecord(
      id: map['id'],
      birdId: map['birdId'],
      date: map['date'],
      recordType: map['recordType'],
      notes: map['notes'],
    );
  }
}
