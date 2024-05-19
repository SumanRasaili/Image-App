import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/core/model/search_model_state.dart';
import 'package:vritapp/features/home/repo/photos_repo.dart';

final searchNotifierProvider =
    StateNotifierProvider<SearchNotifier, SearchModelState>((ref) {
  return SearchNotifier(ref: ref);
});

class SearchNotifier extends StateNotifier<SearchModelState> {
  SearchNotifier({required this.ref}) : super(SearchModelState());
  Ref ref;

  searchPhotos({required String query}) async {
    state = state.copyWith(
      isLoading: true,
    );
    final photos =
        await ref.read(searchPhotosProvider(searchQuery: query).future);
    state = state.copyWith(isLoading: true, photos: photos.photos);
    state = state.copyWith(
      isLoading: false,
    );
  }
}
