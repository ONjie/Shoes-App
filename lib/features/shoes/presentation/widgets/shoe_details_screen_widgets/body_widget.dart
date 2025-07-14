import 'package:flutter/material.dart';

import '../../../domain/entities/shoe_entity.dart';
import 'display_shoe_images_widget.dart';
import 'display_shoe_info_widget.dart';


class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key, required this.shoe,});

  final ShoeEntity shoe;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                DisplayShoeImagesWidget(imagesUrls: shoe.images),
                DisplayShoeInfoWidget(shoe: shoe),
              ],
            ),
          ),
        )
    );
  }
}
