import '../../domain/entities/account_user_entity.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_local_datasource.dart';

class AccountRepositoryImpl implements AccountRepository {

  final AccountLocalDataSource localDataSource;

  AccountRepositoryImpl(this.localDataSource);

  @override
  Future<AccountUserEntity?> getUser() async {
    return localDataSource.getUser();
  }
  @override
  Future<void> updateProfileImage(String path) async {
    await localDataSource.updateProfileImage(path);
  }

  @override
  Future<void> updateProfile({
    required String fullName,
    required String phone,
    required String email,
  }) async {
    await localDataSource.updateProfile(
      fullName: fullName,
      phone: phone,
      email: email,
    );
  }


}
