import 'package:equatable/equatable.dart';

class Game extends Equatable {
  final String type;
  final String instruction;
  final dynamic data;

  const Game({
    required this.type,
    required this.instruction,
    this.data,
  });

  @override
  List<Object?> get props => [type, instruction, data];
}