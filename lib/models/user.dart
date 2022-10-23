import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String _id = '';
  String _name = '';
  String _email = '';
  String _password = '';
  String _color = '';
  String _token = '';
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get color => _color;
  String get token => _token;
  DateTime get createdAt => _createdAt;

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _name = snapshot.data()!['name'] ?? '';
    _email = snapshot.data()!['email'] ?? '';
    _password = snapshot.data()!['password'] ?? '';
    _color = snapshot.data()!['color'] ?? '';
    _token = snapshot.data()!['token'] ?? '';
    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }
}
