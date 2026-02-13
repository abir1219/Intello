import 'dart:convert';
import '../../../../core/storage/hive_service.dart';
import '../models/account_user_model.dart';

class AccountLocalDataSource {

  AccountUserModel? getUser() {
    final jsonString =
    HiveService.userBox.get('registered_user');

    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap =
    jsonDecode(jsonString);

    return AccountUserModel.fromJson(jsonMap);
  }
}
