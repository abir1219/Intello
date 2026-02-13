import '../entities/account_user_entity.dart';

abstract class AccountRepository {
  Future<AccountUserEntity?> getUser();
}
