import 'dart:async';

import 'package:expenses/presentation/pages/add/main_add.dart';
import 'package:expenses/presentation/pages/reports.dart';
import 'package:expenses/presentation/pages/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expenses/presentation/pages/display_data/home.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  bool _showBanner = false;
  Map<String, bool> placements = {
    AdManager.interstitialVideoAdPlacementId: false,
    AdManager.rewardedVideoAdPlacementId: false,
  };
  late Timer _timer;

  List<Widget> pages = [
    const HomeView(),
    const Add(),
    const Reports(),
    const Settings()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UnityAds.init(
      gameId: AdManager.gameId,
      testMode: true,
      onComplete: () {
        if (kDebugMode) {
          print('Initialization Complete');
        }
        _loadAd("Interstitial_Android");
        _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
          _showAd("Interstitial_Android");
        });
      },
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );

  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color.fromRGBO(113, 131, 85,100),
        backgroundColor: Colors.black,
        onTap: (currentIndex) {
          setState(() {
            index = currentIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Expenses"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Reports"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "settings"),
        ],
      ),
    );
  }
  void _loadAd(String placementId) {
    UnityAds.load(
      placementId: placementId,
      onComplete: (placementId) {
        print('Load Complete $placementId');
        setState(() {
          placements[placementId] = true;
        });
      },
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  void _showAd(String placementId) {
    setState(() {
      placements[placementId] = false;
    });
    UnityAds.showVideoAd(
      placementId: placementId,
      onComplete: (placementId) {
        print('Video Ad $placementId completed');
        _loadAd(placementId);
      },
      onFailed: (placementId, error, message) {
        print('Video Ad $placementId failed: $error $message');
        _loadAd(placementId);
      },
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) {
        print('Video Ad $placementId skipped');
        _loadAd(placementId);
      },
    );
  }
}
class AdManager {
  static String get gameId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '5416569';
    }

    return '';
  }

  static String get bannerAdPlacementId {
    return 'Banner_Android';
  }

  static String get interstitialVideoAdPlacementId {
    return 'Interstitial_Android';
  }

  static String get rewardedVideoAdPlacementId {
    return 'Rewarded_Android';
  }
}
