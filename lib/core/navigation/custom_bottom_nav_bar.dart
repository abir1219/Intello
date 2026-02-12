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
    /// Store ONLY asset paths (not SvgPicture widgets)
    final List<String> icons = [
      AppAssets.homeMenu,
      AppAssets.accountMenu,
      AppAssets.homeMenu,
      AppAssets.settings,
    ];

    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          /// Green Background Bar
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

          /// Navigation Items
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(icons.length, (index) {
                final bool isActive = selectedIndex == index;

                return GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    transform: Matrix4.translationValues(
                      0,
                      isActive ? -30 : 0,
                      0,
                    ),

                    /// THIS MAKES IT MOVE UP
                    //margin: EdgeInsets.only(bottom: isActive ? 30 : 0),
                    height: isActive ? 60 : 45,
                    width: isActive ? 60 : 45,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white//AppColors.whiteColor
                          : AppColors.TRANSPARENT_COLOR,
                      // borderRadius: BorderRadius.circular(40)
                      shape: BoxShape.circle,
                      /*boxShadow: isActive
                            ? [
                          BoxShadow(
                            blurRadius: 15,
                            spreadRadius: 3,
                            color: Colors.black.withValues(alpha: 0.2),
                          )
                        ]
                            : [],*/
                    ),
                    child: Center(
                      child: Container(
                        height: isActive ? 40 : 35,
                        width: isActive ? 40 : 35,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.blueColor
                              : AppColors.textColor,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          icons[index],
                          // height: isActive ? 28 :24,
                          // width: isActive ? 28 :24,
                          colorFilter: ColorFilter.mode(
                            AppColors.whiteColor,
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
