import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

/// عميل Supabase المخصص للتطبيق
class SupabaseClientService {
  static SupabaseClient? _instance;

  /// تهيئة Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://wncnupajycgmenzeqpzt.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InduY251cGFqeWNnbWVuemVxcHp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk5Mzk1OTYsImV4cCI6MjA3NTUxNTU5Nn0.3lpxkb-ebkUMwg7J5X97npPCbgmAEueVpfAalNtK-1s',
    );
    _instance = Supabase.instance.client;
  }

  /// الحصول على instance من Supabase Client
  static SupabaseClient get instance {
    if (_instance == null) {
      throw Exception('يجب استدعاء initialize() أولاً');
    }
    return _instance!;
  }

  /// الحصول على المستخدم الحالي
  static User? get currentUser => instance.auth.currentUser;

  /// التحقق من تسجيل الدخول
  static bool get isAuthenticated => currentUser != null;

  /// الحصول على Auth
  static GoTrueClient get auth => instance.auth;

  /// الحصول على Database
  static SupabaseQueryBuilder from(String table) => instance.from(table);

  /// الحصول على Storage
  static SupabaseStorageClient get storage => instance.storage;

  /// رفع صورة إلى Storage
  static Future<String> uploadImage({required String bucket, required String path, required String filePath}) async {
    try {
      final file = File(filePath);
      await storage.from(bucket).upload(path, file);
      final publicUrl = storage.from(bucket).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      throw Exception('فشل رفع الصورة: $e');
    }
  }

  /// حذف صورة من Storage
  static Future<void> deleteImage({required String bucket, required String path}) async {
    try {
      await storage.from(bucket).remove([path]);
    } catch (e) {
      throw Exception('فشل حذف الصورة: $e');
    }
  }
}

/// تسهيل الوصول السريع
final supabase = SupabaseClientService.instance;
