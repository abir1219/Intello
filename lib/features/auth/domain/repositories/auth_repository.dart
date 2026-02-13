import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> register(UserEntity user);

  Future<bool> login(String email, String password);

  Future<bool> changePassword(String currentPassword, String newPassword);
  Future<bool> forgotPassword(String email);
  Future<bool> forgotPasswordSubmit(String password);
}
