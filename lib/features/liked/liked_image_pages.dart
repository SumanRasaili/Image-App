import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/liked/services/isar_local_services.dart';

class LikedImagesScreen extends ConsumerWidget {
  const LikedImagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(localPhotosServiceProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Liked Images"),
      ),
      body: Center(
          child: Column(
        children: [
          FutureBuilder(
            future: data.getAllLikedPhotos(),
            builder: (context, snapshot) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data?[index].title ?? "");
                },
              );
            },
          )
        ],
      )),
    );
  }
}
