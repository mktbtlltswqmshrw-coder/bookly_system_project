import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Use Case لجلب قائمة المستخدمين
class GetUsersUseCase {
  final UsersRepository repository;

  GetUsersUseCase(this.repository);

  Future<Either<Failure, List<UserEntity>>> call(GetUsersParams params) async {
    return await repository.getUsers(role: params.role, isActive: params.isActive);
  }
}

/// معاملات جلب المستخدمين
class GetUsersParams extends Equatable {
  final String? role;
  final bool? isActive;

  const GetUsersParams({this.role, this.isActive});

  @override
  List<Object?> get props => [role, isActive];
}
