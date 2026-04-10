class AppConstants {
  // Toggle for Mock API vs Real API
  static const bool useRealApi = false; // Set to true to send actual data to the API, false for predefined mock data

  // API Configuration
  static const String baseUrl = 'https://api.smartcast.com/api';
  static const String apiVersion = 'v1';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Local Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
  static const String languageKey = 'language';
  static const String themeKey = 'theme';
  static const String fontKey = 'font_family';

  // Database
  static const String dbName = 'smartcast.db';
  static const int dbVersion = 1;

  // Localization
  static const String defaultLanguage = 'en';
  static const String arabicLanguage = 'ar';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 20;
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
}
