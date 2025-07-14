import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/delivery_destination/presentation/widgets/delivery_destinations_screen_widget/delivery_destination_card_with_banner.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/entities/delivery_destination_entity.dart';
import '../bloc/delivery_destination_bloc.dart';
import '../widgets/delivery_destinations_screen_widget/delivery_destination_card_widget.dart';

class DeliveryDestinationsScreen extends StatefulWidget {
  const DeliveryDestinationsScreen({super.key});

  @override
  State<DeliveryDestinationsScreen> createState() =>
      _DeliveryDestinationsScreenState();
}

class _DeliveryDestinationsScreenState
    extends State<DeliveryDestinationsScreen> {
  bool isLoading = true;
  late List<DeliveryDestinationEntity> deliveryDestinations =
      DeliveryDestinationEntity.mockDeliveryDestinations;

  late int currentIndex;

  @override
  void initState() {
    currentIndex = -1;
    BlocProvider.of<DeliveryDestinationBloc>(
      context,
    ).add(FetchDeliveryDestinationsEvent());

    super.initState();
  }

  void onDeliveryDestinationCardSelection(int index) {
    setState(() {
      if (currentIndex == index) {
        currentIndex = -1;
      } else {
        currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go('/home/3');
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: buildAppBar(),
        body: buildBody(context: context),
        floatingActionButton: buildFloatingActionButton(),
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
          context.go('/home/3');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      title: Text(
        'Delivery Destinations',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<DeliveryDestinationBloc>(
            context,
          ).add(FetchDeliveryDestinationsEvent());
          setState(() => isLoading = true);
        },
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(12, 25, 12, 0),
            child: BlocConsumer<
              DeliveryDestinationBloc,
              DeliveryDestinationState
            >(
              builder: (context, state) {
                if (state.deliveryDestinationStatus ==
                    DeliveryDestinationStatus.fetchDeliveryDestinationsError) {
                  return ErrorStateWidget(message: state.message!);
                }
                if (state.deliveryDestinationStatus ==
                    DeliveryDestinationStatus.deleteDeliveryDestinationError) {
                  return ErrorStateWidget(message: state.message!);
                }
                return displayDeliveryDestinations();
              },
              listener: (context, state) {
                if (state.deliveryDestinationStatus ==
                    DeliveryDestinationStatus.loading) {
                  setState(() {
                    isLoading = true;
                  });
                }

                if (state.deliveryDestinationStatus ==
                    DeliveryDestinationStatus.deliveryDestinationsFetched) {
                  setState(() {
                    deliveryDestinations = state.deliveryDestinations!;
                    isLoading = false;
                  });
                }

                if (state.deliveryDestinationStatus ==
                    DeliveryDestinationStatus.deliveryDestinationDeleted) {
                  BlocProvider.of<DeliveryDestinationBloc>(
                    context,
                  ).add(FetchDeliveryDestinationsEvent());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        context.go('/add_delivery_destination');
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 10,
      tooltip: 'Add Delivery Destination',
      child: Icon(Icons.add, size: 35),
    );
  }

  Widget displayDeliveryDestinations() {
    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: true,
      effect: ShimmerEffect(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        duration: Duration(seconds: 1),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ListView.separated(
          itemCount: deliveryDestinations.length,
          itemBuilder: (context, index) {
            deliveryDestinations.sort(
              (a, b) => a.createdAt!.compareTo(b.createdAt!),
            );
            final deliveryDestination = deliveryDestinations[index];
            return InkWell(
              onTap: () {
                onDeliveryDestinationCardSelection(index);
              },
              child:
                  index == 0 && isLoading == false
                      ? DeliveryDestinationCardWithBanner(
                        deliveryDestination: deliveryDestination,
                        isSelected: currentIndex == index,
                        isSelectDestination: false,
                      )
                      : DeliveryDestinationCardWidget(
                        deliveryDestination: deliveryDestination,
                        isSelected: currentIndex == index,
                        isSelectDestination: false,
                      ),
            );
          },
          separatorBuilder:
              (BuildContext context, int index) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}
