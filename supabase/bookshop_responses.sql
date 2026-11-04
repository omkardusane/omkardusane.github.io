-- Run once in the Supabase SQL editor.
-- Visitors (anon role) can insert answers; nobody without the service role can read, change or delete them.

create table if not exists public.bookshop_responses (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  shop text check (char_length(shop) <= 200),
  pains text[] check (cardinality(pains) <= 10),
  time_sink text check (char_length(time_sink) <= 2000),
  wish text check (char_length(wish) <= 2000),
  book text check (char_length(book) <= 300),
  contact text check (char_length(contact) <= 300)
);

alter table public.bookshop_responses enable row level security;

revoke all on public.bookshop_responses from anon, authenticated;
grant insert (shop, pains, time_sink, wish, book, contact) on public.bookshop_responses to anon;

drop policy if exists "anon can insert" on public.bookshop_responses;
create policy "anon can insert"
  on public.bookshop_responses
  for insert
  to anon
  with check (true);
