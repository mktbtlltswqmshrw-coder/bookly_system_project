import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/widgets/custom_button.dart';
import 'package:bookly_system/core/widgets/custom_text_field.dart';
import 'package:bookly_system/core/widgets/help_widgets.dart';
import 'package:bookly_system/features/categories/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

/// صفحة نموذج الفئة (مبسطة للاختبار)
class CategoryFormPage extends StatefulWidget {
  final CategoryEntity? category;

  const CategoryFormPage({super.key, this.category});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameArController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _iconController = TextEditingController();
  final _sortOrderController = TextEditingController();

  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _populateFields();
    } else {
      _sortOrderController.text = '0';
    }
  }

  void _populateFields() {
    final category = widget.category!;
    _nameController.text = category.name;
    _nameArController.text = category.nameAr;
    _descriptionController.text = category.description ?? '';
    _iconController.text = category.icon ?? '';
    _sortOrderController.text = category.sortOrder.toString();
    _isActive = category.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameArController.dispose();
    _descriptionController.dispose();
    _iconController.dispose();
    _sortOrderController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement save logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.category == null ? 'تم إضافة الفئة' : 'تم تحديث الفئة'),
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null ? AppStrings.addCategory : AppStrings.editCategory),
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: _saveCategory, tooltip: AppStrings.save)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // الاسم بالعربية
              CustomTextField(
                label: AppStrings.categoryNameAr,
                controller: _nameArController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'اسم الفئة بالعربية مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // الاسم بالإنجليزية
              CustomTextField(
                label: AppStrings.categoryName,
                controller: _nameController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'اسم الفئة بالإنجليزية مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // الوصف
              CustomTextField(
                label: AppStrings.description,
                controller: _descriptionController,
                maxLines: 3,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // الأيقونة
              TextFieldWithHelp(
                labelText: AppStrings.icon,
                hintText: 'مثال: school, work, palette',
                helpTitle: 'ما هي الأيقونة؟',
                helpMessage:
                    'الأيقونة هي رمز بصري يمثل الفئة في التطبيق.\n\n'
                    'أمثلة شائعة:\n'
                    '• school (للمدرسة)\n'
                    '• work (للمكتب)\n'
                    '• palette (للفن)\n'
                    '• menu_book (للكتب)\n'
                    '• computer (للحاسوب)\n\n'
                    'يمكنك تركها فارغة لاستخدام أيقونة افتراضية',
                controller: _iconController,
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // ترتيب العرض
              TextFieldWithHelp(
                labelText: AppStrings.sortOrder,
                hintText: 'مثال: 1, 2, 3',
                helpTitle: 'ما هو ترتيب العرض؟',
                helpMessage:
                    'ترتيب العرض يحدد ترتيب الفئات في القائمة.\n\n'
                    'القواعد:\n'
                    '• الأرقام الأصغر تظهر أولاً\n'
                    '• 0 = الترتيب الافتراضي\n'
                    '• يمكن استخدام نفس الرقم لعدة فئات\n\n'
                    'مثال: 1 (الأول)، 2 (الثاني)، 3 (الثالث)',
                controller: _sortOrderController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'ترتيب العرض مطلوب';
                  }
                  if (int.tryParse(value) == null) {
                    return 'ترتيب العرض غير صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spaceLG),

              // حالة النشاط
              SwitchListTile(
                title: const Text(AppStrings.active),
                subtitle: const Text('تفعيل الفئة'),
                value: _isActive,
                onChanged: (value) {
                  setState(() => _isActive = value);
                },
              ),
              const SizedBox(height: AppDimensions.spaceXL),

              // زر الحفظ
              CustomButton(
                text: widget.category == null ? AppStrings.add : AppStrings.save,
                onPressed: _saveCategory,
                icon: widget.category == null ? Icons.add : Icons.save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
