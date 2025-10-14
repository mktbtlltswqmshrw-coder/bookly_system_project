import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Use Case لتحديث بيانات المستخدم
class UpdateUserUseCase {
  final UsersRepository repository;

  UpdateUserUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(UpdateUserParams params) async {
    return await repository.updateUser(
      id: params.id,
      fullName: params.fullName,
      phone: params.phone,
      role: params.role,
    );
  }
}

/// معاملات تحديث المستخدم
class UpdateUserParams extends Equatable {
  final String id;
  final String? fullName;
  final String? phone;
  final UserRole? role;

  const UpdateUserParams({required this.id, this.fullName, this.phone, this.role});

  @override
  List<Object?> get props => [id, fullName, phone, role];
}
