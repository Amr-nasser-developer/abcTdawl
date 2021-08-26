import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:abc_trade/layout/home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: HomeScreen(),
      duration: 5000,
      imageSize: 200,
      imageSrc: "assets/images/splash_logo.png",
      backgroundColor: HexColor('#00AEAC'),
    );
  }
}