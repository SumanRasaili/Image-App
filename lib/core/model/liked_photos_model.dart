class LikedPhotos {
  final String? id;
  final String? imageUrl;
  LikedPhotos({
    required this.id,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  factory LikedPhotos.fromMap(Map<String, dynamic> map) {
    return LikedPhotos(
      id: map['id'] ?? "",
      imageUrl: map['image'] ?? "",
    );
  }
}
