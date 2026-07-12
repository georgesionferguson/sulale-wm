-- Run this once in the Supabase SQL editor to create the bets table.
create table if not exists sulale_bets (
  id          bigserial primary key,
  game_id     text      not null,
  player      text      not null,
  team        text      not null,
  created_at  timestamptz not null default now(),
  constraint sulale_bets_unique unique (game_id, player)
);

-- Migration: add stake column (run once if upgrading from initial schema)
alter table sulale_bets add column if not exists stake integer not null default 1;

-- Allow anonymous reads and writes (the anon key is already public in the app)
alter table sulale_bets enable row level security;

create policy "anon read"  on sulale_bets for select using (true);
create policy "anon insert" on sulale_bets for insert with check (true);
create policy "anon delete" on sulale_bets for delete using (true);
