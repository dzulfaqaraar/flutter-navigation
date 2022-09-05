import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class PostLogin {
  final Repository repository;

  PostLogin({required this.repository});

  Future<Either<Failure, bool>> execute(String username, String password) {
    return repository.postUserLogin(username, password);
  }
}
