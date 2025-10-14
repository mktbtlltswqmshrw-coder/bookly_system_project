import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/domain/usecases/activate_user_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/add_user_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/deactivate_user_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/get_user_by_id_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/get_users_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/update_permissions_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/update_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

/// Bloc لإدارة المستخدمين
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsersUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final AddUserUseCase addUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final ActivateUserUseCase activateUserUseCase;
  final DeactivateUserUseCase deactivateUserUseCase;
  final UpdatePermissionsUseCase updatePermissionsUseCase;

  UsersBloc({
    required this.getUsersUseCase,
    required this.getUserByIdUseCase,
    required this.addUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
    required this.activateUserUseCase,
    required this.deactivateUserUseCase,
    required this.updatePermissionsUseCase,
  }) : super(const UsersInitial()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<LoadUserDetailsEvent>(_onLoadUserDetails);
    on<AddUserEvent>(_onAddUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<DeleteUserEvent>(_onDeleteUser);
    on<ActivateUserEvent>(_onActivateUser);
    on<DeactivateUserEvent>(_onDeactivateUser);
    on<UpdatePermissionsEvent>(_onUpdatePermissions);
  }

  /// معالج تحميل قائمة المستخدمين
  Future<void> _onLoadUsers(LoadUsersEvent event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());

    final result = await getUsersUseCase(GetUsersParams(role: event.role, isActive: event.isActive));

    result.fold((failure) => emit(UsersError(failure.message)), (users) => emit(UsersLoaded(users)));
  }

  /// معالج تحميل تفاصيل المستخدم
  Future<void> _onLoadUserDetails(LoadUserDetailsEvent event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());

    final result = await getUserByIdUseCase(event.id);

    result.fold((failure) => emit(UsersError(failure.message)), (user) => emit(UserDetailsLoaded(user)));
  }

  /// معالج إضافة مستخدم
  Future<void> _onAddUser(AddUserEvent event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());

    final result = await addUserUseCase(
      AddUserParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        phone: event.phone,
        role: event.role,
        permissions: event.permissions,
      ),
    );

    result.fold((failure) => emit(UsersError(failure.message)), (user) => emit(UserAdded(user)));
  }

  /// معالج تحديث المستخدم
  Future<void> _onUpdateUser(UpdateUserEvent event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());

    final result = await updateUserUseCase(
      UpdateUserParams(id: event.id, fullName: event.fullName, phone: event.phone, role: event.role),
    );

    result.fold((failure) => emit(UsersError(failure.message)), (user) => emit(UserUpdated(user)));
  }

  /// معالج حذف المستخدم
  Future<void> _onDeleteUser(DeleteUserEvent event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());

    final result = await deleteUserUseCase(event.id);

    result.fold((failure) => emit(UsersError(failure.message)), (_) => emit(const UserDeleted()));
  }

  /// معالج تفعيل المستخدم
  Future<void> _onActivateUser(ActivateUserEvent event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());

    final result = await activateUserUseCase(event.id);

    result.fold((failure) => emit(UsersError(failure.message)), (_) => emit(const UserActivated()));
  }

  /// معالج إيقاف المستخدم
  Future<void> _onDeactivateUser(DeactivateUserEvent event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());

    final result = await deactivateUserUseCase(event.id);

    result.fold((failure) => emit(UsersError(failure.message)), (_) => emit(const UserDeactivated()));
  }

  /// معالج تحديث الصلاحيات
  Future<void> _onUpdatePermissions(UpdatePermissionsEvent event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());

    final result = await updatePermissionsUseCase(
      UpdatePermissionsParams(id: event.id, permissions: event.permissions),
    );

    result.fold((failure) => emit(UsersError(failure.message)), (_) => emit(const PermissionsUpdated()));
  }
}
