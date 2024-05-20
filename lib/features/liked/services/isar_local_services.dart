import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:vritapp/core/model/local_isar_photos_model.dart';
import 'package:vritapp/main.dart';

final localPhotosServiceProvider = Provider<LocalPhotosServices>((ref) {
  return LocalPhotosServices();
});

class LocalPhotosServices {
  Future<List<PhotosCollection>> getAllLikedPhotos() async {
    return isar.photosCollections.where().findAll();
  }
}
