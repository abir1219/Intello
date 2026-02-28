import 'package:equatable/equatable.dart';

class Lesson  extends Equatable {
  final String id;
  final String title;
  final String instruction;

  const Lesson({
    required this.id,
    required this.title,
    required this.instruction,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id,title,instruction];
}