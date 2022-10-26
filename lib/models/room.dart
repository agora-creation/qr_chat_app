import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  String _id = '';
  String _name = '';
  String _color = '';
  List<String> userIds = [];
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get name => _name;
  String get color => _color;
  DateTime get createdAt => _createdAt;

  RoomModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _name = snapshot.data()!['name'] ?? '';
    _color = snapshot.data()!['color'] ?? '';
    userIds = _convertList(snapshot.data()!['userIds'] ?? []);
    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }

  List<String> _convertList(List list) {
    List<String> converted = [];
    for (String value in list) {
      converted.add(value);
    }
    return converted;
  }
}