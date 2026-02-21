import 'package:equatable/equatable.dart';
import '../../domain/entities/subject_entity.dart';

abstract class SubjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubjectInitial extends SubjectState {}

class SubjectLoading extends SubjectState {}

class SubjectLoaded extends SubjectState {
  final List<SubjectEntity> subjects;

  SubjectLoaded(this.subjects);

  @override
  List<Object?> get props => [subjects];
}

class SubjectFailure extends SubjectState {
  final String message;

  SubjectFailure(this.message);

  @override
  List<Object?> get props => [message];
}