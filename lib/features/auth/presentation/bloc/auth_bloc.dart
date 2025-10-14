import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bookly_system/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookly_system/features/auth/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Bloc للمصادقة
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({required this.loginUseCase, required this.logoutUseCase, required this.getCurrentUserUseCase})
    : super(const AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
  }

  /// معالج تسجيل الدخول
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await loginUseCase(LoginParams(email: event.email, password: event.password));

    result.fold((failure) => emit(AuthError(failure.message)), (user) => emit(Authenticated(user)));
  }

  /// معالج تسجيل الخروج
  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await logoutUseCase();

    result.fold((failure) => emit(AuthError(failure.message)), (_) => emit(const Unauthenticated()));
  }

  /// معالج التحقق من حالة تسجيل الدخول
  Future<void> _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await getCurrentUserUseCase();

    result.fold((failure) => emit(const Unauthenticated()), (user) => emit(Authenticated(user)));
  }

  /// معالج الحصول على المستخدم الحالي
  Future<void> _onGetCurrentUser(GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    final result = await getCurrentUserUseCase();

    result.fold((failure) => emit(AuthError(failure.message)), (user) => emit(Authenticated(user)));
  }
}
