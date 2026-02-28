import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intello_new/features/lessons/domain/entities/lesson.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final bool isSelected;
  final VoidCallback onTap;
  const LessonCard({super.key, required this.lesson, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1565C0) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSelected ? AppAssets.selected_level_image:AppAssets.unselected_level_image,
              /*colorFilter: ColorFilter.mode(
                isSelected ? AppColors.whiteColor : AppColors.blueShadowColor,
                BlendMode.srcIn,
              ),*/
              height: 40,
              width: 40,
            ),
            Text(
              lesson.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              lesson.instruction,
              style: TextStyle(
                color: isSelected ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
