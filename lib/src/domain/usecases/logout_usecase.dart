import 'package:dartz/dartz.dart';
import 'package:smartcast/src/core/errors/failures.dart';
import 'package:smartcast/src/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}
