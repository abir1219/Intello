import 'package:equatable/equatable.dart';

abstract class SubjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSubjectsEvent extends SubjectEvent {
  final String levelCode;

  LoadSubjectsEvent(this.levelCode);

  @override
  List<Object?> get props => [levelCode];
}