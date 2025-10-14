-- =====================================================
-- بيانات تجريبية - قرطاسية من البصرة، العراق
-- =====================================================
-- 
-- تعليمات الاستخدام:
-- 1. تأكد من تشغيل supabase_setup.sql أولاً
-- 2. انسخ هذا الملف كاملاً
-- 3. الصقه في Supabase SQL Editor
-- 4. اضغط "Run" لتنفيذ جميع الأوامر
-- 5. تأكد من نجاح التنفيذ
--
-- رابط Supabase: https://wncnupajycgmenzeqpzt.supabase.co

-- =====================================================
-- إضافة فئات القرطاسية المتخصصة
-- =====================================================

-- فئة الأدوات المدرسية
INSERT INTO categories (name, name_ar, description, icon, sort_order, created_by)
SELECT 
    'School Supplies', 'أدوات مدرسية', 'دفاتر وأقلام ومستلزمات مدرسية أساسية', 'school', 1, id
FROM users WHERE role = 'admin' LIMIT 1;

-- فئة الأدوات المكتبية
INSERT INTO categories (name, name_ar, description, icon, sort_order, created_by)
SELECT 
    'Office Supplies', 'أدوات مكتبية', 'ملفات وأوراق ومستلزمات مكتبية متقدمة', 'work', 2, id
FROM users WHERE role = 'admin' LIMIT 1;

-- فئة الأدوات الفنية
INSERT INTO categories (name, name_ar, description, icon, sort_order, created_by)
SELECT 
    'Art Supplies', 'أدوات فنية', 'ألوان وفرش ولوحات ومواد الرسم', 'palette', 3, id
FROM users WHERE role = 'admin' LIMIT 1;

-- فئة الكتب والمراجع
INSERT INTO categories (name, name_ar, description, icon, sort_order, created_by)
SELECT 
    'Books & References', 'كتب ومراجع', 'كتب مدرسية ومراجع علمية', 'menu_book', 4, id
FROM users WHERE role = 'admin' LIMIT 1;

-- فئة الحاسوب والالكترونيات
INSERT INTO categories (name, name_ar, description, icon, sort_order, created_by)
SELECT 
    'Computer & Electronics', 'حاسوب والكترونيات', 'أجهزة حاسوب وملحقاتها', 'computer', 5, id
FROM users WHERE role = 'admin' LIMIT 1;

-- =====================================================
-- إضافة موردين من البصرة
-- =====================================================

INSERT INTO suppliers (name, contact_person, phone, email, address, notes, is_active)
VALUES 
('مكتبة النور - البصرة', 'أحمد محمد العلي', '07801234567', 'alnoor@basra.iq', 'شارع الكويت، البصرة', 'مورد رئيسي للقرطاسية المدرسية', true),
('مكتبة الهدى', 'فاطمة علي حسن', '07709876543', 'alhuda@basra.iq', 'العشار، البصرة', 'متخصصة في الأدوات الفنية', true),
('قرطاسية المعرفة', 'حسين كاظم محمد', '07712345678', 'almarifa@basra.iq', 'الجمهورية، البصرة', 'أدوات مكتبية متقدمة', true),
('مكتبة البصرة العلمية', 'علي محمود أحمد', '07823456789', 'albasra@basra.iq', 'الزبير، البصرة', 'كتب ومراجع علمية', true),
('قرطاسية المستقبل', 'سارة أحمد علي', '07734567890', 'almustaqbal@basra.iq', 'الخور، البصرة', 'أجهزة حاسوب وملحقات', true);

-- =====================================================
-- إضافة منتجات قرطاسية واقعية من البصرة
-- =====================================================

-- دفاتر مدرسية
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Notebook A4 - 100 pages', 'دفتر A4 - 100 ورقة', 'دفتر مسطر 100 ورقة، غلاف كرتون', 
    c.id, 'NB-A4-100', '6281234567890', 'قطعة', 1500, 2500, 20, 150,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%النور%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Notebook A5 - 80 pages', 'دفتر A5 - 80 ورقة', 'دفتر مسطر 80 ورقة، حجم صغير', 
    c.id, 'NB-A5-80', '6281234567891', 'قطعة', 1000, 1800, 30, 200,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

