import 'package:dartz/dartz.dart';
import 'package:smartcast/src/core/errors/failures.dart';
import 'package:smartcast/src/domain/entities/health_data.dart';
import 'package:smartcast/src/domain/repositories/health_repository.dart';

class GetHealthDataHistoryUseCase {
  final HealthRepository repository;

  GetHealthDataHistoryUseCase({required this.repository});

  Future<Either<Failure, List<HealthData>>> call({
    required String userId,
    int limit = 30,
  }) async {
    return await repository.getHealthDataHistory(userId: userId, limit: limit);
  }
}
