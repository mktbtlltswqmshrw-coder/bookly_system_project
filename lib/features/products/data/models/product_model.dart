import 'package:bookly_system/features/products/domain/entities/product_entity.dart';

/// نموذج المنتج - Data Model
class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.nameAr,
    super.description,
    super.categoryId,
    super.sku,
    super.barcode,
    required super.unit,
    required super.costPrice,
    required super.sellingPrice,
    required super.minStockLevel,
    required super.currentStock,
    super.imageUrl,
    super.supplierId,
    required super.isActive,
    super.createdBy,
    required super.createdAt,
    required super.updatedAt,
    required super.isDeleted,
  });

  /// من JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['name_ar'] as String,
      description: json['description'] as String?,
      categoryId: json['category_id'] as String?,
      sku: json['sku'] as String?,
      barcode: json['barcode'] as String?,
      unit: json['unit'] as String? ?? 'قطعة',
      costPrice: (json['cost_price'] as num?)?.toDouble() ?? 0.0,
      sellingPrice: (json['selling_price'] as num).toDouble(),
      minStockLevel: json['min_stock_level'] as int? ?? 0,
      currentStock: json['current_stock'] as int? ?? 0,
      imageUrl: json['image_url'] as String?,
      supplierId: json['supplier_id'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isDeleted: json['is_deleted'] as bool? ?? false,
    );
  }

  /// إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'description': description,
      'category_id': categoryId,
      'sku': sku,
      'barcode': barcode,
      'unit': unit,
      'cost_price': costPrice,
      'selling_price': sellingPrice,
      'min_stock_level': minStockLevel,
      'current_stock': currentStock,
      'image_url': imageUrl,
      'supplier_id': supplierId,
      'is_active': isActive,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }

  /// من Entity
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      nameAr: entity.nameAr,
      description: entity.description,
      categoryId: entity.categoryId,
      sku: entity.sku,
      barcode: entity.barcode,
      unit: entity.unit,
      costPrice: entity.costPrice,
      sellingPrice: entity.sellingPrice,
      minStockLevel: entity.minStockLevel,
      currentStock: entity.currentStock,
      imageUrl: entity.imageUrl,
      supplierId: entity.supplierId,
      isActive: entity.isActive,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDeleted: entity.isDeleted,
    );
  }

  /// نسخ مع تعديلات
  @override
  ProductModel copyWith({
    String? id,
    String? name,
    String? nameAr,
    String? description,
    String? categoryId,
    String? sku,
    String? barcode,
    String? unit,
    double? costPrice,
    double? sellingPrice,
    int? minStockLevel,
    int? currentStock,
    String? imageUrl,
    String? supplierId,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      unit: unit ?? this.unit,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      minStockLevel: minStockLevel ?? this.minStockLevel,
      currentStock: currentStock ?? this.currentStock,
      imageUrl: imageUrl ?? this.imageUrl,
      supplierId: supplierId ?? this.supplierId,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
