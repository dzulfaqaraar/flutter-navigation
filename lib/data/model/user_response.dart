import 'package:app/domain/entity/user.dart';

class UserResponse {
  UserResponse({
    required this.id,
    required this.name,
  });

  final int id;
  final String? name;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        name: json["name"],
      );

  User toEntity() {
    return User(
      name: name,
    );
  }
}
