part of 'auth_bloc.dart';

/// أحداث المصادقة
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// حدث تسجيل الدخول
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

/// حدث تسجيل الخروج
class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

/// حدث التحقق من تسجيل الدخول
class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

/// حدث الحصول على المستخدم الحالي
class GetCurrentUserEvent extends AuthEvent {
  const GetCurrentUserEvent();
}
