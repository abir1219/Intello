import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../domain/entities/subject_entity.dart';

class SubjectCard extends StatelessWidget {
  final SubjectEntity subject;
  final bool isSelected;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.isSelected,
    required this.onTap,
  });

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Book Icon
            /*Icon(
              Icons.menu_book,
              size: 40,
              color: isSelected ? Colors.white : Colors.orange,
            ),*/
            SvgPicture.asset(
              AppAssets.subject_image,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.whiteColor : AppColors.CLOSE_COLOR,
                BlendMode.srcIn,
              ),
              height: 40,
              width: 40,
            ),

            const SizedBox(width: 16),

            /// Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subject.subtitle,
                    style: TextStyle(
                      color: isSelected ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            /// Arrow Button
            // const SizedBox(width: 8),
            SvgPicture.asset(
              AppAssets.arrowSign,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.whiteColor : AppColors.textColor,
                BlendMode.srcIn,
              ),
            ),
            /*Container(
              height: 30,
              width: 30,
              decoration:
              BoxDecoration(
                color: isSelected
                    ? Colors.white24
                    : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward,
                size: 16,
                color: isSelected
                    ? Colors.white
                    : Colors.grey,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
