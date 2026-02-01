import 'package:digital_shop/config/theme.dart';
import 'package:digital_shop/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DigitalShopApp());
}

class DigitalShopApp extends StatelessWidget {
  const DigitalShopApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SubscriptionBD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
