import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/core/model/photos_model_state.dart';
import 'package:vritapp/features/home/repo/photos_repo.dart';

final homeNotifierProvider =
    StateNotifierProvider<HomeNotifier, PhotosModelState>((ref) {
  return HomeNotifier(ref: ref);
});

class HomeNotifier extends StateNotifier<PhotosModelState> {
  HomeNotifier({required this.ref}) : super(PhotosModelState()) {
    getPhotos(nextPage: null);
  }
  Ref ref;

  bool shouldPageNotify(ScrollNotification notification) {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      if ((state.nextPageUrl != null || state.nextPageUrl!.isNotEmpty) &&
          (!state.isPaginationLoading)) {
        state = state.copyWith(isPaginationLoading: true);
        getPhotos(nextPage: state.nextPageUrl);
      }
    }
    return true;
  }

  getPhotos({required String? nextPage}) async {
    if (nextPage == null) {
      final photos =
          await ref.read(getAllPhotosProvider(nextPage: null).future);
      state = state.copyWith(
          isLoading: true, photos: photos.photos, nextPageUrl: photos.nextPage);
      state = state.copyWith(
        isLoading: false,
      );
    } else {
      final photosPg =
          await ref.read(getAllPhotosProvider(nextPage: nextPage).future);
      state = state.copyWith(
          isPaginationLoading: true,
          photos: [...state.photos ?? [], ...photosPg.photos],
          nextPageUrl: photosPg.nextPage);
      state = state.copyWith(
        isPaginationLoading: false,
      );
    }
  }
}
