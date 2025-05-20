import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/user_entity.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildImageCircleAvatar(context: context),
        const SizedBox(height: 10),
        Text(
          user.username.toUpperCase(),
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(user.email, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 12),
        buildEditProfileButton(context: context),
      ],
    );
  }

  Widget buildImageCircleAvatar({required BuildContext context}) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child:
          user.profilePicture.isEmpty
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
                child: CachedNetworkImage(
                  imageUrl: user.profilePicture,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                ),
              ),
    );
  }

  Widget buildEditProfileButton({required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      padding: EdgeInsets.zero,
      child: TextButton(
        onPressed: () {
          context.go('/edit_profile', extra: user);
        },
        child: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
