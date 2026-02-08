import 'package:flutter/material.dart';

import '../data/datasource/category_local_datasource.dart';
import '../widgets/category_grid.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  late Future languagesFuture;

  @override
  void initState() {
    super.initState();
    languagesFuture = CategoryLocalDatasourceImpl().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:
      FutureBuilder(
        future: languagesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Expanded(child: CategoryGrid(categories: snapshot.data!));
        },
      ),
    );
  }
}
