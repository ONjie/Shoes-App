import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/core.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/user_bloc.dart';
import '../widgets/edit_profile_screen_widgets/select_image_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user});

  final UserEntity user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String username = widget.user.username;
  late String profilePicture = widget.user.profilePicture;
  File? selectedImage;
  bool isLoading = false;

  Future pickImage() async {
    final hasPermission = await GalleryPermission().requestGalleryPermission();

    if (!hasPermission) return;

    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;

    final selectedImageFile = File(pickedFile.path);

    setState(() {
      selectedImage = selectedImageFile;
      profilePicture = selectedImage!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        context.go('/home/3');
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: buildAppBar(context: context),
        body: buildBody(context: context),
      ),
    );
  }

  AppBar buildAppBar({required BuildContext context}) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      leading: IconButton(
        onPressed: () {
          context.go('/home/3');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      title: Text(
        'Edit Profile',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
            child: BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state.userStatus == UserStatus.loading) {
                  setState(() {
                    isLoading = true;
                  });
                }

                if (state.userStatus == UserStatus.userProfileUpdated) {
                  setState(() {
                    isLoading = false;
                  });
                  context.go('/home/3');
                }

                if (state.userStatus == UserStatus.updateUserProfileError) {
                  setState(() {
                    isLoading = false;
                  });
                  snackBarWidget(
                    message: state.errorMessage!,
                    bgColor: Theme.of(context).colorScheme.error,
                    duration: 3,
                    context: context,
                  );
                }
              },
              child: Column(
                children: [
                  SelectImageWidget(
                    onPressed: () async {
                      await pickImage();
                    },
                    user: widget.user,
                    selectedImage: selectedImage,
                  ),
                  const SizedBox(height: 50),
                  Form(key: _formKey, child: buildUsernameTextFormField()),
                  const SizedBox(height: 80),
                  isLoading == false
                      ? buildSaveButton()
                      : buildLoadingButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUsernameTextFormField() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: textFormFieldDecorationWidget(
          borderRadius: 12,
          borderSideColor: Theme.of(context).colorScheme.primary,
          filled: true,
          fillColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.1),
          context: context,
          hintTextColor: Theme.of(
            context,
          ).colorScheme.secondary.withValues(alpha: 0.8),
          hintText: 'Username',
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Username cannot be empty';
          }
          return null;
        },
        onChanged: (value) {
          setState(() => username = value.trim());
        },
      ),
    );
  }

  Widget buildSaveButton() {
    return ElevatedButtonWidget(
      buttonText: 'Save',
      textColor: Theme.of(context).colorScheme.surface,
      textFontSize: 20,
      buttonWidth: double.infinity,
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      radius: 10,
      borderSideColor: Theme.of(context).colorScheme.primary,
      borderSideWidth: 0,
      padding: EdgeInsets.all(10),
      onPressed: () {
        BlocProvider.of<UserBloc>(context).add(
              UpdateUserProfileEvent(
                user: widget.user,
                newProfilePicture: selectedImage,
                newUsername: username,
              ),
            );
      },
    );
  }

  Widget buildLoadingButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(10),
      child: Center(
        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.surface,),
      ),
    );
  }
}
