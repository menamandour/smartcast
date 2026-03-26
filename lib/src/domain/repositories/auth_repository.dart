import 'package:dartz/dartz.dart';
import 'package:smartcast/src/core/errors/failures.dart';
import 'package:smartcast/src/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, void>> saveUserLocally(User user);

  Future<Either<Failure, User?>> getUserLocally();
}
