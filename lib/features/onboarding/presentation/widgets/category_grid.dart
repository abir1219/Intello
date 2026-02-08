import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 3 : 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (_, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }
}
