import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';

import '../../../../authentication/presentation/bloc/authentication_bloc.dart';

class UserProfileListViewWidget extends StatefulWidget {
  const UserProfileListViewWidget({super.key, required this.user});

  final UserEntity user;

  @override
  State<UserProfileListViewWidget> createState() =>
      _UserProfileListViewWidgetState();
}

class _UserProfileListViewWidgetState extends State<UserProfileListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authenticationStatus == AuthenticationStatus.success) {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
        }
        if (state.authenticationStatus ==
            AuthenticationStatus.noInternetConnection) {}
      },
      child: Column(
        children: [
          buildListTileWidget(
            icon: Icons.lock,
            title: 'Change Password',
            navigateToScreen: () {
              context.go('/change_password/${widget.user.email}');
            },
          ),
          const SizedBox(height: 16),
          buildListTileWidget(
            icon: CupertinoIcons.location_solid,
            title: 'Delivery Destination',
            navigateToScreen: () {},
          ),
          const SizedBox(height: 16),
          buildListTileWidget(
            icon: CupertinoIcons.bag_fill,
            title: 'Order History',
            navigateToScreen: () {},
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildListTileWidget({
    required IconData icon,
    required String title,
    required Function() navigateToScreen,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: navigateToScreen,
      tileColor: Theme.of(context).colorScheme.tertiary,
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: Icon(
        CupertinoIcons.forward,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
