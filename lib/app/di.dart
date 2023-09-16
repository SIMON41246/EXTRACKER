import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_preferences.dart';

final instance = Get.put(GetIt.I);

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton(() => sharedPreferences);

  instance
      .registerLazySingleton<AppPrefrences>(() => AppPrefrences(instance()));
}
