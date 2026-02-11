import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intello_new/features/onboarding/presentation/pages/category_selection_page.dart';

import '../domain/entities/onboarding_entity.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingEntity data;
  final int pageIndex;
  final ValueListenable<int> currentPage;
  final bool isTablet;
  final bool isLandscape;

  const OnboardingCard({
    super.key,
    required this.data,
    required this.currentPage,
    required this.pageIndex,
    required this.isTablet,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentPage,
      builder: (_, page, __) {
        final bool isActive = page == pageIndex;
        debugPrint("page: $page");
        debugPrint("pageIndex: $pageIndex");

        return page == 0
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 80 : 24,
                  vertical: 32,
                ),
                child: isLandscape
                    ? Row(children: _content(isActive))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _content(isActive),
                      ),
              )
            : CategorySelectionPage();
      },
    );
  }

  List<Widget> _content(bool isActive) {
    return [
      Expanded(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: Image.asset(data.image),
          //SvgPicture.asset(data.image),
        ),
      ),
      const SizedBox(width: 32, height: 32),
      Expanded(
        child: AnimatedScale(
          scale: isActive ? 1.0 : 0.95,
          duration: const Duration(milliseconds: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(data.description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    ];
  }
}
