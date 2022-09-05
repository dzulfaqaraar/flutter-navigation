import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entity/user.dart';
import '../repositories/repository.dart';

class GetUser {
  final Repository repository;

  GetUser({required this.repository});

  Future<Either<Failure, User>> execute() {
    return repository.getDataUser();
  }
}
