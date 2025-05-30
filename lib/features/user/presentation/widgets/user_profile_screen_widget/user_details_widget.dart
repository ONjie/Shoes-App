import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/entities/user_entity.dart';

class UserDetailsWidget extends StatefulWidget {
  const UserDetailsWidget({super.key});

  @override
  State<UserDetailsWidget> createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  late UserEntity user = UserEntity(
    username: 'username',
    email: 'email',
    profilePicture: '',
  );
  bool isLoading = true;

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(FetchUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: false,
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.userStatus == UserStatus.userFetched) {
            setState(() {
              user = state.user!;
              isLoading = false;
            });
          }
          if (state.userStatus == UserStatus.fetchUserError) {
            snackBarWidget(
              context: context,
              message: state.errorMessage!,
              bgColor: Theme.of(context).colorScheme.error,
              duration: 10,
            );
          }
        },
        child: Column(
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
        ),
      ),
    );
  }

  Widget buildImageCircleAvatar({required BuildContext context}) {
    return Skeleton.leaf(
      child: Container(
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
      ),
    );
  }

  Widget buildEditProfileButton({required BuildContext context}) {
    return Skeleton.leaf(
      child: Container(
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
      ),
    );
  }
}
