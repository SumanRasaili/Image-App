import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/home/provider/liked_state_notifier.dart';
import 'package:vritapp/widgets/display_image.dart';

class LikedImagesScreen extends ConsumerWidget {
  const LikedImagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamData = ref.watch(likedProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Liked Images"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            if (streamData.isLoading && streamData.likedPics == null) ...{
              const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
            } else if ((!streamData.isLoading &&
                streamData.likedPics == null)) ...{
              const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text("No data"),
                  ))
            } else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2),
                itemCount: streamData.likedPics!.length,
                itemBuilder: (context, index) {
                  return GridTile(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DisplayImage(
                              image: "${streamData.likedPics?[index].imageUrl}",
                              id: "${streamData.likedPics?[index].id}")));
                    },
                    child: Hero(
                      tag: "$index",
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              streamData.likedPics![index].imageUrl ?? ""),
                    ),
                  ));
                },
              ),
          ]),
        ));
  }
}
