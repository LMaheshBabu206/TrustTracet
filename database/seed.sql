
USE trusttrace;

-- 1. Manufacturers
INSERT INTO manufacturer
    (name, official_website, status)
VALUES
    ('NovaTech Electronics', 'https://example.com/novatech', 'active'),
    ('SoundPeak Audio', 'https://example.com/soundpeak', 'active');

-- 2. Demo users
-- These are fictional accounts; password_hash is a placeholder,
-- not a valid login password hash.
INSERT INTO app_user
    (full_name, email, password_hash, role)
VALUES
    ('Demo Customer', 'customer@trusttrace.demo', 'DEMO_HASH_NOT_FOR_LOGIN', 'customer'),
    ('Demo Investigator', 'investigator@trusttrace.demo', 'DEMO_HASH_NOT_FOR_LOGIN', 'investigator'),
    ('Demo Admin', 'admin@trusttrace.demo', 'DEMO_HASH_NOT_FOR_LOGIN', 'admin');

-- 3. Sellers
INSERT INTO seller
    (seller_name, platform_name, seller_url, rating, total_listings)
VALUES
    ('Official Nova Store', 'DemoMarket', 'https://example.com/seller/nova', 4.80, 1),
    ('Value Deals Outlet', 'DemoMarket', 'https://example.com/seller/value', 2.40, 1);

-- 4. Products
INSERT INTO product
    (manufacturer_id, product_name, model_number, category, brand,
     official_description, specifications)
VALUES
    (1, 'NovaTech Wireless Headphones', 'NT-H100', 'Electronics',
     'NovaTech',
     'Wireless headphones with noise cancellation and USB-C charging.',
     JSON_OBJECT('connectivity', 'Bluetooth', 'charging', 'USB-C')),
    (2, 'SoundPeak Wireless Earbuds', 'SP-E20', 'Audio',
     'SoundPeak',
     'Compact wireless earbuds with a charging case.',
     JSON_OBJECT('connectivity', 'Bluetooth', 'case', 'Charging case'));

-- 5. Product batches
INSERT INTO product_batch
    (product_id, batch_code, manufacture_date, batch_status)
VALUES
    (1, 'NT-H100-BATCH-001', '2026-01-10', 'active'),
    (2, 'SP-E20-BATCH-001', '2026-02-15', 'active');

-- 6. Product listings
INSERT INTO product_listing
    (product_id, seller_id, listing_title, listing_description,
     listed_price, currency, listing_url, platform_listing_id)
VALUES
    (1, 1, 'NovaTech NT-H100 Official Headphones',
     'Official product listing with manufacturer specifications.',
     4999.00, 'INR', 'https://example.com/listing/NT100', 'DEMO-LIST-001'),
    (1, 2, 'Premium Headphones at an Unusually Low Price',
     'Headphones advertised with limited product details and a steep discount.',
     1499.00, 'INR', 'https://example.com/listing/NT101', 'DEMO-LIST-002');

-- 7. Verifications
INSERT INTO verification
    (user_id, listing_id, batch_id, verification_method, result, remarks)
VALUES
    (1, 1, 1, 'serial_number', 'genuine',
     'Demo verification: serial and batch details match the sample record.'),
    (1, 2, NULL, 'ai_assisted', 'suspicious',
     'Demo verification: listing price and description require further review.');

-- 8. Complaints
INSERT INTO complaint
    (user_id, listing_id, batch_id, complaint_text, status)
VALUES
    (1, 2, NULL,
     'Demo complaint: packaging and product details appear inconsistent with the official description.',
     'under_review');

-- 9. Investigation
INSERT INTO investigation
    (listing_id, investigator_id, status, findings)
VALUES
    (2, 3, 'in_progress',
     'Demo investigation: compare seller history, product description and verification evidence.');

-- 10. Link complaint to investigation
INSERT INTO investigation_complaint
    (investigation_id, complaint_id)
VALUES
    (1, 1);

-- 11. Risk assessments
INSERT INTO risk_assessment
    (listing_id, verification_id, risk_score, risk_level,
     explanation, model_version)
VALUES
    (1, 1, 8.00, 'low',
     'Demo score: sample listing has no flagged risk factors.',
     'demo-v1'),
    (2, 2, 78.00, 'high',
     'Demo score: unusually low price and a suspicious verification result warrant review.',
     'demo-v1');

-- 12. Risk factors
INSERT INTO risk_factor
    (assessment_id, factor_type, contribution_score, description)
VALUES
    (1, 'price_anomaly', 0.00,
     'No price anomaly assigned in this demonstration.'),
    (2, 'price_anomaly', 35.00,
     'Listing price is substantially lower than the other sample listing.'),
    (2, 'verification_result', 25.00,
     'The associated verification result is suspicious.'),
    (2, 'description_quality', 18.00,
     'The listing provides limited product details.');

-- Verify inserted records
SELECT 'manufacturer' AS table_name, COUNT(*) AS total FROM manufacturer
UNION ALL
SELECT 'app_user', COUNT(*) FROM app_user
UNION ALL
SELECT 'seller', COUNT(*) FROM seller
UNION ALL
SELECT 'product', COUNT(*) FROM product
UNION ALL
SELECT 'product_batch', COUNT(*) FROM product_batch
UNION ALL
SELECT 'product_listing', COUNT(*) FROM product_listing
UNION ALL
SELECT 'verification', COUNT(*) FROM verification
UNION ALL
SELECT 'complaint', COUNT(*) FROM complaint
UNION ALL
SELECT 'investigation', COUNT(*) FROM investigation
UNION ALL
SELECT 'investigation_complaint', COUNT(*) FROM investigation_complaint
UNION ALL
SELECT 'risk_assessment', COUNT(*) FROM risk_assessment
UNION ALL
SELECT 'risk_factor', COUNT(*) FROM risk_factor;
