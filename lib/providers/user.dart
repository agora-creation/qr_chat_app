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
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void clearController() {
    emailController.text = '';
    passwordController.text = '';
    nameController.text = '';
  }

  UserProvider.initialize() : auth = FirebaseAuth.instance {
    auth?.authStateChanges().listen(_onStateChanged);
  }

  Future<String?> login() async {
    String? errorText;
    if (emailController.text.isEmpty) errorText = 'メールアドレスを入力してください。';
    if (passwordController.text.isEmpty) errorText = 'パスワードを入力してください。';
    try {
      _status = Status.authenticating;
      notifyListeners();
      await auth?.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      errorText = 'ログインに失敗しました。';
    }
    return errorText;
  }

  Future<String?> regist() async {
    String? errorText;
    if (nameController.text.isEmpty) errorText = 'お名前を入力してください。';
    if (emailController.text.isEmpty) errorText = 'メールアドレスを入力してください。';
    if (passwordController.text.isEmpty) errorText = 'パスワードを入力してください。';
    try {
      _status = Status.authenticating;
      notifyListeners();
      await auth
          ?.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        userService.create({
          'id': value.user?.uid,
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'color': 'FFFFFFFF',
          'token': '',
          'createdAt': DateTime.now(),
        });
      });
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      errorText = '登録に失敗しました。';
    }
    return errorText;
  }

  Future<String?> update(Color color) async {
    String? errorText;
    if (nameController.text.isEmpty) errorText = 'お名前を入力してください。';
    if (emailController.text.isEmpty) errorText = 'メールアドレスを入力してください。';
    if (passwordController.text.isEmpty) errorText = 'パスワードを入力してください。';
    try {
      await auth?.currentUser
          ?.updateEmail(emailController.text.trim())
          .then((value) async {
        await auth?.currentUser
            ?.updatePassword(passwordController.text.trim())
            .then((value) {
          userService.update({
            'id': _user?.id,
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'password': passwordController.text.trim(),
            'color': color.value.toRadixString(16),
          });
        });
      });
    } catch (e) {
      errorText = '情報の更新に失敗しました。';
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

  Future<String?> delete() async {
    String? errorText;
    try {
      userService.delete({'id': _user?.id});
      await auth?.currentUser?.delete();
      _status = Status.unauthenticated;
      _user = null;
      notifyListeners();
      Future.delayed(Duration.zero);
    } catch (e) {
      errorText = '削除に失敗しました。';
    }
    return errorText;
  }

  Future reloadUser() async {
    _user = await userService.select(id: _fUser?.uid);
    notifyListeners();
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
