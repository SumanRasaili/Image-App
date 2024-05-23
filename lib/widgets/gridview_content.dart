// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vritapp/core/model/photos_model.dart';
import 'package:vritapp/widgets/display_image.dart';

class GridViewItem extends StatelessWidget {
  final List<Photo> photos;
  final bool isLiked;
  final VoidCallback likedButtonPressed;
  final int index;
  const GridViewItem({
    super.key,
    required this.photos,
    required this.isLiked,
    required this.likedButtonPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DisplayImage(
                    id: index.toString(),
                    image: photos[index].src.large,
                  ),
                ));
              },
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Hero(
                  tag: index.toString(),
                  child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Container(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                        );
                      },
                      imageUrl: photos[index].src.portrait),
                ),
              )),
        ),
        Positioned(
          bottom: 0,
          right: 3,
          // left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  iconSize: 35,
                  onPressed: likedButtonPressed,
                  icon: isLiked
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.red.shade300,
                        )),
            ],
          ),
        ),
      ],
    );
  }
}
