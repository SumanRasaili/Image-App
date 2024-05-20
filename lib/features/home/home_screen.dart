import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/home/provider/photos_provider.dart';
import 'package:vritapp/features/home/search_page.dart';
import 'package:vritapp/widgets/display_image.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homephotos = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.watch(homeNotifierProvider.notifier);
    final photoController = useTextEditingController();
    final result = useState<String>("");
    Future<void> setwallPaper({required String image}) async {
      var file = await DefaultCacheManager().getSingleFile(image);
      try {
        BotToast.showLoading();
        bool res = (await (WallpaperManager.setWallpaperFromFile(
            file.path, WallpaperManager.HOME_SCREEN)));
        if (res) {
          BotToast.closeAllLoading();
          result.value = "Wallpaper set succesfully";
          BotToast.showText(text: result.value);
        }
      } on PlatformException {
        BotToast.closeAllLoading();
        result.value = "Failed to load image";
        BotToast.showText(text: result.value);
      }
    }

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
                                    id: "${homephotos.photos?[index].id}",
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
                                  tag: "${homephotos.photos?[index].id}",
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
                                  color: Colors.red.shade300,
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite)),
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
                                                    await setwallPaper(
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
              Text("Is pagination ${homephotos.isPaginationLoading}"),
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
