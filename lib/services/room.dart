import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_chat_app/models/room.dart';

class RoomService {
  final String collection = 'room';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String id() {
    return firestore.collection(collection).doc().id;
  }

  void create(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).set(values);
  }

  void update(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).update(values);
  }

  void delete(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).delete();
  }

  Future<RoomModel?> select(String? id) async {
    RoomModel? room;
    await firestore.collection(collection).doc(id).get().then((value) {
      room = RoomModel.fromSnapshot(value);
    });
    return room;
  }
}
