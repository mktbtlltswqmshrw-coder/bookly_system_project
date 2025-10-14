import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/network/supabase_client.dart';
import 'package:bookly_system/features/categories/data/models/category_model.dart';
import 'package:flutter/material.dart';

/// واجهة مصدر البيانات البعيد للفئات
abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories({String? parentId, bool? isActive, int? limit, int? offset});

  Future<CategoryModel> getCategoryById(String id);
  Future<CategoryModel> addCategory(CategoryModel category);
  Future<CategoryModel> updateCategory(CategoryModel category);
  Future<void> deleteCategory(String id);
  Future<List<CategoryModel>> getMainCategories();
  Future<List<CategoryModel>> getSubCategories(String parentId);
  Future<List<CategoryModel>> searchCategories(String query);
}

/// تنفيذ مصدر البيانات البعيد للفئات
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  @override
  Future<List<CategoryModel>> getCategories({String? parentId, bool? isActive, int? limit, int? offset}) async {
    try {
      dynamic query = SupabaseClientService.instance.from('categories').select().eq('is_deleted', false);

      // تطبيق الفلاتر
      if (parentId != null) {
        query = query.eq('parent_id', parentId);
      }

      if (isActive != null) {
        query = query.eq('is_active', isActive);
      }

      // تطبيق الترتيب والحدود
      query = query.order('sort_order', ascending: true).order('name_ar', ascending: true);

      if (limit != null) {
        query = query.limit(limit);
      }

      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 50) - 1);
      }

      final response = await query;
      final responseList = response as List;
      debugPrint('🔍 Categories Response Type: ${response.runtimeType}');
      debugPrint('🔍 Categories Response Length: ${responseList.length}');
      debugPrint(
        '🔍 Categories First Item Type: ${responseList.isNotEmpty ? responseList.first.runtimeType : "empty"}',
      );
      return responseList.map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('فشل في جلب الفئات: $e');
    }
  }

  @override
  Future<CategoryModel> getCategoryById(String id) async {
    try {
      final response = await SupabaseClientService.instance
          .from('categories')
          .select()
          .eq('id', id)
          .eq('is_deleted', false)
          .single();

      return CategoryModel.fromJson(response);
    } catch (e) {
      throw ServerException('فشل في جلب الفئة: $e');
    }
  }

  @override
  Future<CategoryModel> addCategory(CategoryModel category) async {
    try {
      final response = await SupabaseClientService.instance
          .from('categories')
          .insert(category.toJson())
          .select()
          .single();

      return CategoryModel.fromJson(response);
    } catch (e) {
      throw ServerException('فشل في إضافة الفئة: $e');
    }
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    try {
      final response = await SupabaseClientService.instance
          .from('categories')
          .update(category.toJson())
          .eq('id', category.id)
          .select()
          .single();

      return CategoryModel.fromJson(response);
    } catch (e) {
      throw ServerException('فشل في تحديث الفئة: $e');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await SupabaseClientService.instance
          .from('categories')
          .update({'is_deleted': true, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', id);
    } catch (e) {
      throw ServerException('فشل في حذف الفئة: $e');
    }
  }

  @override
  Future<List<CategoryModel>> getMainCategories() async {
    try {
      final response = await SupabaseClientService.instance
          .from('categories')
          .select()
          .isFilter('parent_id', null)
          .eq('is_deleted', false)
          .eq('is_active', true)
          .order('sort_order', ascending: true)
          .order('name_ar', ascending: true);

      return (response as List).map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('فشل في جلب الفئات الرئيسية: $e');
    }
  }

  @override
  Future<List<CategoryModel>> getSubCategories(String parentId) async {
    try {
      final response = await SupabaseClientService.instance
          .from('categories')
          .select()
          .eq('parent_id', parentId)
          .eq('is_deleted', false)
          .eq('is_active', true)
          .order('sort_order', ascending: true)
          .order('name_ar', ascending: true);

      return (response as List).map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('فشل في جلب الفئات الفرعية: $e');
    }
  }

  @override
  Future<List<CategoryModel>> searchCategories(String query) async {
    try {
      final response = await SupabaseClientService.instance
          .from('categories')
          .select()
          .eq('is_deleted', false)
          .or('name.ilike.%$query%,name_ar.ilike.%$query%')
          .order('sort_order', ascending: true)
          .order('name_ar', ascending: true);

      return (response as List).map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('فشل في البحث عن الفئات: $e');
    }
  }
}
