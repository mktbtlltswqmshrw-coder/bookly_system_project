import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/utils/validators.dart';
import 'package:bookly_system/core/widgets/custom_button.dart';
import 'package:bookly_system/core/widgets/custom_text_field.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/presentation/bloc/users_bloc.dart';
import 'package:bookly_system/features/users/presentation/widgets/permissions_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحة نموذج المستخدم (إضافة/تعديل)
class UserFormPage extends StatefulWidget {
  final UserEntity? user; // null = إضافة، موجود = تعديل

  const UserFormPage({super.key, this.user});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late UserRole _selectedRole;
  late bool _isActive;
  late List<String> _selectedPermissions;

  bool get isEditMode => widget.user != null;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController(text: widget.user?.fullName ?? '');
    _phoneController = TextEditingController(text: widget.user?.phone ?? '');
    _selectedRole = widget.user?.role ?? UserRole.employee;
    _isActive = widget.user?.isActive ?? true;
    _selectedPermissions = List.from(widget.user?.permissions ?? []);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (isEditMode) {
        context.read<UsersBloc>().add(
              UpdateUserEvent(
                id: widget.user!.id,
                fullName: _fullNameController.text.trim(),
                phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
                role: _selectedRole,
              ),
            );
      } else {
        context.read<UsersBloc>().add(
              AddUserEvent(
                email: _emailController.text.trim(),
                password: _passwordController.text,
                fullName: _fullNameController.text.trim(),
                phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
                role: _selectedRole,
                permissions: _selectedPermissions,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? AppStrings.editUser : AppStrings.addUser),
      ),
      body: BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UserAdded || state is UserUpdated) {
            Navigator.of(context).pop();
          } else if (state is UsersError) {
            // الخطأ سيتم عرضه من UsersListPage
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLG),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // معلومات أساسية
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingMD),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'المعلومات الأساسية',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: AppDimensions.spaceMD),

                        // البريد الإلكتروني
                        CustomTextField(
                          label: AppStrings.email,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.email),
                          validator: Validators.email,
                          enabled: !isEditMode, // لا يمكن تعديل البريد
                        ),
                        const SizedBox(height: AppDimensions.spaceMD),

                        // كلمة المرور (للإضافة فقط)
                        if (!isEditMode) ...[
                          PasswordTextField(
                            label: AppStrings.password,
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            validator: Validators.password,
                          ),
                          const SizedBox(height: AppDimensions.spaceMD),
                        ],

                        // الاسم الكامل
                        CustomTextField(
                          label: AppStrings.fullName,
                          controller: _fullNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.person),
                          validator: Validators.required,
                        ),
                        const SizedBox(height: AppDimensions.spaceMD),

                        // رقم الهاتف
                        CustomTextField(
                          label: AppStrings.phone,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          prefixIcon: const Icon(Icons.phone),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return Validators.iraqiPhone(value);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppDimensions.spaceMD),

                        // الدور
                        DropdownButtonFormField<UserRole>(
                          initialValue: _selectedRole,
                          decoration: const InputDecoration(
                            labelText: AppStrings.role,
                            prefixIcon: Icon(Icons.admin_panel_settings),
                          ),
                          items: UserRole.values.map((role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(role.nameAr),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value!;
                            });
                          },
                        ),
                        const SizedBox(height: AppDimensions.spaceMD),

                        // الحالة
                        SwitchListTile(
                          value: _isActive,
                          onChanged: (value) {
                            setState(() {
                              _isActive = value;
                            });
                          },
                          title: const Text(AppStrings.active),
                          subtitle: Text(_isActive ? 'المستخدم نشط' : 'المستخدم غير نشط'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),

                // الصلاحيات (للموظفين فقط)
                if (_selectedRole == UserRole.employee) ...[
                  const SizedBox(height: AppDimensions.spaceMD),
                  PermissionsSelectorWidget(
                    selectedPermissions: _selectedPermissions,
                    onPermissionsChanged: (permissions) {
                      setState(() {
                        _selectedPermissions = permissions;
                      });
                    },
                  ),
                ],

                const SizedBox(height: AppDimensions.spaceLG),

                // زر الحفظ
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: AppStrings.save,
                      onPressed: _handleSubmit,
                      isLoading: state is UsersLoading,
                      icon: Icons.save,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
