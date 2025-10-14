-- =====================================================
-- نظام إدارة المكتبة - Supabase Database Setup
-- =====================================================
--
-- تعليمات التنفيذ:
-- 1. انسخ هذا الملف كاملاً
-- 2. الصقه في Supabase SQL Editor
-- 3. اضغط "Run" لتنفيذ جميع الأوامر
-- 4. تأكد من نجاح التنفيذ
--
-- رابط Supabase: https://wncnupajycgmenzeqpzt.supabase.co

-- =====================================================
-- حذف البيانات القديمة (إذا كانت موجودة)
-- =====================================================
-- تحذير: هذا سيحذف جميع البيانات! استخدم فقط في التطوير
-- 
-- إذا كنت قد شغلت هذا الملف من قبل، شغل هذا القسم أولاً
-- لحذف الجداول والوظائف القديمة قبل إنشاء الجديدة
--
-- ملاحظة: إذا كانت هذه المرة الأولى، يمكنك تخطي هذا القسم

-- حذف الجداول (بالترتيب الصحيح لتجنب مشاكل Foreign Key)
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS stock_movements CASCADE;
DROP TABLE IF EXISTS invoice_items CASCADE;
DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- حذف الأنواع المخصصة (ENUM types)
DROP TYPE IF EXISTS payment_status CASCADE;
DROP TYPE IF EXISTS invoice_type CASCADE;
DROP TYPE IF EXISTS reference_type CASCADE;
DROP TYPE IF EXISTS movement_type CASCADE;
DROP TYPE IF EXISTS user_role CASCADE;

-- حذف العروض (Views)
DROP VIEW IF EXISTS dashboard_stats CASCADE;
DROP VIEW IF EXISTS products_summary CASCADE;

-- حذف الوظائف (Functions)
DROP FUNCTION IF EXISTS generate_invoice_number CASCADE;
DROP FUNCTION IF EXISTS update_product_stock CASCADE;
DROP FUNCTION IF EXISTS update_updated_at_column CASCADE;

-- حذف Triggers الخاصة بـ Supabase Auth (إذا كانت موجودة)
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user CASCADE;

-- =====================================================
-- إنشاء ENUM types
-- =====================================================
CREATE TYPE user_role AS ENUM ('admin', 'employee');
CREATE TYPE movement_type AS ENUM ('in', 'out', 'adjustment');
CREATE TYPE reference_type AS ENUM ('purchase_invoice', 'sales_invoice', 'adjustment');
CREATE TYPE invoice_type AS ENUM ('sales', 'purchase');
CREATE TYPE payment_status AS ENUM ('pending', 'partial', 'paid');

-- =====================================================
-- جدول المستخدمين (Users)
-- =====================================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL, -- كلمة المرور بشكل صريح
    full_name TEXT NOT NULL,
    phone TEXT,
    role user_role NOT NULL DEFAULT 'employee',
    permissions JSONB DEFAULT '[]'::jsonb,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    is_deleted BOOLEAN DEFAULT false
);

-- Index للبحث السريع
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_is_active ON users(is_active, is_deleted);

-- =====================================================
-- جدول الفئات (Categories)
-- =====================================================
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    name_ar TEXT NOT NULL,
    description TEXT,
    parent_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    icon TEXT,
    image_url TEXT, -- إضافة حقل الصورة للفئات
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    is_deleted BOOLEAN DEFAULT false
);

-- Index للفئات
CREATE INDEX idx_categories_parent ON categories(parent_id);
CREATE INDEX idx_categories_active ON categories(is_active, is_deleted);
CREATE INDEX idx_categories_sort ON categories(sort_order);

-- =====================================================
-- جدول الموردين (Suppliers)
-- =====================================================
CREATE TABLE suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    contact_person TEXT,
    phone TEXT,
    email TEXT,
    address TEXT,
    notes TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    is_deleted BOOLEAN DEFAULT false
);

-- Index للموردين
CREATE INDEX idx_suppliers_name ON suppliers(name);
CREATE INDEX idx_suppliers_active ON suppliers(is_active, is_deleted);

