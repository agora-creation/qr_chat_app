import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/services/user.dart';

enum Status { authenticated, uninitialized, authenticating, unauthenticated }

class UserProvider with ChangeNotifier {
  Status _status = Status.uninitialized;
  Status get status => _status;
  FirebaseAuth? auth;
  User? _fUser;
  UserService userService = UserService();
  UserModel? _user;
  UserModel? get user => _user;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void clearController() {
    emailController.text = '';
    nameController.text = '';
  }

  UserProvider.initialize() : auth = FirebaseAuth.instance {
    auth?.authStateChanges().listen(_onStateChanged);
  }

  Future<String?> login() async {
    String? errorText;
    if (emailController.text.isEmpty) errorText = 'メールアドレスを入力してください。';
    try {
      _status = Status.authenticating;
      notifyListeners();
      await auth?.sendSignInLinkToEmail(
        email: emailController.text.trim(),
        actionCodeSettings: ActionCodeSettings(url: ''),
      );
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      errorText = '認証に失敗しました。';
    }
    return errorText;
  }

  Future logout() async {
    await auth?.signOut();
    _status = Status.unauthenticated;
    _user = null;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      _fUser = firebaseUser;
      _status = Status.authenticated;
      _user = await userService.select(id: _fUser?.uid);
    }
    notifyListeners();
  }
}
