import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/entity/user.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../model/login_request.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  static const databaseFailureMessage = 'Database failed';
  static const serverFailureMessage = 'Something went wrong';
  static const connectionFailureMessage = 'Failed to connect to the network';
  static const tokenFailureMessage = 'Token expired';

  RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<bool> isLoggedIn() async {
    try {
      final result = await localDataSource.isLoggedIn();
      return result;
    } on DatabaseException {
      return false;
    }
  }

  @override
  Future<Either<Failure, bool>> postUserLogin(
      String username, String password) async {
    try {
      final request = LoginRequest(username: username, password: password);
      final result = await remoteDataSource.login(request);

      if (result.token != null && result.expire != null) {
        await localDataSource.setLoggedIn(result.token!, result.expire!);

        return const Right(true);
      } else {
        return const Right(false);
      }
    } on ServerException {
      return const Left(ServerFailure(serverFailureMessage));
    } on SocketException {
      return const Left(ConnectionFailure(connectionFailureMessage));
    }
  }

  @override
  Future<Either<Failure, User>> getDataUser() async {
    try {
      final token = await localDataSource.getToken();
      final result = await remoteDataSource.getDataUser(token ?? '');
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(serverFailureMessage));
    } on SocketException {
      return const Left(ConnectionFailure(connectionFailureMessage));
    }
  }

  @override
  Future<bool> logOutUser() async {
    try {
      final result = await localDataSource.clear();
      return result;
    } on DatabaseException {
      return false;
    }
  }
}
