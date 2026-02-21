import '../../domain/entities/subject_entity.dart';
import '../../domain/repositories/subject_repository.dart';
import '../datasources/subject_local_datasource.dart';

class SubjectRepositoryImpl
    implements SubjectRepository {

  final SubjectLocalDataSource localDataSource;

  SubjectRepositoryImpl(this.localDataSource);

  @override
  Future<List<SubjectEntity>> getSubjects(
      String levelCode) {
    return localDataSource
        .getSubjectsByLevel(levelCode);
  }
}