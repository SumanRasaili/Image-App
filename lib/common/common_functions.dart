import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

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
      BotToast.showText(text: "Failed to set image ");
    }
  }

  Future<void> setLockScreen({required String image}) async {
    var file = await DefaultCacheManager().getSingleFile(image);
    try {
      BotToast.showLoading();
      bool res = (await (WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.LOCK_SCREEN)));
      if (res) {
        BotToast.closeAllLoading();

        BotToast.showText(text: "Lock Screen set succesfully");
      }
    } on PlatformException {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to set image ");
    }
  }

  Future<void> setBoth({required String image}) async {
    var file = await DefaultCacheManager().getSingleFile(image);
    try {
      BotToast.showLoading();
      bool res = (await (WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.BOTH_SCREEN)));
      if (res) {
        BotToast.closeAllLoading();
        BotToast.showText(text: "Wallpaper and LockScreen set succesfully");
      }
    } on PlatformException {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to set image ");
    }
  }

  Future<void> sharedImage({required String image}) async {
    try {
      BotToast.showLoading();
      final result = await Share.shareUri(Uri.parse(image));
      if (result.status == ShareResultStatus.success) {
        BotToast.closeAllLoading();
        BotToast.showText(text: "Shared succesfully");
      } else if (result.status == ShareResultStatus.dismissed) {
        BotToast.closeAllLoading();
        BotToast.showText(text: "Cacelled operation");
      } else if (result.status == ShareResultStatus.unavailable) {
        BotToast.closeAllLoading();
        BotToast.showText(text: "Unknown Issue");
      }
    } on PlatformException {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to share ");
    }
  }

  Future<void> saveImageToGallery({required String imageUrl}) async {
    try {
      BotToast.showLoading();
      //to download image
      final response = await Dio().get(imageUrl,
          onReceiveProgress: showDownloadProgress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));

      //to get temp directory
      final dir = await getTemporaryDirectory();
      //create a base  file name
      String baseFileName = "image";
      String fileExtension = ".png";
      String fileName = "$baseFileName$fileExtension";
      String filePath = "${dir.path}/$fileName";
      //counter is to check if the image is already  there or not if there inxrease the file count while
      //saving if not checked caused iuuse tlike filetype not supported
      int counter = 1;
      while (await File(filePath).exists()) {
        fileName = "$baseFileName($counter)$fileExtension";
        filePath = "${dir.path}/$fileName";
        counter++;
      }

//for saving to fileSystem
      var file = File(filePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      BotToast.closeAllLoading();
      //showing dialog to save user to which location we r saving the image
      final params =
          SaveFileDialogParams(sourceFilePath: file.path, fileName: filePath);
      final finalPath = await FlutterFileDialog.saveFile(params: params);
      if (finalPath != null) {
        BotToast.closeAllLoading();
        BotToast.showText(text: 'Image saved');
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: 'cancelled before saving');
      }
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: 'An error occurred while saving the image');
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
