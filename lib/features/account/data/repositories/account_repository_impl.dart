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
}
