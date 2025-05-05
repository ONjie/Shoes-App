import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  final List<String> brandsList = ['Nike', 'Adidas', 'Puma', 'Reebok'];

  final brandLogoList = [
    'nike_logo.png',
    'adidas_logo.png',
    'puma_logo.png',
    'reebok_logo.png',
  ];

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
          child: brandsListView(),
        ),
      ),
    );
  }

  Widget brandsListView() {
    return ListView.separated(
      itemCount: brandsList.length,
      itemBuilder: (context, index) {
        return Column(children: [brandsListTile(index: index)]);
      },
      separatorBuilder:
          (BuildContext context, index) => const SizedBox(height: 8),
    );
  }

  Widget brandsListTile({required int index}) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        context.go('/shoes_by_brand/${brandsList[index]}');
      },
      leading: Image.asset(
        'assets/icons/${brandLogoList[index]}',
        width: 40,
        height: 40,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        brandsList[index],
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
