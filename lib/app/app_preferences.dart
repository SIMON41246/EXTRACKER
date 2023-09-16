import 'package:shared_preferences/shared_preferences.dart';

const String APP_PREFS_KEY = "APP_PREFS_KEY";
const String ONBOARDINGVIEWSCREENVIEWED = "OnBoardingViewScreenViewed";
const String UserLoggedInSuccesFully = "UserLoggedInSuccesFully";

class AppPrefrences {
  final SharedPreferences _sharedPreferences;

  AppPrefrences(this._sharedPreferences);

  Future<void> setOnBoardingViewScreenViewed() async {
    _sharedPreferences.setBool(ONBOARDINGVIEWSCREENVIEWED, true);
  }

  Future<bool> isOnBoardingViewScreenViewed() async {
    return _sharedPreferences.getBool(ONBOARDINGVIEWSCREENVIEWED) ?? false;
  }
}
