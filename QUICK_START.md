# دليل البدء السريع - نظام إدارة المكتبة

## الخطوة 1: حذف البيانات القديمة (إذا كنت قد شغلت SQL سابقاً)

1. افتح Supabase Dashboard: https://wncnupajycgmenzeqpzt.supabase.co
2. اذهب إلى **SQL Editor**
3. شغل هذا الأمر:
```sql
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
```

## الخطوة 2: إعداد قاعدة البيانات

1. في SQL Editor، انسخ محتوى ملف `supabase_setup.sql` كاملاً
2. شغله مرة واحدة
3. تأكد من نجاح التنفيذ

## الخطوة 3: إنشاء المستخدم الأول (جاهز!)

المستخدم الافتراضي موجود في قاعدة البيانات:
- **Email**: `admin@bookly.com`
- **Password**: `Admin@123456`

لا حاجة لإنشاء مستخدم من Authentication!
فقط شغل SQL وابدأ استخدام التطبيق.

## الخطوة 4: تشغيل التطبيق

```bash
flutter pub get
flutter run
```

## بيانات تسجيل الدخول:

- **Email**: `admin@bookly.com`
- **Password**: `Admin@123456`

---

## استكشاف الأخطاء

### خطأ: "Invalid login credentials"

**الحلول:**
- ✅ تأكد من إنشاء المستخدم في Authentication
- ✅ تأكد من تفعيل "Auto Confirm User"
- ✅ تأكد من صحة البريد وكلمة المرور
- ✅ تحقق من Console لرؤية رسائل Debug

### خطأ: "لا يوجد مستخدم" أو "relation does not exist"

**الحلول:**
- ✅ تأكد من تشغيل `supabase_setup.sql` بنجاح
- ✅ تحقق من وجود جدول `users` في Database
- ✅ تأكد من وجود المستخدم الافتراضي في قاعدة البيانات

### خطأ: "RLS policy violation"

**الحلول:**
- ✅ RLS معطل حالياً، إذا ظهر هذا الخطأ تأكد من عدم تفعيل RLS
- ✅ في SQL Editor، نفذ:
```sql
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE categories DISABLE ROW LEVEL SECURITY;
ALTER TABLE products DISABLE ROW LEVEL SECURITY;
-- وهكذا لباقي الجداول
```

---

## معلومات مفيدة

### Debugging:
- افتح **Developer Tools** في المتصفح أو **Debug Console** في VS Code
- ستجد رسائل مثل:
  - `🔐 محاولة تسجيل الدخول: admin@bookly.com`
  - `✅ نجح Auth: 12345678-1234-1234-1234-123456789012`
  - `📊 جلب بيانات المستخدم من جدول users...`
  - `✅ تم جلب البيانات: مدير النظام`

### إذا لم تظهر رسائل Debug:
- تأكد من تشغيل التطبيق في Debug Mode
- تحقق من Console في المتصفح أو Terminal في VS Code

### إنشاء مستخدمين إضافيين:
1. كرر الخطوة 3 مع بيانات مختلفة
2. **لا حاجة لإضافة يدوية** - المستخدم سيُضاف تلقائياً!

---

## ملاحظات مهمة

- 🔒 **RLS معطل** حالياً للتطوير والاختبار
- 📧 **Auto Confirm** مهم جداً - بدونها لن يعمل تسجيل الدخول
- 🤖 **نظام تلقائي** - المستخدم يُضاف تلقائياً عبر Trigger
- 🐛 **Debugging مفعل** - ستجد رسائل مفصلة في Console

---

## الدعم

إذا واجهت مشاكل:
1. تحقق من رسائل Debug في Console
2. تأكد من تنفيذ جميع الخطوات بالترتيب
3. تحقق من وجود المستخدم في Authentication
4. تأكد من ربط الـ UUID بشكل صحيح
