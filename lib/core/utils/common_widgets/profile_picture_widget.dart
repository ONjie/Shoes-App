import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    required this.user,
    this.selectedImage,
    required this.height,
    required this.width,
  });

  final UserEntity user;
  final File? selectedImage;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child:
          user.profilePicture.isEmpty && selectedImage == null
              ? Center(
                child: Text(
                  user.username[0].toUpperCase(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              )
              : ClipRRect(
                child:
                    selectedImage == null
                        ? CachedNetworkImage(
                          imageUrl: user.profilePicture,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                        )
                        : Image.file(selectedImage!, fit: BoxFit.cover),
              ),
    );
  }
}
