part of 'learning_bloc.dart';


abstract class LearningState {}

class LearningInitial extends LearningState {}

class LearningLoading extends LearningState {}

class LearningLoaded extends LearningState {
  final List<Level> levels;

  LearningLoaded(this.levels);
}

class LearningError extends LearningState {}