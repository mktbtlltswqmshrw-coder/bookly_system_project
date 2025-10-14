import 'package:bookly_system/features/categories/domain/entities/category_entity.dart';

/// نموذج الفئة - Data Model
class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.nameAr,
    super.description,
    super.parentId,
    super.icon,
    super.imageUrl, // إضافة حقل الصورة
    required super.sortOrder,
    required super.isActive,
    super.createdBy,
    required super.createdAt,
    required super.updatedAt,
    required super.isDeleted,
  });

  /// من JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['name_ar'] as String,
      description: json['description'] as String?,
      parentId: json['parent_id'] as String?,
      icon: json['icon'] as String?,
      imageUrl: json['image_url'] as String?, // إضافة حقل الصورة
      sortOrder: json['sort_order'] as int? ?? 0,
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
      'parent_id': parentId,
      'icon': icon,
      'image_url': imageUrl, // إضافة حقل الصورة
      'sort_order': sortOrder,
      'is_active': isActive,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }

  /// من Entity
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      nameAr: entity.nameAr,
      description: entity.description,
      parentId: entity.parentId,
      icon: entity.icon,
      imageUrl: entity.imageUrl, // إضافة حقل الصورة
      sortOrder: entity.sortOrder,
      isActive: entity.isActive,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDeleted: entity.isDeleted,
    );
  }

  /// نسخ مع تعديلات
  @override
  CategoryModel copyWith({
    String? id,
    String? name,
    String? nameAr,
    String? description,
    String? parentId,
    String? icon,
    String? imageUrl, // إضافة حقل الصورة
    int? sortOrder,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      icon: icon ?? this.icon,
      imageUrl: imageUrl ?? this.imageUrl, // إضافة حقل الصورة
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
