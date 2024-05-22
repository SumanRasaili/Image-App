import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/core/model/liked_photos_model_state.dart';
import 'package:vritapp/core/model/photos_model_state.dart';
import 'package:vritapp/features/liked/services/cloud_firestore_services.dart';

final likedProvider =
    StateNotifierProvider<Notifier, LikedPhotosModelState>((ref) {
  return Notifier(ref: ref);
});

class Notifier extends StateNotifier<LikedPhotosModelState> {
  Notifier({required this.ref}) : super(LikedPhotosModelState()) {
    getLikedPhotos();
  }
  Ref ref;
  getLikedPhotos() async {
    final respData = ref.read(firebaseFirestoreProvider).getAllLikedPhotos();
    respData.listen((event) {
      state = state.copyWith(likedPics: event);
      state = state.copyWith(isLoading: false);
      print("State === $state");
    });
  }

  bool isPhotoLiked(int index, PhotosModelState photo) {
    for (var likedPhoto in state.likedPics ?? []) {
      if (int.parse(likedPhoto.id.toString()) == photo.photos![index].id) {
        return true;
      }
    }
    return false;
  }
}
