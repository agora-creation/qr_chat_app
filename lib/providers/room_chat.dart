import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/services/room_chat.dart';

class RoomChatProvider with ChangeNotifier {
  RoomChatService roomChatService = RoomChatService();

  TextEditingController messageController = TextEditingController();

  void clearController() {
    messageController.text = '';
  }

  Future<String?> create({
    RoomModel? room,
    UserModel? user,
  }) async {
    String? errorText;
    if (room == null) errorText = '送信に失敗しました。';
    if (user == null) errorText = '送信に失敗しました。';
    if (messageController.text.isEmpty) errorText = '送信に失敗しました。';
    try {
      String id = roomChatService.id(room?.id);
      roomChatService.create({
        'id': id,
        'roomId': room?.id,
        'userId': user?.id,
        'message': messageController.text,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      errorText = '送信に失敗しました。';
    }
    return errorText;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamList({
    RoomModel? room,
    UserModel? user,
  }) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? ret;
    ret = FirebaseFirestore.instance
        .collection('room')
        .doc(room?.id ?? 'error')
        .collection('chat')
        .where('userId', isEqualTo: user?.id ?? 'error')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return ret;
  }
}
