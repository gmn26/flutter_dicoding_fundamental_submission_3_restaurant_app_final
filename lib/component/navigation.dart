import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBottom extends StatelessWidget {
  const NavBottom({super.key, required this.navIndex});

  final int navIndex;

  void changeUI(int destination) {
    if (destination == 0) {
      Get.offNamed(
        '/',
      );
    } else if (destination == 1) {
      Get.offNamed(
        '/favorite-restaurant',
      );
    } else if (destination == 2) {
      Get.offNamed(
        '/setting',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        changeUI(index);
      },
      selectedIndex: navIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: "Favorite",
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: "Setting",
        ),
      ],
    );
  }
}
