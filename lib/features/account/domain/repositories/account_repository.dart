import '../entities/account_user_entity.dart';

abstract class AccountRepository {
  Future<AccountUserEntity?> getUser();

  Future<void> updateProfileImage(String path);

  Future<void> updateProfile({
    required String fullName,
    required String phone,
    required String email,

  });
}
