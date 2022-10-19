import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/helpers/style.dart';
import 'package:qr_chat_app/screens/login.dart';
import 'package:qr_chat_app/screens/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

class SplashController extends StatefulWidget {
  const SplashController({Key? key}) : super(key: key);

  @override
  State<SplashController> createState() => _SplashControllerState();
}

class _SplashControllerState extends State<SplashController> {
  void _init() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    pushReplacementScreen(context, const LoginScreen());
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
