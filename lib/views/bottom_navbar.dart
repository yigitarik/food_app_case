import 'package:flutter/material.dart';
import 'package:food_mood/core/constants/colors.dart';
import 'package:food_mood/views/favorites_view.dart';
import 'package:food_mood/views/home_view.dart';
import 'package:food_mood/views/my_cart_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class GlobalBottomBar extends StatefulWidget {
  const GlobalBottomBar({super.key});

  @override
  State<GlobalBottomBar> createState() => _GlobalBottomBarState();
}

class _GlobalBottomBarState extends State<GlobalBottomBar> {
  final List<Widget> _views = [
    const HomeView(),
    const MyFavoritesView(),
    MyCartView(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: _views[_currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: AppColors.primaryColor,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text("Likes"),
              selectedColor: AppColors.primaryColor,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.shopping_basket_outlined),
              title: const Text("Cart"),
              selectedColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
