import 'package:flutter/material.dart';
import 'package:netflix_clone/constants/assets.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "splash";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            Assets.imagesNetflixLogo1,
          ),
        ),
      ),
    );
  }
}
