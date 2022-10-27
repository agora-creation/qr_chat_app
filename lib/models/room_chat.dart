import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChatModel {
  String _id = '';
  String _roomId = '';
  String _userId = '';
  String _userName = '';
  String _userColor = '';
  String _message = '';
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get roomId => _roomId;
  String get userId => _userId;
  String get userName => _userName;
  String get userColor => _userColor;
  String get message => _message;
  DateTime get createdAt => _createdAt;

  RoomChatModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _roomId = snapshot.data()!['roomId'] ?? '';
    _userId = snapshot.data()!['userId'] ?? '';
    _userName = snapshot.data()!['userName'] ?? '';
    _userColor = snapshot.data()!['userColor'] ?? '';
    _message = snapshot.data()!['message'] ?? '';
    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }
}
