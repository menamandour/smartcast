import 'package:flutter/material.dart';
import 'package:smartcast/src/presentation/pages/health_monitoring_page.dart';
import 'package:smartcast/src/presentation/pages/main_page.dart';
import 'package:smartcast/src/presentation/pages/login_page.dart';
import 'package:smartcast/src/presentation/pages/forgot_password_page.dart';
import 'package:smartcast/src/presentation/pages/onboarding_page.dart';
import 'package:smartcast/src/presentation/pages/register_page.dart';
import 'package:smartcast/src/presentation/pages/splash_page.dart';
import 'package:smartcast/src/presentation/pages/welcome_page.dart';
import 'package:smartcast/src/presentation/pages/page1.dart';
import 'package:smartcast/src/presentation/pages/page2.dart';
import 'package:smartcast/src/presentation/pages/page3.dart';
import 'package:smartcast/src/presentation/pages/page4.dart';
import 'package:smartcast/src/presentation/pages/page5.dart';
import 'package:smartcast/src/presentation/pages/page6.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String health = '/health';
  static const String welcome = '/welcome';
  static const String page1 = '/page1';
  static const String page2 = '/page2';
  static const String page3 = '/page3';
  static const String page4 = '/page4';
  static const String page5 = '/page5';
  static const String page6 = '/page6';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashPage(),
      onboarding: (context) => const OnboardingPage(),
      login: (context) => const LoginPage(),
      forgotPassword: (context) => const ForgotPasswordPage(),
      register: (context) => const RegisterPage(),
      home: (context) => const MainPage(),
      health: (context) => const HealthMonitoringPage(),
      welcome: (context) => WelcomePage(),
      page1: (context) => Page1(),
      page2: (context) => Page2(),
      page3: (context) => Page3(),
      page4: (context) => Page4(),
      page5: (context) => Page5(),
      page6: (context) => Page6(),
    };
  }
}
