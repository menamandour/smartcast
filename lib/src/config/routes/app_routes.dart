import 'package:flutter/material.dart';
import 'package:smartcast/src/presentation/pages/health_monitoring_page.dart';
import 'package:smartcast/src/presentation/pages/main_page.dart';
import 'package:smartcast/src/presentation/pages/login_page.dart';
import 'package:smartcast/src/presentation/pages/forgot_password_page.dart';
import 'package:smartcast/src/presentation/pages/onboarding_page.dart';
import 'package:smartcast/src/presentation/pages/register_page.dart';
import 'package:smartcast/src/presentation/pages/splash_page.dart';
import 'package:smartcast/src/presentation/pages/welcome_page.dart';
import 'package:smartcast/src/presentation/pages/devices_page.dart';
import 'package:smartcast/src/presentation/pages/bluetooth_details_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String health = '/health';
  static const String welcome = '/welcome';
  static const String devices = '/devices';
  static const String bluetoothDetails = '/bluetooth-details';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashPage(),
      onboarding: (context) => const OnboardingPage(),
      login: (context) => const LoginPage(),
      forgotPassword: (context) => const ForgotPasswordPage(),
      register: (context) => const RegisterPage(),
      home: (context) => const MainPage(),
      health: (context) => const HealthMonitoringPage(),
      welcome: (context) => const WelcomePage(),
      devices: (context) => const DevicesPage(),
      bluetoothDetails: (context) => const BluetoothDetailsPage(),
    };
  }
}
