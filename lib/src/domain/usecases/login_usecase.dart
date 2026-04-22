import 'package:dartz/dartz.dart';
import 'package:smartcast/src/core/errors/failures.dart';
import 'package:smartcast/src/domain/entities/user.dart';
import 'package:smartcast/src/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    return await repository.login(
      email: email, 
      password: password, 
      rememberMe: rememberMe,
    );
  }
}
