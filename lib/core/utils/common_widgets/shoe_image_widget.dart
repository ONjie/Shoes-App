import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShoeImageWidget extends StatelessWidget {
  const ShoeImageWidget({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.topRightRadius,
    required this.topLeftRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
  });

 final String imageUrl;
 final double width;
 final double height;
 final double topRightRadius;
 final double topLeftRadius;
 final double bottomRightRadius;
 final double bottomLeftRadius;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightRadius),
            topLeft: Radius.circular(topLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            bottomLeft: Radius.circular(bottomLeftRadius),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightRadius),
            topLeft: Radius.circular(topLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            bottomLeft: Radius.circular(bottomLeftRadius),
          ),
          child: imageUrl == 'image' ? SizedBox() : CachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
