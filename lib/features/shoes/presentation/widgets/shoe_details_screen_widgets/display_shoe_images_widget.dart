import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class DisplayShoeImagesWidget extends StatefulWidget {
  const DisplayShoeImagesWidget({super.key, required this.imagesUrls});

  final List<String> imagesUrls;

  @override
  State<DisplayShoeImagesWidget> createState() =>
      _DisplayShoeImagesWidgetState();
}

class _DisplayShoeImagesWidgetState extends State<DisplayShoeImagesWidget> {
  late int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items:
              widget.imagesUrls.map((imageUrl) {
                return ShoeImageWidget(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  height: 350,
                  topRightRadius: 0,
                  topLeftRadius: 0,
                  bottomRightRadius: 0,
                  bottomLeftRadius: 0,
                );
              }).toList(),
          options: CarouselOptions(
            height: 350,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged:
                (index, reason) => setState(() => currentImageIndex = index),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.15,
          bottom: 8,
          child: SizedBox(
            height: 60,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.imagesUrls.length,
              itemBuilder: (context, index) {
                return shoeImagesButtons(index: index);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget shoeImagesButtons({required int index}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              currentImageIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
        ),
      ),
      width: 60,
      height: 60,
      child: ShoeImageWidget(
        imageUrl: widget.imagesUrls[index],
        width: 60,
        height: 60,
        topRightRadius: 10,
        topLeftRadius: 10,
        bottomRightRadius: 10,
        bottomLeftRadius: 10,
      ),
    );
  }
}
