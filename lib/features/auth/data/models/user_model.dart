import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.firstName,
    required super.lastName,
    required super.whatsapp,
    required super.email,
    required super.password,
  });

  UserModel copyWith({
    String? password,
  }) {
    return UserModel(
      firstName: firstName,
      lastName: lastName,
      whatsapp: whatsapp,
      email: email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "whatsapp": whatsapp,
      "email": email,
      "password": password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      whatsapp: json["whatsapp"],
      email: json["email"],
      password: json["password"],
    );
  }
}
