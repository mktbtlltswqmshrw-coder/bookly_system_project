import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

/// Use Case لتفعيل المستخدم
class ActivateUserUseCase {
  final UsersRepository repository;

  ActivateUserUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.activateUser(id);
  }
}
