import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../user/presentation/screens/user_profile_screen.dart';
import 'favorite_shoes_screen.dart';
import 'shoes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.screenIndex});

  final int screenIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  late int tapCount = 0;
  late int currentIndex = 0;
  final screens = [const ShoesScreen(), const FavoriteShoesScreen(), const CartScreen(), const UserProfileScreen()];
  late Widget currentScreen;

  @override
  void initState() {
    currentIndex = widget.screenIndex;
    currentScreen = screens[currentIndex];
    super.initState();
  }

  void changeScreen({required int selectedIndex}){
    setState(() {
      currentIndex = selectedIndex;
      currentScreen = screens[selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result){
        if(didPop){
          return;
        }
        tapCount++;

        if(tapCount == 1){
          showToast(context: context);
        }
        else if(tapCount == 2){
          exit(0);
        }
        else{
          tapCount = 0;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: currentScreen,
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }


  Widget buildBottomNavigationBar(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/home.png',), size: 19,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline_rounded),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/cart.png',), size: 24,),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/user.png',), size: 24,),
          label: 'Profile',
        ),
      ],
      elevation: 10,
      currentIndex: currentIndex,
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.8),
      onTap: (selectedIndex) => changeScreen(selectedIndex: selectedIndex),
    );
  }


}
