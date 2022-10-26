import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/room.dart';
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
    if (user == null) errorText = 'ルームの作成に失敗しました。';
    if (color == null) errorText = 'ルームの作成に失敗しました。';
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
      errorText = 'ルームの作成に失敗しました。';
    }
    return errorText;
  }

  Future<String?> update({
    RoomModel? room,
    Color? color,
  }) async {
    String? errorText;
    if (room == null) errorText = '情報の更新に失敗しました。';
    if (color == null) errorText = '情報の更新に失敗しました。';
    if (nameController.text.isEmpty) errorText = 'ルームの名前を入力してください。';
    try {
      roomService.update({
        'id': room?.id,
        'name': nameController.text.trim(),
        'color': color?.value.toRadixString(16),
      });
    } catch (e) {
      errorText = '情報の更新に失敗しました。';
    }
    return errorText;
  }

  Future<String?> updateIn({
    RoomModel? room,
    UserModel? user,
  }) async {
    String? errorText;
    if (room == null) errorText = 'ルームの参加に失敗しました。';
    if (user == null) errorText = 'ルームの参加に失敗しました。';
    List<String> userIds = room?.userIds ?? [];
    if (!userIds.contains(user?.id ?? '')) {
      userIds.add(user?.id ?? '');
    }
    try {
      roomService.update({
        'id': room?.id,
        'userIds': userIds,
      });
    } catch (e) {
      errorText = 'ルームの参加に失敗しました。';
    }
    return errorText;
  }

  Future<String?> delete({RoomModel? room}) async {
    String? errorText;
    if (room == null) errorText = 'ルームの消去に失敗しました。';
    try {
      roomService.delete({'id': room?.id});
    } catch (e) {
      errorText = 'ルームの消去に失敗しました。';
    }
    return errorText;
  }

  Future<RoomModel?> select(String? id) async {
    RoomModel? room;
    await roomService.select(id).then((value) {
      room = value;
    });
    return room;
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
