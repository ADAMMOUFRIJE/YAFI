-- =============================================
-- BASE DE DONNÉES PFE CHATBOT - VERSION AUTHENTIFICATION
-- =============================================

-- NETTOYAGE COMPLET (Attention !)
DROP TABLE IF EXISTS messages CASCADE;
DROP TABLE IF EXISTS learning_base CASCADE;
DROP TABLE IF EXISTS knowledge_base CASCADE;
DROP TABLE IF EXISTS sessions CASCADE;
DROP TABLE IF EXISTS users CASCADE;

create extension if not exists "uuid-ossp";

-- 1. TABLE UTILISATEURS AVEC AUTH
create table users (
  id uuid default uuid_generate_v4() primary key,
  email text unique not null,
  password text not null, -- Stockage simple pour le prototype
  full_name text not null,
  role text default 'user', -- 'admin' ou 'user'
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. TABLE SESSIONS
create table sessions (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references users(id) on delete cascade not null, -- Lien fort avec users
  title text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. TABLE MESSAGES
create table messages (
  id uuid default uuid_generate_v4() primary key,
  session_id uuid references sessions(id) on delete cascade not null,
  role text not null check (role in ('user', 'assistant', 'system')),
  content text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 4. KNOWLEDGE BASE
create table knowledge_base (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  content text not null,
  type text default 'text/plain',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 5. LEARNING BASE
create table learning_base (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references users(id) on delete cascade not null,
  fact text not null,
  source_session_id uuid references sessions(id) on delete set null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- OUVERTURE DES DROITS
alter table users enable row level security;
alter table sessions enable row level security;
alter table messages enable row level security;
alter table knowledge_base enable row level security;
alter table learning_base enable row level security;

create policy "Public Access" on users for all using (true) with check (true);
create policy "Public Access" on sessions for all using (true) with check (true);
create policy "Public Access" on messages for all using (true) with check (true);
create policy "Public Access" on knowledge_base for all using (true) with check (true);
create policy "Public Access" on learning_base for all using (true) with check (true);
