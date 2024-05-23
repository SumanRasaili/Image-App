import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vritapp/features/home/model/photos_model.dart';
import 'package:vritapp/widgets/display_image.dart';

class CustomGridView extends StatelessWidget {
  final List<Photo> photos;
 final Widget child;
  const CustomGridView(
      {
        required this.child,
      required this.photos,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: photos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return  child;
      },
    );
  }
}
