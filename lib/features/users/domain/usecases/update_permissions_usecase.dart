import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Use Case لتحديث صلاحيات المستخدم
class UpdatePermissionsUseCase {
  final UsersRepository repository;

  UpdatePermissionsUseCase(this.repository);

  Future<Either<Failure, Unit>> call(UpdatePermissionsParams params) async {
    return await repository.updatePermissions(params.id, params.permissions);
  }
}

/// معاملات تحديث الصلاحيات
class UpdatePermissionsParams extends Equatable {
  final String id;
  final List<String> permissions;

  const UpdatePermissionsParams({required this.id, required this.permissions});

  @override
  List<Object> get props => [id, permissions];
}
