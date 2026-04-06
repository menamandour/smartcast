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
  String get viewAll => translate('common.viewAll');
  String get submit => translate('common.submit');

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
  String get forgotPasswordSubtitle => translate('auth.forgotPasswordSubtitle');
  String get emailHint => translate('auth.emailHint');
  String get verificationEmail => translate('auth.verificationEmail');
  String get otpSubtitle => translate('auth.otpSubtitle');
  String get didntReceiveCode => translate('auth.didntReceiveCode');
  String get resend => translate('auth.resend');
  String get verify => translate('auth.verify');
  String get setNewPasswordTitle => translate('auth.setNewPasswordTitle');
  String get setNewPasswordSubtitle => translate('auth.setNewPasswordSubtitle');
  String get enterNewPassword => translate('auth.enterNewPassword');
  String get reEnterPassword => translate('auth.reEnterPassword');
  String get updatePassword => translate('auth.updatePassword');
  String get registerSubtitle => translate('auth.registerSubtitle');

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
  String get onboardingGetStarted => translate('onboarding.getStarted');

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
  String get select => translate('drawer.select');
  String get changeLanguage => translate('drawer.changeLanguage');
  String get changeFont => translate('drawer.changeFont');
  String get brightnessLevel => translate('drawer.brightnessLevel');

  // Navigation
  String get navHome => translate('nav.home');
  String get navSensors => translate('nav.sensors');
  String get navAlerts => translate('nav.alerts');
  String get navProfile => translate('nav.profile');

  // Alerts
  String get alerts => translate('alerts.alerts');
  String get todayAlerts => translate('alerts.todayAlerts');
  String get highPressure => translate('alerts.highPressure');
  String get feverDetected => translate('alerts.feverDetected');
  String get humidityIsHigh => translate('alerts.humidityIsHigh');
  String get pressureIsRising => translate('alerts.pressureIsRising');
  String get tempAbove37 => translate('alerts.tempAbove37');
  String get humidityAlert => translate('alerts.humidityAlert');
  String get minAgo => translate('alerts.minAgo');
  String get hrAgo => translate('alerts.hrAgo');

  // Doctor Messages
  String get doctorMessages => translate('messages.doctorMessages');
  String get typeYourMessage => translate('messages.typeYourMessage');
  String get drAhmed => translate('messages.drAhmed');
  String get drOmar => translate('messages.drOmar');
  String get keepLegElevated => translate('messages.keepLegElevated');
  String get nextCheckupOnFri => translate('messages.nextCheckupOnFri');

  // Devices
  String get connectCast => translate('devices.connectCast');
  String get nearbyBluetoothDevice => translate('devices.nearbyBluetoothDevice');
  String get bluetoothDevices => translate('devices.bluetoothDevices');
  String get bluetooth => translate('devices.bluetooth');
  String get connected => translate('devices.connected');
  String get disconnected => translate('devices.disconnected');
  String get castIdLabel => translate('devices.castIdLabel');
  String get batteryLabel => translate('devices.batteryLabel');
  String get searchingForDevice => translate('devices.searchingForDevice');

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
        'viewAll': 'View All',
        'submit': 'Submit',
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
        'forgotPasswordSubtitle': 'Don\'t worry! it happens. please enter the email associated with your account',
        'emailHint': 'Enter your email',
        'verificationEmail': 'Verification Email',
        'otpSubtitle': 'Please enter the code we just sent to email',
        'didntReceiveCode': 'If you didn\'t receive a code? ',
        'resend': 'Resend',
        'verify': 'Verify',
        'setNewPasswordTitle': 'Set a new password',
        'setNewPasswordSubtitle': 'Create a new password. Ensure it differs from previous ones for security',
        'enterNewPassword': 'Enter your new password',
        'reEnterPassword': 'Re-enter password',
        'updatePassword': 'Update Password',
        'registerSubtitle': 'Join us to manage your smart cast',
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
        'screen1Title': 'Welcome to Smart Vital Cast: \n Monitor Your Cast Health Instantly',
        'screen1Subtitle': 'Capture or connect your smart cast, and we’ll track pressure levels, swelling indicators, and healing progress in real time to ensure safe recovery.',
        'screen2Title': 'Automate Recovery Monitoring',
        'screen2Subtitle': 'Set personalized recovery settings that adapt to your injury condition. Just select your comfort level, and let the smart system handle continuous monitoring and alerts!',
        'screen3Title': 'Monitor Your Healing Vital Signs',
        'screen3Subtitle': 'Attach the smart sensor to your cast to receive real-time data on pressure, temperature, circulation indicators, and movement tracking — ensuring optimal healing and preventing complications.',
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
        'select': 'Select',
        'changeLanguage': 'Change Language',
        'changeFont': 'Change Font',
        'brightnessLevel': 'Brightness Level',
      },
      'nav': {
        'home': 'Home',
        'sensors': 'Sensors',
        'alerts': 'Alerts',
        'profile': 'profile',
      },
      'alerts': {
        'alerts': 'Alerts',
        'todayAlerts': 'Today’s Alerts',
        'highPressure': 'High Pressure!',
        'feverDetected': 'Fever Detected!',
        'humidityIsHigh': 'Humidity is High',
        'pressureIsRising': 'Pressure is rising',
        'tempAbove37': 'Temp above 37 °C',
        'humidityAlert': 'Humidity Alert',
        'minAgo': 'min ago',
        'hrAgo': 'hr ago',
      },
      'messages': {
        'doctorMessages': 'Doctor Messages',
        'typeYourMessage': 'Type your message...',
        'drAhmed': 'Dr. Ahmed',
        'drOmar': 'Dr. Omar',
        'keepLegElevated': 'Keep leg elevated & dry.',
        'nextCheckupOnFri': 'Next checkup on fri.',
      },
      'devices': {
        'connectCast': 'Connect Cast',
        'nearbyBluetoothDevice': 'Nearby Bluetooth device',
        'bluetoothDevices': 'Bluetooth devices',
        'bluetooth': 'Bluetooth',
        'connected': 'Connected',
        'disconnected': 'Disconnected',
        'castIdLabel': 'Cast ID',
        'batteryLabel': 'Battery',
        'searchingForDevice': 'Searching for device...',
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
        'viewAll': 'عرض الكل',
        'submit': 'إرسال',
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
        'forgotPasswordSubtitle': 'لا تقلق! يحدث هذا. يرجى إدخال البريد الإلكتروني المرتبط بحسابك',
        'emailHint': 'أدخل بريدك الإلكتروني',
        'verificationEmail': 'بريد التحقق',
        'otpSubtitle': 'يرجى إدخال الكود الذي أرسلناه للتو إلى البريد الإلكتروني',
        'didntReceiveCode': 'إذا لم تستلم الكود؟ ',
        'resend': 'إعادة إرسال',
        'verify': 'تحقق',
        'setNewPasswordTitle': 'تعيين كلمة مرور جديدة',
        'setNewPasswordSubtitle': 'قم بإنشاء كلمة مرور جديدة. تأكد من أنها تختلف عن الكلمات السابقة للأمان',
        'enterNewPassword': 'أدخل كلمة المرور الجديدة',
        'reEnterPassword': 'أعد إدخال كلمة المرور',
        'updatePassword': 'تحديث كلمة المرور',
        'registerSubtitle': 'انضم إلينا لإدارة جبيرتك الذكية',
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
        'screen1Title': 'مرحبًا بك في سمارت فيتال كاست: \n راقب صحة جبيرتك فورًا',
        'screen1Subtitle': 'قم بتصوير أو توصيل جبيرتك الذكية، وسنقوم بتتبع مستويات الضغط ومؤشرات التورم وتقدم الشفاء في الوقت الفعلي لضمان التعافي الآمن.',
        'screen2Title': 'أتمتة مراقبة التعافي',
        'screen2Subtitle': 'قم بضبط إعدادات التعافي الشخصية التي تتكيف مع حالة إصابتك. ما عليك سوى اختيار مستوى راحتك، ودع النظام الذكي يتولى المراقبة والتنبيهات المستمرة!',
        'screen3Title': 'راقب علاماتك الحيوية أثناء الشفاء',
        'screen3Subtitle': 'قم بتوصيل المستشعر الذكي بجبيرتك لتلقي بيانات فورية عن الضغط ودرجة الحرارة ومؤشرات الدورة الدموية وتتبع الحركة - لضمان الشفاء الأمثل ومنع المضاعفات.',
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
        'select': 'اختر',
        'changeLanguage': 'تغيير اللغة',
        'changeFont': 'تغيير الخط',
        'brightnessLevel': 'درجة السطوع',
      },
      'nav': {
        'home': 'الرئيسية',
        'sensors': 'الحساسات',
        'alerts': 'التنبيهات',
        'profile': 'ملفي',
      },
      'alerts': {
        'alerts': 'التنبيهات',
        'todayAlerts': 'تنبيهات اليوم',
        'highPressure': 'ضغط مرتفع!',
        'feverDetected': 'تم اكتشاف حمى!',
        'humidityIsHigh': 'الرطوبة مرتفع',
        'pressureIsRising': 'الضغط يرتفع',
        'tempAbove37': 'الحرارة فوق ٣٧ درجة',
        'humidityAlert': 'تنبيه الرطوبة',
        'minAgo': 'دقيقة مضت',
        'hrAgo': 'ساعة مضت',
      },
      'messages': {
        'doctorMessages': 'رسائل الطبيب',
        'typeYourMessage': 'اكتب رسالتك...',
        'drAhmed': 'د. أحمد',
        'drOmar': 'د. عمر',
        'keepLegElevated': 'حافظ على رفع الساق وجفافها.',
        'nextCheckupOnFri': 'الفحص القادم يوم الجمعة.',
      },
      'devices': {
        'connectCast': 'توصيل الجبيرة',
        'nearbyBluetoothDevice': 'أجهزة بلوتوث قريبة',
        'bluetoothDevices': 'أجهزة بلوتوث',
        'bluetooth': 'بلوتوث',
        'connected': 'متصل',
        'disconnected': 'غير متصل',
        'castIdLabel': 'معرف الجبيرة',
        'batteryLabel': 'البطارية',
        'searchingForDevice': 'جاري البحث عن جهاز...',
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
