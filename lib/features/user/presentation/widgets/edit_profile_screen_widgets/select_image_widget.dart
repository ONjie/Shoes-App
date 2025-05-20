import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';

class SelectImageWidget extends StatelessWidget {
  const SelectImageWidget({
    super.key,
    required this.onPressed,
    required this.user,
    this.selectedImage
  });

  final Function()? onPressed;
  final UserEntity user;
  final File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ProfilePictureWidget(user: user, height: 200, width: 200, selectedImage: selectedImage,),
        Positioned(
          right: 8,
          bottom: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.add_a_photo_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
