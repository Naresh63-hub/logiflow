-- ====================================================================
-- YUVA LOGISTICS (3PL) SCHEMA MIGRATION
-- Project: LogiFlow Yuva - Production Cross-Platform Shipment System
-- Generated: 2026-11-11
-- ====================================================================

-- 1. EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. CUSTOM TYPES & ENUMS
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('shipper', 'hub_manager', 'driver', 'admin');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE shipment_status AS ENUM (
        'created',
        'pickup_scheduled',
        'picked_up',
        'arrived_at_hub',
        'in_transit',
        'out_for_delivery',
        'delivered',
        'delivery_failed',
        'returned',
        'cancelled'
    );
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE priority_level AS ENUM ('standard', 'express', 'overnight');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- 3. HUBS TABLE
CREATE TABLE IF NOT EXISTS public.hubs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(16) UNIQUE NOT NULL,
    name VARCHAR(128) NOT NULL,
    city VARCHAR(64) NOT NULL DEFAULT 'Noida',
    state VARCHAR(64) NOT NULL DEFAULT 'Uttar Pradesh',
    address TEXT NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. PROFILES TABLE (Extends Supabase auth.users)
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name VARCHAR(128) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    role user_role NOT NULL DEFAULT 'shipper',
    hub_id UUID REFERENCES public.hubs(id) ON DELETE SET NULL,
    avatar_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. SHIPMENTS TABLE
CREATE TABLE IF NOT EXISTS public.shipments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tracking_number VARCHAR(32) UNIQUE NOT NULL,
    sender_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    sender_name VARCHAR(128) NOT NULL,
    sender_phone VARCHAR(20) NOT NULL,
    sender_address TEXT NOT NULL,
    receiver_name VARCHAR(128) NOT NULL,
    receiver_phone VARCHAR(20) NOT NULL,
    receiver_address TEXT NOT NULL,
    package_category VARCHAR(64) NOT NULL,
    weight_kg NUMERIC(6,2) NOT NULL CHECK (weight_kg > 0),
    priority priority_level NOT NULL DEFAULT 'standard',
    current_status shipment_status NOT NULL DEFAULT 'created',
    origin_hub_id UUID NOT NULL REFERENCES public.hubs(id) ON DELETE RESTRICT,
    destination_hub_id UUID NOT NULL REFERENCES public.hubs(id) ON DELETE RESTRICT,
    assigned_driver_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    expected_delivery TIMESTAMPTZ NOT NULL,
    version INTEGER NOT NULL DEFAULT 1,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. SHIPMENT EVENTS (Audit Trail)
CREATE TABLE IF NOT EXISTS public.shipment_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    shipment_id UUID NOT NULL REFERENCES public.shipments(id) ON DELETE CASCADE,
    previous_status shipment_status,
    new_status shipment_status NOT NULL,
    location_name VARCHAR(128) NOT NULL,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    remarks TEXT,
    updated_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. DELIVERY ASSIGNMENTS
CREATE TABLE IF NOT EXISTS public.delivery_assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    shipment_id UUID NOT NULL REFERENCES public.shipments(id) ON DELETE CASCADE,
    driver_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    assigned_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    status VARCHAR(32) NOT NULL DEFAULT 'assigned', -- assigned, accepted, in_progress, completed
    assigned_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

-- 8. PROOF OF DELIVERIES (POD)
CREATE TABLE IF NOT EXISTS public.proof_of_deliveries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    shipment_id UUID UNIQUE NOT NULL REFERENCES public.shipments(id) ON DELETE CASCADE,
    receiver_name VARCHAR(128) NOT NULL,
    signature_url TEXT,
    photo_url TEXT,
    delivery_latitude DOUBLE PRECISION NOT NULL,
    delivery_longitude DOUBLE PRECISION NOT NULL,
    delivery_timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    notes TEXT,
    submitted_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    sync_status VARCHAR(32) NOT NULL DEFAULT 'synced',
    is_verified BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 9. NOTIFICATIONS
CREATE TABLE IF NOT EXISTS public.notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    title VARCHAR(128) NOT NULL,
    body TEXT NOT NULL,
    payload JSONB,
    is_read BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 10. SYNC OPERATIONS (Conflict & Offline Reconciliation Log)
