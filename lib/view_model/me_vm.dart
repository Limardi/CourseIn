import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_ss/model/user.dart';
import 'package:project_ss/repositories/user_repo.dart';

class MeViewModel with ChangeNotifier{
  final UserRepo _userRepository;
  late StreamSubscription<User?> _meSubscription;

  final StreamController<User> _meStreamController = StreamController<User>();
  Stream<User> get meStream => _meStreamController.stream;

  late String _myId;
  String get myId => _myId;
  User? _me;
  User? get me => _me;

  MeViewModel(String userId, {UserRepo? userRepository}):_userRepository = userRepository ?? UserRepo(){
    _myId = userId;
    _meSubscription = _userRepository.streamUser(userId).listen((me) {
      if (me == null) {
        return;
      }
      _meStreamController.add(me);
      _me = me;

      notifyListeners();
    });
  }

  Future<void> addMe(User me) async {
    await _userRepository.createOrUpdateUser(me);
  }

}


