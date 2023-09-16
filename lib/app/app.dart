import 'package:expenses/app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void dispose() {

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    UnityAds.init(gameId: "5416569");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Expense Tracker ",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: Routes.pages,
    );
  }
}


//Show banner Ad

