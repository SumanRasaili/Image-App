import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/core/model/photos_model_state.dart';
import 'package:vritapp/features/home/repo/photos_repo.dart';

final homeNotifierProvider =
    StateNotifierProvider<HomeNotifier, PhotosModelState>((ref) {
  return HomeNotifier(ref: ref);
});

class HomeNotifier extends StateNotifier<PhotosModelState> {
  HomeNotifier({required this.ref}) : super(PhotosModelState()) {
    getPhotos();
  }
  Ref ref;

  getPhotos() async {
    state = state.copyWith(
      isLoading: true,
    );
    final photos = await ref.read(getAllPhotosProvider.future);
    state = state.copyWith(isLoading: true, photos: photos.photos);
    state = state.copyWith(
      isLoading: false,
    );
  }
}
