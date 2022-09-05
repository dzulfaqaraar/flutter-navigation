import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entity/user.dart';

abstract class Repository {
  Future<bool> isLoggedIn();
  Future<Either<Failure, bool>> postUserLogin(String username, String password);
  Future<Either<Failure, User>> getDataUser();
  Future<bool> logOutUser();
}
