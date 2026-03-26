# SmartCast - Quick Start Guide

## 🚀 Get Running in 5 Minutes

### Step 1: Navigate to Project
```bash
cd c:\Users\BG\Desktop\amazon\project\smartcast
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Generate Model Files
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 4: Run the App
```bash
flutter run
```

## 📲 Testing the App Flow

### 1. **Splash Screen** (Auto-navigates after 2 seconds)
   -Shows SmartCast logo and app name

### 2. **Onboarding Screen** (3 pages)
   - Swipe through features
   - Tap "Next" or "GetStarted" to proceed
   - Data shows monitoring capabilities

### 3. **Login Page**
   - Email: `test@example.com`
   - Password: `password123`
   - [Skip to Register](or use mock data)

### 4. **Register Page** (Alternative)
   - Fill in all fields
   - Passwords must match
   - Tap Sign Up

### 5. **Home Page** (After Auth)
   - Shows welcome message
   - Displays vital signs grid (requires health data)
   - "Record Health Data" button to add metrics
   - "View History" button to refresh

### 6. **Health Monitoring Page**
   - Enter vital signs:
     - Pressure (mmHg)
     - Temperature (°C)
     - Circulation (%)
     - Movement Tracking (%)
   - Tap "Save" to record

## 🔑 Project Highlights

### Clean Architecture Layers

**Domain Layer** (`lib/src/domain/`)
- Business logic (entities, repositories, use cases)
- No external dependencies
- Framework agnostic

**Data Layer** (`lib/src/data/`)
- API calls, local storage
- Model conversions
- Repository implementations

**Presentation Layer** (`lib/src/presentation/`)
- UI screens and widgets
- BLoC state management
- Event-driven updates

### Key Files to Understand

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point, BLoC providers, routing |
| `lib/src/config/service_locator.dart` | Dependency injection setup |
| `lib/src/presentation/bloc/auth_bloc.dart` | Authentication state management |
| `lib/src/domain/usecases/login_usecase.dart` | Login business logic |
| `lib/src/data/datasources/auth_remote_data_source.dart` | API calls |

## 🎨 Customization Examples

### Change Primary Color
```dart
// lib/src/core/constants/app_colors.dart
static const Color primary = Color(0xFF1E40AF); // Change this
```

### Add New String
```dart
// assets/i18n/en.json
{
  "customKey": "Custom Value"
}

// lib/src/config/localization/app_localizations.dart
String get customKey => translate('customKey');
```

### Modify Theme
```dart
// lib/src/config/theme/app_theme.dart
// Update lightTheme or darkTheme
```

## 🔗 API Integration

### Current Mock Setup
The app uses mock data. To integrate your backend:

1. **Update API Base URL**
   ```dart
   // lib/src/core/constants/app_constants.dart
   static const String baseUrl = 'https://your-api.com/api';
   ```

2. **Ensure API Endpoints Match**
   - POST `/auth/login` - Login
   - POST `/auth/register` - Register
   - GET `/auth/me` - Get current user
   - POST `/health/record` - Save health data
   - GET `/health/history` - Get records

3. **Update Models if Needed**
   ```dart
   // lib/src/data/models/user_model.dart
   @JsonSerializable()
   class UserModel extends User {
     // Add/remove fields as needed
   }
   ```

4. **Run Build Runner**
   ```bash
   flutter pub run build_runner build
   ```

## 📱 Device Testing

### iOS
```bash
flutter run -d all  # Run on all connected devices
```

### Android
```bash
flutter run
```

### Web
```bash
flutter run -d chrome
```

## 🛠️ Common Commands

```bash
# Format code
flutter format lib/

# Analyze code
flutter analyze

# Check dependencies
flutter pub outdated

# Update dependencies
flutter pub upgrade

# Clean build
flutter clean && flutter pub get

# Build APK (Android)
flutter build apk --release

# Build IPA (iOS)
flutter build ios --release
```

## 🐛 Debug Tips

### Enable Debug Mode
```dart
// In main.dart or any screen
debugPrint('Log message: $value');
```

### View State Changes
Add to BLoC:
```dart
on<AuthLoginEvent>((event, emit) {
  debugPrint('Login event: ${event.email}');
  // ...
});
```

### Network Debugging
View all HTTP requests:
```dart
// In service_locator.dart
final dio = Dio(/*...*/);
dio.interceptors.add(LoggingInterceptor()); // Add logging
```

## 📚 Code Patterns

### Create a New Page
1. Create file in `presentation/pages/`
2. Create corresponding BLoC in `presentation/bloc/`
3. Add route in `config/routes/app_routes.dart`
4. Update localization in `assets/i18n/`

### Add a Use Case
1. Create file in `domain/usecases/`
2. Define in abstract repository
3. Implement in data repository
4. Register in `service_locator.dart`
5. Add to BLoC

## ⚡ Performance Tips

1. **Use const constructors** everywhere possible
2. **Implement cached repositories** for frequently accessed data
3. **Lazy load** BLoCs only when needed
4. **Use `ItemScrollController`** for large lists
5. **Implement pagination** for API responses

## 🔒 Security Best Practices

```dart
// Secure token storage (install flutter_secure_storage)
final secureStorage = FlutterSecureStorage();
await secureStorage.write(key: 'auth_token', value: token);

// Never log sensitive data
// Validate all inputs
// Use HTTPS only
```

## 📊 Project Statistics

- **Files**: 30+
- **Screens**: 6
- **BLoCs**: 2
- **Use Cases**: 6
- **Dependencies**: 20+
- **Locales**: 2 (English, Arabic)

## 🎓 Learning Resources

- **Clean Architecture**: Study `domain/`, `data/`, `presentation/` separation
- **BLoC Pattern**: Check `presentation/bloc/auth_bloc.dart`
- **Repository Pattern**: See `data/repositories/`
- **Dependency Injection**: Review `config/service_locator.dart`
- **Localization**: Check `assets/i18n/` and `config/localization/`

## ❓ FAQ

**Q: How do I add a new language?**
A: Add JSON file to `assets/i18n/`, update `AppLocalizations`, add locale to `main.dart`

**Q: How do I change the app name?**
A: Update in `pubspec.yaml`, `android/app/build.gradle`, `ios/Runner.xcodeproj`

**Q: How do I add a new API endpoint?**
A: Add to data source, create use case, add to respository, use in BLoC

**Q: How do I handle offline mode?**
A: Implement local caching in repositories, check connectivity status

## 🎯 Next Steps

1. ✅ Run the app
2. ✅ Test all flows
3. ✅ Connect to your API
4. ✅ Customize branding/colors
5. ✅ Add more features
6. ✅ Deploy!

---

**Happy Coding! 🚀**

Need help? Check the SETUP_GUIDE.md or PROJECT_STRUCTURE.md files.
