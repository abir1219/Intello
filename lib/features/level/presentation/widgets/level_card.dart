import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intello_new/core/constants/app_assets.dart';
import 'package:intello_new/core/constants/app_colors.dart';

import '../../domain/entity/level_entity.dart';

class LevelCard extends StatelessWidget {
  final LevelEntity level;
  final bool isSelected;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? level.level == 1
                    ? AppColors.blueColor
                    : level.level == 2
                    ? AppColors.CLOSE_COLOR
                    : AppColors.greenColor
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: level.level == 1
                ? AppColors.blueColor
                : level.level == 2
                ? AppColors.CLOSE_COLOR
                : AppColors.greenColor,
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.level,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? AppColors.whiteColor
                    : level.level == 1
                    ? AppColors.blueColor
                    : level.level == 2
                    ? AppColors.CLOSE_COLOR
                    : AppColors.greenColor,
                BlendMode.srcIn,
              ),
            ),
            Text(
              level.code,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.whiteColor
                    : level.level == 1
                    ? AppColors.blueColor
                    : level.level == 2
                    ? AppColors.CLOSE_COLOR
                    : AppColors.greenColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              level.title,
              style: TextStyle(
                color: isSelected
                    ? AppColors.whiteColor
                    : level.level == 1
                    ? AppColors.blueColor
                    : level.level == 2
                    ? AppColors.CLOSE_COLOR
                    : AppColors.greenColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
