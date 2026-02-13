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

  Future<void> updateProfileImage(String path) async {
    final jsonString = HiveService.userBox.get('registered_user');
    if (jsonString == null) return;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    jsonMap["image_path"] = path;

    await HiveService.userBox.put(
      'registered_user',
      jsonEncode(jsonMap),
    );
  }

  Future<void> updateProfile({
    required String fullName,
    required String phone,
    required String email,
  }) async {

    final jsonString = HiveService.userBox.get('registered_user');
    print("jsonString-->$jsonString");
    if (jsonString == null) return;

    final Map<String, dynamic> jsonMap =
    jsonDecode(jsonString);

    final names = fullName.split(" ");

    jsonMap["first_name"] =
    names.isNotEmpty ? names.first : "";

    jsonMap["last_name"] =
    names.length > 1 ? names.sublist(1).join(" ") : "";

    jsonMap["whatsapp"] = phone;
    jsonMap["email"] = email;

    await HiveService.userBox.put(
      'registered_user',
      jsonEncode(jsonMap),
    );
  }

}
