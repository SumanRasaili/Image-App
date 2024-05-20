// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            )
          ],
        ),
      ),
    );
  }
}
