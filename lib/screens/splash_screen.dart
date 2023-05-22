import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/global.dart';
import 'package:voting_app/screens/home_layout_screen.dart';
import 'package:voting_app/screens/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  prefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    if (token.isNotEmpty) {
      // ignore: use_build_context_synchronously
      navigateAndRemove(context, const HomeLayout());
    } else {
      // ignore: use_build_context_synchronously
      navigateAndRemove(context, RegisterScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () => prefs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/splash.json'),
      ),
    );
  }
}
