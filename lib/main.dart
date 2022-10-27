import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:qr_chat_app/helpers/style.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/providers/room_chat.dart';
import 'package:qr_chat_app/providers/user.dart';
import 'package:qr_chat_app/screens/home.dart';
import 'package:qr_chat_app/screens/login.dart';
import 'package:qr_chat_app/screens/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: RoomProvider()),
        ChangeNotifierProvider.value(value: RoomChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ja')],
        locale: const Locale('ja'),
        title: 'QR-CHAT',
        theme: themeData(),
        home: const SplashController(),
      ),
    );
  }
}

class SplashController extends StatelessWidget {
  const SplashController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    switch (userProvider.status) {
      case Status.uninitialized:
        return const SplashScreen();
      case Status.unauthenticated:
      case Status.authenticating:
        return const LoginScreen();
      case Status.authenticated:
        return const HomeScreen();
      default:
        return const LoginScreen();
    }
  }
}
