-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- 1. SESSIONS TABLE
create table sessions (
  id uuid default uuid_generate_v4() primary key,
  user_id text not null, -- Stores Profile name for this PFE
  title text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. MESSAGES TABLE
create table messages (
  id uuid default uuid_generate_v4() primary key,
  session_id uuid references sessions(id) on delete cascade not null,
  role text not null check (role in ('user', 'assistant', 'system')),
  content text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. KNOWLEDGE BASE (RAG)
create table knowledge_base (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  content text not null,
  type text default 'text/plain',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 4. LEARNING BASE (Memory)
create table learning_base (
  id uuid default uuid_generate_v4() primary key,
  user_id text not null,
  fact text not null,
  source_session_id uuid references sessions(id) on delete set null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- DISABLE RLS for PFE Prototype (Simplification)
alter table sessions enable row level security;
alter table messages enable row level security;
alter table knowledge_base enable row level security;
alter table learning_base enable row level security;

-- OPEN POLICIES (Allow All Public Access for Demo)
create policy "Allow all access to sessions" on sessions for all using (true) with check (true);
create policy "Allow all access to messages" on messages for all using (true) with check (true);
create policy "Allow all access to knowledge_base" on knowledge_base for all using (true) with check (true);
create policy "Allow all access to learning_base" on learning_base for all using (true) with check (true);
