import 'package:dartz/dartz.dart';
import 'package:smartcast/src/core/constants/app_constants.dart';
import 'package:smartcast/src/core/errors/exceptions.dart';
import 'package:smartcast/src/core/errors/failures.dart';
import 'package:smartcast/src/data/datasources/auth_local_data_source.dart';
import 'package:smartcast/src/data/datasources/auth_remote_data_source.dart';
import 'package:smartcast/src/data/models/user_model.dart';
import 'package:smartcast/src/domain/entities/user.dart';
import 'package:smartcast/src/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      final userModel = await remoteDataSource.login(
        email: email,
        password: password,
      );

      // Persist auth data only when "Remember Me" is enabled.
      // If it's disabled, make sure any previous persisted auth state is cleared.
      if (rememberMe) {
        await localDataSource.saveUser(userModel);
      } else {
        await localDataSource.clearUser();
      }

      // Always keep token in memory for the session,
      // but only persist it to disk if rememberMe is true.
      if (userModel.token != null) {
        await localDataSource.saveToken(userModel.token!, persist: rememberMe);
      }
      
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    try {
      final userModel = await remoteDataSource.register(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
      );
      
      await localDataSource.saveUser(userModel);
      // For register, we usually want them logged in for the session
      if (userModel.token != null) {
        await localDataSource.saveToken(userModel.token!, persist: true);
      }
      
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Clear everything: Remote, Local User, and both Memory/Disk Tokens
      await remoteDataSource.logout();
      await localDataSource.clearUser();
      await localDataSource.clearToken();
      return const Right(null);
    } catch (_) {
      // Still clear local data even if remote logout fails; logout should always
      // leave the app unauthenticated.
      await localDataSource.clearUser();
      await localDataSource.clearToken();
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final token = await localDataSource.getToken();
      if (token == null || token.isEmpty) {
        return const Left(CacheFailure(message: 'No saved auth token'));
      }

      final userModel = await remoteDataSource.getCurrentUser();
      await localDataSource.saveUser(userModel);
      // Update session token if a new one is provided, but don't force disk persistence 
      // unless it's already there.
      if (userModel.token != null) {
        final hasPersistentToken = sharedPreferences.containsKey(AppConstants.userTokenKey);
        await localDataSource.saveToken(userModel.token!, persist: hasPersistentToken);
      }
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserLocally(User user) async {
    try {
      if (user is UserModel) {
        await localDataSource.saveUser(user);
      } else {
        final userModel = UserModel(
          id: user.id,
          email: user.email,
          fullName: user.fullName,
          phone: user.phone,
          avatar: user.avatar,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt,
        );
        await localDataSource.saveUser(userModel);
      }
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getUserLocally() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> hasSeenOnboarding() async {
    return sharedPreferences.getBool(AppConstants.onboardingKey) ?? false;
  }

  @override
  Future<void> setOnboardingSeen() async {
    await sharedPreferences.setBool(AppConstants.onboardingKey, true);
  }
}
