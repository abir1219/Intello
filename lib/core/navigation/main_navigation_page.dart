import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intello_new/core/constants/app_assets.dart';
import 'package:intello_new/core/constants/app_colors.dart';
import 'package:intello_new/features/account/presentation/pages/profile_page.dart';

import 'custom_bottom_nav_bar.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 1;

  final List<Widget> _pages = const [
    Center(child: Text("Home Page")),
    ProfilePage(),
    Center(child: Text("Profile Page")),
    Center(child: Text("Games Page")),
    Center(child: Text("Settings Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );

      /*Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: AppColors.greenColor,
        style: TabStyle.titled,
        initialActiveIndex: 1,
        curve: Curves.easeIn,
        color: AppColors.whiteColor,
        activeColor: AppColors.whiteColor,
        items: [
          TabItem(icon: buildIcon(AppAssets.homeMenu, 0),title: " "),
          TabItem(icon: buildIcon(AppAssets.accountMenu, 1),title: " "),
          TabItem(icon: buildIcon(AppAssets.homeMenu, 2),title: " "),
          TabItem(icon: buildIcon(AppAssets.homeMenu, 3),title: " "),
          TabItem(icon: buildIcon(AppAssets.homeMenu, 4),title: " "),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );*/
  }


  Widget buildIcon(String asset, int index) {
    final isActive = _currentIndex == index;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.blueColor : Colors.transparent,
      ),
      padding: const EdgeInsets.all(12),
      child: SvgPicture.asset(
        asset,
        colorFilter: ColorFilter.mode(
          isActive ? Colors.white : Colors.white.withOpacity(0.7),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
