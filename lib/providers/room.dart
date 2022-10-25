import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/services/room.dart';

class RoomProvider with ChangeNotifier {
  RoomService roomService = RoomService();

  TextEditingController nameController = TextEditingController();

  void clearController() {
    nameController.text = '';
  }

  Future<String?> create({
    UserModel? user,
    Color? color,
  }) async {
    String? errorText;
    if (user == null) errorText = 'ルームの追加に失敗しました。';
    if (color == null) errorText = 'ルームの追加に失敗しました。';
    if (nameController.text.isEmpty) errorText = 'ルームの名前を入力してください。';
    List<String> userIds = [];
    userIds.add(user?.id ?? '');
    try {
      String id = roomService.id();
      roomService.create({
        'id': id,
        'name': nameController.text.trim(),
        'color': color?.value.toRadixString(16),
        'userIds': userIds,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      errorText = 'ルームの追加に失敗しました。';
    }
    return errorText;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamList({
    UserModel? user,
  }) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? ret;
    ret = FirebaseFirestore.instance
        .collection('room')
        .where('userIds', arrayContains: user?.id ?? 'error')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return ret;
  }
}
