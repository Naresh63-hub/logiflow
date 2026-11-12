-- ====================================================================
-- LOGIFLOW LOGISTICS (3PL) SEED DATA (Noida NCR Operational Hub)
-- Project: LogiFlow
-- ====================================================================

-- 1. HUBS SEED
INSERT INTO public.hubs (id, code, name, city, state, address, latitude, longitude, contact_phone) VALUES
('11111111-1111-1111-1111-111111111111', 'HUB-NOI-01', 'Noida Sector 62 Central Hub', 'Noida', 'Uttar Pradesh', 'Plot B-9, Industrial Area, Sector 62, Noida, UP 201309', 28.6280, 77.3649, '+91 120 456 7890'),
('22222222-2222-2222-2222-222222222222', 'HUB-GNW-02', 'Greater Noida West Fulfillment Hub', 'Greater Noida', 'Uttar Pradesh', 'TechZone 4, Greater Noida West, UP 201306', 28.5833, 77.4450, '+91 120 987 6543'),
('33333333-3333-3333-3333-333333333333', 'HUB-OKH-03', 'Okhla NCR Gateway Distribution Center', 'New Delhi', 'Delhi', 'Phase 3, Okhla Industrial Estate, New Delhi 110020', 28.5284, 77.2755, '+91 11 2684 1234')
ON CONFLICT (id) DO NOTHING;

