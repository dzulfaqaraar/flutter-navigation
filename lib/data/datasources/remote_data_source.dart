import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/exception.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';
import '../model/user_response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<UserResponse> getDataUser(String token);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({required this.client});

  final http.Client client;
  static const baseUrl = "http://192.168.18.21:3000/";

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await client.post(Uri.parse('$baseUrl/login'));

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserResponse> getDataUser(String token) async {
    final headers = {'API_TOKEN': token};
    final response =
        await client.get(Uri.parse('$baseUrl/profile'), headers: headers);

    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
