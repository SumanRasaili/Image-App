// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vritapp/core/model/photos_model.dart';

class SearchModelState {
  final int? page;
  bool? isLoading;
  final List<Photo>? photos;

  SearchModelState({
     this.page,
     this.photos,
     this.isLoading,
  });

  SearchModelState copyWith({
    int? page,
    bool? isLoading,
    List<Photo>? photos,
  }) {
    return SearchModelState(
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      photos: photos ?? this.photos,
    );
  }
}
