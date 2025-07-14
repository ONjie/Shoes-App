import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';

import '../../../../core/core.dart';
import '../bloc/delivery_destination_bloc.dart';

class EditDeliveryDestinationScreen extends StatefulWidget {
  const EditDeliveryDestinationScreen({
    super.key,
    required this.deliveryDestination,
  });

  final DeliveryDestinationEntity deliveryDestination;

  @override
  State<EditDeliveryDestinationScreen> createState() =>
      _EditDeliveryDestinationScreenState();
}

class _EditDeliveryDestinationScreenState
    extends State<EditDeliveryDestinationScreen> {
  final _formKey = GlobalKey<FormState>();

  late int? id = widget.deliveryDestination.id!;
  late String country = widget.deliveryDestination.country;
  late String name = widget.deliveryDestination.name;
  late String city = widget.deliveryDestination.city;
  late String googlePlusCode = widget.deliveryDestination.googlePlusCode;
  late String contactNumber = widget.deliveryDestination.contactNumber;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        context.go('/delivery_destinations');
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: buildAppBar(),
        body: buildBody(context: context),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      leading: IconButton(
        onPressed: () {
          context.go('/delivery_destinations');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      title: Text(
        'Edit Delivery Destination',
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
            padding: const EdgeInsets.fromLTRB(12, 25, 12, 0),
            child:
                BlocListener<DeliveryDestinationBloc, DeliveryDestinationState>(
                  listener: (context, state) {
                    if (state.deliveryDestinationStatus ==
                        DeliveryDestinationStatus.deliveryDestinationUpdated) {
                      context.go('/delivery_destinations');
                      setState(() => isLoading = false);
                    }
                    if (state.deliveryDestinationStatus ==
                        DeliveryDestinationStatus
                            .updateDeliveryDestinationError) {
                      setState(() => isLoading = false);
                      snackBarWidget(
                        context: context,
                        message: state.message!,
                        bgColor: Theme.of(context).colorScheme.error,
                        duration: 3,
                      );
                    }
                  },
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextFormField(
                          label: 'Country',
                          width: double.infinity,
                          onChange: (value) {
                            setState(() => country = value!.trim());
                          },
                          initialValue: country,
                        ),
                        const SizedBox(height: 20),
                        buildTextFormField(
                          label: 'Name',
                          width: double.infinity,
                          onChange: (value) {
                            setState(() => name = value!.trim());
                          },
                          initialValue: name,
                        ),
                        const SizedBox(height: 20),
                        buildTextFormField(
                          label: 'City',
                          width: double.infinity,
                          onChange: (value) {
                            setState(() => city = value!.trim());
                          },
                          initialValue: city,
                        ),
                        const SizedBox(height: 20),
                        buildTextFormField(
                          label: 'Google Plus Code',
                          width: double.infinity,
                          onChange: (value) {
                            setState(() => googlePlusCode = value!.trim());
                          },
                          initialValue: googlePlusCode,
                        ),
                        const SizedBox(height: 20),
                        buildTextFormField(
                          label: 'Contact Number',
                          width: double.infinity,
                          onChange: (value) {
                            setState(() => contactNumber = value!.trim());
                          },
                          initialValue: contactNumber,
                        ),
                        const SizedBox(height: 60),
                        isLoading ? buildLoadingButton() : buildUpdateButton(),
                      ],
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required String label,
    required double width,
    required Function(String?) onChange,
    required initialValue,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: textFormFieldDecorationWidget(
          filled: true,
          fillColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.1),
          hintText: 'Enter $label',
          hintTextColor: Theme.of(
            context,
          ).colorScheme.secondary.withValues(alpha: 0.6),
          borderRadius: 12,
          borderSideColor: Theme.of(context).colorScheme.primary,
          context: context,
          showPrefixIcon: false,
          showSuffixIcon: false,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return '$label cannot be empty';
          }
          return null;
        },
        onChanged: onChange,
      ),
    );
  }

  Widget buildUpdateButton() {
    return ElevatedButtonWidget(
      buttonText: 'Update',
      textColor: Theme.of(context).colorScheme.surface,
      textFontSize: 20,
      buttonWidth: double.infinity,
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      radius: 10,
      borderSideColor: Theme.of(context).colorScheme.primary,
      borderSideWidth: 1,
      padding: EdgeInsets.all(12),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() => isLoading = true);
          BlocProvider.of<DeliveryDestinationBloc>(context).add(
            UpdateDeliveryDestinationEvent(
              deliveryDestination: DeliveryDestinationEntity(
                id: id,
                country: country,
                city: city,
                name: name,
                contactNumber: contactNumber,
                googlePlusCode: googlePlusCode,
                createdAt: widget.deliveryDestination.createdAt
              ),
            ),
          );
        }
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
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
