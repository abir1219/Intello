import 'package:equatable/equatable.dart';

class Option extends Equatable {
  final String id;
  final String value;

  const Option({
    required this.id,
    required this.value,
  });

  @override
  List<Object> get props => [id, value];
}