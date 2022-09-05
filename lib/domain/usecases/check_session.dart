import '../repositories/repository.dart';

class CheckSession {
  final Repository repository;

  CheckSession({required this.repository});

  Future<bool> execute() {
    return repository.isLoggedIn();
  }
}
