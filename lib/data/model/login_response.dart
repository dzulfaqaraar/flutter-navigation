class LoginResponse {
  LoginResponse({
    required this.token,
    required this.expire,
  });

  final String? token;
  final String? expire;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        expire: json["expire"],
      );
}
