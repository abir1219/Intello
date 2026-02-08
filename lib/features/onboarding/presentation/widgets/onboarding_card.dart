import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intello_new/features/onboarding/presentation/pages/category_selection_page.dart';

import '../domain/entities/onboarding_entity.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingEntity data;
  final int pageIndex;
  final bool isTablet;
  final bool isLandscape;

  const OnboardingCard({
    super.key,
    required this.data,
    required this.pageIndex,
    required this.isTablet,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    return pageIndex == 0
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 80 : 24,
              vertical: 32,
            ),
            child: isLandscape
                ? Row(children: _content())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _content(),
                  ),
          )
        : CategorySelectionPage();
  }

  List<Widget> _content() {
    return [
      Expanded(
        child: SvgPicture.asset(data.image),
        //Image.asset(data.image),
      ),
      const SizedBox(width: 32, height: 32),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(data.description, textAlign: TextAlign.center),
          ],
        ),
      ),
    ];
  }
}
