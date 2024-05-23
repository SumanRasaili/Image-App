import 'package:vritapp/features/home/model/liked_photos_model.dart';

class LikedPhotosModelState {
  final bool isLoading;
  List<LikedPhotos>? likedPics;
  LikedPhotosModelState({
    this.likedPics,
    this.isLoading = true,
  });

  LikedPhotosModelState copyWith({
    bool? isLoading,
    List<LikedPhotos>? likedPics,
  }) {
    return LikedPhotosModelState(
      isLoading: isLoading ?? this.isLoading,
      likedPics: likedPics ?? this.likedPics,
    );
  }
}