-- =====================================================
-- جدول المنتجات (Products)
-- =====================================================
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    name_ar TEXT NOT NULL,
    description TEXT,
    category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    sku TEXT UNIQUE,
    barcode TEXT,
    unit TEXT DEFAULT 'قطعة',
    cost_price DECIMAL(12, 2) DEFAULT 0,
    selling_price DECIMAL(12, 2) NOT NULL,
    min_stock_level INTEGER DEFAULT 0,
    current_stock INTEGER DEFAULT 0,
    image_url TEXT,
    supplier_id UUID REFERENCES suppliers(id) ON DELETE SET NULL,
    is_active BOOLEAN DEFAULT true,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    is_deleted BOOLEAN DEFAULT false
);

-- Index للمنتجات
CREATE INDEX idx_products_name ON products(name_ar);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_sku ON products(sku);
CREATE INDEX idx_products_barcode ON products(barcode);
CREATE INDEX idx_products_active ON products(is_active, is_deleted);
CREATE INDEX idx_products_stock ON products(current_stock);

-- =====================================================
-- جدول الفواتير (Invoices)
-- =====================================================
CREATE TABLE invoices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_number TEXT UNIQUE NOT NULL,
    invoice_type invoice_type NOT NULL,
    invoice_date DATE NOT NULL DEFAULT CURRENT_DATE,
    customer_name TEXT,
    supplier_id UUID REFERENCES suppliers(id) ON DELETE SET NULL,
    total_amount DECIMAL(12, 2) DEFAULT 0,
    discount_amount DECIMAL(12, 2) DEFAULT 0,
    tax_amount DECIMAL(12, 2) DEFAULT 0,
    net_amount DECIMAL(12, 2) DEFAULT 0,
    payment_status payment_status DEFAULT 'pending',
    paid_amount DECIMAL(12, 2) DEFAULT 0,
    payment_method TEXT,
    notes TEXT,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    is_deleted BOOLEAN DEFAULT false
);

-- Index للفواتير
CREATE INDEX idx_invoices_number ON invoices(invoice_number);
CREATE INDEX idx_invoices_type ON invoices(invoice_type);
CREATE INDEX idx_invoices_date ON invoices(invoice_date DESC);
CREATE INDEX idx_invoices_status ON invoices(payment_status);
CREATE INDEX idx_invoices_active ON invoices(is_deleted);

