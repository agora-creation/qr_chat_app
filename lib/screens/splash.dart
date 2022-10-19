import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            height: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'QR-CHAT',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSerif-Bold',
                      letterSpacing: 1,
                    ),
                  ),
                  SpinKitDancingSquare(
                    size: 48,
                    color: Color(0xFF333333),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
