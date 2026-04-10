import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/config/routes/app_routes.dart';
import 'package:smartcast/src/config/service_locator.dart';
import 'package:smartcast/src/config/theme/app_theme.dart';
import 'package:smartcast/src/core/constants/app_constants.dart';
import 'package:smartcast/src/core/providers/locale_provider.dart';
import 'package:smartcast/src/core/providers/settings_provider.dart';
import 'package:smartcast/src/presentation/bloc/auth_bloc.dart';
import 'package:smartcast/src/presentation/bloc/health_bloc.dart';
import 'package:smartcast/src/presentation/bloc/bluetooth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(create: (context) => sl<HealthBloc>()),
        BlocProvider(create: (context) => sl<BluetoothBloc>()),
      ],
      child: ListenableBuilder(
        listenable: localeProvider,
        builder: (context, _) {
          return ListenableBuilder(
            listenable: settingsProvider,
            builder: (context, __) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'SmartCast',
                theme: AppTheme.themeData(settingsProvider.fontFamily, false),
                darkTheme: AppTheme.themeData(
                    settingsProvider.fontFamily, true),
                themeMode: settingsProvider.themeMode,
                locale: localeProvider.locale,
                localizationsDelegates: [
                  const AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale(AppConstants.defaultLanguage),
                  Locale(AppConstants.arabicLanguage),
                ],
                routes: AppRoutes.getRoutes(),
                initialRoute: AppRoutes.splash,
              );
            },
          );
        },
      ),
    );
  }
}