-- أقلام حبر جاف
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Pen Blue - Ballpoint', 'قلم أزرق - جاف', 'قلم حبر جاف لون أزرق، ماركة محلية', 
    c.id, 'PEN-BLUE-01', '6281234567892', 'قطعة', 250, 500, 50, 300,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Pen Black - Ballpoint', 'قلم أسود - جاف', 'قلم حبر جاف لون أسود، ماركة محلية', 
    c.id, 'PEN-BLACK-01', '6281234567893', 'قطعة', 250, 500, 50, 280,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%النور%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Pen Red - Ballpoint', 'قلم أحمر - جاف', 'قلم حبر جاف لون أحمر، ماركة محلية', 
    c.id, 'PEN-RED-01', '6281234567894', 'قطعة', 250, 500, 30, 150,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

-- أقلام رصاص
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Pencil HB - Wooden', 'قلم رصاص HB', 'قلم رصاص خشبي درجة HB، ماركة محلية', 
    c.id, 'PENCIL-HB-01', '6281234567895', 'قطعة', 150, 300, 100, 500,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Pencil 2B - Wooden', 'قلم رصاص 2B', 'قلم رصاص خشبي درجة 2B، للرسم', 
    c.id, 'PENCIL-2B-01', '6281234567896', 'قطعة', 200, 400, 50, 200,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

-- ممحاة
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Eraser White - Plastic', 'ممحاة بيضاء', 'ممحاة بلاستيك بيضاء، ماركة محلية', 
    c.id, 'ERASER-WHT-01', '6281234567897', 'قطعة', 200, 400, 50, 200,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%النور%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Eraser Pink - Art', 'ممحاة وردية', 'ممحاة وردية للرسم، ماركة محلية', 
    c.id, 'ERASER-PINK-01', '6281234567898', 'قطعة', 300, 600, 30, 100,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

-- مساطر
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Ruler 30cm - Plastic', 'مسطرة 30 سم', 'مسطرة بلاستيك شفافة 30 سم', 
    c.id, 'RULER-30CM', '6281234567899', 'قطعة', 500, 1000, 30, 100,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Ruler 15cm - Plastic', 'مسطرة 15 سم', 'مسطرة بلاستيك شفافة 15 سم', 
    c.id, 'RULER-15CM', '6281234567900', 'قطعة', 300, 600, 50, 150,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%النور%' AND u.role = 'admin'
LIMIT 1;

-- صمغ
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Glue Stick 20g', 'صمغ عصا 20 جرام', 'صمغ عصا 20 جرام، ماركة محلية', 
    c.id, 'GLUE-STICK-20', '6281234567901', 'قطعة', 800, 1500, 20, 80,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Glue Bottle 50ml', 'صمغ زجاجة 50 مل', 'صمغ سائل في زجاجة 50 مل', 
    c.id, 'GLUE-BOTTLE-50', '6281234567902', 'قطعة', 1200, 2000, 15, 60,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

-- مقص
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Scissors - School Safe', 'مقص مدرسي آمن', 'مقص مدرسي آمن، أطراف مدورة', 
    c.id, 'SCISSORS-SAFE', '6281234567903', 'قطعة', 2000, 3500, 15, 60,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%النور%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Scissors - Art', 'مقص فني', 'مقص فني للرسم والحرف', 
    c.id, 'SCISSORS-ART', '6281234567904', 'قطعة', 3000, 5000, 10, 40,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

-- ألوان خشبية
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Color Pencils 12 colors', 'ألوان خشبية 12 لون', 'علبة ألوان خشبية 12 لون، ماركة محلية', 
    c.id, 'COLOR-PENCIL-12', '6281234567905', 'علبة', 5000, 8000, 10, 40,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Color Pencils 24 colors', 'ألوان خشبية 24 لون', 'علبة ألوان خشبية 24 لون، ماركة محلية', 
    c.id, 'COLOR-PENCIL-24', '6281234567906', 'علبة', 8000, 12000, 5, 25,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

-- ألوان مائية
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Watercolors 12 colors', 'ألوان مائية 12 لون', 'علبة ألوان مائية 12 لون، ماركة محلية', 
    c.id, 'WATERCOLOR-12', '6281234567907', 'علبة', 8000, 12000, 5, 25,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%النور%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Watercolors 18 colors', 'ألوان مائية 18 لون', 'علبة ألوان مائية 18 لون، ماركة محلية', 
    c.id, 'WATERCOLOR-18', '6281234567908', 'علبة', 12000, 18000, 3, 15,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

