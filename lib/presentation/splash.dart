import 'dart:async';

import 'package:expenses/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/app_preferences.dart';
import '../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPrefrences _appPreferences = instance<AppPrefrences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() async {
    _appPreferences
        .isOnBoardingViewScreenViewed()
        .then((isOnBoardingScreenViewed) => {
              if (isOnBoardingScreenViewed)
                {
                  // navigate to login screen

                  Get.offNamed(Routes.home)
                }
              else
                {
                  // navigate to onboarding screen

                  Get.offNamed(Routes.onBoarding)
                }
            });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(66, 144, 150, 100),
      body: Center(child: Image.asset("assets/splash.png")),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
