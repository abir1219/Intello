import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimenstion.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  Color color;
  bool logoVisible;
  final VoidCallback onPressed;

  PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = AppColors.blueColor,
    this.logoVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    final width = AppDimensions.getResponsiveWidth(context);

    return SizedBox(
      width: width * 0.6, // tablet friendly
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
            const SizedBox(width: 8),
            logoVisible ? SvgPicture.asset(AppAssets.arrowSign) : SizedBox(),
            /*const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 22,
            ),*/
          ],
        ),
      ),
    );
  }
}
