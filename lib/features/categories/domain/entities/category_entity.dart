import 'package:equatable/equatable.dart';

/// كيان الفئة - Domain Entity
class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String nameAr;
  final String? description;
  final String? parentId;
  final String? icon;
  final String? imageUrl; // إضافة حقل الصورة
  final int sortOrder;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.nameAr,
    this.description,
    this.parentId,
    this.icon,
    this.imageUrl, // إضافة حقل الصورة
    required this.sortOrder,
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
    parentId,
    icon,
    imageUrl, // إضافة حقل الصورة
    sortOrder,
    isActive,
    createdBy,
    createdAt,
    updatedAt,
    isDeleted,
  ];

  /// نسخ الفئة مع تعديل بعض الخصائص
  CategoryEntity copyWith({
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
    return CategoryEntity(
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

  /// التحقق من أن الفئة رئيسية (ليس لها فئة أب)
  bool get isMainCategory => parentId == null;

  /// التحقق من أن الفئة فرعية (لها فئة أب)
  bool get isSubCategory => parentId != null;
}
