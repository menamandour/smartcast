import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, dynamic> _translations;

  AppLocalizations({required this.locale});

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<bool> load() async {
    if (locale.languageCode == 'ar') {
      _translations = _getArabicTranslations();
    } else {
      _translations = _getEnglishTranslations();
    }
    return true;
  }

  String translate(String key) {
    List<String> keys = key.split('.');
    dynamic value = _translations;

    for (String k in keys) {
      if (value is Map && value.containsKey(k)) {
        value = value[k];
      } else {
        return key;
      }
    }

    return value?.toString() ?? key;
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
  String get welcomeBack => translate('common.welcomeBack');
  String get normal => translate('common.normal');
  String get high => translate('common.high');
  String get low => translate('common.low');

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
  String get humidity => translate('health.humidity');
  String get circulation => translate('health.circulation');
  String get movementTracking => translate('health.movementTracking');
  String get vitalSigns => translate('health.vitalSigns');
  String get healthData => translate('health.healthData');
  String get recordHealthData => translate('health.recordHealthData');
  String get viewHistory => translate('health.viewHistory');
  String get latestReading => translate('health.latestReading');
  String get noData => translate('health.noData');
  String get attachSmartSensor => translate('health.attachSmartSensor');
  String get healthAnalytics => translate('health.healthAnalytics');
  String get pressureTrend => translate('health.pressureTrend');
  String get temperatureTrend => translate('health.temperatureTrend');
  String get humidityTrend => translate('health.humidityTrend');
  String get trend => translate('health.trend');
  String get medicalInsight => translate('health.medicalInsight');
  String get skinPressureNoSigns => translate('health.skinPressureNoSigns');
  String get skinTempNoSigns => translate('health.skinTempNoSigns');
  String get humidityNoSigns => translate('health.humidityNoSigns');
  String get castPressureOptimal => translate('health.castPressureOptimal');
  String get day => translate('health.day');
  String get week => translate('health.week');
  String get month => translate('health.month');

  // Onboarding
  String get welcome => translate('onboarding.welcome');
  String get welcomeSubtitle => translate('onboarding.welcomeSubtitle');
  String get monitorYourHealing => translate('onboarding.monitorYourHealing');
  String get captureOrConnect => translate('onboarding.captureOrConnect');
  String get getStarted => translate('onboarding.getStarted');

  // Profile
  String get profile => translate('profile.profile');
  String get accountSetting => translate('profile.accountSetting');
  String get appSetting => translate('profile.appSetting');
  String get support => translate('profile.support');
  String get address => translate('profile.address');
  String get history => translate('profile.history');
  String get language => translate('profile.language');
  String get notification => translate('profile.notification');
  String get helpCenter => translate('profile.helpCenter');

  // Drawer
  String get smartCastAr => translate('drawer.smartCastAr');
  String get home => translate('drawer.home');
  String get analytics => translate('drawer.analytics');
  String get patients => translate('drawer.patients');
  String get devices => translate('drawer.devices');
  String get settings => translate('drawer.settings');

  // Navigation
  String get navHome => translate('nav.home');
  String get navSensors => translate('nav.sensors');
  String get navAlerts => translate('nav.alerts');
  String get navProfile => translate('nav.profile');

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
        'welcomeBack': 'Welcome,',
        'normal': 'Normal',
        'high': 'High',
        'low': 'Low',
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
        'healthData': 'Sensors Data',
        'recordHealthData': 'Record Health Data',
        'viewHistory': 'View History',
        'latestReading': 'Latest Reading',
        'noData': 'No data available',
        'humidity': 'Humidity',
        'attachSmartSensor': 'Attach the smart sensor to your cast to receive real-time data on pressure, temperature, circulation indicators, and movement tracking — ensuring optimal healing and preventing complications.',
        'healthAnalytics': 'Health Analytics',
        'pressureTrend': 'Pressure Trend',
        'temperatureTrend': 'Temperature Trend',
        'humidityTrend': 'Humidity Trend',
        'trend': 'Trend',
        'medicalInsight': 'Medical Insight',
        'skinPressureNoSigns': 'Skin pressure shows no signs of inflammation.',
        'skinTempNoSigns': 'Skin temperature shows no signs of inflammation.',
        'humidityNoSigns': 'Humidity shows no signs of inflammation.',
        'castPressureOptimal': 'Cast pressure is optimal for healing.',
        'day': 'Day',
        'week': 'Week',
        'month': 'Month',
      },
      'onboarding': {
        'welcome': 'Welcome to SmartCast',
        'welcomeSubtitle': 'Smart Cast Health Monitoring System',
        'monitorYourHealing': 'Monitor Your Healing Vital Signs',
        'captureOrConnect': 'Capture or connect your smart cast, and we\'ll track pressure levels, swelling indicators, and healing progress in real time to ensure safe recovery.',
        'getStarted': 'Get Started',
      },
      'profile': {
        'profile': 'profile',
        'accountSetting': 'Account Setting',
        'appSetting': 'APP Setting',
        'support': 'Support',
        'address': 'Address',
        'history': 'History',
        'language': 'Language',
        'notification': 'Notification',
        'helpCenter': 'Help center',
      },
      'drawer': {
        'smartCastAr': 'الجبيرة الذكية',
        'home': 'Home',
        'analytics': 'Analytics',
        'patients': 'Patients',
        'devices': 'Devices',
        'settings': 'Settings',
      },
      'nav': {
        'home': 'Home',
        'sensors': 'Sensors',
        'alerts': 'Alerts',
        'profile': 'profile',
      }
    };
  }

  Map<String, dynamic> _getArabicTranslations() {
    return {
      'appName': 'سمارت كاست',
      'appSubtitle': 'نظام مراقبة الجبيرة الذكية',
      'common': {
        'next': 'التالي',
        'skip': 'تخطي',
        'login': 'تسجيل الدخول',
        'logout': 'تسجيل الخروج',
        'signUp': 'إنشاء حساب',
        'register': 'تسجيل',
        'done': 'تم',
        'cancel': 'إلغاء',
        'save': 'حفظ',
        'delete': 'حذف',
        'edit': 'تعديل',
        'close': 'إغلاق',
        'loading': 'جاري التحميل...',
        'retry': 'إعادة المحاولة',
        'welcomeBack': 'مرحبا،',
        'normal': 'طبيعي',
        'high': 'مرتفع',
        'low': 'منخفض',
      },
      'auth': {
        'email': 'البريد الإلكتروني',
        'password': 'كلمة المرور',
        'confirmPassword': 'تأكيد كلمة المرور',
        'fullName': 'الاسم بالكامل',
        'phone': 'رقم الهاتف',
        'rememberMe': 'تذكرني',
        'forgotPassword': 'نسيت كلمة المرور؟',
        'dontHaveAccount': 'ليس لديك حساب؟',
        'alreadyHaveAccount': 'لديك حساب بالفعل؟',
        'signInWithEmail': 'تسجيل الدخول بالبريد',
        'createNewAccount': 'إنشاء حساب جديد',
        'loginSuccess': 'تم تسجيل الدخول بنجاح',
        'signUpSuccess': 'تم إنشاء الحساب بنجاح',
        'logoutSuccess': 'تم تسجيل الخروج بنجاح',
      },
      'validation': {
        'emailRequired': 'البريد الإلكتروني مطلوب',
        'invalidEmail': 'بريد إلكتروني غير صالح',
        'passwordRequired': 'كلمة المرور مطلوبة',
        'passwordTooShort': 'يجب أن تكون كلمة المرور ٨ أحرف على الأقل',
        'passwordMismatch': 'كلمات المرور غير متطابقة',
        'nameRequired': 'الاسم مطلوب',
      },
      'errors': {
        'serverError': 'حدث خطأ في الخادم',
        'networkError': 'حدث خطأ في الشبكة',
        'cacheError': 'حدث خطأ في الذاكرة المؤقتة',
        'unknownError': 'حدث خطأ غير معروف',
        'noConnection': 'لا يوجد اتصال بالإنترنت',
        'tryAgain': 'يرجى المحاولة مرة أخرى',
      },
      'health': {
        'monitorYourHealth': 'راقب علاماتك الحيوية أثناء الشفاء',
        'pressure': 'الضغط',
        'temperature': 'درجة الحرارة',
        'circulation': 'الدورة الدموية',
        'movementTracking': 'تتبع الحركة',
        'vitalSigns': 'العلامات الحيوية',
        'healthData': 'بيانات الحساسات',
        'recordHealthData': 'تسجيل البيانات الصحية',
        'viewHistory': 'عرض السجل',
        'latestReading': 'آخر قراءة',
        'noData': 'لا توجد بيانات متاحة',
        'humidity': 'الرطوبة',
        'attachSmartSensor': 'قم بتوصيل المستشعر الذكي بجبيرتك لتلقي بيانات فورية عن الضغط ودرجة الحرارة ومؤشرات الدورة الدموية وتتبع الحركة - لضمان الشفاء الأمثل ومنع المضاعفات.',
        'healthAnalytics': 'التحليلات الصحية',
        'pressureTrend': 'تطور الضغط',
        'temperatureTrend': 'تطور درجة الحرارة',
        'humidityTrend': 'تطور الرطوبة',
        'trend': 'تطور',
        'medicalInsight': 'نظرة طبية',
        'skinPressureNoSigns': 'ضغط الجلد لا يظهر أي علامات التهاب.',
        'skinTempNoSigns': 'درجة حرارة الجلد لا تظهر أي علامات التهاب.',
        'humidityNoSigns': 'الرطوبة لا تظهر أي علامات التهاب.',
        'castPressureOptimal': 'ضغط الجبيرة مثالي للشفاء.',
        'day': 'يوم',
        'week': 'أسبوع',
        'month': 'شهر',
      },
      'onboarding': {
        'welcome': 'مرحباً بك في سمارت كاست',
        'welcomeSubtitle': 'نظام مراقبة الجبيرة الذكية',
        'monitorYourHealing': 'راقب علاماتك الحيوية أثناء الشفاء',
        'captureOrConnect': 'قم بتصوير أو توصيل جبيرتك الذكية، وسنقوم بتتبع مستويات الضغط ومؤشرات التورم وتقدم الشفاء في الوقت الفعلي لضمان التعافي الآمن.',
        'getStarted': 'ابدأ الآن',
      },
      'profile': {
        'profile': 'الملف الشخصي',
        'accountSetting': 'إعدادات الحساب',
        'appSetting': 'إعدادات التطبيق',
        'support': 'الدعم',
        'address': 'العنوان',
        'history': 'السجل',
        'language': 'اللغة',
        'notification': 'الإشعارات',
        'helpCenter': 'مركز المساعدة',
      },
      'drawer': {
        'smartCastAr': 'الجبيرة الذكية',
        'home': 'الرئيسية',
        'analytics': 'التحليلات',
        'patients': 'المرضى',
        'devices': 'الأجهزة',
        'settings': 'الإعدادات',
      },
      'nav': {
        'home': 'الرئيسية',
        'sensors': 'الحساسات',
        'alerts': 'التنبيهات',
        'profile': 'ملفي',
      }
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
