import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

/// Use Case لتسجيل الخروج
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}
