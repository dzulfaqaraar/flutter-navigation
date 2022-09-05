import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecases/get_user.dart';

class ProfileNotifier extends ChangeNotifier {
  final GetUser getUser;

  ProfileNotifier({required this.getUser});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  User? _userData;
  User? get userData => _userData;

  void fetchUserData() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getUser.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _userData = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
