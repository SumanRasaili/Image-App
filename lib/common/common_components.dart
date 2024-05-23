import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final commonfuncProvider = Provider<CommonRepo>((ref) {
  return CommonRepo();
});

class CommonRepo {
  Future<void> setwallPaper({required String image}) async {
    var file = await DefaultCacheManager().getSingleFile(image);
    try {
      BotToast.showLoading();
      bool res = (await (WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN)));
      if (res) {
        BotToast.closeAllLoading();

        BotToast.showText(text: "Wallpaper set succesfully");
      }
    } on PlatformException {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to load image ");
    }
  }
}
