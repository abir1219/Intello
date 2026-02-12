import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intello_new/core/constants/app_assets.dart';
import 'package:intello_new/core/utils/responsive.dart';

import '../../../core/constants/app_colors.dart';

class CreatePasswordSuccessDialog extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onContinue;

  const CreatePasswordSuccessDialog({
    super.key,
    required this.onClose,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final width = Responsive.width(context);
    final isTablet = Responsive.isTablet(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isTablet ? width * 0.25 : 24,
      ),
      child: Stack(
        children: [
          /// 🔹 Main Container
          Container(
            padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),

                /// Title
                const Text(
                  "Mot de passe réinitialisé avec succès.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                /// Subtitle
                 Text(
                  "Utilisez votre nouveau mot de passe pour vous connecter.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.TEXT_FIELD_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 32),

                /// Orange Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.CLOSE_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Se connecter maintenant",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        SvgPicture.asset(AppAssets.arrowSign),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 Close Button (Top Right)
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                size: 26,
                color: AppColors.CLOSE_COLOR,
              ),
            ),
          ),
        ],
      ),
    );
  }
}