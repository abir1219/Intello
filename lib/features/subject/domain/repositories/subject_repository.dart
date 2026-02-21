import '../entities/subject_entity.dart';

abstract class SubjectRepository {
  Future<List<SubjectEntity>> getSubjects(
      String levelCode);
}