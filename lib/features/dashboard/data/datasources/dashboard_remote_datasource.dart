import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/network/supabase_client.dart';
import 'package:bookly_system/features/dashboard/data/models/dashboard_stats_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// واجهة مصدر البيانات البعيد للوحة التحكم
abstract class DashboardRemoteDataSource {
  Future<DashboardStatsModel> getDashboardStats();
}

/// تطبيق مصدر البيانات البعيد للوحة التحكم
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final SupabaseClient supabase;

  DashboardRemoteDataSourceImpl() : supabase = SupabaseClientService.instance;

  @override
  Future<DashboardStatsModel> getDashboardStats() async {
    try {
      // استخدام View المعرف في قاعدة البيانات
      final response = await supabase.from('dashboard_stats').select().single();

      return DashboardStatsModel.fromJson(response);
    } catch (e) {
      throw DatabaseException('حدث خطأ في جلب إحصائيات لوحة التحكم: $e');
    }
  }
}
