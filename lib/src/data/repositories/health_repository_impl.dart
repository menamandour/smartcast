import 'package:dartz/dartz.dart';
import 'package:smartcast/src/core/errors/exceptions.dart';
import 'package:smartcast/src/core/errors/failures.dart';
import 'package:smartcast/src/data/datasources/health_remote_data_source.dart';
import 'package:smartcast/src/domain/entities/health_data.dart';
import 'package:smartcast/src/domain/repositories/health_repository.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthRemoteDataSource remoteDataSource;

  HealthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, HealthData>> recordHealthData({
    required String userId,
    required double pressure,
    required double temperature,
    required double circulation,
    required double movementTracking,
  }) async {
    try {
      final healthData = await remoteDataSource.recordHealthData(
        userId: userId,
        pressure: pressure,
        temperature: temperature,
        circulation: circulation,
        movementTracking: movementTracking,
      );
      return Right(healthData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HealthData>>> getHealthDataHistory({
    required String userId,
    int limit = 30,
  }) async {
    try {
      final healthDataList = await remoteDataSource.getHealthDataHistory(
        userId: userId,
        limit: limit,
      );
      return Right(healthDataList);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HealthData?>> getLatestHealthData({
    required String userId,
  }) async {
    try {
      final healthData = await remoteDataSource.getLatestHealthData(
        userId: userId,
      );
      return Right(healthData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHealthData({
    required String healthDataId,
  }) async {
    try {
      await remoteDataSource.deleteHealthData(healthDataId: healthDataId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
