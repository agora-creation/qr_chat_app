import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/screens/room_camera2.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class RoomCameraScreen extends StatefulWidget {
  final RoomProvider roomProvider;
  final UserModel? user;

  const RoomCameraScreen({
    required this.roomProvider,
    this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<RoomCameraScreen> createState() => _RoomCameraScreenState();
}

class _RoomCameraScreenState extends State<RoomCameraScreen> {
  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isScanned = false;
  RoomModel? room;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController?.pauseCamera();
    }
    qrViewController?.resumeCamera();
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => qrViewController = controller);
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code == null) {}
      if (RegExp(r'^[A-Za-z0-9]+$').hasMatch(scanData.code ?? '')) {
        _getRoom(scanData.code);
      }
    });
  }

  Future _getRoom(String? id) async {
    room = await widget.roomProvider.select(id);
    if (room != null) {
      if (!isScanned) {
        qrViewController?.pauseCamera();
        isScanned = true;
        if (!mounted) return;
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomCamera2Screen(
              roomProvider: widget.roomProvider,
              room: room!,
              user: widget.user!,
            ),
          ),
        ).then((value) {
          qrViewController?.dispose();
          isScanned = false;
          room = null;
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: true,
        title: const Text('ルームに参加'),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.lightBlue,
          borderRadius: 16,
          borderLength: 24,
          borderWidth: 8,
        ),
      ),
    );
  }
}
