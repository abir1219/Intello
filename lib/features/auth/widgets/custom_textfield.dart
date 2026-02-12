import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intello_new/core/constants/app_assets.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';

class CustomTextField {
  static Widget buildTextFieldWithLabel({
    required BuildContext context,
    required TextEditingController? controller,
    required String hintText,
    required String label,
    TextInputType? keyboardType,
    int maxLength = 100,
    bool obscureText = false,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      height: Responsive.isLandscape(context)
          ? MediaQuery.sizeOf(context).height * 0.12
          : MediaQuery.sizeOf(context).height * 0.07,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background container
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Container(
              // height: 65,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                //borderSide: BorderSide(color: Colors.white.withAlpha(70), width: 1.5),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.blueColor, width: 0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  maxLength: maxLength,
                  style: TextStyle(
                    color: AppColors.TEXT_FIELD_COLOR,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    suffixIcon: obscureText
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              AppAssets.lockSign,
                              height: 20,
                              width: 10,
                            ),
                          )
                        : null,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    counterText: '',
                    isDense: true,
                  ),
                  validator: validator,
                ),
              ),
            ),
          ),

          // Floating label
          Positioned(
            top: 0,
            left: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: AppColors.TEXT_FIELD_BACKGROUND_WHITE_COLOR.withAlpha(220),
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.TEXT_FIELD_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
