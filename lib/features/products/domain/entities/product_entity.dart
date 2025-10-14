import 'package:equatable/equatable.dart';

/// كيان المنتج - Domain Entity
class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String nameAr;
  final String? description;
  final String? categoryId;
  final String? sku;
  final String? barcode;
  final String unit;
  final double costPrice;
  final double sellingPrice;
  final int minStockLevel;
  final int currentStock;
  final String? imageUrl;
  final String? supplierId;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.nameAr,
    this.description,
    this.categoryId,
    this.sku,
    this.barcode,
    required this.unit,
    required this.costPrice,
    required this.sellingPrice,
    required this.minStockLevel,
    required this.currentStock,
    this.imageUrl,
    this.supplierId,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    nameAr,
    description,
    categoryId,
    sku,
    barcode,
    unit,
    costPrice,
    sellingPrice,
    minStockLevel,
    currentStock,
    imageUrl,
    supplierId,
    isActive,
    createdBy,
    createdAt,
    updatedAt,
    isDeleted,
  ];

  /// نسخ المنتج مع تعديل بعض الخصائص
  ProductEntity copyWith({
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
    return ProductEntity(
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

  /// التحقق من أن المخزون منخفض
  bool get isLowStock => currentStock <= minStockLevel;

  /// التحقق من نفاد المخزون
  bool get isOutOfStock => currentStock <= 0;

  /// حساب هامش الربح
  double get profitMargin => sellingPrice - costPrice;

  /// حساب نسبة الربح
  double get profitPercentage => costPrice > 0 ? (profitMargin / costPrice) * 100 : 0;
}