CREATE TABLE IF NOT EXISTS public.sync_operations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    operation_id VARCHAR(64) UNIQUE NOT NULL,
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    shipment_id UUID,
    operation_type VARCHAR(64) NOT NULL,
    payload JSONB NOT NULL,
    local_timestamp TIMESTAMPTZ NOT NULL,
    server_timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    status VARCHAR(32) NOT NULL DEFAULT 'synced', -- synced, failed, conflict
    retry_count INTEGER NOT NULL DEFAULT 0,
    error_message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ====================================================================
-- INDEXES FOR PRODUCTION QUERY OPTIMIZATION
-- ====================================================================
CREATE INDEX IF NOT EXISTS idx_shipments_tracking ON public.shipments(tracking_number);
CREATE INDEX IF NOT EXISTS idx_shipments_status ON public.shipments(current_status);
CREATE INDEX IF NOT EXISTS idx_shipments_sender ON public.shipments(sender_id);
CREATE INDEX IF NOT EXISTS idx_shipments_origin_hub ON public.shipments(origin_hub_id);
CREATE INDEX IF NOT EXISTS idx_shipments_dest_hub ON public.shipments(destination_hub_id);
CREATE INDEX IF NOT EXISTS idx_shipment_events_shipment_id ON public.shipment_events(shipment_id);
CREATE INDEX IF NOT EXISTS idx_pod_shipment_id ON public.proof_of_deliveries(shipment_id);
CREATE INDEX IF NOT EXISTS idx_sync_ops_user ON public.sync_operations(user_id);

-- ====================================================================
-- AUTOMATIC VERSION & TIMESTAMP TRIGGERS
-- ====================================================================
CREATE OR REPLACE FUNCTION update_timestamp_and_version()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    NEW.version = OLD.version + 1;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_shipments_version ON public.shipments;
CREATE TRIGGER trigger_shipments_version
BEFORE UPDATE ON public.shipments
FOR EACH ROW
EXECUTE FUNCTION update_timestamp_and_version();

-- ====================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ====================================================================
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.hubs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shipments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shipment_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.delivery_assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.proof_of_deliveries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sync_operations ENABLE ROW LEVEL SECURITY;

-- 1. Profiles RLS
CREATE POLICY "Public profiles are viewable by authenticated users"
ON public.profiles FOR SELECT TO authenticated
USING (true);

CREATE POLICY "Users can update their own profile"
ON public.profiles FOR UPDATE TO authenticated
USING (auth.uid() = id);

-- 2. Hubs RLS
CREATE POLICY "Hubs viewable by authenticated users"
ON public.hubs FOR SELECT TO authenticated
USING (true);

-- 3. Shipments RLS
CREATE POLICY "Shippers can view their own shipments"
ON public.shipments FOR SELECT TO authenticated
USING (
    sender_id = auth.uid() OR
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin', 'driver'))
);

CREATE POLICY "Shippers can create new shipments"
ON public.shipments FOR INSERT TO authenticated
WITH CHECK (
    sender_id = auth.uid() OR
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin'))
);

CREATE POLICY "Hub managers and drivers can update shipments"
ON public.shipments FOR UPDATE TO authenticated
USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin', 'driver'))
);

-- 4. Shipment Events RLS
CREATE POLICY "Events viewable by shipment stakeholders"
ON public.shipment_events FOR SELECT TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.shipments s
        WHERE s.id = shipment_id AND (
            s.sender_id = auth.uid() OR
            EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin', 'driver'))
        )
    )
);

CREATE POLICY "Events insertable by staff"
ON public.shipment_events FOR INSERT TO authenticated
WITH CHECK (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin', 'driver'))
);

-- 5. Proof of Delivery RLS
CREATE POLICY "POD viewable by stakeholders"
ON public.proof_of_deliveries FOR SELECT TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.shipments s
        WHERE s.id = shipment_id AND (
            s.sender_id = auth.uid() OR
            EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin', 'driver'))
        )
    )
);

CREATE POLICY "POD insertable by authorized staff"
ON public.proof_of_deliveries FOR INSERT TO authenticated
WITH CHECK (
    submitted_by = auth.uid() AND
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'driver', 'admin'))
);

-- 6. Notifications RLS
CREATE POLICY "Users can only read their own notifications"
ON public.notifications FOR SELECT TO authenticated
USING (user_id = auth.uid());

-- 7. Sync Operations RLS
CREATE POLICY "Users can view and insert their own sync operations"
ON public.sync_operations FOR ALL TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());
