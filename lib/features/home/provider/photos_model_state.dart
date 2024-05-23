// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vritapp/features/home/model/photos_model.dart';

class PhotosModelState {
  final String? nextPageUrl;
  bool isLoading;
  bool isPaginationLoading;
  final List<Photo>? photos;

  PhotosModelState({
    this.nextPageUrl,
    this.photos,
    this.isLoading = true,
    this.isPaginationLoading = false,
  });

  PhotosModelState copyWith({
    String? nextPageUrl,
    bool? isLoading,
    bool? isPaginationLoading,
    List<Photo>? photos,
  }) {
    return PhotosModelState(
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      isLoading: isLoading ?? this.isLoading,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      photos: photos ?? this.photos,
    );
  }
}
