import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/widgets/custom_button.dart';
import 'package:bookly_system/core/widgets/custom_text_field.dart';
import 'package:bookly_system/core/widgets/help_widgets.dart';
import 'package:bookly_system/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

/// صفحة نموذج المنتج (مبسطة للاختبار)
class ProductFormPage extends StatefulWidget {
  final ProductEntity? product;

  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameArController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skuController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _unitController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _minStockController = TextEditingController();
  final _currentStockController = TextEditingController();

  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _populateFields();
    } else {
      _unitController.text = 'قطعة';
      _minStockController.text = '0';
      _currentStockController.text = '0';
      _costPriceController.text = '0';
    }
  }

  void _populateFields() {
    final product = widget.product!;
    _nameController.text = product.name;
    _nameArController.text = product.nameAr;
    _descriptionController.text = product.description ?? '';
    _skuController.text = product.sku ?? '';
    _barcodeController.text = product.barcode ?? '';
    _unitController.text = product.unit;
    _costPriceController.text = product.costPrice.toString();
    _sellingPriceController.text = product.sellingPrice.toString();
    _minStockController.text = product.minStockLevel.toString();
    _currentStockController.text = product.currentStock.toString();
    _isActive = product.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameArController.dispose();
    _descriptionController.dispose();
    _skuController.dispose();
    _barcodeController.dispose();
    _unitController.dispose();
    _costPriceController.dispose();
    _sellingPriceController.dispose();
    _minStockController.dispose();
    _currentStockController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement save logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.product == null ? 'تم إضافة المنتج' : 'تم تحديث المنتج'),
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
        title: Text(widget.product == null ? AppStrings.addProduct : AppStrings.editProduct),
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: _saveProduct, tooltip: AppStrings.save)],
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
                label: AppStrings.productNameAr,
                controller: _nameArController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'اسم المنتج بالعربية مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // الاسم بالإنجليزية
              CustomTextField(
                label: AppStrings.productName,
                controller: _nameController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'اسم المنتج بالإنجليزية مطلوب';
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

              // SKU
              TextFieldWithHelp(
                labelText: AppStrings.sku,
                hintText: 'مثال: NB-A4-100',
                helpTitle: 'ما هو SKU؟',
                helpMessage:
                    'SKU (Stock Keeping Unit) هو رمز تعريف فريد لكل منتج.\n\n'
                    'يساعد في:\n'
                    '• تتبع المخزون بسهولة\n'
                    '• البحث السريع عن المنتج\n'
                    '• منع التكرار\n\n'
                    'مثال: NB-A4-100 (دفتر A4 100 ورقة)',
                controller: _skuController,
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // الباركود
              TextFieldWithHelp(
                labelText: AppStrings.barcode,
                hintText: 'مثال: 6281234567890',
                helpTitle: 'ما هو الباركود؟',
                helpMessage:
                    'الباركود هو رمز خطي أو مربع يحتوي على معلومات المنتج.\n\n'
                    'الفوائد:\n'
                    '• مسح سريع للمنتج\n'
                    '• تقليل الأخطاء في الإدخال\n'
                    '• تسريع عملية البيع\n\n'
                    'مثال: 6281234567890',
                controller: _barcodeController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // الوحدة
              TextFieldWithHelp(
                labelText: AppStrings.unit,
                hintText: 'مثال: قطعة، علبة، كيلو',
                helpTitle: 'ما هي الوحدة؟',
                helpMessage:
                    'الوحدة هي مقياس الكمية للمنتج.\n\n'
                    'أمثلة شائعة:\n'
                    '• قطعة (للمنتجات الفردية)\n'
                    '• علبة (للمجموعات)\n'
                    '• كيلو (للوزن)\n'
                    '• متر (للطول)\n\n'
                    'مثال: قطعة، علبة، كيلو',
                controller: _unitController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الوحدة مطلوبة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // سعر الشراء
              TextFieldWithHelp(
                labelText: AppStrings.costPrice,
                hintText: 'مثال: 1500',
                helpTitle: 'ما هو سعر الشراء؟',
                helpMessage:
                    'سعر الشراء هو التكلفة التي دفعتها لشراء المنتج من المورد.\n\n'
                    'الفوائد:\n'
                    '• حساب هامش الربح\n'
                    '• تحديد سعر البيع المناسب\n'
                    '• تتبع التكاليف\n\n'
                    'مثال: 1500 دينار عراقي',
                controller: _costPriceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'سعر الشراء مطلوب';
                  }
                  if (double.tryParse(value) == null) {
                    return 'سعر الشراء غير صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // سعر البيع
              TextFieldWithHelp(
                labelText: AppStrings.sellingPrice,
                hintText: 'مثال: 2500',
                helpTitle: 'ما هو سعر البيع؟',
                helpMessage:
                    'سعر البيع هو السعر الذي ستبيعه به المنتج للعميل.\n\n'
                    'نصائح:\n'
                    '• يجب أن يكون أعلى من سعر الشراء\n'
                    '• ضع في اعتبارك هامش الربح\n'
                    '• قارن مع أسعار المنافسين\n\n'
                    'مثال: 2500 دينار عراقي',
                controller: _sellingPriceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'سعر البيع مطلوب';
                  }
                  if (double.tryParse(value) == null) {
                    return 'سعر البيع غير صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // الحد الأدنى للمخزون
              TextFieldWithHelp(
                labelText: AppStrings.minStockLevel,
                hintText: 'مثال: 20',
                helpTitle: 'ما هو الحد الأدنى للمخزون؟',
                helpMessage:
                    'الحد الأدنى للمخزون هو أقل كمية يجب أن تكون متوفرة من المنتج.\n\n'
                    'الفوائد:\n'
                    '• تحذير عند انخفاض المخزون\n'
                    '• تجنب نفاد المنتج\n'
                    '• تخطيط الطلبات مسبقاً\n\n'
                    'مثال: 20 قطعة',
                controller: _minStockController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الحد الأدنى للمخزون مطلوب';
                  }
                  if (int.tryParse(value) == null) {
                    return 'الحد الأدنى للمخزون غير صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spaceMD),

              // المخزون الحالي
              TextFieldWithHelp(
                labelText: AppStrings.currentStock,
                hintText: 'مثال: 150',
                helpTitle: 'ما هو المخزون الحالي؟',
                helpMessage:
                    'المخزون الحالي هو الكمية الموجودة حالياً من المنتج في المتجر.\n\n'
                    'الفوائد:\n'
                    '• معرفة الكمية المتوفرة\n'
                    '• تتبع حركة المخزون\n'
                    '• تجنب الطلبات الزائدة\n\n'
                    'مثال: 150 قطعة',
                controller: _currentStockController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'المخزون الحالي مطلوب';
                  }
                  if (int.tryParse(value) == null) {
                    return 'المخزون الحالي غير صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spaceLG),

              // حالة النشاط
              SwitchListTile(
                title: const Text(AppStrings.active),
                subtitle: const Text('تفعيل المنتج'),
                value: _isActive,
                onChanged: (value) {
                  setState(() => _isActive = value);
                },
              ),
              const SizedBox(height: AppDimensions.spaceXL),

              // زر الحفظ
              CustomButton(
                text: widget.product == null ? AppStrings.add : AppStrings.save,
                onPressed: _saveProduct,
                icon: widget.product == null ? Icons.add : Icons.save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
