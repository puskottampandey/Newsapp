import 'package:flutter/material.dart';

import 'package:newsapp/homepage_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          children: [
            Container(height: 150),
            Center(child: Image.asset('assets/images/ic_launcher.png')),
            const Padding(padding: EdgeInsets.all(50)),
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
