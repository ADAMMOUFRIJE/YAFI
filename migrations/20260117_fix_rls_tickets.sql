-- Fix for RLS policy violation
-- Since the app uses a custom 'users' table and not Supabase Auth, auth.uid() is null.
-- We will disable RLS for now to allow the custom system to work.

ALTER TABLE tickets DISABLE ROW LEVEL SECURITY;
ALTER TABLE ticket_messages DISABLE ROW LEVEL SECURITY;

-- If you want to keep RLS but allow access, you can use:
-- CREATE POLICY "Enable all for now" ON tickets FOR ALL USING (true);
-- But disabling it is cleaner if you aren't using Supabase Auth features.
