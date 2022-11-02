import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_chat_app/models/user.dart';

class UserService {
  final String collection = 'user';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void create(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).set(values);
  }

  void update(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).update(values);
  }

  void delete(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).delete();
  }

  Future<UserModel?> select({String? id}) async {
    UserModel? user;
    await firestore.collection(collection).doc(id).get().then((value) {
      user = UserModel.fromSnapshot(value);
    });
    return user;
  }

  Future<List<UserModel>> selectBlockList(List<String> blockUserIds) async {
    List<UserModel> users = [];
    await firestore
        .collection(collection)
        .where('id', whereIn: blockUserIds)
        .get()
        .then((value) {
      for (DocumentSnapshot<Map<String, dynamic>> data in value.docs) {
        users.add(UserModel.fromSnapshot(data));
      }
    });
    return users;
  }
}
