import 'package:dartz/dartz.dart';
import 'package:smartcast/src/core/errors/failures.dart';
import 'package:smartcast/src/domain/entities/health_data.dart';

abstract class HealthRepository {
  Future<Either<Failure, HealthData>> recordHealthData({
    required String userId,
    required double pressure,
    required double temperature,
    required double circulation,
    required double movementTracking,
  });

  Future<Either<Failure, List<HealthData>>> getHealthDataHistory({
    required String userId,
    int limit = 30,
  });

  Future<Either<Failure, HealthData?>> getLatestHealthData({
    required String userId,
  });

  Future<Either<Failure, void>> deleteHealthData({
    required String healthDataId,
  });
}
