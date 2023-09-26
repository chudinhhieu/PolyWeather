import 'package:flutter/material.dart';
import 'package:polyweather/screens/home_screen.dart';
import 'package:polyweather/screens/weather_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) =>  const HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/logo.png'),
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'POLY WEATHER',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
