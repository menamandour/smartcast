import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcast/src/core/constants/app_constants.dart';
import 'package:smartcast/src/data/datasources/auth_local_data_source.dart';
import 'package:smartcast/src/data/datasources/auth_remote_data_source.dart';
import 'package:smartcast/src/data/datasources/health_remote_data_source.dart';
import 'package:smartcast/src/data/repositories/auth_repository_impl.dart';
import 'package:smartcast/src/data/repositories/health_repository_impl.dart';
import 'package:smartcast/src/domain/repositories/auth_repository.dart';
import 'package:smartcast/src/domain/repositories/health_repository.dart';
import 'package:smartcast/src/domain/usecases/get_current_user_usecase.dart';
import 'package:smartcast/src/domain/usecases/get_health_data_history_usecase.dart';
import 'package:smartcast/src/domain/usecases/login_usecase.dart';
import 'package:smartcast/src/domain/usecases/logout_usecase.dart';
import 'package:smartcast/src/domain/usecases/record_health_data_usecase.dart';
import 'package:smartcast/src/domain/usecases/register_usecase.dart';
import 'package:smartcast/src/presentation/bloc/auth_bloc.dart';
import 'package:smartcast/src/presentation/bloc/health_bloc.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Dio Setup
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectionTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
    ),
  );

  sl.registerSingleton<Dio>(dio);

  // Data Sources
  sl.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  sl.registerSingleton<AuthLocalDataSource>(
    AuthLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()),
  );

  sl.registerSingleton<HealthRemoteDataSource>(
    HealthRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  sl.registerSingleton<HealthRepository>(
    HealthRepositoryImpl(
      remoteDataSource: sl<HealthRemoteDataSource>(),
    ),
  );

  // Use Cases
  sl.registerSingleton<LoginUseCase>(
    LoginUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerSingleton<RegisterUseCase>(
    RegisterUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerSingleton<LogoutUseCase>(
    LogoutUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerSingleton<GetCurrentUserUseCase>(
    GetCurrentUserUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerSingleton<RecordHealthDataUseCase>(
    RecordHealthDataUseCase(repository: sl<HealthRepository>()),
  );

  sl.registerSingleton<GetHealthDataHistoryUseCase>(
    GetHealthDataHistoryUseCase(repository: sl<HealthRepository>()),
  );

  // BLoCs
  sl.registerSingleton<AuthBloc>(
    AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
    ),
  );

  sl.registerSingleton<HealthBloc>(
    HealthBloc(
      recordHealthDataUseCase: sl<RecordHealthDataUseCase>(),
      getHealthDataHistoryUseCase: sl<GetHealthDataHistoryUseCase>(),
    ),
  );
}
