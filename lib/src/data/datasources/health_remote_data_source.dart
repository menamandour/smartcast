import 'package:dio/dio.dart';
import 'package:smartcast/src/core/constants/app_constants.dart';
import 'package:smartcast/src/core/errors/exceptions.dart';
import 'package:smartcast/src/data/models/health_data_model.dart';

abstract class HealthRemoteDataSource {
  Future<HealthDataModel> recordHealthData({
    required String userId,
    required double pressure,
    required double temperature,
    required double circulation,
    required double movementTracking,
  });

  Future<List<HealthDataModel>> getHealthDataHistory({
    required String userId,
    int limit = 30,
  });

  Future<HealthDataModel?> getLatestHealthData({required String userId});

  Future<void> deleteHealthData({required String healthDataId});
}

class HealthRemoteDataSourceImpl implements HealthRemoteDataSource {
  final Dio dio;

  HealthRemoteDataSourceImpl({required this.dio});

  @override
  Future<HealthDataModel> recordHealthData({
    required String userId,
    required double pressure,
    required double temperature,
    required double circulation,
    required double movementTracking,
  }) async {
    if (!AppConstants.useRealApi) {
      await Future.delayed(const Duration(milliseconds: 800));
      return HealthDataModel(
        id: "mock_data_${DateTime.now().millisecondsSinceEpoch}",
        userId: userId,
        pressure: pressure,
        temperature: temperature,
        circulation: circulation,
        movementTracking: movementTracking,
        recordedAt: DateTime.now(),
      );
    }

    try {
      final response = await dio.post(
        '/health/record',
        data: {
          'userId': userId,
          'pressure': pressure,
          'temperature': temperature,
          'circulation': circulation,
          'movementTracking': movementTracking,
        },
      );

      if (response.statusCode == 201) {
        return HealthDataModel.fromJson(response.data['data']);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to record health data',
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
  Future<List<HealthDataModel>> getHealthDataHistory({
    required String userId,
    int limit = 30,
  }) async {
    if (!AppConstants.useRealApi) {
      await Future.delayed(const Duration(milliseconds: 500));
      final now = DateTime.now();
      return List.generate(10, (index) {
        return HealthDataModel(
          id: "mock_history_$index",
          userId: userId,
          pressure: 120.0 + index,
          temperature: 36.5 + (index * 0.1),
          circulation: 95.0 + (index % 5),
          movementTracking: 500.0 * index,
          recordedAt: now.subtract(Duration(hours: index)),
        );
      });
    }

    try {
      final response = await dio.get(
        '/health/history',
        queryParameters: {'userId': userId, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final dataList = response.data['data'] as List;
        return dataList.map((data) => HealthDataModel.fromJson(data)).toList();
      } else {
        throw ServerException(
          message:
              response.data['message'] ?? 'Failed to get health data history',
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
  Future<HealthDataModel?> getLatestHealthData({required String userId}) async {
    if (!AppConstants.useRealApi) {
      await Future.delayed(const Duration(milliseconds: 300));
      return HealthDataModel(
        id: "mock_latest",
        userId: userId,
        pressure: 120.0,
        temperature: 36.6,
        circulation: 98.0,
        movementTracking: 1250.0,
        recordedAt: DateTime.now().subtract(const Duration(minutes: 15)),
      );
    }

    try {
      final response = await dio.get(
        '/health/latest',
        queryParameters: {'userId': userId},
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        return HealthDataModel.fromJson(response.data['data']);
      }
      return null;
    } on DioException catch (e) {
      throw NetworkException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<void> deleteHealthData({required String healthDataId}) async {
    if (!AppConstants.useRealApi) return;

    try {
      final response = await dio.delete('/health/$healthDataId');

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to delete health data',
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
