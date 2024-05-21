import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/liked/services/cloud_firestore_services.dart';

class LikedImagesScreen extends ConsumerWidget {
  const LikedImagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamData = ref.watch(likedphotosProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Liked Images"),
        ),
        body: streamData.when(data: (ssData) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2),
            itemCount: ssData.length,
            itemBuilder: (context, index) {
              return GridTile(
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: ssData[index].imageUrl ?? ""));
            },
          );
        }, error: (error, stackTrace) {
          return Center(
            child: Text("Error Occured ${error.toString()}"),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
