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
import 'package:smartcast/src/presentation/pages/edit_profile_page.dart';
import 'package:smartcast/src/presentation/pages/address_page.dart';
import 'package:smartcast/src/presentation/pages/history_page.dart';
import 'package:smartcast/src/presentation/pages/language_page.dart';
import 'package:smartcast/src/presentation/pages/notification_settings_page.dart';
import 'package:smartcast/src/presentation/pages/help_center_page.dart';

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
  static const String editProfile = '/profile/edit';
  static const String address = '/profile/address';
  static const String history = '/profile/history';
  static const String language = '/profile/language';
  static const String notifications = '/profile/notifications';
  static const String helpCenter = '/profile/help-center';

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
      editProfile: (context) => const EditProfilePage(),
      address: (context) => const AddressPage(),
      history: (context) => const HistoryPage(),
      language: (context) => const LanguagePage(),
      notifications: (context) => const NotificationSettingsPage(),
      helpCenter: (context) => const HelpCenterPage(),
    };
  }
}
