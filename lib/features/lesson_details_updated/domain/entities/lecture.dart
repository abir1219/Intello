import 'package:equatable/equatable.dart';

class Lecture extends Equatable{
  final String pdf;

  const Lecture({
    required this.pdf
  });

  @override
  List<Object?> get props => [
    pdf
  ];

}