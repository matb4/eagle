class BirdImage {
  final int? id;
  final int birdId;
  final String imagePath;

  BirdImage({
    this.id,
    required this.birdId,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'birdId': birdId,
      'imagePath': imagePath,
    };
  }

  factory BirdImage.fromMap(Map<String, dynamic> map) {
    return BirdImage(
      id: map['id'],
      birdId: map['birdId'],
      imagePath: map['imagePath'],
    );
  }
}
