import '../../domain/entity/option.dart';

class OptionModel extends Option {
  const OptionModel({
    required super.id,
    required super.value,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "value": value,
    };
  }
}