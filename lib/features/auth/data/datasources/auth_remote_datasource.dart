import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/network/supabase_client.dart';
import 'package:bookly_system/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:bookly_system/features/auth/data/models/user_model.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

/// واجهة مصدر البيانات البعيد للمصادقة
abstract class AuthRemoteDataSource {
  /// تسجيل الدخول
  Future<UserModel> login({required String email, required String password});

  /// تسجيل الخروج
  Future<void> logout();

  /// الحصول على المستخدم الحالي
  Future<UserModel> getCurrentUser();

  /// التحقق من تسجيل الدخول
  bool get isAuthenticated;

  /// مراقبة حالة تسجيل الدخول
  Stream<bool> get authStateChanges;
}

/// تطبيق مصدر البيانات البعيد للمصادقة
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;
  final AuthLocalDataSource localDataSource;

  AuthRemoteDataSourceImpl({required this.localDataSource}) : supabase = SupabaseClientService.instance;

  @override
  Future<UserModel> login({required String email, required String password}) async {
    try {
      debugPrint('🔐 محاولة تسجيل الدخول: $email');

      // البحث عن المستخدم بالبريد وكلمة المرور
      final response = await supabase
          .from('users')
          .select()
          .eq('email', email)
          .eq('password', password)
          .eq('is_active', true)
          .single();

      debugPrint('✅ تم العثور على المستخدم: ${response['full_name']}');

      final userModel = _mapToUserModel(response);

      // حفظ الجلسة محلياً
      await localDataSource.saveUserSession(userModel.id, userModel.email);

      return userModel;
    } catch (e) {
      debugPrint('❌ Error: $e');
      throw AuthException('البريد الإلكتروني أو كلمة المرور غير صحيحة');
    }
  }

  @override
  Future<void> logout() async {
    try {
      // مسح الجلسة المحلية
      await localDataSource.clearUserSession();
      debugPrint('✅ تم تسجيل الخروج');
    } catch (e) {
      throw AuthException('حدث خطأ في تسجيل الخروج: $e');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final session = await localDataSource.getUserSession();
      if (session == null) {
        throw const AuthException('لا يوجد مستخدم مسجل دخول');
      }

      // البحث عن المستخدم في قاعدة البيانات
      final response = await supabase
          .from('users')
          .select()
          .eq('id', session['user_id']!)
          .eq('is_active', true)
          .single();

      return _mapToUserModel(response);
    } catch (e) {
      throw AuthException('لا يوجد مستخدم مسجل دخول');
    }
  }

  @override
  bool get isAuthenticated {
    // يمكن تحسين هذا لاحقاً باستخدام Stream
    return false;
  }

  @override
  Stream<bool> get authStateChanges {
    return Stream.value(false); // مبسط - يمكن تحسينه لاحقاً
  }

  /// تحويل البيانات من Map إلى UserModel
  UserModel _mapToUserModel(Map<String, dynamic> data) {
    // معالجة الصلاحيات
    List<String> permissions = [];
    if (data['permissions'] != null) {
      if (data['permissions'] is List) {
        permissions = List<String>.from(data['permissions']);
      }
    }

    return UserModel(
      id: data['id'],
      email: data['email'],
      fullName: data['full_name'],
      phone: data['phone'],
      role: UserRole.fromString(data['role']),
      permissions: permissions,
      isActive: data['is_active'] ?? true,
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }
}
