-- =============================================
-- BASE DE DONNÉES PFE CHATBOT - VERSION 2.0
-- =============================================

-- 1. Extension UUID
create extension if not exists "uuid-ossp";

-- 2. TABLE UTILISATEURS (NOUVEAU)
-- Pour garder une trace des inscriptions simplifiées
create table users (
  id uuid default uuid_generate_v4() primary key,
  full_name text not null,
  role text default 'user', -- 'user' ou 'admin'
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. TABLE SESSIONS
create table sessions (
  id uuid default uuid_generate_v4() primary key,
  user_id text not null, -- On garde le nom ou l'ID ici
  title text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 4. TABLE MESSAGES
create table messages (
  id uuid default uuid_generate_v4() primary key,
  session_id uuid references sessions(id) on delete cascade not null,
  role text not null check (role in ('user', 'assistant', 'system')),
  content text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 5. TABLE KNOWLEDGE BASE (Documents RAG)
create table knowledge_base (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  content text not null,
  type text default 'text/plain',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 6. TABLE LEARNING BASE (Mémoire des faits)
create table learning_base (
  id uuid default uuid_generate_v4() primary key,
  user_id text not null,
  fact text not null,
  source_session_id uuid references sessions(id) on delete set null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- =============================================
-- SÉCURITÉ (RLS PUBLIC POUR PROTOTYPE)
-- =============================================

alter table users enable row level security;
alter table sessions enable row level security;
alter table messages enable row level security;
alter table knowledge_base enable row level security;
alter table learning_base enable row level security;

create policy "Public Users" on users for all using (true) with check (true);
create policy "Public Sessions" on sessions for all using (true) with check (true);
create policy "Public Messages" on messages for all using (true) with check (true);
create policy "Public Knowledge" on knowledge_base for all using (true) with check (true);
create policy "Public Memory" on learning_base for all using (true) with check (true);
