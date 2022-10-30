import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  String _id = '';
  String _roomId = '';
  String _roomChatId = '';
  String _userId = '';
  String _userName = '';
  String _message = '';
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get roomId => _roomId;
  String get roomChatId => _roomChatId;
  String get userId => _userId;
  String get userName => _userName;
  String get message => _message;
  DateTime get createdAt => _createdAt;

  ReportModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _roomId = snapshot.data()!['roomId'] ?? '';
    _roomChatId = snapshot.data()!['roomChatId'] ?? '';
    _userId = snapshot.data()!['userId'] ?? '';
    _userName = snapshot.data()!['userName'] ?? '';
    _message = snapshot.data()!['message'] ?? '';
    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }
}
