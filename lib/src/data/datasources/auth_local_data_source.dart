import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcast/src/core/constants/app_constants.dart';
import 'package:smartcast/src/core/errors/exceptions.dart';
import 'package:smartcast/src/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);

  Future<UserModel?> getUser();

  Future<void> clearUser();

  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await sharedPreferences.setString(AppConstants.userKey, userJson);
    } catch (e) {
      throw CacheException(message: 'Failed to save user locally');
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final userJson = sharedPreferences.getString(AppConstants.userKey);
      if (userJson == null) {
        return null;
      }
      return UserModel.fromJson(jsonDecode(userJson));
    } catch (e) {
      throw CacheException(message: 'Failed to retrieve user from cache');
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await sharedPreferences.remove(AppConstants.userKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear user from cache');
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await sharedPreferences.setString(AppConstants.userTokenKey, token);
    } catch (e) {
      throw CacheException(message: 'Failed to save token locally');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return sharedPreferences.getString(AppConstants.userTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to retrieve token from cache');
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await sharedPreferences.remove(AppConstants.userTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear token from cache');
    }
  }
}
