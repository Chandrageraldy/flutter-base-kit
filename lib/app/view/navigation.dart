import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_base_kit/app/assets/color_manager.dart';
import 'package:flutter_base_kit/app/assets/constants.dart';
import 'package:flutter_base_kit/l10n/l10n.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key, required this.child, required this.location});

  final Widget child;
  final String location;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  var navBarItems = <GoRouterBottomNavBarItem>[];

  void _onTabItemTapped(BuildContext context, int index) {
    if (index == _selectedIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = navBarItems[index].initialLocation ?? '';

    setState(() {
      _selectedIndex = index;
    });
    router.go(location);
  }

  @override
  Widget build(BuildContext context) {
    navBarItems = <GoRouterBottomNavBarItem>[
      // CONFIGURE NAVIGATION BAR ITEM
      GoRouterBottomNavBarItem(
        icon: const Icon(Icons.home),
        activeIcon: const Icon(Icons.home_filled),
        label: context.l10n.dumdumTitle,
        initialLocation: NavigatePath.homeScreen1,
      ),
      GoRouterBottomNavBarItem(
        icon: const Icon(Icons.home),
        activeIcon: const Icon(Icons.home_filled),
        label: context.l10n.dumdumTitle,
        initialLocation: NavigatePath.homeScreen2,
      ),
      // ADD MORE NAVIGATION ITEM BELOW
    ];
    int currentIndex =
        widget.location == NavigatePath.homeScreen1 ? NavigatorRouteItem.home1 : NavigatorRouteItem.home2;
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: StylesManager.selectedLabelStyle,
        unselectedLabelStyle: StylesManager.unselectedLabelStyle,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorManager.lightBlueColor,
        items: navBarItems,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (int index) => _onTabItemTapped(context, index),
      ),
    );
  }
}

class GoRouterBottomNavBarItem extends BottomNavigationBarItem {
  final String? initialLocation;

  const GoRouterBottomNavBarItem({this.initialLocation, required Widget icon, Widget? activeIcon, String? label})
      : super(icon: icon, activeIcon: activeIcon ?? icon, label: label);
}
