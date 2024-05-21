// ignore_for_file: public_member_api_docs, sort_constructors_first
class LikedPhotosModel {
  final String? id;
  final String? imageUrl;
  LikedPhotosModel({
    required this.id,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  factory LikedPhotosModel.fromMap(Map<String, dynamic> map) {
    return LikedPhotosModel(
      id: map['id'] ?? "",
      imageUrl: map['image'] ??"",
    );
  }
}
