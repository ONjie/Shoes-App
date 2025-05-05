import 'package:flutter/material.dart';

import '../../../features/shoes/domain/entities/shoe_entity.dart';
import '../../core.dart';


class ShoesGridViewWidget extends StatelessWidget {
  const ShoesGridViewWidget({
    super.key,
    required this.shoes,
    required this.screenHeight,
    required this.screenWidth,
  });

 final List<ShoeEntity> shoes;
 final double screenHeight;
 final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        shrinkWrap: true,
          itemCount: shoes.length,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 2,
              childAspectRatio: screenWidth /(screenHeight / 1.6),
          ),
          itemBuilder: (context, index){
          return ShoeCardWidget(shoe: shoes[index],);
          },
      ),
    );
  }
}
