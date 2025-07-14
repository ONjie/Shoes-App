import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';
import '../../../authentication/presentation/bloc/authentication_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/user_bloc.dart';
import '../widgets/user_profile_screen_widget/user_details_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserEntity user = UserEntity.mockUser;
  bool isLoading = true;

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(FetchUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: buildAppBar(),
      body: buildBody(context: context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(SignOutEvent());
          },
          icon: Icon(
            Icons.logout_rounded,
            size: 30,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
          child: MultiBlocListener(
            listeners: [
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state.userStatus == UserStatus.loading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
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
              ),
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state.authenticationStatus ==
                      AuthenticationStatus.signOutSuccess) {
                    context.go('/sign_in');
                  }
                  if (state.authenticationStatus ==
                      AuthenticationStatus.signOutError) {
                    snackBarWidget(
                      context: context,
                      message: state.message!,
                      bgColor: Theme.of(context).colorScheme.error,
                      duration: 3,
                    );
                  }
                },
              ),
            ],
            child: Column(
              children: [
                UserDetailsWidget(isLoading: isLoading, user: user),
                const SizedBox(height: 40),
                buildListTileWidget(
                  icon: Icons.lock,
                  title: 'Change Password',
                  navigateToScreen: () {
                    context.go('/change_password/${user.email}');
                  },
                ),
                const SizedBox(height: 16),
                buildListTileWidget(
                  icon: CupertinoIcons.location_solid,
                  title: 'Delivery Destinations',
                  navigateToScreen: () {
                    context.go('/delivery_destinations');
                  },
                ),
                const SizedBox(height: 16),
                buildListTileWidget(
                  icon: CupertinoIcons.bag_fill,
                  title: 'Orders History',
                  navigateToScreen: () {
                    context.go('/orders_history');
                  },
                ),
              ],
            ),
          ),
        ),
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
