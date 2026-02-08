import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/core/constants/app_assets.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.go(AppPages.ONBOARDING_SCREEN);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            /// 🔹 Background
            SvgPicture.asset(
              AppAssets.splash_background,
              fit: BoxFit.cover,
            ),

            /// 🔹 Content
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// 🔹 Logo
                    SizedBox(
                      height: isLandscape ? height * 0.35 : height * 0.3,
                      width: isLandscape ? width * 0.25 : width * 0.35,
                      child: SvgPicture.asset(
                        AppAssets.logo,
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    /// 🔹 Tagline
                    Text(
                      "Ta réussite scolaire est notre priorité.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: isLandscape ? 20 : 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
