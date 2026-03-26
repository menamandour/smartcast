import 'package:dartz/dartz.dart';
import 'package:smartcast/src/core/errors/failures.dart';
import 'package:smartcast/src/domain/entities/health_data.dart';
import 'package:smartcast/src/domain/repositories/health_repository.dart';

class RecordHealthDataUseCase {
  final HealthRepository repository;

  RecordHealthDataUseCase({required this.repository});

  Future<Either<Failure, HealthData>> call({
    required String userId,
    required double pressure,
    required double temperature,
    required double circulation,
    required double movementTracking,
  }) async {
    return await repository.recordHealthData(
      userId: userId,
      pressure: pressure,
      temperature: temperature,
      circulation: circulation,
      movementTracking: movementTracking,
    );
  }
}
