class LikedPhotos {
  final String? id;
  final String? imageUrl;
  bool isLiked;
  LikedPhotos({
    required this.id,
    this.isLiked = false,
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
