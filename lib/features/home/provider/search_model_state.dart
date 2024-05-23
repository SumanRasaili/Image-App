// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vritapp/features/home/model/photos_model.dart';

class SearchModelState {
  final String? nextPageUrl;
  bool isLoading;
  bool isPaginationLoading;
  final List<Photo>? photos;

  SearchModelState({
    this.nextPageUrl,
    this.isPaginationLoading = false,
    this.photos,
    this.isLoading = true,
  });

  SearchModelState copyWith({
    String? nextPageUrl,
    bool? isLoading,
    bool? isPaginationLoading,
    List<Photo>? photos,
  }) {
    return SearchModelState(
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      isLoading: isLoading ?? this.isLoading,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      photos: photos ?? this.photos,
    );
  }
}
