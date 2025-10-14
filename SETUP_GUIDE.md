# 📚 دليل إعداد نظام إدارة المكتبة - Bookly System

## 🎯 نظرة عامة

نظام إدارة مكتبة شامل ومتكامل يوفر:
- ✅ إدارة المستخدمين والصلاحيات
- ✅ إدارة المنتجات والفئات
- ✅ إدارة المخزون (وارد/صادر)
- ✅ إدارة الفواتير (مبيعات/مشتريات)
- ✅ التقارير والإحصائيات
- ✅ إدارة الموردين
- ✅ دعم المود الليلي والنهاري
- ✅ واجهة عربية كاملة (RTL)

---

## 🛠️ المتطلبات

### 1. البيئة التطويرية
- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
- حساب Supabase (مجاني)

### 2. المكتبات المستخدمة
- `flutter_bloc` - إدارة الحالة
- `supabase_flutter` - قاعدة البيانات
- `dartz` - Functional Programming
- `get_it` - Dependency Injection
- `fl_chart` - الرسوم البيانية
- `pdf` & `printing` - طباعة الفواتير
- وغيرها...

---

## 📦 خطوات التثبيت

### الخطوة 1: استنساخ المشروع

```bash
git clone <repository-url>
cd bookly_system
```

### الخطوة 2: تثبيت المكتبات

```bash
flutter pub get
```

### الخطوة 3: إعداد Supabase

#### أ. إنشاء مشروع Supabase

