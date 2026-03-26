# SmartCast - Smart Cast Health Monitoring System

SmartCast is a Flutter application for monitoring and tracking vital signs recovery progress with a smart cast sensor. The app is built using **Clean Architecture** principles with **BLoC** state management.

## Project Structure

```
lib/
├── main.dart                      # Application entry point
└── src/
    ├── config/                    # Configuration files
    │   ├── localization/          # i18n localization setup
    │   ├── routes/                # Navigation routes
    │   ├── service_locator.dart   # Dependency injection
    │   └── theme/                 # App theme configuration
    ├── core/                      # Core utilities
    │   ├── constants/             # App constants (colors, strings)
    │   ├── errors/                # Error handling (failures, exceptions)
    │   └── utils/                 # Utility functions
    ├── data/                      # Data layer
    │   ├── datasources/           # Remote & local data sources
    │   ├── models/                # Data models with JSON serialization
    │   └── repositories/          # Repository implementations
    ├── domain/                    # Domain layer
    │   ├── entities/              # Business entities
    │   ├── repositories/          # Abstract repositories
    │   └── usecases/              # Business logic use cases
    └── presentation/              # Presentation layer
        ├── bloc/                  # BLoC state management
        ├── pages/                 # UI screens
        └── widgets/               # Reusable widgets
```

## Features

- **User Authentication** - Login and registration with email/password
- **Health Monitoring** - Record and track vital signs (pressure, temperature, circulation, movement)
- **Bilingual Support** - English and Arabic localization
- **Responsive Design** - Works on all device sizes
- **State Management** - BLoC pattern for predictable state changes
- **Clean Architecture** - Separation of concerns with domain, data, and presentation layers

## Architecture

SmartCast follows **Clean Architecture** principles:

### Domain Layer
- Pure business logic
- Entities and abstract repositories
- Use cases for operations

### Data Layer
- Implementation of repositories
- Remote and local data sources
- Models with JSON serialization

### Presentation Layer
- UI screens and widgets
- BLoC for state management
- Event-driven architecture

## Getting Started

### Prerequisites
- Flutter SDK >= 3.9.2
- Dart SDK >= 3.9.2

### Installation

1. Clone the repository:
```bash
cd smartcast
```

2. Get dependencies:
```bash
flutter pub get
```

3. Generate JSON serializable files:
```bash
flutter pub run build_runner build
```

4. Run the app:
```bash
flutter run
```

## Dependencies

### State Management
- `flutter_bloc: ^9.0.0` - BLoC state management
- `bloc: ^9.0.0` - BLoC library
- `equatable: ^2.0.5` - Value equality

### Networking
- `dio: ^5.4.0` - HTTP client
- `retrofit: ^4.1.0` - REST client

### Local Storage
- `sqflite: ^2.3.0` - SQLite database
- `shared_preferences: ^2.2.2` - Key-value storage

### Localization
- `intl: ^0.19.0` - Internationalization
- `flutter_localizations` - Flutter localization

### Dependency Injection
- `get_it: ^7.6.0` - Service locator

### Utilities
- `dartz: ^0.10.1` - Functional programming
- `json_serializable: ^6.7.1` - JSON serialization
- `google_fonts: ^6.1.0` - Google fonts

## Pages Overview

### 1. Splash Page
Initial loading screen showing the app logo and name.

### 2. Onboarding Page
3-step onboarding flow explaining app features with pagination.

### 3. Login Page
User authentication with email and password.

### 4. Register Page
New user account creation with validation.

### 5. Home Page
Main dashboard showing:
- Welcome message with user name
- Latest vital signs in a grid format
- Quick action buttons for recording data and viewing history

### 6. Health Monitoring Page
Form to record vital signs:
- Pressure (mmHg)
- Temperature (°C)
- Circulation (%)
- Movement Tracking (%)

## Localization

The app supports English and Arabic. Translations are defined in:
- `assets/i18n/en.json` - English translations
- `assets/i18n/ar.json` - Arabic translations

### Adding New Strings

1. Add string key to both JSON files
2. Update `AppLocalizations` class with getter
3. Use `AppLocalizations.of(context).stringKey` in UI

## API Configuration

Base URL and API constants are configured in `lib/src/core/constants/app_constants.dart`:
- Base URL: `https://api.smartcast.com/api`
- Connection timeout: 30 seconds
- Receive timeout: 30 seconds

## Error Handling

The app uses a custom error hierarchy:
- `Failure` - Abstract base class for all failures
- `ServerFailure` - Server-side errors
- `NetworkFailure` - Network connectivity issues
- `CacheFailure` - Local storage errors
- `ValidationFailure` - Input validation errors

## Development

### Building JSON Serializable Files

After modifying models:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running in Watch Mode
```bash
flutter pub run build_runner watch
```

### Code Analysis
```bash
flutter analyze
```

### Running Tests
```bash
flutter test
```

## Contributing

1. Create a feature branch (`git checkout -b feature/AmazingFeature`)
2. Commit changes (`git commit -m 'Add AmazingFeature'`)
3. Push to branch (`git push origin feature/AmazingFeature`)
4. Open a Pull Request

## License

This project is licensed under the MIT License.

## Support

For support, email support@smartcast.com or open an issue in the repository.

---

**Created with ❤️ for better health monitoring**
