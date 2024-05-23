import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/core/model/liked_photos_model.dart';
import 'package:vritapp/features/home/provider/photos_provider.dart';

final firebaseFirestoreProvider = Provider<CloudFirestoreServices>((ref) {
  return CloudFirestoreServices(
      firebaseFirestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance);
});

class CloudFirestoreServices {
  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;
  CloudFirestoreServices(
      {required this.firebaseFirestore, required this.firebaseAuth});
  Future<void> addToLiked(
      {required LikedPhotos likedPhotosModel,
      required WidgetRef ref,
      required BuildContext context}) async {
    final photosModel = {
      "id": likedPhotosModel.id,
      "image": likedPhotosModel.imageUrl,
    };
    try {
      BotToast.showLoading();

      final mapData = await firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("liked_photos")
          .doc(likedPhotosModel.id)
          .get();

      final resp = LikedPhotos.fromMap(mapData.data() ?? {});
      print(resp.id);

      if (resp.id == likedPhotosModel.id) {
        BotToast.closeAllLoading();
        BotToast.showText(text: "Already added");
      } else {
        await firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("liked_photos")
            .doc(likedPhotosModel.id)
            .set(photosModel)
            .then((value) {
          BotToast.closeAllLoading();
          BotToast.showText(text: "Added to liked");
          ref.invalidate(homeNotifierProvider);
        });
      }
    } on Firebase catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Error Occured $e");
    }
  }

  Stream<List<LikedPhotos>> getAllLikedPhotos() {
    return firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("liked_photos")
        .snapshots()
        .map((event) {
      List<LikedPhotos> likedList = [];
      for (var doc in event.docs) {
        likedList.add(LikedPhotos.fromMap(doc.data()));
      }
      return likedList;
    });
  }

  Future<void> deleteLikedPhotos(
      {required LikedPhotos likedPhotosModel, required WidgetRef ref}) async {
    try {
      BotToast.showLoading();
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .collection("liked_photos")
          .doc(likedPhotosModel.id)
          .delete();

      ref.invalidate(homeNotifierProvider);
      BotToast.closeAllLoading();
      BotToast.showText(text: "Deleted Successfully");
    } on FirebaseException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Error Occured :$e");
    }
  }
}