-- دفاتر رسم
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Drawing Book A4 - 50 pages', 'دفتر رسم A4 - 50 ورقة', 'دفتر رسم 50 ورقة، ورق سميك', 
    c.id, 'DRAW-BOOK-A4-50', '6281234567909', 'قطعة', 3000, 5000, 15, 70,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Drawing Book A3 - 30 pages', 'دفتر رسم A3 - 30 ورقة', 'دفتر رسم كبير 30 ورقة', 
    c.id, 'DRAW-BOOK-A3-30', '6281234567910', 'قطعة', 5000, 8000, 10, 40,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%النور%' AND u.role = 'admin'
LIMIT 1;

-- فرش رسم
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Paint Brush Set - 5 pieces', 'مجموعة فرش رسم - 5 قطع', 'مجموعة فرش رسم مختلفة الأحجام', 
    c.id, 'BRUSH-SET-5', '6281234567911', 'مجموعة', 4000, 7000, 8, 30,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات فنية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

-- أدوات مكتبية متقدمة
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'File Folder - A4', 'ملف A4', 'ملف بلاستيك شفاف A4', 
    c.id, 'FILE-A4', '6281234567912', 'قطعة', 500, 1000, 50, 200,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مكتبية' AND s.name LIKE '%النور%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Stapler - Office', 'دباسة مكتبية', 'دباسة مكتبية مع دبابيس', 
    c.id, 'STAPLER-OFFICE', '6281234567913', 'قطعة', 8000, 12000, 5, 20,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مكتبية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Paper Clips - Box 100', 'مشابك ورق - علبة 100', 'علبة مشابك ورق معدنية 100 قطعة', 
    c.id, 'CLIPS-BOX-100', '6281234567914', 'علبة', 2000, 3500, 10, 50,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مكتبية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

-- كتب مدرسية
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Math Book - Grade 6', 'كتاب الرياضيات - الصف السادس', 'كتاب الرياضيات للصف السادس الابتدائي', 
    c.id, 'MATH-G6', '6281234567915', 'كتاب', 15000, 25000, 20, 100,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'كتب ومراجع' AND s.name LIKE '%البصرة%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Arabic Book - Grade 6', 'كتاب اللغة العربية - الصف السادس', 'كتاب اللغة العربية للصف السادس الابتدائي', 
    c.id, 'ARABIC-G6', '6281234567916', 'كتاب', 15000, 25000, 20, 100,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'كتب ومراجع' AND s.name LIKE '%البصرة%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Science Book - Grade 6', 'كتاب العلوم - الصف السادس', 'كتاب العلوم للصف السادس الابتدائي', 
    c.id, 'SCIENCE-G6', '6281234567917', 'كتاب', 15000, 25000, 20, 100,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'كتب ومراجع' AND s.name LIKE '%البصرة%' AND u.role = 'admin'
LIMIT 1;

-- أجهزة حاسوب
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'USB Flash Drive 32GB', 'ذاكرة USB 32 جيجا', 'ذاكرة USB 32 جيجابايت', 
    c.id, 'USB-32GB', '6281234567918', 'قطعة', 25000, 40000, 10, 30,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'حاسوب والكترونيات' AND s.name LIKE '%المستقبل%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Mouse - Wireless', 'فأرة لاسلكية', 'فأرة حاسوب لاسلكية', 
    c.id, 'MOUSE-WIRELESS', '6281234567919', 'قطعة', 15000, 25000, 15, 40,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'حاسوب والكترونيات' AND s.name LIKE '%المستقبل%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Keyboard - Arabic', 'لوحة مفاتيح عربية', 'لوحة مفاتيح عربية وإنجليزية', 
    c.id, 'KEYBOARD-AR', '6281234567920', 'قطعة', 20000, 35000, 10, 25,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'حاسوب والكترونيات' AND s.name LIKE '%المستقبل%' AND u.role = 'admin'
LIMIT 1;

-- =====================================================
-- إضافة حركات مخزون أولية
-- =====================================================

INSERT INTO stock_movements (product_id, movement_type, quantity, unit_cost, reference_type, notes, created_by)
SELECT 
    p.id, 'in', p.current_stock, p.cost_price, 'adjustment', 'مخزون افتتاحي - بيانات تجريبية', u.id
