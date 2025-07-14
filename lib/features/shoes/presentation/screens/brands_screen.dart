import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/shoes/domain/entities/brand_entity.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  final List<BrandEntity> brands = BrandEntity.brands;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        context.go('/home/0');
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          context.go('/home/0');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      title: Text('All Brands', style: Theme.of(context).textTheme.titleLarge),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
          child: ListView.separated(
            itemCount: brands.length,
            itemBuilder: (context, index) {
              return Column(children: [brandsListTile(index: index)]);
            },
            separatorBuilder:
                (BuildContext context, index) => const SizedBox(height: 8),
          ),
        ),
      ),
    );
  }

  Widget brandsListTile({required int index}) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        context.go('/shoes_by_brand/${brands[index].brand}');
      },
      leading: Image.asset(
        brands[index].logo,
        width: 40,
        height: 40,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        brands[index].brand,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: Icon(
        CupertinoIcons.forward,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
