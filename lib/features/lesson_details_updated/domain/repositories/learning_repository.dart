import '../entities/level.dart';

abstract class LearningRepository {
  Future<List<Level>> getLevels();
}