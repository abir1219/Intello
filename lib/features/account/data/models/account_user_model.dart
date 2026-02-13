import '../../domain/entities/account_user_entity.dart';

class AccountUserModel extends AccountUserEntity {

  AccountUserModel({
    required super.firstName,
    required super.lastName,
    required super.whatsapp,
    required super.email,
    super.imagePath,
  });

  factory AccountUserModel.fromJson(Map<String, dynamic> json) {
    return AccountUserModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      whatsapp: json["whatsapp"],
      email: json["email"],
      imagePath: json["image_path"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "whatsapp": whatsapp,
      "email": email,
      "image_path": imagePath,
    };
  }

  AccountUserModel copyWith({
    String? imagePath,
  }) {
    return AccountUserModel(
      firstName: firstName,
      lastName: lastName,
      whatsapp: whatsapp,
      email: email,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
