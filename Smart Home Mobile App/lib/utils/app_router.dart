import 'package:go_router/go_router.dart';
import 'package:smart_home/view/add_device_view/add_bluetooth_device_view.dart';
import 'package:smart_home/view/home_view/home_view.dart';
import 'package:smart_home/view/led_view/led_view.dart';
import 'package:smart_home/view/splash_view/splash_page.dart';

enum AppRoute {
  splashPage,
  homePage,
  addDevicePage,
  ledPage;

  get getRoute => {
        AppRoute.splashPage: AppRoute.splashPage.getRoute,
        AppRoute.homePage: AppRoute.homePage.getRoute,
        AppRoute.addDevicePage: AppRoute.addDevicePage.getRoute,
        AppRoute.ledPage: AppRoute.ledPage.getRoute,
      }[this];
}

class Routes {
  static const splashPage = '/splashPage';
  static const homePage = '/homePage';
  static const addDevicePage = '/addDevicePage';
  static const ledPage = '/ledPage';
}

class SmartHomeRouter {
  final GoRouter appRoute = GoRouter(
    initialLocation: Routes.splashPage,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.splashPage,
        name: AppRoute.splashPage.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: Routes.homePage,
        name: AppRoute.homePage.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: Routes.addDevicePage,
        name: AppRoute.addDevicePage.name,
        builder: (context, state) => const AddBluetoothDevicePage(),
      ),
      GoRoute(
        path: Routes.ledPage,
        name: AppRoute.ledPage.name,
        builder: (context, state) => const LedPage(),
      ),
    ],
    errorBuilder: (context, state) => const HomePage(),
  );

  GoRouter get getAppRouter => appRoute;
}
