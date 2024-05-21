import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/common/common_components.dart';
import 'package:vritapp/core/model/liked_photos_model.dart';
import 'package:vritapp/features/home/provider/search_provider.dart';
import 'package:vritapp/features/liked/services/cloud_firestore_services.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoController = useTextEditingController();
    final photoList = ref.watch(searchNotifierProvider);
    final photoNotifier = ref.watch(searchNotifierProvider.notifier);
    final isSearching = useState<bool>(false);
    final timer = useState<Timer?>(null);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search"),
        bottom: PreferredSize(
            preferredSize: const Size(200, 60),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                onFieldSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    ref.read(searchNotifierProvider.notifier).searchPhotos(
                          query: value,
                        );
                  }
                },
                onChanged: (value) {
                  isSearching.value = true;
                  if (timer.value != null) {
                    timer.value?.cancel();
                  }
                  timer.value = Timer(const Duration(seconds: 1), () async {
                    ref.read(searchNotifierProvider.notifier).searchPhotos(
                          query: value,
                        );
                    isSearching.value = false;
                  });
                },
                controller: photoController,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    suffixIcon: photoController.text.isNotEmpty
                        ? const Icon(Icons.close)
                        : const Icon(Icons.search),
                    hintText: "Search Photos",
                    border: const OutlineInputBorder()),
              ),
            )),
      ),
      body: NotificationListener(
        onNotification: photoNotifier.shouldPageNotify,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              if (isSearching.value) ...{
                const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ))
              } else if ((photoList.photos == null ||
                  photoList.photos!.isEmpty)) ...{
                const SizedBox(
                  height: 200,
                  child: Center(child: Text("Nothing to Show")),
                ),
              } else
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      photoList.photos != null ? photoList.photos!.length : 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: InteractiveViewer(
                                      child: Image.network(photoList
                                              .photos?[index].src.portrait ??
                                          ""),
                                    ),
                                  );
                                },
                              );
                            },
                            child: CachedNetworkImage(
                                imageUrl:
                                    photoList.photos?[index].src.portrait ??
                                        ""),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          left: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  iconSize: 20,
                                  color: Colors.red.shade300,
                                  onPressed: () async {
                                    final likedModel = LikedPhotos(
                                        id: "${photoList.photos?[index].id}",
                                        imageUrl: photoList
                                                .photos?[index].src.portrait ??
                                            "");
                                    await ref
                                        .read(firebaseFirestoreProvider)
                                        .addToLiked(
                                            likedPhotosModel: likedModel,
                                            context: context);
                                  },
                                  icon: const Icon(Icons.favorite)),
                              IconButton(
                                  iconSize: 20,
                                  color: Colors.amber,
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                              content: const Text(
                                                  "Do you want to set??"),
                                              actions: [
                                                FilledButton(
                                                  onPressed: () {
                                                    Navigator.pop(ctx);
                                                  },
                                                  child: const Text("No"),
                                                ),
                                                FilledButton(
                                                  onPressed: () async {
                                                    await ref
                                                        .read(
                                                            commonfuncProvider)
                                                        .setwallPaper(
                                                            image: photoList
                                                                    .photos?[
                                                                        index]
                                                                    .src
                                                                    .portrait ??
                                                                "")
                                                        .then((value) =>
                                                            Navigator.of(ctx)
                                                                .pop());
                                                  },
                                                  child: const Text("YES"),
                                                ),
                                              ],
                                              title: const Text(
                                                  "Set this image as wallpaper"));
                                        });
                                  },
                                  icon: const Icon(Icons.wallpaper)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              const SizedBox(
                height: 10,
              ),
              if (photoList.isPaginationLoading) ...{
                const Center(
                  child: CircularProgressIndicator(),
                ),
              },
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
