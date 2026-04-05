part of 'learning_bloc.dart';


abstract class LearningState extends Equatable{}

class LearningInitial extends LearningState {
  @override
  List<Object?> get props => [];
}

class LearningLoading extends LearningState {
  @override
  List<Object?> get props => [];
}

class LearningLoaded extends LearningState {
  // final List<Level> levels;
  // final List<Lesson> lessons;
  final Lesson lessons;
  // final List<Activity> activity;
  final double exercisePercentage;

  LearningLoaded({required this.lessons,required this.exercisePercentage,/*required this.activity*/});
  @override
  List<Object?> get props => [lessons,exercisePercentage,/*activity*/];
}

class LearningError extends LearningState {
  final String message;

   LearningError(this.message);

  @override
  List<Object?> get props => [message];

}