1. اذهب إلى [https://supabase.com](https://supabase.com)
2. أنشئ حساب جديد أو سجل الدخول
3. أنشئ مشروع جديد

#### ب. تشغيل سكريبت قاعدة البيانات

1. افتح SQL Editor في لوحة تحكم Supabase
2. انسخ محتوى ملف `supabase_setup.sql`
3. شغل السكريبت

**السكريبت يقوم بـ:**
- إنشاء 8 جداول رئيسية
- إضافة Indexes للأداء
- إنشاء Triggers تلقائية
- إعداد RLS Policies للأمان
- إنشاء Views للتقارير
- إضافة بيانات أولية

#### ج. إنشاء Storage Bucket

1. اذهب إلى Storage في لوحة تحكم Supabase
2. أنشئ bucket جديد باسم `products`
3. اجعله public

#### د. تحديث معلومات الاتصال

معلومات Supabase موجودة في:
```
lib/core/network/supabase_client.dart
```

الروابط الحالية:
- URL: `https://wncnupajycgmenzeqpzt.supabase.co`
- Anon Key: موجود في الملف

---

## 🚀 تشغيل المشروع

### تشغيل على الموبايل

```bash
flutter run
```

### تشغيل على الويب

```bash
flutter run -d chrome
```

### تشغيل على سطح المكتب (Windows)

```bash
flutter run -d windows
```

---

## 👤 بيانات الدخول الافتراضية

**ملاحظة مهمة:** يجب إنشاء مستخدم Admin أولاً:

1. في لوحة تحكم Supabase، اذهب إلى Authentication
2. أنشئ مستخدم جديد:
   - Email: `admin@bookly.com`
   - Password: `123456` (أو أي كلمة مرور)

3. في SQL Editor، أضف هذا المستخدم إلى جدول users:

```sql
INSERT INTO users (id, email, full_name, phone, role, is_active)
SELECT 
    id, 
    email, 
    'مدير النظام', 
    '07XX-XXX-XXXX', 
    'admin', 
    true
FROM auth.users 
WHERE email = 'admin@bookly.com';
```

---

## 🏗️ هيكل المشروع

```
lib/
├── core/                      # المكونات المشتركة
│   ├── constants/             # الثوابت (ألوان، أبعاد، نصوص)
│   ├── theme/                 # الثيمات (فاتح/داكن)
│   ├── error/                 # معالجة الأخطاء
│   ├── network/               # Supabase client
│   ├── utils/                 # Utilities
│   ├── widgets/               # Widgets مشتركة
│   └── di/                    # Dependency Injection
├── features/                  # الميزات (Feature-First)
│   ├── auth/                  # المصادقة ✅
│   ├── dashboard/             # لوحة التحكم ✅
│   ├── users/                 # إدارة المستخدمين ✅
│   ├── categories/            # إدارة الفئات (قريباً)
│   ├── products/              # إدارة المنتجات (قريباً)
│   ├── suppliers/             # إدارة الموردين (قريباً)
│   ├── stock/                 # إدارة المخزون (قريباً)
│   ├── invoices/              # الفواتير (قريباً)
│   └── reports/               # التقارير (قريباً)
└── main.dart                  # نقطة الدخول
```

---

## 🎨 الميزات الحالية

### ✅ مكتملة

1. **Auth Feature**
   - تسجيل الدخول
   - تسجيل الخروج
   - إدارة الجلسات

2. **Dashboard Feature**
   - عرض الإحصائيات العامة
   - إجمالي المنتجات
   - المخزون المنخفض
   - مبيعات اليوم والشهر
   - الفواتير المعلقة

3. **Users Management Feature**
   - عرض قائمة المستخدمين
   - إضافة مستخدم (Admin/Employee)
   - تعديل بيانات المستخدم
   - حذف المستخدم
   - تفعيل/إيقاف المستخدم
   - إدارة الصلاحيات (19 صلاحية مختلفة)
   - بحث وتصفية متقدمة

### 🚧 قيد التطوير

- Categories Feature
- Products Feature
- Suppliers Feature
- Stock Management Feature
- Invoices Feature
- Reports Feature

---

## 🔐 نظام الصلاحيات

### أدوار المستخدمين

#### Admin (مدير)
- صلاحية كاملة على كل شيء
- لا يحتاج لتحديد صلاحيات منفصلة

#### Employee (موظف)
- يتم تحديد صلاحياته من قبل Admin
- 19 صلاحية متاحة عبر 7 فئات:

**المنتجات:**
- عرض المنتجات
- إضافة منتج
- تعديل منتج
- حذف منتج

**الفئات:**
- عرض الفئات
- إدارة الفئات

**الفواتير:**
- عرض الفواتير
- إنشاء فاتورة مبيعات
- إنشاء فاتورة مشتريات
- حذف فاتورة

**المخزون:**
- عرض المخزون
- تعديل المخزون

**التقارير:**
- عرض التقارير
- تصدير التقارير

**المستخدمين:**
- عرض المستخدمين
- إدارة المستخدمين
- إدارة الصلاحيات

**الموردين:**
- عرض الموردين
- إدارة الموردين

---

## 🎨 واجهة المستخدم

### نظام الألوان

**الوضع النهاري:**
- Primary: أخضر داكن (#2E7D32) - يرمز للمعرفة
- Secondary: أزرق (#1976D2) - احترافية
- Accent: برتقالي (#FF6F00) - تحفيزي

**الوضع الليلي:**
- Primary: أخضر فاتح (#66BB6A)
- Secondary: أزرق فاتح (#42A5F5)
- Accent: برتقالي فاتح (#FFB74D)

### ميزات UI/UX
- Material Design 3
- دعم RTL كامل للعربية
- رسوم متحركة سلسة
- تصميم responsive
- Loading states واضحة
- Error handling شامل
- نظام إشعارات مخصص (بدلاً من SnackBar)

---

## 🗄️ قاعدة البيانات

### الجداول الرئيسية

1. **users** - المستخدمين والصلاحيات
2. **categories** - الفئات (رئيسية وفرعية)
3. **products** - المنتجات
4. **suppliers** - الموردين
5. **stock_movements** - حركة المخزون
6. **invoices** - الفواتير
7. **invoice_items** - تفاصيل الفواتير
8. **payments** - الدفعات

### الميزات التقنية

- **Triggers**: تحديث المخزون تلقائياً
- **Functions**: توليد أرقام الفواتير
- **Views**: إحصائيات جاهزة
- **RLS**: أمان على مستوى الصفوف
- **Indexes**: أداء عالي للبحث

---

## 🧪 الاختبار

### اختبار المصادقة

1. افتح التطبيق
2. سجل الدخول بحساب Admin
3. ستنتقل إلى لوحة التحكم

### اختبار إدارة المستخدمين

1. من القائمة الجانبية، اختر "المستخدمين"
2. أضف موظف جديد
3. حدد الصلاحيات المطلوبة
4. اختبر تفعيل/إيقاف المستخدم
5. اختبر التعديل والحذف

---

## 🔧 استكشاف الأخطاء

### خطأ في الاتصال بـ Supabase

**الحل:**
- تأكد من تشغيل سكريبت قاعدة البيانات
- تحقق من صحة URL و Anon Key
- تأكد من وجود اتصال بالإنترنت

### خطأ "No user found"

**الحل:**
- أنشئ مستخدم في Supabase Auth
- أضفه إلى جدول users
- تأكد من تطابق البريد الإلكتروني

### خطأ في الصلاحيات

**الحل:**
- تأكد من تفعيل RLS Policies
- تحقق من أن المستخدم لديه الصلاحية المطلوبة

---

## 📝 الخطوات التالية

### مخطط التطوير

1. ✅ Core Setup
2. ✅ Auth Feature
3. ✅ Dashboard Feature  
4. ✅ Users Management Feature
5. 🔄 **التالي**: Categories Feature
6. 🔄 Products Feature
7. 🔄 Suppliers Feature
8. 🔄 Stock Management Feature
9. 🔄 Invoices Feature
10. 🔄 Reports Feature

---

## 🤝 المساهمة

المشروع يستخدم:
- Clean Architecture
- Feature-First Organization
- SOLID Principles
- DRY Principle

لإضافة ميزة جديدة:
1. أنشئ مجلد في `lib/features/`
2. اتبع البنية: domain / data / presentation
3. سجل الـ dependencies في `injection_container.dart`

---

## 📞 الدعم

للمشاكل أو الاستفسارات:
- راجع سكريبت SQL
- تحقق من console logs
- راجع Supabase dashboard

---

## 🎉 بدء الاستخدام

1. شغل سكريبت SQL
2. أنشئ مستخدم Admin
3. شغل التطبيق
4. سجل الدخول
5. ابدأ باستخدام النظام!

**مبروك! نظامك جاهز للعمل** 🚀
