import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<void> register(UserEntity user) async {
    final userModel = UserModel(
      firstName: user.firstName,
      lastName: user.lastName,
      whatsapp: user.whatsapp,
      email: user.email,
      password: user.password,
    );

    await localDataSource.saveUser(userModel);
  }

  @override
  Future<bool> login(String email, String password) async {
    final result = localDataSource.login(email, password);

    if (result) {
      await localDataSource.setLoggedIn(true);
    }

    return result;
  }

  @override
  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    return await localDataSource.changePassword(currentPassword, newPassword);
  }

  @override
  Future<bool> forgotPassword(String phone) async {
    return localDataSource.checkPhoneExists(phone);
  }

  @override
  Future<bool> forgotPasswordSubmit(String password) {
    return localDataSource.submitForgotPassword(password);
  }
}
