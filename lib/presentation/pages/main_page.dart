import 'dart:async';

import 'package:expenses/presentation/pages/reports.dart';
import 'package:expenses/presentation/pages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'add/add_group_expense.dart';
import 'categories.dart';
import 'display_data/expenses.dart';
import 'home/home_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currenttab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    Categories(),
    Reports(),
    Settings()
  ];
  Widget currentScreen = HomeScreen();
  final PageStorageBucket bucket = PageStorageBucket();

  late Timer _timer;
  bool _isExpanded = false;

  List<Widget> pages = [
    const HomeScreen(),
    const Expenses(),
    const Reports(),
    const Settings()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*UnityAds.init(
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
    );*/
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Icon(_isExpanded ? Icons.close : Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currenttab = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.home,
                          color: currenttab == 0
                              ? Colors.green
                              : Colors.green.shade50,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                              color: currenttab == 0
                                  ? Colors.green
                                  : Colors.green.shade50),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Expenses();
                        currenttab = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.network_cell_outlined,
                          color: currenttab == 0
                              ? Colors.green
                              : Colors.green.shade50,
                        ),
                        Text(
                          "Expenses",
                          style: TextStyle(
                              color: currenttab == 0
                                  ? Colors.green
                                  : Colors.green.shade50),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Reports();
                        currenttab = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          color: currenttab == 0
                              ? Colors.green
                              : Colors.green.shade50,
                        ),
                        Text(
                          "Reports",
                          style: TextStyle(
                              color: currenttab == 0
                                  ? Colors.green
                                  : Colors.green.shade50),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Settings();
                        currenttab = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.settings,
                          color: currenttab == 0
                              ? Colors.green
                              : Colors.green.shade50,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                              color: currenttab == 0
                                  ? Colors.green
                                  : Colors.green.shade50),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _isExpanded
          ? Container(
              height: 180.h,
              padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 15.r),
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(AddGroupExpense());
                    },
                    child: Container(
                      height: 40.h,
                      child: Center(child: Text("Add Group Expense")),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade300),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(AddGroupExpense());
                    },
                    child: Container(
                      height: 40.h,
                      child: Center(child: Text("Add Personal Expense")),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade300),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            )
          : null, // If not expanded, bottom navigation bar is null
    );
  }

  void _loadAd(String placementId) {
    /*UnityAds.load(
      placementId: placementId,
      onComplete: (placementId) {
        print('Load Complete $placementId');
        setState(() {
          placements[placementId] = true;
        });
      },
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );*/
  }

/*
  void _showAd(String placementId) {
    setState(() {
      placements[placementId] = false;
    });
    */
/*UnityAds.showVideoAd(
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
    );*/ /*

  }
*/
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
