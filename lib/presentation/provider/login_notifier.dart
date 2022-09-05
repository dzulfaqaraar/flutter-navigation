import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../../domain/usecases/check_session.dart';
import '../../domain/usecases/post_login.dart';
import '../pages/home_page.dart';
import 'home_notifier.dart';

class LoginNotifier extends ChangeNotifier {
  final CheckSession checkSession;
  final PostLogin postLogin;

  LoginNotifier({
    required this.checkSession,
    required this.postLogin,
  });

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  Future<void> isLoggedIn(VoidCallback callback) async {
    _state = RequestState.loading;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 1000), () async {
      final result = await checkSession.execute();

      _state = RequestState.loaded;
      notifyListeners();

      if (result) {
        callback.call();
      }
    });
  }

  void login(BuildContext context, String username, String password) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await postLogin.execute(username, password);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        if (data) {
          _state = RequestState.loaded;
          notifyListeners();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider<HomeNotifier>(
                create: (_) => HomeNotifier(logoutUser: locator()),
                child: const HomePage(),
              ),
            ),
          );
        } else {
          _message = 'Failed to login';
          _state = RequestState.error;
          notifyListeners();
        }
      },
    );
  }
}
