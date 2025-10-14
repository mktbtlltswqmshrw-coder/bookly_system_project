import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

/// Use Case لإيقاف المستخدم
class DeactivateUserUseCase {
  final UsersRepository repository;

  DeactivateUserUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deactivateUser(id);
  }
}
