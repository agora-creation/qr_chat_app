import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/room_chat.dart';
import 'package:qr_chat_app/services/report.dart';

class ReportProvider with ChangeNotifier {
  ReportService reportService = ReportService();

  Future<String?> create(RoomChatModel? chat) async {
    String? errorText;
    if (chat == null) errorText = '違反報告に失敗しました。';
    try {
      String id = reportService.id();
      reportService.create({
        'id': id,
        'roomId': chat?.roomId,
        'roomChatId': chat?.id,
        'userId': chat?.userId,
        'userName': chat?.userName,
        'message': chat?.message,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      errorText = '違反報告に失敗しました。';
    }
    return errorText;
  }
}
