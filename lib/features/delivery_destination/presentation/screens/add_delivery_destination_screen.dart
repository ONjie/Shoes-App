import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';

import '../bloc/delivery_destination_bloc.dart';

class AddDeliveryDestinationScreen extends StatefulWidget {
  const AddDeliveryDestinationScreen({super.key});

  @override
  State<AddDeliveryDestinationScreen> createState() =>
      _AddDeliveryDestinationScreenState();
}

class _AddDeliveryDestinationScreenState
    extends State<AddDeliveryDestinationScreen> {
  final _formKey = GlobalKey<FormState>();

  late String country = "";
  late String name = "";
  late String city = "";
  late String googlePlusCode = "";
  late String contactNumber = "";
  late String countryCode = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
        'Add Delivery Destination',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  Widget buildBody({required BuildContext context}) {
    return SafeArea(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(12, 25, 12, 0),
            child:
                BlocListener<DeliveryDestinationBloc, DeliveryDestinationState>(
                  listener: (context, state) {
                    if (state.deliveryDestinationStatus ==
                        DeliveryDestinationStatus.loading) {
                      setState(() {
                        isLoading = true;
                      });
                    }

                    if (state.deliveryDestinationStatus ==
                        DeliveryDestinationStatus.deliveryDestinationAdded) {
                      setState(() {
                        isLoading = false;
                      });
                      context.go('/delivery_destinations');
                    }
                    if (state.deliveryDestinationStatus ==
                        DeliveryDestinationStatus.addDeliveryDestinationError) {
                      setState(() {
                        isLoading = false;
                      });
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
                          label: 'Name',
                          width: double.infinity,
                          onChange: (value) {
                            setState(() => name = value!.trim());
                          },
                        ),
                        const SizedBox(height: 20),
                        buildTextFormField(
                          label: 'Google Plus Code',
                          width: double.infinity,
                          onChange: (value) {
                            setState(() => googlePlusCode = value!.trim());
                          },
                        ),
                        const SizedBox(height: 20),
                        buildTextFormField(
                          label: 'City',
                          width: double.infinity,
                          onChange: (value) {
                            setState(() => city = value!.trim());
                          },
                        ),
                        const SizedBox(height: 20),
                        buildTextFormField(
                          label: 'Country',
                          width: double.infinity,
                          onChange: (value) {
                            setState(() => country = value!.trim());
                          },
                        ),
                        const SizedBox(height: 20),
                        buildCountryCodeAndPhoneNumberWidget(),
                        const SizedBox(height: 60),
                        isLoading ? buildLoadingButton() : buildAddButton(),
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
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
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

  Widget buildCountryCodeAndPhoneNumberWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 65,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
            ),
            child: CountryCodePicker(
              showFlag: false,
              initialSelection: '+220',
              textStyle: Theme.of(context).textTheme.bodyMedium,
              onChanged: (value) {
                setState(() => countryCode = value.toString().trim());
              },
            ),
          ),
        ),
        buildTextFormField(
          label: 'Contact Number',
          width: MediaQuery.of(context).size.width * 0.60,
          onChange: (value) {
            setState(() => contactNumber = value!.trim());
          },
        ),
      ],
    );
  }

  Widget buildAddButton() {
    return ElevatedButtonWidget(
      buttonText: 'Add',
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
          BlocProvider.of<DeliveryDestinationBloc>(context).add(
            AddDeliveryDestinationEvent(
              deliveryDestination: DeliveryDestinationEntity(
                country: country,
                city: city,
                name: name,
                contactNumber: '$countryCode $contactNumber',
                googlePlusCode: googlePlusCode,
                createdAt: DateTime.now(),
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
