import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/common/common_components.dart';
import 'package:vritapp/core/model/liked_photos_model.dart';
import 'package:vritapp/features/home/provider/liked_state_notifier.dart';
import 'package:vritapp/features/home/provider/photos_provider.dart';
import 'package:vritapp/features/home/search_page.dart';
import 'package:vritapp/features/liked/services/cloud_firestore_services.dart';
import 'package:vritapp/widgets/display_image.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homephotos = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.watch(homeNotifierProvider.notifier);
    final likedProv = ref.watch(likedProvider.notifier);
    final photoController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Home"),
        bottom: PreferredSize(
            preferredSize: const Size(200, 60),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                readOnly: true,
                controller: photoController,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ));
                },
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search Photos",
                    border: OutlineInputBorder()),
              ),
            )),
      ),
      body: NotificationListener(
        onNotification: homeNotifier.shouldPageNotify,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              if ((homephotos.isLoading) && (homephotos.photos == null)) ...{
                SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ))
              } else if ((!homephotos.isLoading) &&
                  homephotos.photos == null) ...{
                const Center(
                  child: Text("No data"),
                )
              } else if ((!homephotos.isLoading) &&
                  homephotos.photos != null) ...{
                GridView.builder(
                  padding: const EdgeInsets.all(10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      homephotos.photos != null ? homephotos.photos?.length : 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        GridTile(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DisplayImage(
                                    id: index.toString(),
                                    image:
                                        homephotos.photos?[index].src.large ??
                                            "",
                                  ),
                                ));
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Hero(
                                  tag: index.toString(),
                                  child: CachedNetworkImage(
                                      placeholder: (context, url) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300),
                                        );
                                      },
                                      imageUrl: homephotos
                                              .photos?[index].src.portrait ??
                                          ""),
                                ),
                              )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  iconSize: 30,
                                  onPressed: () async {
                                    final likedModel = LikedPhotos(
                                        id: "${homephotos.photos?[index].id}",
                                        imageUrl: homephotos
                                                .photos?[index].src.portrait ??
                                            "");
                                    await ref
                                        .read(firebaseFirestoreProvider)
                                        .addToLiked(
                                            ref: ref,
                                            likedPhotosModel: likedModel,
                                            context: context);
                                  },
                                  icon:
                                      likedProv.isPhotoLiked(index, homephotos)
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              color: Colors.red.shade300,
                                            )),
                              IconButton(
                                  iconSize: 30,
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
                                                            image: homephotos
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
              } else ...{
                const Center(
                  child: Text("Something Went Wrong"),
                )
              },
              const SizedBox(
                height: 10,
              ),
              if (homephotos.isPaginationLoading) ...{
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: 10,
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
