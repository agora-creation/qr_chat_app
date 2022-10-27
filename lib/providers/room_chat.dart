import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/services/room.dart';
import 'package:qr_chat_app/services/room_chat.dart';

class RoomChatProvider with ChangeNotifier {
  RoomService roomService = RoomService();
  RoomChatService roomChatService = RoomChatService();

  TextEditingController messageController = TextEditingController();

  void clearController() {
    messageController.text = '';
    notifyListeners();
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
        'userName': user?.name,
        'userColor': user?.color,
        'message': messageController.text,
        'createdAt': DateTime.now(),
      });
      roomService.update({
        'id': room?.id,
        'lastMessage': messageController.text,
      });
    } catch (e) {
      errorText = '送信に失敗しました。';
    }
    return errorText;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamList({RoomModel? room}) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? ret;
    ret = FirebaseFirestore.instance
        .collection('room')
        .doc(room?.id ?? 'error')
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return ret;
  }
}
