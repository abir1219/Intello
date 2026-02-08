import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../data/models/onboarding_model.dart';
import '../widgets/onboarding_card.dart';
import '../widgets/page_indicator.dart';
import '../widgets/primary_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  AppAssets.background,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    SizedBox(height: height * 0.03),
                    SizedBox(
                      height: isLandscape ? height * 0.15 : height * 0.18,
                      width: isLandscape ? width * 0.2 : width * 0.2,
                      child: SvgPicture.asset(
                        AppAssets.logo,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Expanded(
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: onboardingData.length,
                        onPageChanged: (index) {
                          setState(() => _currentIndex = index);
                        },
                        itemBuilder: (_, index) {
                          return OnboardingCard(
                            data: onboardingData[index],
                            pageIndex:_currentIndex,
                            isTablet: isTablet,
                            isLandscape: orientation == Orientation.landscape,
                          );
                        },
                      ),
                    ),
                    PageIndicator(
                      currentIndex: _currentIndex,
                      itemCount: onboardingData.length,
                    ),

                    SizedBox(height: height * 0.04),

                    /// 🔹 CTA Button
                    PrimaryButton(
                      title: _currentIndex == onboardingData.length - 1
                          ? "Commencer"
                          : "Suivant",
                      onPressed: () {
                        if (_currentIndex < onboardingData.length - 1) {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Navigate to Language Selection / Home
                        }
                      },
                    ),

                    /// 🔹 Skip Button
                    TextButton(
                      onPressed: () {
                        // Skip onboarding
                      },
                      child: const Text(
                        "Ignorer",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.03),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
