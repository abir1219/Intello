import 'dart:convert';
import '../../../../core/storage/hive_service.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {

  Future<void> saveUser(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());
    await HiveService.userBox.put('registered_user', jsonString);
  }

  UserModel? getUser() {
    final jsonString = HiveService.userBox.get('registered_user');
    if (jsonString == null) return null;
    return UserModel.fromJson(jsonDecode(jsonString));
  }

  /// 🔐 LOGIN CHECK
  bool login(String email, String password) {
    final storedUser = getUser();

    if (storedUser == null) return false;

    return storedUser.email == email &&
        storedUser.password == password;
  }

  /// Optional session flag
  Future<void> setLoggedIn(bool value) async {
    await HiveService.userBox.put('is_logged_in', value);
  }

  bool isLoggedIn() {
    return HiveService.userBox.get('is_logged_in', defaultValue: false);
  }

  Future<bool> changePassword(
      String currentPassword,
      String newPassword,
      ) async {
    final user = getUser();
    if (user == null) return false;

    if (user.password != currentPassword) {
      return false;
    }

    final updatedUser = user.copyWith(password: newPassword);

    final jsonString = jsonEncode(updatedUser.toJson());
    await HiveService.userBox.put('registered_user', jsonString);

    return true;
  }

  bool checkPhoneExists(String phone) {
    final user = getUser();
    if (user == null) return false;
    return user.whatsapp == phone;
  }

  Future<bool> submitForgotPassword(
      String newPassword,
      ) async {
    final user = getUser();
    if (user == null) return false;

    final updatedUser = user.copyWith(password: newPassword);

    final jsonString = jsonEncode(updatedUser.toJson());
    await HiveService.userBox.put('registered_user', jsonString);

    return true;
  }

}
