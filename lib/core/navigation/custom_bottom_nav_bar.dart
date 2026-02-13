import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intello_new/core/constants/app_colors.dart';

import '../constants/app_assets.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      AppAssets.homeMenu,
      AppAssets.accountMenu,
      AppAssets.laughingMenu,
      AppAssets.settings,
    ];

    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          /// Green Background
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          /// Items
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(icons.length, (index) {
                final isActive = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    onItemSelected(index); // ✅ IMPORTANT
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 850),
                    transform: Matrix4.translationValues(
                      0,
                      isActive ? -30 : 0,
                      0,
                    ),
                    height: isActive ? 60 : 45,
                    width: isActive ? 60 : 45,
                    decoration: BoxDecoration(
                      color:
                      // isActive ? Colors.white : Colors.transparent,
                      isActive ? AppColors.TEXT_FIELD_BACKGROUND_BLUE_COLOR : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        height: isActive ? 40 : 35,
                        width: isActive ? 40 : 35,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.blueColor
                              : AppColors.textColor,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          icons[index],
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
