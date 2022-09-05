import '../repositories/repository.dart';

class LogoutUser {
  final Repository repository;

  LogoutUser({required this.repository});

  Future<bool> execute() {
    return repository.logOutUser();
  }
}
