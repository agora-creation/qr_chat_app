import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChatService {
  final String collection = 'room';
  String subCollection = 'chat';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String id(String? roomId) {
    return firestore
        .collection(collection)
        .doc(roomId)
        .collection(subCollection)
        .doc()
        .id;
  }

  void create(Map<String, dynamic> values) {
    firestore
        .collection(collection)
        .doc(values['roomId'])
        .collection(subCollection)
        .doc(values['id'])
        .set(values);
  }

  void update(Map<String, dynamic> values) {
    firestore
        .collection(collection)
        .doc(values['roomId'])
        .collection(subCollection)
        .doc(values['id'])
        .update(values);
  }

  void delete(Map<String, dynamic> values) {
    firestore
        .collection(collection)
        .doc(values['roomId'])
        .collection(subCollection)
        .doc(values['id'])
        .delete();
  }
}
