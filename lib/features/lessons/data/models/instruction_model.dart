
import '../../domain/entities/lesson.dart';

class InstructionModel extends Instruction {
  const InstructionModel({
    required super.fr,
    required super.moore,
  });

  factory InstructionModel.fromJson(Map<String, dynamic> json) {
    return InstructionModel(
      fr: json['fr'],
      moore: json['moore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fr': fr,
      'moore': moore,
    };
  }
}