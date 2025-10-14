part of 'auth_bloc.dart';

/// حالات المصادقة
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// الحالة الأولية
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// جاري التحميل
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// تم تسجيل الدخول بنجاح
class Authenticated extends AuthState {
  final UserEntity user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

/// لم يتم تسجيل الدخول
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// حدث خطأ
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
