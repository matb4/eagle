class Milestone {
  final int? id;
  final int birdId;
  final String title;
  final bool isCompleted;

  Milestone({
    this.id,
    required this.birdId,
    required this.title,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'birdId': birdId,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0, // Store boolean as integer (0 or 1)
    };
  }

  factory Milestone.fromMap(Map<String, dynamic> map) {
    return Milestone(
      id: map['id'],
      birdId: map['birdId'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1, // Convert integer back to boolean
    );
  }
}
