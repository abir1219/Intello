import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';

class CustomCard extends StatelessWidget {
  //final IconData icon;
  final String icon;
  final String title;
  final String subtitle;
  final double progress;
  final Color progressColor;

  const CustomCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: .0,
          color: AppColors.greyColor.withAlpha(20)
        )
      ),
      child: Row(
        children: [
          // Left Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
            ),
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(progressColor, BlendMode.srcIn),
            ),
            /*child: Icon(
              icon,
              color: progressColor,
              size: 26,
            ),*/
          ),
          const SizedBox(width: 16),

          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Circular Progress
          Stack(
            alignment: Alignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 6,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    ),
                  );
                },
              ),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Text(
                    "${(value * 100).toInt()}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
          /*Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
