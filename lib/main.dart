import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/di/injection_container.dart';
import 'package:bookly_system/core/theme/app_theme.dart';
import 'package:bookly_system/core/utils/bloc_observer.dart';
import 'package:bookly_system/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:bookly_system/features/auth/presentation/pages/login_page.dart';
import 'package:bookly_system/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // التأكد من تهيئة Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // تفعيل BlocObserver لتتبع جميع Events و States
  Bloc.observer = AppBlocObserver();

  // تعيين اتجاه النص RTL للعربية
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // تهيئة جميع الـ dependencies
  await initDependencies(sharedPreferences);

  // Check if user is logged in
  final authLocalDataSource = getIt<AuthLocalDataSource>();
  final userSession = await authLocalDataSource.getUserSession();

  runApp(BooklyApp(isLoggedIn: userSession != null));
}

class BooklyApp extends StatelessWidget {
  final bool isLoggedIn;

  const BooklyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // الثيمات
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // اللغة والاتجاه
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // RTL Support
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },

      // الصفحة الرئيسية - حسب حالة تسجيل الدخول
      home: isLoggedIn ? const DashboardPage() : const LoginPage(),
    );
  }
}

/// صفحة البداية المؤقتة
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شعار مؤقت
            Icon(Icons.book, size: 120, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 24),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'نظام إدارة متكامل للمكتبات',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('جاري التحميل...', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
