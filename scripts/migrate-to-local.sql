-- ============================================================================
-- Migrasi URL Media dari Supabase Storage ke Local Payload CMS File Endpoint
-- ============================================================================

UPDATE "media"
SET 
  url = REPLACE(url, 'https://rrovzatthpkjuwwwqxat.supabase.co/storage/v1/object/public/media', '/api/media/file'),
  thumbnail_u_r_l = REPLACE(thumbnail_u_r_l, 'https://rrovzatthpkjuwwwqxat.supabase.co/storage/v1/object/public/media', '/api/media/file'),
  sizes_thumbnail_url = REPLACE(sizes_thumbnail_url, 'https://rrovzatthpkjuwwwqxat.supabase.co/storage/v1/object/public/media', '/api/media/file'),
  sizes_hero_url = REPLACE(sizes_hero_url, 'https://rrovzatthpkjuwwwqxat.supabase.co/storage/v1/object/public/media', '/api/media/file'),
  sizes_card_url = REPLACE(sizes_card_url, 'https://rrovzatthpkjuwwwqxat.supabase.co/storage/v1/object/public/media', '/api/media/file')
WHERE url LIKE '%supabase.co%';

-- Verifikasi hasil migrasi
SELECT count(*) AS remaining_supabase_urls FROM "media" WHERE url LIKE '%supabase.co%';
