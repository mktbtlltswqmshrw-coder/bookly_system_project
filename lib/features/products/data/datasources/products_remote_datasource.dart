import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/network/supabase_client.dart';
import 'package:bookly_system/features/products/data/models/product_model.dart';

/// واجهة مصدر البيانات البعيد للمنتجات
abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    String? categoryId,
    String? searchQuery,
    bool? isActive,
    int? limit,
    int? offset,
  });

  Future<ProductModel> getProductById(String id);
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<List<ProductModel>> searchProducts(String query);
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
  Future<List<ProductModel>> getLowStockProducts();
  Future<ProductModel> updateProductStock(String productId, int newStock);
}

/// تنفيذ مصدر البيانات البعيد للمنتجات
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts({
    String? categoryId,
    String? searchQuery,
    bool? isActive,
    int? limit,
    int? offset,
  }) async {
    try {
      dynamic query = SupabaseClientService.instance.from('products').select().eq('is_deleted', false);

      // تطبيق الفلاتر
      if (categoryId != null) {
        query = query.eq('category_id', categoryId);
      }

      if (isActive != null) {
        query = query.eq('is_active', isActive);
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.or('name.ilike.%$searchQuery%,name_ar.ilike.%$searchQuery%,sku.ilike.%$searchQuery%');
      }

      // تطبيق الترتيب والحدود
      query = query.order('created_at', ascending: false);

      if (limit != null) {
        query = query.limit(limit);
      }

      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 50) - 1);
      }

      final response = await query;
      final responseList = response as List;
      print('🔍 Products Response Type: ${response.runtimeType}');
      print('🔍 Products Response Length: ${responseList.length}');
      print('🔍 Products First Item Type: ${responseList.isNotEmpty ? responseList.first.runtimeType : "empty"}');
      return responseList.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('فشل في جلب المنتجات: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await SupabaseClientService.instance
          .from('products')
          .select()
          .eq('id', id)
          .eq('is_deleted', false)
          .single();

      return ProductModel.fromJson(response);
    } catch (e) {
      throw ServerException('فشل في جلب المنتج: $e');
    }
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      final response = await SupabaseClientService.instance.from('products').insert(product.toJson()).select().single();

      return ProductModel.fromJson(response);
    } catch (e) {
      throw ServerException('فشل في إضافة المنتج: $e');
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      final response = await SupabaseClientService.instance
          .from('products')
          .update(product.toJson())
          .eq('id', product.id)
          .select()
          .single();

      return ProductModel.fromJson(response);
    } catch (e) {
      throw ServerException('فشل في تحديث المنتج: $e');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await SupabaseClientService.instance
          .from('products')
          .update({'is_deleted': true, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', id);
    } catch (e) {
      throw ServerException('فشل في حذف المنتج: $e');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await SupabaseClientService.instance
          .from('products')
          .select()
          .eq('is_deleted', false)
          .or('name.ilike.%$query%,name_ar.ilike.%$query%,sku.ilike.%$query%,barcode.ilike.%$query%')
          .order('created_at', ascending: false);

      return (response as List).map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('فشل في البحث عن المنتجات: $e');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final response = await SupabaseClientService.instance
          .from('products')
          .select()
          .eq('category_id', categoryId)
          .eq('is_deleted', false)
          .eq('is_active', true)
          .order('name_ar', ascending: true);

      return (response as List).map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('فشل في جلب منتجات الفئة: $e');
    }
  }

  @override
  Future<List<ProductModel>> getLowStockProducts() async {
    try {
      final response = await SupabaseClientService.instance
          .from('products')
          .select()
          .eq('is_deleted', false)
          .eq('is_active', true)
          .lte('current_stock', 'min_stock_level')
          .order('current_stock', ascending: true);

      return (response as List).map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('فشل في جلب منتجات المخزون المنخفض: $e');
    }
  }

  @override
  Future<ProductModel> updateProductStock(String productId, int newStock) async {
    try {
      final response = await SupabaseClientService.instance
          .from('products')
          .update({'current_stock': newStock, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', productId)
          .select()
          .single();

      return ProductModel.fromJson(response);
    } catch (e) {
      throw ServerException('فشل في تحديث مخزون المنتج: $e');
    }
  }
}
