import 'package:expenses/presentation/onBoarding/view/onBoarding_view.dart';

import 'package:expenses/presentation/pages/home/home_screen.dart';
import 'package:expenses/presentation/pages/main_page.dart';
import 'package:expenses/presentation/pages/reports.dart';
import 'package:expenses/presentation/pages/settings.dart';
import 'package:expenses/presentation/splash.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static const String add = "/add";
  static const String categeries = "/categeries";
  static const String expenses = "/expenses";
  static const String home = "/";
  static const String splash = "/splash";
  static const String reports = "/reports";
  static const String settings = "/settings";
  static const String onBoarding = "/onBoarding";


  static List<GetPage> pages = [
    GetPage(name: Routes.expenses, page: () => const HomeScreen()),
    GetPage(name: Routes.reports, page: () => const Reports()),
    GetPage(name: Routes.settings, page: () => const Settings()),
    GetPage(name: Routes.home, page: () => const MainPage()),
    GetPage(name: Routes.splash, page: () =>const SplashView()),
    GetPage(name: Routes.onBoarding, page: () =>const OnboardingView()),

  ];
}
