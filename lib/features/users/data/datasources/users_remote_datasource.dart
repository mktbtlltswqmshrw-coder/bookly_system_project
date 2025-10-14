import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/network/supabase_client.dart';
import 'package:bookly_system/features/auth/data/models/user_model.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

/// واجهة مصدر البيانات البعيد لإدارة المستخدمين
abstract class UsersRemoteDataSource {
  Future<List<UserModel>> getUsers({String? role, bool? isActive});
  Future<UserModel> getUserById(String id);
  Future<UserModel> addUser({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    required UserRole role,
    List<String>? permissions,
  });
  Future<UserModel> updateUser({required String id, String? fullName, String? phone, UserRole? role});
  Future<void> deleteUser(String id);
  Future<void> updateUserStatus(String id, bool isActive);
  Future<void> updatePermissions(String id, List<String> permissions);
}

/// تطبيق مصدر البيانات البعيد لإدارة المستخدمين
class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final SupabaseClient supabase;

  UsersRemoteDataSourceImpl() : supabase = SupabaseClientService.instance;

  @override
  Future<List<UserModel>> getUsers({String? role, bool? isActive}) async {
    try {
      var query = supabase.from('users').select().eq('is_deleted', false);

      if (role != null) {
        query = query.eq('role', role);
      }

      if (isActive != null) {
        query = query.eq('is_active', isActive);
      }

      final response = await query.order('created_at', ascending: false);

      return (response as List).map((data) => _mapToUserModel(data)).toList();
    } catch (e) {
      throw DatabaseException('حدث خطأ في جلب المستخدمين: $e');
    }
  }

  @override
  Future<UserModel> getUserById(String id) async {
    try {
      final response = await supabase.from('users').select().eq('id', id).eq('is_deleted', false).single();

      return _mapToUserModel(response);
    } catch (e) {
      throw NotFoundException('المستخدم غير موجود');
    }
  }

  @override
  Future<UserModel> addUser({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    required UserRole role,
    List<String>? permissions,
  }) async {
    try {
      // إنشاء المستخدم في Supabase Auth
      final authResponse = await supabase.auth.signUp(email: email, password: password);

      if (authResponse.user == null) {
        throw const AuthException('فشل إنشاء حساب المستخدم');
      }

      // إضافة بيانات المستخدم في جدول users
      final userData = await supabase
          .from('users')
          .insert({
            'id': authResponse.user!.id,
            'email': email,
            'full_name': fullName,
            'phone': phone,
            'role': role.value,
            'permissions': permissions ?? [],
            'is_active': true,
          })
          .select()
          .single();

      return _mapToUserModel(userData);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw DatabaseException('حدث خطأ في إضافة المستخدم: $e');
    }
  }

  @override
  Future<UserModel> updateUser({required String id, String? fullName, String? phone, UserRole? role}) async {
    try {
      final Map<String, dynamic> updates = {};

      if (fullName != null) updates['full_name'] = fullName;
      if (phone != null) updates['phone'] = phone;
      if (role != null) updates['role'] = role.value;

      if (updates.isEmpty) {
        throw const ValidationException('لا توجد بيانات للتحديث');
      }

      final response = await supabase.from('users').update(updates).eq('id', id).select().single();

      return _mapToUserModel(response);
    } catch (e) {
      throw DatabaseException('حدث خطأ في تحديث المستخدم: $e');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      // Soft delete
      await supabase.from('users').update({'is_deleted': true}).eq('id', id);
    } catch (e) {
      throw DatabaseException('حدث خطأ في حذف المستخدم: $e');
    }
  }

  @override
  Future<void> updateUserStatus(String id, bool isActive) async {
    try {
      await supabase.from('users').update({'is_active': isActive}).eq('id', id);
    } catch (e) {
      throw DatabaseException('حدث خطأ في تحديث حالة المستخدم: $e');
    }
  }

  @override
  Future<void> updatePermissions(String id, List<String> permissions) async {
    try {
      await supabase.from('users').update({'permissions': permissions}).eq('id', id);
    } catch (e) {
      throw DatabaseException('حدث خطأ في تحديث الصلاحيات: $e');
    }
  }

  /// تحويل البيانات من Map إلى UserModel
  UserModel _mapToUserModel(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      email: data['email'],
      fullName: data['full_name'],
      phone: data['phone'],
      role: UserRole.fromString(data['role']),
      permissions: (data['permissions'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      isActive: data['is_active'] ?? true,
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }
}
