import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, dynamic> _translations;

  AppLocalizations({required this.locale});

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<bool> load() async {
    // TODO: Load translations from JSON files in assets/i18n/
    // For now, using English as default
    _translations = _getEnglishTranslations();
    return true;
  }

  String translate(String key) {
    List<String> keys = key.split('.');
    dynamic value = _translations;

    for (String k in keys) {
      if (value is Map) {
        value = value[k];
      } else {
        return key;
      }
    }

    return value.toString();
  }

  String get appName => translate('appName');
  String get appSubtitle => translate('appSubtitle');

  // Common
  String get next => translate('common.next');
  String get skip => translate('common.skip');
  String get login => translate('common.login');
  String get logout => translate('common.logout');
  String get signUp => translate('common.signUp');
  String get register => translate('common.register');
  String get done => translate('common.done');
  String get cancel => translate('common.cancel');
  String get save => translate('common.save');
  String get delete => translate('common.delete');
  String get edit => translate('common.edit');
  String get close => translate('common.close');
  String get loading => translate('common.loading');
  String get retry => translate('common.retry');

  // Auth
  String get email => translate('auth.email');
  String get password => translate('auth.password');
  String get confirmPassword => translate('auth.confirmPassword');
  String get fullName => translate('auth.fullName');
  String get phone => translate('auth.phone');
  String get rememberMe => translate('auth.rememberMe');
  String get forgotPassword => translate('auth.forgotPassword');
  String get dontHaveAccount => translate('auth.dontHaveAccount');
  String get alreadyHaveAccount => translate('auth.alreadyHaveAccount');
  String get signInWithEmail => translate('auth.signInWithEmail');
  String get createNewAccount => translate('auth.createNewAccount');
  String get loginSuccess => translate('auth.loginSuccess');
  String get signUpSuccess => translate('auth.signUpSuccess');
  String get logoutSuccess => translate('auth.logoutSuccess');

  // Validation
  String get emailRequired => translate('validation.emailRequired');
  String get invalidEmail => translate('validation.invalidEmail');
  String get passwordRequired => translate('validation.passwordRequired');
  String get passwordTooShort => translate('validation.passwordTooShort');
  String get passwordMismatch => translate('validation.passwordMismatch');
  String get nameRequired => translate('validation.nameRequired');

  // Errors
  String get serverError => translate('errors.serverError');
  String get networkError => translate('errors.networkError');
  String get cacheError => translate('errors.cacheError');
  String get unknownError => translate('errors.unknownError');
  String get noConnection => translate('errors.noConnection');
  String get tryAgain => translate('errors.tryAgain');

  // Health
  String get monitorYourHealth => translate('health.monitorYourHealth');
  String get pressure => translate('health.pressure');
  String get temperature => translate('health.temperature');
  String get circulation => translate('health.circulation');
  String get movementTracking => translate('health.movementTracking');
  String get vitalSigns => translate('health.vitalSigns');
  String get healthData => translate('health.healthData');
  String get recordHealthData => translate('health.recordHealthData');
  String get viewHistory => translate('health.viewHistory');
  String get latestReading => translate('health.latestReading');
  String get noData => translate('health.noData');
  String get attachSmartSensor => translate('health.attachSmartSensor');

  // Onboarding
  String get welcome => translate('onboarding.welcome');
  String get welcomeSubtitle => translate('onboarding.welcomeSubtitle');
  String get monitorYourHealing => translate('onboarding.monitorYourHealing');
  String get captureOrConnect => translate('onboarding.captureOrConnect');
  String get getStarted => translate('onboarding.getStarted');

  Map<String, dynamic> _getEnglishTranslations() {
    return {
      'appName': 'SmartCast',
      'appSubtitle': 'Smart Cast Health Monitoring System',
      'common': {
        'next': 'Next',
        'skip': 'Skip',
        'login': 'Login',
        'logout': 'Logout',
        'signUp': 'Sign Up',
        'register': 'Register',
        'done': 'Done',
        'cancel': 'Cancel',
        'save': 'Save',
        'delete': 'Delete',
        'edit': 'Edit',
        'close': 'Close',
        'loading': 'Loading...',
        'retry': 'Retry',
      },
      'auth': {
        'email': 'Email',
        'password': 'Password',
        'confirmPassword': 'Confirm Password',
        'fullName': 'Full Name',
        'phone': 'Phone Number',
        'rememberMe': 'Remember Me',
        'forgotPassword': 'Forgot Password?',
        'dontHaveAccount': 'Don\'t have an account?',
        'alreadyHaveAccount': 'Already have an account?',
        'signInWithEmail': 'Sign In with Email',
        'createNewAccount': 'Create New Account',
        'loginSuccess': 'Login successful',
        'signUpSuccess': 'Account created successfully',
        'logoutSuccess': 'Logged out successfully',
      },
      'validation': {
        'emailRequired': 'Email is required',
        'invalidEmail': 'Invalid email address',
        'passwordRequired': 'Password is required',
        'passwordTooShort': 'Password must be at least 8 characters',
        'passwordMismatch': 'Passwords do not match',
        'nameRequired': 'Name is required',
      },
      'errors': {
        'serverError': 'Server error occurred',
        'networkError': 'Network error occurred',
        'cacheError': 'Cache error occurred',
        'unknownError': 'Unknown error occurred',
        'noConnection': 'No internet connection',
        'tryAgain': 'Please try again',
      },
      'health': {
        'monitorYourHealth': 'Monitor Your Healing Vital Signs',
        'pressure': 'Pressure',
        'temperature': 'Temperature',
        'circulation': 'Circulation',
        'movementTracking': 'Movement Tracking',
        'vitalSigns': 'Vital Signs',
        'healthData': 'Health Data',
        'recordHealthData': 'Record Health Data',
        'viewHistory': 'View History',
        'latestReading': 'Latest Reading',
        'noData': 'No data available',
        'attachSmartSensor':
            'Attach the smart sensor to your cast to receive real-time data on pressure, temperature, circulation indicators, and movement tracking — ensuring optimal healing and preventing complications.',
      },
      'onboarding': {
        'welcome': 'Welcome to SmartCast',
        'welcomeSubtitle': 'Smart Cast Health Monitoring System',
        'monitorYourHealing': 'Monitor Your Healing Vital Signs',
        'captureOrConnect':
            'Capture or connect your smart cast, and we\'ll track pressure levels, swelling indicators, and healing progress in real time to ensure safe recovery.',
        'getStarted': 'Get Started',
      },
    };
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
