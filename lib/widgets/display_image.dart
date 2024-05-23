// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vritapp/common/common_functions.dart';
import 'package:vritapp/common/components/elevated_button.dart';

class DisplayImage extends ConsumerWidget {
  final String image;
  final String id;
  const DisplayImage({
    super.key,
    required this.image,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: id,
              child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * .7,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  },
                  imageUrl: image),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onPressed: () {
                  showModalBottomSheet(
                      constraints: BoxConstraints(
                        // minHeight: MediaQuery.of(context).size.height * .7,
                        maxHeight: MediaQuery.of(context).size.height * .5,
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      context: context,
                      builder: (ctx) {
                        return ListView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          children: [
                            const ListTile(
                              title: Text(
                                "What do you want to do ?",
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                await ref
                                    .read(commonfuncProvider)
                                    .setwallPaper(image: image)
                                    .then((value) => Navigator.pop(context));
                              },
                              leading: const Icon(Icons.wallpaper),
                              title: const Text(
                                "Set As Wallpaper",
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                await ref
                                    .read(commonfuncProvider)
                                    .setLockScreen(image: image)
                                    .then((value) => Navigator.pop(context));
                              },
                              leading: const Icon(
                                  Icons.screen_lock_landscape_rounded),
                              title: const Text(
                                "Set As Lock Screen",
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                await ref
                                    .read(commonfuncProvider)
                                    .setBoth(image: image)
                                    .then((value) => Navigator.pop(context));
                              },
                              leading: const Icon(
                                Icons.two_k,
                              ),
                              title: const Text(
                                "Set As Both",
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                await Share.shareUri(Uri.parse(image))
                                    .then((value) => {print(value)});
                              },
                              leading: const Icon(
                                Icons.share,
                              ),
                              title: const Text(
                                "Share Image",
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: const Icon(Icons.download),
                              title: const Text(
                                "Save to Gallery",
                              ),
                            ),
                          ],
                        );
                      });
                  // await ref.read(commonfuncProvider).setwallPaper(image: image);
                },
                title: "Set As WallPaper"),
          ],
        ),
      ),
    );
  }
}
