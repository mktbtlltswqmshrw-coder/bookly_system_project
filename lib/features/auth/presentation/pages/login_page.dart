import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/di/injection_container.dart';
import 'package:bookly_system/core/utils/app_notification.dart';
import 'package:bookly_system/core/utils/validators.dart';
import 'package:bookly_system/core/widgets/custom_button.dart';
import 'package:bookly_system/core/widgets/custom_text_field.dart';
import 'package:bookly_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookly_system/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحة تسجيل الدخول
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<AuthBloc>(), child: const LoginView());
  }
}

/// عرض صفحة تسجيل الدخول
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEvent(email: _emailController.text.trim(), password: _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // الانتقال إلى لوحة التحكم
            AppNotification.showSuccess(context, 'تم تسجيل الدخول بنجاح');
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const DashboardPage()));
          } else if (state is AuthError) {
            print('🔴 Login Error: ${state.message}'); // إضافة debugging
            AppNotification.showError(context, state.message);
          }
        },
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingLG),
              child: Card(
                elevation: AppDimensions.elevationHigh,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusLG)),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: AppDimensions.maxFormWidth),
                  padding: const EdgeInsets.all(AppDimensions.paddingXL),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // الشعار
                        Icon(
                          Icons.book,
                          size: AppDimensions.iconXXL * 1.5,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: AppDimensions.spaceMD),

                        // العنوان
                        Text(
                          AppStrings.appName,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimensions.spaceSM),

                        Text(
                          AppStrings.loginToContinue,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimensions.spaceXL),

                        // حقل البريد الإلكتروني
                        CustomTextField(
                          label: AppStrings.email,
                          hint: 'admin@bookly.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: Validators.email,
                        ),
                        const SizedBox(height: AppDimensions.spaceMD),

                        // حقل كلمة المرور
                        PasswordTextField(
                          label: AppStrings.password,
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          validator: Validators.password,
                        ),
                        const SizedBox(height: AppDimensions.spaceLG),

                        // زر تسجيل الدخول
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return CustomButton(
                              text: AppStrings.login,
                              onPressed: _handleLogin,
                              isLoading: state is AuthLoading,
                              icon: Icons.login,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
