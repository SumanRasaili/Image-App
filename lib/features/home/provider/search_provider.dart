import 'package:flutter/material.dart';
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

  bool shouldPageNotify(ScrollNotification notification) {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      if ((state.nextPageUrl != null) && (!state.isPaginationLoading)) {
        state = state.copyWith(isPaginationLoading: true);
        searchPhotos(nextPageUrl: state.nextPageUrl, query: null);
      }
    }
    return true;
  }

  searchPhotos({required String? query, String? nextPageUrl}) async {
    final response = await ref.read(
        searchPhotosProvider(searchQuery: query, nextPageUrl: nextPageUrl)
            .future);
    if (nextPageUrl == null) {
      print(" not pagination case");
      print("pnot paginateg =-========== ${response.nextPage}");
      state = state.copyWith(
          isLoading: true,
          photos: response.photos,
          nextPageUrl: response.nextPage);
      state = state.copyWith(
        isLoading: false,
      );
    } else {
      print("pagination case");
      state = state.copyWith(
        isPaginationLoading: true,
        nextPageUrl: response.nextPage,
        photos: [...state.photos ?? [], ...response.photos],
      );
      print("The state response is ${state.photos}");
      state = state.copyWith(
        isPaginationLoading: false,
      );
    }
  }
}
