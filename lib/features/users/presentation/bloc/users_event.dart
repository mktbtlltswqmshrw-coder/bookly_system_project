part of 'users_bloc.dart';

/// أحداث إدارة المستخدمين
abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

/// حدث تحميل قائمة المستخدمين
class LoadUsersEvent extends UsersEvent {
  final String? role;
  final bool? isActive;

  const LoadUsersEvent({this.role, this.isActive});

  @override
  List<Object?> get props => [role, isActive];
}

/// حدث تحميل تفاصيل مستخدم
class LoadUserDetailsEvent extends UsersEvent {
  final String id;

  const LoadUserDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}

/// حدث إضافة مستخدم
class AddUserEvent extends UsersEvent {
  final String email;
  final String password;
  final String fullName;
  final String? phone;
  final UserRole role;
  final List<String>? permissions;

  const AddUserEvent({
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

/// حدث تحديث مستخدم
class UpdateUserEvent extends UsersEvent {
  final String id;
  final String? fullName;
  final String? phone;
  final UserRole? role;

  const UpdateUserEvent({required this.id, this.fullName, this.phone, this.role});

  @override
  List<Object?> get props => [id, fullName, phone, role];
}

/// حدث حذف مستخدم
class DeleteUserEvent extends UsersEvent {
  final String id;

  const DeleteUserEvent(this.id);

  @override
  List<Object> get props => [id];
}

/// حدث تفعيل مستخدم
class ActivateUserEvent extends UsersEvent {
  final String id;

  const ActivateUserEvent(this.id);

  @override
  List<Object> get props => [id];
}

/// حدث إيقاف مستخدم
class DeactivateUserEvent extends UsersEvent {
  final String id;

  const DeactivateUserEvent(this.id);

  @override
  List<Object> get props => [id];
}

/// حدث تحديث الصلاحيات
class UpdatePermissionsEvent extends UsersEvent {
  final String id;
  final List<String> permissions;

  const UpdatePermissionsEvent({required this.id, required this.permissions});

  @override
  List<Object> get props => [id, permissions];
}
