-- Modified migration for 30-minute limit interval
-- We will change the column meaning or add a new one.
-- Let's stick with existing columns but change how we interpret them? 
-- Actually, 'last_request_date' is insufficient for 30-min checks. We need 'last_request_timestamp'.

ALTER TABLE users ADD COLUMN IF NOT EXISTS last_request_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW();

-- We can keep daily_requests_count as just "requests_count" for the current interval.
-- No need to rename it, we just reset it differently in the logic.
