import '../entities/level.dart';
import '../repositories/learning_repository.dart';

class GetLevels {
  final LearningRepository repository;

  GetLevels(this.repository);

  Future<List<Level>> call() async {
    return await repository.getLevels();
  }
}