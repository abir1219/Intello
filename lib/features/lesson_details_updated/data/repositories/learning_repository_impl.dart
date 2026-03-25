import '../../domain/entities/level.dart';
import '../../domain/repositories/learning_repository.dart';
import '../datasources/learning_local_datasource.dart';

class LearningRepositoryImpl implements LearningRepository {
  final LearningLocalDataSource localDataSource;

  LearningRepositoryImpl(this.localDataSource);

  @override
  Future<List<Level>> getLevels() {
    return localDataSource.getLevels();
  }
}