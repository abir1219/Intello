import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/category_model.dart';

abstract class CategoryLocalDatasource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryLocalDatasourceImpl implements CategoryLocalDatasource {
  @override
  Future<List<CategoryModel>> getCategories() async {
    final jsonStr =
    await rootBundle.loadString('assets/json/onboarding.json');

    debugPrint("jsonStr==>$jsonStr");
    final Map<String, dynamic> jsonMap = json.decode(jsonStr);
    debugPrint("jsonMap==>$jsonMap");
    return (jsonMap['categories'] as List)
        .where((e) => e['isEnabled'] == true)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }
}
