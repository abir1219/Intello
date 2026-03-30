import '../../domain/entities/lesson.dart';

class InstructionModel extends Instruction {
  const InstructionModel({required super.fr, required super.moore});

  factory InstructionModel.fromJson(Map<String, dynamic> json) {
    return InstructionModel(fr: json['fr'], moore: json['moore']);
  }

  Map<String, dynamic> toJson() {
    return {'fr': fr, 'moore': moore};
  }
}

class LirePlusModel extends LirePlus {
  const LirePlusModel({
    required super.extendedContent,
    required super.enabled,
    required super.buttonLabel,
  });

  factory LirePlusModel.fromJson(Map<String, dynamic> json) {
    return LirePlusModel(
      enabled: json['enabled'] ?? false,
      buttonLabel: json['button_label'] ?? '',
      extendedContent: json['extended_content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'extended_content': extendedContent,
      'enabled': enabled,
      'button_label': buttonLabel,
    };
  }
}
