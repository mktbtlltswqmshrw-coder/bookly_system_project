import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/di/injection_container.dart';
import 'package:bookly_system/core/utils/app_notification.dart';
import 'package:bookly_system/core/widgets/empty_state_widget.dart';
import 'package:bookly_system/core/widgets/error_widget.dart';
import 'package:bookly_system/core/widgets/loading_widget.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/presentation/bloc/users_bloc.dart';
import 'package:bookly_system/features/users/presentation/pages/user_form_page.dart';
import 'package:bookly_system/features/users/presentation/widgets/user_card_widget.dart';
import 'package:bookly_system/features/users/presentation/widgets/user_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحة قائمة المستخدمين
class UsersListPage extends StatelessWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<UsersBloc>()..add(const LoadUsersEvent()), child: const UsersListView());
  }
}

/// عرض قائمة المستخدمين
class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  UserRole? _selectedRole;
  bool? _selectedStatus;
  bool _showFilters = false;

  void _loadUsers() {
    context.read<UsersBloc>().add(LoadUsersEvent(role: _selectedRole?.value, isActive: _selectedStatus));
  }

  void _showAddUserDialog() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(value: context.read<UsersBloc>(), child: const UserFormPage()),
      ),
    );
  }

  void _showEditUserDialog(UserEntity user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<UsersBloc>(),
          child: UserFormPage(user: user),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(UserEntity user) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.deleteUser),
        content: Text('${AppStrings.deleteUserConfirmation}\n\n${user.fullName}'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text(AppStrings.cancel)),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<UsersBloc>().add(DeleteUserEvent(user.id));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorLight),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
  }

  void _toggleUserStatus(UserEntity user) {
    if (user.isActive) {
      context.read<UsersBloc>().add(DeactivateUserEvent(user.id));
    } else {
      context.read<UsersBloc>().add(ActivateUserEvent(user.id));
    }
  }

  void _showPermissionsDialog(UserEntity user) {
    // TODO: سيتم إنشاء صفحة منفصلة لإدارة الصلاحيات
    AppNotification.showInfo(context, 'سيتم إضافة صفحة إدارة الصلاحيات قريباً');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.users),
        actions: [
          IconButton(
            icon: Icon(_showFilters ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            tooltip: AppStrings.filter,
          ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadUsers, tooltip: AppStrings.refresh),
        ],
      ),
      body: BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UserAdded) {
            AppNotification.showSuccess(context, AppStrings.userAdded);
            _loadUsers();
          } else if (state is UserUpdated) {
            AppNotification.showSuccess(context, AppStrings.userUpdated);
            _loadUsers();
          } else if (state is UserDeleted) {
            AppNotification.showSuccess(context, AppStrings.userDeleted);
            _loadUsers();
          } else if (state is UserActivated) {
            AppNotification.showSuccess(context, AppStrings.userActivated);
            _loadUsers();
          } else if (state is UserDeactivated) {
            AppNotification.showSuccess(context, AppStrings.userDeactivated);
            _loadUsers();
          } else if (state is PermissionsUpdated) {
            AppNotification.showSuccess(context, 'تم تحديث الصلاحيات بنجاح');
            _loadUsers();
          }
        },
        child: Column(
          children: [
            // الفلاتر
            if (_showFilters)
              UserFilterWidget(
                selectedRole: _selectedRole,
                selectedStatus: _selectedStatus,
                onRoleChanged: (role) {
                  setState(() {
                    _selectedRole = role;
                  });
                  _loadUsers();
                },
                onStatusChanged: (status) {
                  setState(() {
                    _selectedStatus = status;
                  });
                  _loadUsers();
                },
              ),

            // القائمة
            Expanded(
              child: BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  if (state is UsersLoading) {
                    return const LoadingWidget(message: 'جاري تحميل المستخدمين...');
                  } else if (state is UsersError) {
                    return CustomErrorWidget(message: state.message, onRetry: _loadUsers);
                  } else if (state is UsersLoaded) {
                    if (state.users.isEmpty) {
                      return EmptyStateWidget(
                        message: AppStrings.noData,
                        description: 'لا يوجد مستخدمين بعد',
                        icon: Icons.people_outline,
                        onAction: _showAddUserDialog,
                        actionText: AppStrings.addUser,
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingSM),
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return UserCardWidget(
                          user: user,
                          onTap: () {
                            // TODO: Navigate to user details
                          },
                          onEdit: () => _showEditUserDialog(user),
                          onDelete: () => _showDeleteConfirmation(user),
                          onToggleStatus: () => _toggleUserStatus(user),
                          onManagePermissions: user.role == UserRole.employee
                              ? () => _showPermissionsDialog(user)
                              : null,
                        );
                      },
                    );
                  }

                  return const EmptyStateWidget(message: AppStrings.noData, icon: Icons.people_outline);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddUserDialog,
        icon: const Icon(Icons.person_add),
        label: const Text(AppStrings.addUser),
      ),
    );
  }
}
