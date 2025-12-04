class TrainingTopic {
  final int? id;
  final String title;
  final String content;
  final String? imagePath;

  TrainingTopic({
    this.id,
    required this.title,
    required this.content,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imagePath': imagePath,
    };
  }

  factory TrainingTopic.fromMap(Map<String, dynamic> map) {
    return TrainingTopic(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      imagePath: map['imagePath'],
    );
  }
}
