-- ====================================================================
-- LOGIFLOW LOGISTICS: AUTH TRIGGERS, RLS FIXES & STORAGE BUCKET
-- ====================================================================

-- 1. Allow users to insert their own profile on signup
DROP POLICY IF EXISTS "Users can insert their own profile" ON public.profiles;
CREATE POLICY "Users can insert their own profile"
ON public.profiles FOR INSERT TO authenticated
WITH CHECK (auth.uid() = id);

-- 2. Allow shippers to insert initial 'created' events for their own shipments
DROP POLICY IF EXISTS "Events insertable by staff or shipment creator" ON public.shipment_events;
DROP POLICY IF EXISTS "Events insertable by staff" ON public.shipment_events;
CREATE POLICY "Events insertable by staff or shipment creator"
ON public.shipment_events FOR INSERT TO authenticated
WITH CHECK (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin', 'driver'))
    OR
    EXISTS (SELECT 1 FROM public.shipments s WHERE s.id = shipment_id AND s.sender_id = auth.uid() AND new_status = 'created')
);

-- 3. Allow delivery assignments visibility & management
DROP POLICY IF EXISTS "Assignments viewable by stakeholders" ON public.delivery_assignments;
CREATE POLICY "Assignments viewable by stakeholders"
ON public.delivery_assignments FOR SELECT TO authenticated
USING (
    driver_id = auth.uid() OR
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin'))
);

DROP POLICY IF EXISTS "Assignments manageable by hub managers" ON public.delivery_assignments;
CREATE POLICY "Assignments manageable by hub managers"
ON public.delivery_assignments FOR ALL TO authenticated
USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin'))
)
WITH CHECK (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'admin'))
);

-- 4. Allow staff to upsert/update POD evidence
DROP POLICY IF EXISTS "POD updatable by authorized staff" ON public.proof_of_deliveries;
CREATE POLICY "POD updatable by authorized staff"
ON public.proof_of_deliveries FOR UPDATE TO authenticated
USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'driver', 'admin'))
);

-- 5. Automatic Profile Creation Trigger on Supabase Auth Sign-Up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
DECLARE
    requested_role user_role;
BEGIN
    requested_role := CASE
        WHEN COALESCE(NEW.raw_user_meta_data->>'role', '') = 'hub_manager' THEN 'hub_manager'::user_role
        WHEN COALESCE(NEW.raw_user_meta_data->>'role', '') = 'driver' THEN 'driver'::user_role
        ELSE 'shipper'::user_role
    END;

    INSERT INTO public.profiles (id, full_name, email, phone, role, hub_id)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'phone', '+91 98000 00000'),
        requested_role,
        CASE WHEN requested_role IN ('hub_manager', 'driver') THEN '11111111-1111-1111-1111-111111111111'::UUID ELSE NULL END
    )
    ON CONFLICT (id) DO UPDATE SET
        full_name = EXCLUDED.full_name,
        phone = EXCLUDED.phone;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 6. Supabase Storage Bucket for Proof of Delivery Photos & Signatures
INSERT INTO storage.buckets (id, name, public)
VALUES ('pod-evidence', 'pod-evidence', true)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS "POD evidence readable by authenticated users" ON storage.objects;
CREATE POLICY "POD evidence readable by authenticated users"
ON storage.objects FOR SELECT TO authenticated
USING (bucket_id = 'pod-evidence');

DROP POLICY IF EXISTS "POD evidence uploadable by staff" ON storage.objects;
CREATE POLICY "POD evidence uploadable by staff"
ON storage.objects FOR INSERT TO authenticated
WITH CHECK (
    bucket_id = 'pod-evidence' AND
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('hub_manager', 'driver', 'admin'))
);
