import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/failure.dart';
import '../../common/state_enum.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecases/get_user.dart';
import '../../injection.dart' as di;
import '../pages/login_page.dart';
import 'login_notifier.dart';

class ProfileNotifier extends ChangeNotifier {
  final GetUser getUser;

  ProfileNotifier({required this.getUser});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  User? _userData;
  User? get userData => _userData;

  void fetchUserData(BuildContext context) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getUser.execute();
    result.fold(
      (failure) {
        if (failure is TokenFailure) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider<LoginNotifier>(
                create: (_) => LoginNotifier(
                  checkSession: di.locator(),
                  postLogin: di.locator(),
                ),
                child: const LoginPage(isFromLogout: true),
              ),
            ),
            (r) => false,
          );
        } else {
          _message = failure.message;
          _state = RequestState.error;
          notifyListeners();
        }
      },
      (data) {
        _userData = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
