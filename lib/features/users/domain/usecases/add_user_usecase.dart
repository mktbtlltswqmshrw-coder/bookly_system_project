import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Use Case لإضافة مستخدم جديد
class AddUserUseCase {
  final UsersRepository repository;

  AddUserUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(AddUserParams params) async {
    return await repository.addUser(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
      phone: params.phone,
      role: params.role,
      permissions: params.permissions,
    );
  }
}

/// معاملات إضافة مستخدم
class AddUserParams extends Equatable {
  final String email;
  final String password;
  final String fullName;
  final String? phone;
  final UserRole role;
  final List<String>? permissions;

  const AddUserParams({
    required this.email,
    required this.password,
    required this.fullName,
    this.phone,
    required this.role,
    this.permissions,
  });

  @override
  List<Object?> get props => [email, password, fullName, phone, role, permissions];
}