FROM products p, users u
WHERE u.role = 'admin'
ORDER BY p.created_at
LIMIT 30;

-- =====================================================
-- إضافة منتجات إضافية للتجربة
-- =====================================================

-- دفاتر إضافية بأحجام مختلفة
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Notebook A5 - 60 pages', 'دفتر A5 - 60 ورقة', 'دفتر صغير مسطر 60 ورقة', 
    c.id, 'NB-A5-60', '6281234567921', 'قطعة', 800, 1500, 30, 200,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%النور%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Notebook A4 - 200 pages', 'دفتر A4 - 200 ورقة', 'دفتر كبير مسطر 200 ورقة', 
    c.id, 'NB-A4-200', '6281234567922', 'قطعة', 3000, 4500, 15, 80,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

-- مجموعات أقلام ملونة
INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Pen Set - 4 colors', 'مجموعة أقلام - 4 ألوان', 'مجموعة أقلام ملونة 4 ألوان', 
    c.id, 'PEN-SET-4', '6281234567923', 'مجموعة', 1500, 2500, 20, 100,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%الهدى%' AND u.role = 'admin'
LIMIT 1;

INSERT INTO products (name, name_ar, description, category_id, sku, barcode, unit, cost_price, selling_price, min_stock_level, current_stock, supplier_id, is_active, created_by)
SELECT 
    'Pen Set - 8 colors', 'مجموعة أقلام - 8 ألوان', 'مجموعة أقلام ملونة 8 ألوان', 
    c.id, 'PEN-SET-8', '6281234567924', 'مجموعة', 2500, 4000, 15, 60,
    s.id, true, u.id
FROM categories c, suppliers s, users u
WHERE c.name_ar = 'أدوات مدرسية' AND s.name LIKE '%المعرفة%' AND u.role = 'admin'
LIMIT 1;

-- فئات فرعية للتجربة
INSERT INTO categories (name, name_ar, description, parent_id, icon, sort_order, is_active, created_by)
SELECT 
    'Pens', 'أقلام', 'أقلام بأنواعها المختلفة', 
    c.id, 'edit', 1, true, u.id
FROM categories c, users u
WHERE c.name_ar = 'أدوات مدرسية' AND u.role = 'admin'
LIMIT 1;

INSERT INTO categories (name, name_ar, description, parent_id, icon, sort_order, is_active, created_by)
SELECT 
    'Notebooks', 'دفاتر', 'دفاتر بأحجام مختلفة', 
    c.id, 'book', 2, true, u.id
FROM categories c, users u
WHERE c.name_ar = 'أدوات مدرسية' AND u.role = 'admin'
LIMIT 1;

INSERT INTO categories (name, name_ar, description, parent_id, icon, sort_order, is_active, created_by)
SELECT 
    'Art Tools', 'أدوات الرسم', 'أدوات الرسم والتلوين', 
    c.id, 'palette', 1, true, u.id
FROM categories c, users u
WHERE c.name_ar = 'أدوات فنية' AND u.role = 'admin'
LIMIT 1;

-- =====================================================
-- ملخص البيانات المضافة
-- =====================================================
-- 
-- تم إضافة:
-- ✅ 5 فئات متخصصة (أدوات مدرسية، مكتبية، فنية، كتب، حاسوب)
-- ✅ 3 فئات فرعية جديدة (أقلام، دفاتر، أدوات الرسم)
-- ✅ 5 موردين من البصرة مع تفاصيل واقعية
-- ✅ 34 منتج متنوع مع أسعار واقعية بالدينار العراقي
-- ✅ حركات مخزون أولية لجميع المنتجات
-- 
-- الأسعار بالدينار العراقي (د.ع):
-- - دفاتر: 1,000 - 2,500 د.ع
-- - أقلام: 250 - 500 د.ع
-- - ألوان: 5,000 - 18,000 د.ع
-- - كتب مدرسية: 15,000 - 25,000 د.ع
-- - أجهزة حاسوب: 15,000 - 40,000 د.ع
-- 
-- =====================================================
-- ملاحظات مهمة
-- =====================================================
-- 1. جميع الأسعار بالدينار العراقي
-- 2. المنتجات من ماركات محلية عراقية
-- 3. الموردين من مناطق مختلفة في البصرة
-- 4. المخزون الأولي واقعي ومتنوع
-- 5. جاهز للاختبار والتطوير
