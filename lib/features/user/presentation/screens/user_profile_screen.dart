import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_app/core/core.dart';

import '../bloc/user_bloc.dart';
import '../widgets/user_profile_screen_widget/user_details_widget.dart';
import '../widgets/user_profile_screen_widget/user_profile_list_view_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
          onPressed: () {},
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
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.userStatus == UserStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }

              if (state.userStatus == UserStatus.userFetched) {
                return Column(
                  children: [
                    UserDetailsWidget(user: state.user!),
                    const SizedBox(height: 40),
                    UserProfileListViewWidget(user: state.user!),
                  ],
                );
              }

              if (state.userStatus == UserStatus.fetchUserError) {
                return ErrorStateWidget(message: state.errorMessage!);
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
