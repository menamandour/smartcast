import 'package:dartz/dartz.dart';
import 'package:smartcast/src/core/errors/failures.dart';
import 'package:smartcast/src/domain/entities/user.dart';
import 'package:smartcast/src/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    return await repository.register(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
    );
  }
}
