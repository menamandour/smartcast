import 'package:dio/dio.dart';
import 'package:smartcast/src/core/constants/app_constants.dart';
import 'package:smartcast/src/core/errors/exceptions.dart';
import 'package:smartcast/src/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  });

  Future<void> logout();

  Future<UserModel> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    if (!AppConstants.useRealApi) {
      await Future.delayed(const Duration(seconds: 1));
      return UserModel(
        id: "mock_user_1",
        email: email, // Use the entered email
        fullName: "Mock User",
        token: "mock_jwt_token_xyz",
        createdAt: DateTime.now(),
      );
    }

    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Login failed',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw NetworkException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    if (!AppConstants.useRealApi) {
      await Future.delayed(const Duration(seconds: 1));
      return UserModel(
        id: "mock_user_${DateTime.now().millisecondsSinceEpoch}",
        email: email,
        fullName: fullName,
        phone: phone,
        token: "mock_jwt_token_new",
        createdAt: DateTime.now(),
      );
    }

    try {
      final response = await dio.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'fullName': fullName,
          'phone': phone,
        },
      );

      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Registration failed',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw NetworkException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    if (!AppConstants.useRealApi) return;

    try {
      await dio.post('/auth/logout');
    } on DioException catch (e) {
      throw NetworkException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    if (!AppConstants.useRealApi) {
      return UserModel(
        id: "mock_user_1",
        email: "test@smartcast.com",
        fullName: "Mock User",
        token: "mock_jwt_token_xyz",
        createdAt: DateTime.now(),
      );
    }

    try {
      final response = await dio.get('/auth/me');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to get user',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw NetworkException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
