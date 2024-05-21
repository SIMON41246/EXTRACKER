
import 'package:expenses/app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 800),
      child: GetMaterialApp(
        title: "Expense Tracker ",
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        getPages: Routes.pages,
      ),
    );
  }


}

//Show banner Ad

