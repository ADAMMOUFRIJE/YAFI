-- Add premium columns to users table
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_premium BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS daily_requests_count INTEGER DEFAULT 0;
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_request_date DATE DEFAULT CURRENT_DATE;

-- Function to reset daily counts (can be triggered or checked on usage)
CREATE OR REPLACE FUNCTION check_and_reset_daily_limit()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.last_request_date < CURRENT_DATE THEN
    NEW.daily_requests_count := 0;
    NEW.last_request_date := CURRENT_DATE;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update request count automatically? 
-- Actually, for simplicity in Supabase JS client usage without complex triggers right now, 
-- we will handle the reset logic in the Application (Frontend/Backend) or a simple logic.
-- But proper SQL is better. Let's just create the columns for now as that's safe.
