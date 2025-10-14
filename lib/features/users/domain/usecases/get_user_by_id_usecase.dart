import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

/// Use Case لجلب مستخدم بالـ ID
class GetUserByIdUseCase {
  final UsersRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String id) async {
    return await repository.getUserById(id);
  }
}