-- =====================================================
-- جدول تفاصيل الفواتير (Invoice Items)
-- =====================================================
CREATE TABLE invoice_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID REFERENCES invoices(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(12, 2) NOT NULL,
    discount_percentage DECIMAL(5, 2) DEFAULT 0,
    total_price DECIMAL(12, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Index لتفاصيل الفواتير
CREATE INDEX idx_invoice_items_invoice ON invoice_items(invoice_id);
CREATE INDEX idx_invoice_items_product ON invoice_items(product_id);

-- =====================================================
-- جدول حركة المخزون (Stock Movements)
-- =====================================================
CREATE TABLE stock_movements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products(id) ON DELETE RESTRICT,
    movement_type movement_type NOT NULL,
    quantity INTEGER NOT NULL,
    unit_cost DECIMAL(12, 2) DEFAULT 0,
    reference_type reference_type NOT NULL,
    reference_id UUID,
    notes TEXT,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Index لحركة المخزون
CREATE INDEX idx_stock_movements_product ON stock_movements(product_id);
CREATE INDEX idx_stock_movements_type ON stock_movements(movement_type);
CREATE INDEX idx_stock_movements_date ON stock_movements(created_at DESC);

-- =====================================================
-- جدول الدفعات (Payments)
-- =====================================================
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID REFERENCES invoices(id) ON DELETE CASCADE,
    amount DECIMAL(12, 2) NOT NULL,
    payment_method TEXT NOT NULL,
    payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    notes TEXT,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Index للدفعات
CREATE INDEX idx_payments_invoice ON payments(invoice_id);
CREATE INDEX idx_payments_date ON payments(payment_date DESC);

-- =====================================================
-- Functions & Triggers
-- =====================================================

-- Function لتحديث updated_at تلقائياً
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers لتحديث updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_categories_updated_at BEFORE UPDATE ON categories
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_suppliers_updated_at BEFORE UPDATE ON suppliers
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_invoices_updated_at BEFORE UPDATE ON invoices
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function لتحديث المخزون تلقائياً
CREATE OR REPLACE FUNCTION update_product_stock()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.movement_type = 'in' THEN
        UPDATE products 
        SET current_stock = current_stock + NEW.quantity
        WHERE id = NEW.product_id;
    ELSIF NEW.movement_type = 'out' THEN
        UPDATE products 
        SET current_stock = current_stock - NEW.quantity
        WHERE id = NEW.product_id;
    ELSIF NEW.movement_type = 'adjustment' THEN
        UPDATE products 
        SET current_stock = NEW.quantity
        WHERE id = NEW.product_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger لتحديث المخزون عند إضافة حركة
CREATE TRIGGER trigger_update_stock
AFTER INSERT ON stock_movements
FOR EACH ROW EXECUTE FUNCTION update_product_stock();

-- Function لتوليد رقم فاتورة تلقائياً
CREATE OR REPLACE FUNCTION generate_invoice_number(inv_type invoice_type)
RETURNS TEXT AS $$
DECLARE
    prefix TEXT;
    last_number INTEGER;
    new_number TEXT;
BEGIN
    -- تحديد البادئة حسب نوع الفاتورة
    IF inv_type = 'sales' THEN
        prefix := 'SAL';
    ELSE
        prefix := 'PUR';
    END IF;
    
    -- الحصول على آخر رقم
    SELECT COALESCE(MAX(
        CAST(SUBSTRING(invoice_number FROM '[0-9]+$') AS INTEGER)
    ), 0) INTO last_number
    FROM invoices
    WHERE invoice_number LIKE prefix || '%';
    
    -- توليد الرقم الجديد
    new_number := prefix || '-' || TO_CHAR(CURRENT_DATE, 'YYYYMMDD') || '-' || LPAD((last_number + 1)::TEXT, 4, '0');
    
    RETURN new_number;
END;
$$ LANGUAGE plpgsql;

-- ملاحظة: تم حذف Trigger و Function الخاصة بـ Supabase Auth
-- النظام الآن يستخدم مصادقة بسيطة مباشرة من جدول users

-- =====================================================
-- Row Level Security (RLS) - معطل للتطوير والاختبار
-- =====================================================

-- ملاحظة: تم تعطيل RLS لتسهيل التطوير والاختبار
-- في الإنتاج، يجب تفعيل RLS وإضافة policies مناسبة

-- تفعيل RLS على الجداول (معطل حالياً)
-- ALTER TABLE users ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE products ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE invoice_items ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE stock_movements ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- بيانات أولية (Initial Data)
-- =====================================================

-- إنشاء مستخدم Admin افتراضي بكلمة مرور صريحة
INSERT INTO users (email, password, full_name, role, is_active)
VALUES ('admin@bookly.com', 'Admin@123456', 'مدير النظام', 'admin', true);

-- فئات أساسية
INSERT INTO categories (name, name_ar, description, icon, sort_order, created_by)
SELECT 
    'Stationery', 'قرطاسية', 'أدوات مكتبية وقرطاسية', 'edit', 1, id
FROM users WHERE role = 'admin' LIMIT 1;

INSERT INTO categories (name, name_ar, description, icon, sort_order, created_by)
SELECT 
    'Books', 'كتب', 'كتب بأنواعها', 'menu_book', 2, id
FROM users WHERE role = 'admin' LIMIT 1;

INSERT INTO categories (name, name_ar, description, icon, sort_order, created_by)
SELECT 
    'Notebooks', 'دفاتر', 'دفاتر ومذكرات', 'book', 3, id
FROM users WHERE role = 'admin' LIMIT 1;

-- إنشاء Storage Bucket لصور المنتجات
-- يتم تنفيذه من لوحة تحكم Supabase:
-- INSERT INTO storage.buckets (id, name, public) VALUES ('products', 'products', true);

-- =====================================================
-- Views للتقارير والإحصائيات
-- =====================================================

-- عرض ملخص المنتجات
CREATE OR REPLACE VIEW products_summary AS
SELECT 
    p.id,
    p.name_ar,
    p.sku,
    p.current_stock,
    p.min_stock_level,
    p.selling_price,
    p.cost_price,
    c.name_ar as category_name,
    s.name as supplier_name,
    CASE 
        WHEN p.current_stock <= p.min_stock_level THEN true
        ELSE false
    END as is_low_stock
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN suppliers s ON p.supplier_id = s.id
WHERE p.is_deleted = false;

-- عرض إحصائيات Dashboard
CREATE OR REPLACE VIEW dashboard_stats AS
SELECT 
    (SELECT COUNT(*) FROM products WHERE is_deleted = false AND is_active = true) as total_products,
    (SELECT COUNT(*) FROM products WHERE is_deleted = false AND current_stock <= min_stock_level) as low_stock_products,
    (SELECT COUNT(*) FROM invoices WHERE is_deleted = false AND invoice_type = 'sales' AND invoice_date = CURRENT_DATE) as today_sales,
    (SELECT COALESCE(SUM(net_amount), 0) FROM invoices WHERE is_deleted = false AND invoice_type = 'sales' AND invoice_date = CURRENT_DATE) as today_revenue,
    (SELECT COALESCE(SUM(net_amount), 0) FROM invoices WHERE is_deleted = false AND invoice_type = 'sales' AND DATE_TRUNC('month', invoice_date) = DATE_TRUNC('month', CURRENT_DATE)) as monthly_revenue,
    (SELECT COUNT(*) FROM invoices WHERE is_deleted = false AND payment_status = 'pending') as pending_invoices;

-- =====================================================
-- تعليمات التنفيذ في SQL Editor
-- =====================================================
--
-- 1. افتح Supabase Dashboard: https://wncnupajycgmenzeqpzt.supabase.co
-- 2. اذهب إلى SQL Editor
-- 3. انسخ هذا الملف كاملاً (من السطر 1 إلى السطر الأخير)
-- 4. الصقه في SQL Editor واضغط "Run"
-- 5. تأكد من نجاح التنفيذ (يجب أن ترى رسائل نجاح)
--
-- =====================================================
-- إذا كان الجدول موجوداً بالفعل (للمطورين)
-- =====================================================
-- إذا كنت قد شغلت هذا الملف من قبل وترغب في إضافة عمود image_url فقط:
-- 1. استخدم ملف database_migrations.sql بدلاً من هذا الملف
-- 2. أو شغل الأمر التالي مباشرة:
--    ALTER TABLE categories ADD COLUMN IF NOT EXISTS image_url TEXT;
--    ALTER TABLE products ADD COLUMN IF NOT EXISTS image_url TEXT;
--
-- =====================================================
-- بيانات تسجيل الدخول الجاهزة
-- =====================================================
-- 
-- المستخدم الافتراضي موجود في قاعدة البيانات:
-- Email: admin@bookly.com
-- Password: Admin@123456
--
-- لا حاجة لإنشاء مستخدم من Authentication!
-- فقط شغل SQL وابدأ استخدام التطبيق.
--
-- =====================================================
-- ملاحظات مهمة
-- =====================================================
-- 1. RLS معطل حالياً للتطوير والاختبار
-- 2. يجب إنشاء Storage Bucket للصور من لوحة التحكم
-- 3. كلمة المرور مخزنة بشكل صريح (بدون تشفير)
-- 4. للصلاحيات المتقدمة، استخدم JSONB في حقل permissions
-- 5. إذا واجهت أخطاء، تأكد من تشغيل قسم "حذف البيانات القديمة" أولاً
