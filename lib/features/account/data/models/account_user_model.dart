import '../../domain/entities/account_user_entity.dart';

class AccountUserModel extends AccountUserEntity {

  AccountUserModel({
    required super.firstName,
    required super.lastName,
    required super.whatsapp,
    required super.email,
  });

  factory AccountUserModel.fromJson(Map<String, dynamic> json) {
    return AccountUserModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      whatsapp: json["whatsapp"],
      email: json["email"],
    );
  }
}
