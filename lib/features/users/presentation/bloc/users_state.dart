part of 'users_bloc.dart';

/// حالات إدارة المستخدمين
abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

/// الحالة الأولية
class UsersInitial extends UsersState {
  const UsersInitial();
}

/// جاري التحميل
class UsersLoading extends UsersState {
  const UsersLoading();
}

/// تم تحميل قائمة المستخدمين
class UsersLoaded extends UsersState {
  final List<UserEntity> users;

  const UsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

/// تم تحميل تفاصيل المستخدم
class UserDetailsLoaded extends UsersState {
  final UserEntity user;

  const UserDetailsLoaded(this.user);

  @override
  List<Object> get props => [user];
}

/// تم إضافة المستخدم بنجاح
class UserAdded extends UsersState {
  final UserEntity user;

  const UserAdded(this.user);

  @override
  List<Object> get props => [user];
}

/// تم تحديث المستخدم بنجاح
class UserUpdated extends UsersState {
  final UserEntity user;

  const UserUpdated(this.user);

  @override
  List<Object> get props => [user];
}

/// تم حذف المستخدم بنجاح
class UserDeleted extends UsersState {
  const UserDeleted();
}

/// تم تحديث الصلاحيات بنجاح
class PermissionsUpdated extends UsersState {
  const PermissionsUpdated();
}

/// تم تفعيل المستخدم بنجاح
class UserActivated extends UsersState {
  const UserActivated();
}

/// تم إيقاف المستخدم بنجاح
class UserDeactivated extends UsersState {
  const UserDeactivated();
}

/// حدث خطأ
class UsersError extends UsersState {
  final String message;

  const UsersError(this.message);

  @override
  List<Object> get props => [message];
}
