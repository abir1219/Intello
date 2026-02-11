import 'package:flutter/material.dart';
import 'package:intello_new/core/utils/app_dimenstion.dart';

import '../domain/entities/category_entity.dart';
import 'category_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.builder(
      clipBehavior: Clip.none,
      padding:  EdgeInsets.symmetric(horizontal: AppDimensions.getResponsiveWidth(context) * 0.05),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 3 : 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (_, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }
}
