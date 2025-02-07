import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/navbar_controller.dart';
import 'package:crater/view/home_page/home_screen.dart';
import 'package:crater/view/unpaid_orders_screen/unpaid_order.dart';
import 'package:crater/view/update_price/update_price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final NavBarController navbarVM = Get.put(NavBarController());
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: navbarVM.index.value);
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      UnpaidOrderScreen(),
      UpdatePriceScreen(), // Replace with the actual screen for index 2
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.list_alt_rounded),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.app_registration),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarHeight: 60.h,
      backgroundColor: AppColors.secondary,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
      stateManagement: false,
      navBarStyle: NavBarStyle.style6, // Adjust style as needed
      onItemSelected: (index) {
        navbarVM.index.value = index;
      },
    );
  }
}
