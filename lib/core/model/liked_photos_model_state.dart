// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:vritapp/core/model/liked_photos_model.dart';

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



