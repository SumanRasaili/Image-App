// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vritapp/core/model/photos_model.dart';

class PhotosModelState {
  final int? page;
  bool? isLoading;
  final List<Photo>? photos;

  PhotosModelState({
     this.page,
     this.photos,
     this.isLoading,
  });

  PhotosModelState copyWith({
    int? page,
    bool? isLoading,
    List<Photo>? photos,
  }) {
    return PhotosModelState(
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      photos: photos ?? this.photos,
    );
  }
}
