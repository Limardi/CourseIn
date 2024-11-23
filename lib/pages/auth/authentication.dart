import 'package:flutter/material.dart';
import 'package:project_ss/repositories/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ss/model/user.dart' as models;

class AuthenticationService {
  final UserRepo _userRepository;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthenticationService({UserRepo? userRepository})
      : _userRepository = userRepository ?? UserRepo();

  Future<String?> signUp({
    required BuildContext context,
    required String studentId,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      String userId = userCredential.user!.uid;
      _postSignUp(uid: userId, email: email, studentId: studentId);
      debugPrint('New account created');
      return userId;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        final existingUserDoc = await _userRepository.getUserByEmail(email);

        if (existingUserDoc == null) {
          throw Exception('Email already in use but no user doc found');
        }

        if (context.mounted) {
          await _promptLogInInstead(context);
        }
      }
    }
  }

  Future<String>logIn(
    {required String email, required String password}) async{
      try{
        UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

        _postLogIn(userCredential.user!);
        return userCredential.user!.uid;
        
      }
      on FirebaseAuthException catch (e) {
        throw Exception('${e.code}: ${e.message}');
      }
  }

  Future<void> _postLogIn(User user) async{
    IdTokenResult idTokenResult = await user.getIdTokenResult(true);
    debugPrint('Logged in');
  }


  Future<void> _postSignUp({
    required String uid,
    required String email,
    required String studentId,
  }) async {
    await _userRepository.createOrUpdateUser(models.User(
      id: uid,
      email: email,
      studentId: studentId,

    ));
  }

  Future<void> _promptLogInInstead(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Email already in use'),
            content: const Text(
              'The email address you provided is already in use. Please log in instead.',
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  String? checkAndGetLoggedInUserId() {
    User? user = _firebaseAuth.currentUser;
    if (user == null) return null;

    user.reload();
    return _firebaseAuth.currentUser?.uid; // return new result
  }

  Stream<bool> authStateChanges() {
    return _firebaseAuth.idTokenChanges().map((user) => user != null);
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
