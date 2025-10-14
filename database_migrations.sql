-- =====================================================
-- ملف التحديثات لقاعدة البيانات الموجودة
-- =====================================================
--
-- تعليمات الاستخدام:
-- 1. إذا كنت قد شغلت supabase_setup.sql من قبل
-- 2. انسخ هذا الملف كاملاً
-- 3. الصقه في Supabase SQL Editor
-- 4. اضغط "Run" لتنفيذ التحديثات
-- 5. تأكد من نجاح التنفيذ
--
-- رابط Supabase: https://wncnupajycgmenzeqpzt.supabase.co

-- =====================================================
-- تحديث 1: إضافة عمود الصورة لجدول الفئات
-- =====================================================
-- إذا كان الجدول موجوداً بالفعل، استخدم هذا الأمر لإضافة عمود الصورة:
ALTER TABLE categories ADD COLUMN IF NOT EXISTS image_url TEXT;

-- =====================================================
-- تحديث 2: إضافة عمود الصورة لجدول المنتجات (إذا لم يكن موجوداً)
-- =====================================================
ALTER TABLE products ADD COLUMN IF NOT EXISTS image_url TEXT;

-- =====================================================
-- تحديث 3: إضافة indexes للصور (اختياري لتحسين الأداء)
-- =====================================================
CREATE INDEX IF NOT EXISTS idx_categories_image ON categories(image_url) WHERE image_url IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_products_image ON products(image_url) WHERE image_url IS NOT NULL;

-- =====================================================
-- تحديث 4: إضافة تعليقات توضيحية للأعمدة الجديدة
-- =====================================================
COMMENT ON COLUMN categories.image_url IS 'رابط صورة الفئة - يمكن أن يكون URL خارجي أو مسار في Storage';
COMMENT ON COLUMN products.image_url IS 'رابط صورة المنتج - يمكن أن يكون URL خارجي أو مسار في Storage';

-- =====================================================
-- ملاحظات مهمة
-- =====================================================
-- 1. تم إضافة عمود image_url لجدولي categories و products
-- 2. العمود اختياري (NULL مسموح)
-- 3. يمكن تخزين روابط خارجية أو مسارات في Supabase Storage
-- 4. تم إضافة indexes لتحسين أداء البحث
-- 5. جميع التحديثات آمنة ولن تؤثر على البيانات الموجودة

-- =====================================================
-- التحقق من التحديثات
-- =====================================================
-- يمكنك تشغيل هذه الاستعلامات للتحقق من نجاح التحديثات:

-- SELECT column_name, data_type, is_nullable 
-- FROM information_schema.columns 
-- WHERE table_name = 'categories' AND column_name = 'image_url';

-- SELECT column_name, data_type, is_nullable 
-- FROM information_schema.columns 
-- WHERE table_name = 'products' AND column_name = 'image_url';