-- 2. DEMO AUTH & PROFILES (Placeholder auth references with no active password; create real logins via Sign Up)
INSERT INTO auth.users (id, instance_id, aud, role, email, encrypted_password, email_confirmed_at, raw_app_meta_data, raw_user_meta_data, created_at, updated_at)
VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'shipper@logiflow.in', '', NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Amit Sharma","role":"shipper"}', NOW(), NOW()),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'manager@logiflow.in', '', NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Rajesh Kumar","role":"hub_manager"}', NOW(), NOW()),
('cccccccc-cccc-cccc-cccc-cccccccccccc', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'driver@logiflow.in', '', NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Vikas Singh","role":"driver"}', NOW(), NOW()),
('dddddddd-dddd-dddd-dddd-dddddddddddd', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'priya.shipper@logistics.in', '', NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Priya Verma","role":"shipper"}', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.profiles (id, full_name, email, phone, role, hub_id, avatar_url) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Amit Sharma', 'shipper@logiflow.in', '+91 98712 34567', 'shipper', NULL, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Rajesh Kumar', 'manager@logiflow.in', '+91 98101 23456', 'hub_manager', '11111111-1111-1111-1111-111111111111', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150'),
('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Vikas Singh', 'driver@logiflow.in', '+91 99580 98765', 'driver', '11111111-1111-1111-1111-111111111111', 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150'),
('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Priya Verma', 'priya.shipper@logistics.in', '+91 98111 87654', 'shipper', NULL, 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150')
ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
    phone = EXCLUDED.phone,
    role = EXCLUDED.role,
    hub_id = EXCLUDED.hub_id,
    avatar_url = EXCLUDED.avatar_url;

-- 3. SHIPMENTS SEED (Realistic Noida Logistics Lifecycle & Edge Cases)
INSERT INTO public.shipments (
    id, tracking_number, sender_id, sender_name, sender_phone, sender_address,
    receiver_name, receiver_phone, receiver_address, package_category, weight_kg,
    priority, current_status, origin_hub_id, destination_hub_id, assigned_driver_id,
    expected_delivery, version
) VALUES
-- 1. Delivered with Complete POD (GPS Sector 18 Noida)
(
    '00000001-0000-0000-0000-000000000001',
    'LGF-2026-88401',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Amit Sharma',
    '+91 98712 34567',
    'Tower 4, ATS One Hamlet, Sector 104, Noida, UP 201304',
    'Sunil Mehra',
    '+91 98188 23456',
    'Office 402, Wave Silver Tower, Sector 18, Noida, UP 201301',
    'Electronics / IT Hardware',
    3.50,
    'express',
    'delivered',
    '11111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
    'cccccccc-cccc-cccc-cccc-cccccccccccc',
    NOW() - INTERVAL '4 hours',
    4
),
-- 2. Out for Delivery (Live in Greater Noida West)
(
    '00000002-0000-0000-0000-000000000002',
    'LGF-2026-88402',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Amit Sharma',
    '+91 98712 34567',
    'C-24, Sector 65, Noida, UP 201301',
    'Neha Gupta',
    '+91 99100 87654',
    'Flat 1204, Gaur City 2, Greater Noida West, UP 201306',
    'Healthcare & Diagnostics',
    1.20,
    'overnight',
    'out_for_delivery',
    '11111111-1111-1111-1111-111111111111',
    '22222222-2222-2222-2222-222222222222',
    'cccccccc-cccc-cccc-cccc-cccccccccccc',
    NOW() + INTERVAL '3 hours',
    3
),
-- 3. In Transit (Between Noida Hub and Okhla Hub)
(
    '00000003-0000-0000-0000-000000000003',
    'LGF-2026-88403',
    'dddddddd-dddd-dddd-dddd-dddddddddddd',
    'Priya Verma',
    '+91 98111 87654',
    'B-12, Sector 83, Phase 2, Noida, UP 201305',
    'Rahul Malhotra',
    '+91 98200 12345',
    'F-82, Okhla Phase 1, New Delhi 110020',
    'Apparel & Textiles',
    12.40,
    'standard',
    'in_transit',
    '11111111-1111-1111-1111-111111111111',
    '33333333-3333-3333-3333-333333333333',
    NULL,
    NOW() + INTERVAL '1 day',
    2
),
-- 4. Arrived at Hub (Noida Sector 62)
(
    '00000004-0000-0000-0000-000000000004',
    'LGF-2026-88404',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Amit Sharma',
    '+91 98712 34567',
    'D-102, Sector 128, Noida, UP 201304',
    'Kavita Rao',
    '+91 97111 44556',
    'Villa 15, Jaypee Greens, Greater Noida, UP 201310',
    'Automotive Spare Parts',
    8.75,
    'express',
    'arrived_at_hub',
    '11111111-1111-1111-1111-111111111111',
    '22222222-2222-2222-2222-222222222222',
    NULL,
    NOW() + INTERVAL '18 hours',
    2
),
-- 5. Picked Up (From Merchant Warehouse)
(
    '00000005-0000-0000-0000-000000000005',
    'LGF-2026-88405',
    'dddddddd-dddd-dddd-dddd-dddddddddddd',
    'Priya Verma',
    '+91 98111 87654',
    'Logistics Park, Ecotech 3, Greater Noida, UP 201306',
    'Deepak Chopra',
    '+91 98109 99887',
    'Sector 50, Noida, UP 201301',
    'Industrial Hardware',
    24.00,
    'standard',
    'picked_up',
    '22222222-2222-2222-2222-222222222222',
    '11111111-1111-1111-1111-111111111111',
    NULL,
    NOW() + INTERVAL '2 days',
    1
),
-- 6. Pickup Scheduled
(
    '00000006-0000-0000-0000-000000000006',
    'LGF-2026-88406',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Amit Sharma',
    '+91 98712 34567',
    'Sector 62, Noida, UP 201309',
    'Ananya Sen',
    '+91 98300 55443',
    'Sector 137, Expressway, Noida, UP 201305',
    'Documents & Legal Briefs',
    0.50,
    'express',
    'pickup_scheduled',
    '11111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
    NULL,
    NOW() + INTERVAL '1 day',
    1
),
-- 7. Delivery Failed (Edge case: Locked gate / recipient unavailable)
(
    '00000007-0000-0000-0000-000000000007',
    'LGF-2026-88407',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Amit Sharma',
    '+91 98712 34567',
    'Sector 15A, Noida, UP 201301',
    'Manish Taneja',
    '+91 98112 00011',
    'Shop 14, Atta Market, Sector 27, Noida, UP 201301',
    'High-Value Consumer Electronics',
    2.10,
    'express',
    'delivery_failed',
    '11111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
    'cccccccc-cccc-cccc-cccc-cccccccccccc',
    NOW() - INTERVAL '2 hours',
    4
),
-- 8. Created (Edge case: Very long description & offline sync prototype)
(
    '00000008-0000-0000-0000-000000000008',
    'LGF-2026-88408',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Amit Sharma',
    '+91 98712 34567',
    'Tower 1, Stellar IT Park, Sector 62, Noida, UP',
    'Dr. Sanjay Kapoor',
    '+91 98733 88123',
    'Fortis Hospital Campus, Sector 62, Noida, UP 201301',
    'Medical Cryogenic Diagnostic Samples - Handle with extreme caution at temperature below 4 deg Celsius. Contains calibration quartz tubes and insulated specimen containers for lab verification.',
    4.80,
    'overnight',
    'created',
    '11111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
    NULL,
    NOW() + INTERVAL '12 hours',
    1
)
ON CONFLICT (id) DO NOTHING;

-- 4. TIMELINE EVENTS SEED
INSERT INTO public.shipment_events (id, shipment_id, previous_status, new_status, location_name, latitude, longitude, remarks, updated_by, created_at) VALUES
-- Events for LGF-2026-88401 (Delivered)
('10000001-0000-0000-0000-000000000001', '00000001-0000-0000-0000-000000000001', NULL, 'created', 'ATS One Hamlet, Sector 104, Noida', 28.5355, 77.3752, 'Shipment order booked via Mobile App', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NOW() - INTERVAL '26 hours'),
('10000001-0000-0000-0000-000000000002', '00000001-0000-0000-0000-000000000001', 'created', 'picked_up', 'Sector 104, Noida', 28.5355, 77.3752, 'Package picked up by courier van 14', 'cccccccc-cccc-cccc-cccc-cccccccccccc', NOW() - INTERVAL '20 hours'),
('10000001-0000-0000-0000-000000000003', '00000001-0000-0000-0000-000000000001', 'picked_up', 'arrived_at_hub', 'Noida Sector 62 Central Hub', 28.6280, 77.3649, 'Sorted at Sector 62 Central Conveyor', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', NOW() - INTERVAL '14 hours'),
('10000001-0000-0000-0000-000000000004', '00000001-0000-0000-0000-000000000001', 'arrived_at_hub', 'out_for_delivery', 'Wave Silver Tower, Sector 18', 28.5708, 77.3259, 'Assigned to driver Vikas Singh for final mile', 'cccccccc-cccc-cccc-cccc-cccccccccccc', NOW() - INTERVAL '6 hours'),
('10000001-0000-0000-0000-000000000005', '00000001-0000-0000-0000-000000000001', 'out_for_delivery', 'delivered', 'Wave Silver Tower, Sector 18, Noida', 28.5708, 77.3259, 'Delivered to Sunil Mehra with digital signature & photo', 'cccccccc-cccc-cccc-cccc-cccccccccccc', NOW() - INTERVAL '4 hours'),

-- Events for LGF-2026-88402 (Out for delivery)
('10000002-0000-0000-0000-000000000001', '00000002-0000-0000-0000-000000000002', NULL, 'created', 'C-24, Sector 65, Noida', 28.6180, 77.3820, 'Shipment manifested', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NOW() - INTERVAL '16 hours'),
('10000002-0000-0000-0000-000000000002', '00000002-0000-0000-0000-000000000002', 'created', 'arrived_at_hub', 'Noida Sector 62 Central Hub', 28.6280, 77.3649, 'Inbound scanned at Hub 01', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', NOW() - INTERVAL '10 hours'),
('10000002-0000-0000-0000-000000000003', '00000002-0000-0000-0000-000000000002', 'arrived_at_hub', 'out_for_delivery', 'Greater Noida West Route', 28.5833, 77.4450, 'Out for delivery with Vikas Singh', 'cccccccc-cccc-cccc-cccc-cccccccccccc', NOW() - INTERVAL '2 hours'),

-- Events for LGF-2026-88407 (Delivery Failed)
('10000007-0000-0000-0000-000000000001', '00000007-0000-0000-0000-000000000007', 'out_for_delivery', 'delivery_failed', 'Atta Market, Sector 27, Noida', 28.5720, 77.3290, 'Customer premise closed / shop shutter locked. Re-attempt scheduled tomorrow.', 'cccccccc-cccc-cccc-cccc-cccccccccccc', NOW() - INTERVAL '2 hours')
ON CONFLICT (id) DO NOTHING;

-- 5. PROOF OF DELIVERY SEED (For LGF-2026-88401)
INSERT INTO public.proof_of_deliveries (
    id, shipment_id, receiver_name, signature_url, photo_url,
    delivery_latitude, delivery_longitude, delivery_timestamp, notes, submitted_by, sync_status, is_verified
) VALUES (
    '55555555-5555-5555-5555-555555555555',
    '00000001-0000-0000-0000-000000000001',
    'Sunil Mehra',
    'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?w=300',
    'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=500',
    28.5708,
    77.3259,
    NOW() - INTERVAL '4 hours',
    'Received by receiver Sunil Mehra personally at 4th floor reception. Package seal intact.',
    'cccccccc-cccc-cccc-cccc-cccccccccccc',
    'synced',
    true
)
ON CONFLICT (id) DO NOTHING;
