-- ============================================================================
-- DUMP SUPABASE DATABASE COMPRO MIRAI - 2026-10-02T01:56:07.147Z
-- ============================================================================

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET session_replication_role = 'replica';

-- ============================================================================

-- 1. EXTENSIONS & ENUM TYPES

-- ============================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE EXTENSION IF NOT EXISTS "pgcrypto";


DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_careers_category') THEN
    CREATE TYPE "enum_careers_category" AS ENUM ('developer', 'administrasi', 'marketing', 'internship', 'freelance');
  END IF;
END $$;


DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_careers_location') THEN
    CREATE TYPE "enum_careers_location" AS ENUM ('On-Site', 'Hybrid', 'Remote');
  END IF;
END $$;


DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_careers_type') THEN
    CREATE TYPE "enum_careers_type" AS ENUM ('Full-Time', 'Part-Time', 'Contract', 'Internship');
  END IF;
END $$;


DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_news_category') THEN
    CREATE TYPE "enum_news_category" AS ENUM ('berita', 'pengumuman', 'acara', 'penghargaan', 'teknologi');
  END IF;
END $$;


DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_portfolios_tags_theme') THEN
    CREATE TYPE "enum_portfolios_tags_theme" AS ENUM ('software', 'hardware');
  END IF;
END $$;


DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_services_floating_cards_bottom_right_dot_color') THEN
    CREATE TYPE "enum_services_floating_cards_bottom_right_dot_color" AS ENUM ('green', 'orange', 'blue');
  END IF;
END $$;


DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_services_floating_cards_top_left_dot_color') THEN
    CREATE TYPE "enum_services_floating_cards_top_left_dot_color" AS ENUM ('green', 'orange', 'blue');
  END IF;
END $$;


DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_solution_categories_badge_color') THEN
    CREATE TYPE "enum_solution_categories_badge_color" AS ENUM ('teal', 'blue', 'orange', 'purple', 'green');
  END IF;
END $$;



-- ============================================================================

-- 2. SEQUENCES

-- ============================================================================

CREATE SEQUENCE IF NOT EXISTS "about_us_id_seq";

CREATE SEQUENCE IF NOT EXISTS "careers_id_seq";

CREATE SEQUENCE IF NOT EXISTS "customers_id_seq";

CREATE SEQUENCE IF NOT EXISTS "faqs_id_seq";

CREATE SEQUENCE IF NOT EXISTS "industries_id_seq";

CREATE SEQUENCE IF NOT EXISTS "media_id_seq";

CREATE SEQUENCE IF NOT EXISTS "news_id_seq";

CREATE SEQUENCE IF NOT EXISTS "partnership_solutions_id_seq";

CREATE SEQUENCE IF NOT EXISTS "partnerships_id_seq";

CREATE SEQUENCE IF NOT EXISTS "payload_kv_id_seq";

CREATE SEQUENCE IF NOT EXISTS "payload_locked_documents_id_seq";

CREATE SEQUENCE IF NOT EXISTS "payload_locked_documents_rels_id_seq";

CREATE SEQUENCE IF NOT EXISTS "payload_migrations_id_seq";

CREATE SEQUENCE IF NOT EXISTS "payload_preferences_id_seq";

CREATE SEQUENCE IF NOT EXISTS "payload_preferences_rels_id_seq";

CREATE SEQUENCE IF NOT EXISTS "portfolios_id_seq";

CREATE SEQUENCE IF NOT EXISTS "portfolios_rels_id_seq";

CREATE SEQUENCE IF NOT EXISTS "pricing_faqs_id_seq";

CREATE SEQUENCE IF NOT EXISTS "problems_id_seq";

CREATE SEQUENCE IF NOT EXISTS "products_id_seq";

CREATE SEQUENCE IF NOT EXISTS "services_id_seq";

CREATE SEQUENCE IF NOT EXISTS "solution_categories_id_seq";

CREATE SEQUENCE IF NOT EXISTS "solutions_id_seq";

CREATE SEQUENCE IF NOT EXISTS "solutions_rels_id_seq";

CREATE SEQUENCE IF NOT EXISTS "users_id_seq";

CREATE SEQUENCE IF NOT EXISTS "visitors_id_seq";


-- ============================================================================

-- 3. TABLE DEFINITIONS (DDL)

-- ============================================================================

CREATE TABLE IF NOT EXISTS "about_us" (
  "id" integer DEFAULT nextval('about_us_id_seq'::regclass) NOT NULL,
  "hero_headline" varchar DEFAULT 'Mendorong Transformasi Digital Indonesia'::character varying NOT NULL,
  "hero_description" varchar NOT NULL,
  "hero_image_id" integer,
  "vision_text" varchar NOT NULL,
  "milestone_headline" varchar DEFAULT 'Jejak Langkah Kami'::character varying,
  "team_headline" varchar DEFAULT 'Kenali Orang-orang di Balik Mirai Softnet'::character varying NOT NULL,
  "team_description" varchar,
  "cta_headline" varchar DEFAULT 'Siap Memulai Transformasi Digital Anda?'::character varying NOT NULL,
  "cta_description" varchar,
  "cta_button_text" varchar DEFAULT 'Hubungi Kami'::character varying NOT NULL,
  "cta_button_link" varchar DEFAULT '/contact'::character varying NOT NULL,
  "updated_at" timestamp with time zone,
  "created_at" timestamp with time zone,
  CONSTRAINT "about_us_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "about_us_core_values" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "icon_id" integer,
  "title" varchar NOT NULL,
  "description" varchar NOT NULL,
  CONSTRAINT "about_us_core_values_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "about_us_industries" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "icon_id" integer,
  "name" varchar NOT NULL,
  CONSTRAINT "about_us_industries_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "about_us_milestones" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "year" varchar NOT NULL,
  "title" varchar NOT NULL,
  "description" varchar,
  CONSTRAINT "about_us_milestones_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "about_us_mission_list" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "mission_text" varchar NOT NULL,
  CONSTRAINT "about_us_mission_list_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "about_us_strengths" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "title" varchar NOT NULL,
  "description" varchar,
  CONSTRAINT "about_us_strengths_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "about_us_team_members" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "photo_id" integer,
  "name" varchar NOT NULL,
  "position" varchar NOT NULL,
  "linkedin" varchar,
  CONSTRAINT "about_us_team_members_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "careers" (
  "id" integer DEFAULT nextval('careers_id_seq'::regclass) NOT NULL,
  "title" varchar NOT NULL,
  "slug" varchar NOT NULL,
  "is_urgent" boolean DEFAULT false,
  "category" "enum_careers_category" NOT NULL,
  "image_id" integer NOT NULL,
  "short_description" varchar NOT NULL,
  "skill" varchar NOT NULL,
  "experience" varchar NOT NULL,
  "location" "enum_careers_location" NOT NULL,
  "type" "enum_careers_type" NOT NULL,
  "content" jsonb NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "careers_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "customers" (
  "id" integer DEFAULT nextval('customers_id_seq'::regclass) NOT NULL,
  "name" varchar NOT NULL,
  "logo_id" integer NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "customers_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "faqs" (
  "id" integer DEFAULT nextval('faqs_id_seq'::regclass) NOT NULL,
  "category_name" varchar NOT NULL,
  "icon_id" integer,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "faqs_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "faqs_qna_list" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "question" varchar NOT NULL,
  "answer" varchar NOT NULL,
  CONSTRAINT "faqs_qna_list_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "industries" (
  "id" integer DEFAULT nextval('industries_id_seq'::regclass) NOT NULL,
  "name" varchar NOT NULL,
  "slug" varchar,
  "description" varchar,
  "order" numeric DEFAULT 0,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "industries_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "media" (
  "id" integer DEFAULT nextval('media_id_seq'::regclass) NOT NULL,
  "alt" varchar NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "url" varchar,
  "thumbnail_u_r_l" varchar,
  "filename" varchar,
  "mime_type" varchar,
  "filesize" numeric,
  "width" numeric,
  "height" numeric,
  "focal_x" numeric,
  "focal_y" numeric,
  "sizes_thumbnail_url" varchar,
  "sizes_thumbnail_width" numeric,
  "sizes_thumbnail_height" numeric,
  "sizes_thumbnail_mime_type" varchar,
  "sizes_thumbnail_filesize" numeric,
  "sizes_thumbnail_filename" varchar,
  "sizes_hero_url" varchar,
  "sizes_hero_width" numeric,
  "sizes_hero_height" numeric,
  "sizes_hero_mime_type" varchar,
  "sizes_hero_filesize" numeric,
  "sizes_hero_filename" varchar,
  "sizes_card_url" varchar,
  "sizes_card_width" numeric,
  "sizes_card_height" numeric,
  "sizes_card_mime_type" varchar,
  "sizes_card_filesize" numeric,
  "sizes_card_filename" varchar,
  CONSTRAINT "media_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "news" (
  "id" integer DEFAULT nextval('news_id_seq'::regclass) NOT NULL,
  "title" varchar NOT NULL,
  "slug" varchar NOT NULL,
  "category" "enum_news_category" NOT NULL,
  "date" timestamp with time zone NOT NULL,
  "image_id" integer NOT NULL,
  "short_description" varchar NOT NULL,
  "content" jsonb NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "thumbnail_id" integer,
  CONSTRAINT "news_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "partnership_solutions" (
  "id" integer DEFAULT nextval('partnership_solutions_id_seq'::regclass) NOT NULL,
  "name" varchar NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "partnership_solutions_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "partnerships" (
  "id" integer DEFAULT nextval('partnerships_id_seq'::regclass) NOT NULL,
  "name" varchar NOT NULL,
  "logo_id" integer NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "partnerships_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "payload_kv" (
  "id" integer DEFAULT nextval('payload_kv_id_seq'::regclass) NOT NULL,
  "key" varchar NOT NULL,
  "data" jsonb NOT NULL,
  CONSTRAINT "payload_kv_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "payload_locked_documents" (
  "id" integer DEFAULT nextval('payload_locked_documents_id_seq'::regclass) NOT NULL,
  "global_slug" varchar,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "payload_locked_documents_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "payload_locked_documents_rels" (
  "id" integer DEFAULT nextval('payload_locked_documents_rels_id_seq'::regclass) NOT NULL,
  "order" integer,
  "parent_id" integer NOT NULL,
  "path" varchar NOT NULL,
  "users_id" integer,
  "media_id" integer,
  "services_id" integer,
  "customers_id" integer,
  "partnerships_id" integer,
  "careers_id" integer,
  "products_id" integer,
  "faqs_id" integer,
  "portfolios_id" integer,
  "visitors_id" integer,
  "pricing_faqs_id" integer,
  "problems_id" integer,
  "news_id" integer,
  "solutions_id" integer,
  "industries_id" integer,
  "solution_categories_id" integer,
  "partnership_solutions_id" integer,
  CONSTRAINT "payload_locked_documents_rels_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "payload_migrations" (
  "id" integer DEFAULT nextval('payload_migrations_id_seq'::regclass) NOT NULL,
  "name" varchar,
  "batch" numeric,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "payload_migrations_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "payload_preferences" (
  "id" integer DEFAULT nextval('payload_preferences_id_seq'::regclass) NOT NULL,
  "key" varchar,
  "value" jsonb,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "payload_preferences_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "payload_preferences_rels" (
  "id" integer DEFAULT nextval('payload_preferences_rels_id_seq'::regclass) NOT NULL,
  "order" integer,
  "parent_id" integer NOT NULL,
  "path" varchar NOT NULL,
  "users_id" integer,
  CONSTRAINT "payload_preferences_rels_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "portfolios" (
  "id" integer DEFAULT nextval('portfolios_id_seq'::regclass) NOT NULL,
  "client_name" varchar NOT NULL,
  "customer_id" integer,
  "description" varchar NOT NULL,
  "image_id" integer NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "portfolios_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "portfolios_achievements" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "text" varchar NOT NULL,
  CONSTRAINT "portfolios_achievements_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "portfolios_rels" (
  "id" integer DEFAULT nextval('portfolios_rels_id_seq'::regclass) NOT NULL,
  "order" integer,
  "parent_id" integer NOT NULL,
  "path" varchar NOT NULL,
  "services_id" integer,
  CONSTRAINT "portfolios_rels_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "portfolios_tags" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "label" varchar NOT NULL,
  "theme" "enum_portfolios_tags_theme" DEFAULT 'software'::enum_portfolios_tags_theme,
  CONSTRAINT "portfolios_tags_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "pricing_faqs" (
  "id" integer DEFAULT nextval('pricing_faqs_id_seq'::regclass) NOT NULL,
  "question" varchar NOT NULL,
  "answer" varchar NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "pricing_faqs_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "problems" (
  "id" integer DEFAULT nextval('problems_id_seq'::regclass) NOT NULL,
  "title" varchar NOT NULL,
  "description" varchar NOT NULL,
  "icon_id" integer NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "problems_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "products" (
  "id" integer DEFAULT nextval('products_id_seq'::regclass) NOT NULL,
  "name" varchar NOT NULL,
  "product_url" varchar NOT NULL,
  "badge" varchar,
  "headline" varchar NOT NULL,
  "description" varchar NOT NULL,
  "image_id" integer NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "subtitle" varchar NOT NULL,
  "icon_title_id" integer NOT NULL,
  "cta_text" varchar DEFAULT 'Kunjungi Website'::character varying,
  "full_description" jsonb,
  "slug" varchar NOT NULL,
  "benefit_title" varchar NOT NULL,
  "benefit_description" varchar NOT NULL,
  CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "products_benefits" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "title" varchar NOT NULL,
  "description" varchar NOT NULL,
  CONSTRAINT "products_benefits_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "products_clients" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "client_logo_id" integer NOT NULL,
  "client_name" varchar,
  CONSTRAINT "products_clients_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "products_features" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "icon_id" integer,
  "title" varchar NOT NULL,
  "description" varchar NOT NULL,
  "picture_id" integer,
  CONSTRAINT "products_features_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "products_gallery" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "gallery_image_id" integer NOT NULL,
  "caption" varchar,
  CONSTRAINT "products_gallery_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "products_integrations" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "logo_id" integer,
  "name" varchar NOT NULL,
  CONSTRAINT "products_integrations_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "products_use_cases" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "industry" varchar NOT NULL,
  CONSTRAINT "products_use_cases_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "services" (
  "id" integer DEFAULT nextval('services_id_seq'::regclass) NOT NULL,
  "title" varchar NOT NULL,
  "slug" varchar NOT NULL,
  "hero_badge" varchar,
  "hero_description" varchar,
  "hero_image_id" integer,
  "hero_btn1_text" varchar,
  "hero_btn1_link" varchar,
  "hero_btn2_text" varchar,
  "hero_btn2_link" varchar,
  "show_problem" boolean DEFAULT true,
  "problem_badge" varchar,
  "problem_title" varchar,
  "problem_subtitle" varchar,
  "show_solution" boolean DEFAULT true,
  "solution_badge" varchar,
  "solution_title" varchar,
  "show_process" boolean DEFAULT true,
  "process_badge" varchar,
  "process_title" varchar,
  "process_subtitle" varchar,
  "show_framework" boolean DEFAULT true,
  "framework_title" varchar,
  "framework_subtitle" varchar,
  "show_benefit" boolean DEFAULT true,
  "benefit_badge" varchar,
  "benefit_title" varchar,
  "benefit_subtitle" varchar,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "show_pricing" boolean DEFAULT true,
  "pricing_pricing_headline" varchar,
  "pricing_pricing_description" varchar,
  "subtitle" varchar NOT NULL,
  "icon_title_id" integer NOT NULL,
  "dashboard_badge" varchar,
  "dashboard_title" varchar,
  "dashboard_subtitle" varchar,
  "category" varchar,
  "floating_cards_top_left_title" varchar,
  "floating_cards_top_left_subtitle" varchar,
  "floating_cards_top_left_dot_color" "enum_services_floating_cards_top_left_dot_color" DEFAULT 'green'::enum_services_floating_cards_top_left_dot_color,
  "floating_cards_bottom_right_title" varchar,
  "floating_cards_bottom_right_subtitle" varchar,
  "floating_cards_bottom_right_dot_color" "enum_services_floating_cards_bottom_right_dot_color" DEFAULT 'orange'::enum_services_floating_cards_bottom_right_dot_color,
  CONSTRAINT "services_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "services_benefit_cards" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "icon_id" integer,
  "title" varchar,
  "description" varchar,
  CONSTRAINT "services_benefit_cards_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "services_framework_logos" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "logo_id" integer,
  CONSTRAINT "services_framework_logos_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "services_pricing_tiers" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "is_popular" boolean DEFAULT false,
  "tier_name" varchar,
  "price" varchar,
  "price_suffix" varchar,
  "description" varchar,
  "button_text" varchar,
  "button_link" varchar,
  CONSTRAINT "services_pricing_tiers_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "services_pricing_tiers_features" (
  "_order" integer NOT NULL,
  "_parent_id" varchar NOT NULL,
  "id" varchar NOT NULL,
  "feature_item" varchar,
  CONSTRAINT "services_pricing_tiers_features_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "services_problem_cards" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "icon_id" integer,
  "title" varchar,
  "description" varchar,
  CONSTRAINT "services_problem_cards_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "services_process_steps" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "icon_id" integer,
  "title" varchar,
  "description" varchar,
  CONSTRAINT "services_process_steps_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "services_solution_list" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "badge" varchar,
  "title" varchar,
  "description" varchar,
  "image_id" integer,
  CONSTRAINT "services_solution_list_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "solution_categories" (
  "id" integer DEFAULT nextval('solution_categories_id_seq'::regclass) NOT NULL,
  "name" varchar NOT NULL,
  "slug" varchar,
  "badge_color" "enum_solution_categories_badge_color" DEFAULT 'teal'::enum_solution_categories_badge_color,
  "description" varchar,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "solution_categories_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "solutions" (
  "id" integer DEFAULT nextval('solutions_id_seq'::regclass) NOT NULL,
  "title" varchar NOT NULL,
  "slug" varchar,
  "published_date" timestamp with time zone NOT NULL,
  "excerpt" varchar NOT NULL,
  "cover_image_id" integer,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "industry_id" integer NOT NULL,
  "description" jsonb,
  CONSTRAINT "solutions_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "solutions_rels" (
  "id" integer DEFAULT nextval('solutions_rels_id_seq'::regclass) NOT NULL,
  "order" integer,
  "parent_id" integer NOT NULL,
  "path" varchar NOT NULL,
  "solution_categories_id" integer,
  "partnership_solutions_id" integer,
  CONSTRAINT "solutions_rels_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "users" (
  "id" integer DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "email" varchar NOT NULL,
  "reset_password_token" varchar,
  "reset_password_expiration" timestamp with time zone,
  "salt" varchar,
  "hash" varchar,
  "login_attempts" numeric DEFAULT 0,
  "lock_until" timestamp with time zone,
  CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "users_sessions" (
  "_order" integer NOT NULL,
  "_parent_id" integer NOT NULL,
  "id" varchar NOT NULL,
  "created_at" timestamp with time zone,
  "expires_at" timestamp with time zone NOT NULL,
  CONSTRAINT "users_sessions_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "visitors" (
  "id" integer DEFAULT nextval('visitors_id_seq'::regclass) NOT NULL,
  "name" varchar NOT NULL,
  "email" varchar NOT NULL,
  "phone" varchar NOT NULL,
  "message" varchar NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "visitors_pkey" PRIMARY KEY ("id")
);

-- ============================================================================-- 4. DATA (INSERT INTO)-- ============================================================================
-- Data untuk tabel: "about_us" (1 rows)
TRUNCATE TABLE "about_us" CASCADE;
INSERT INTO "about_us" ("id", "hero_headline", "hero_description", "hero_image_id", "vision_text", "milestone_headline", "team_headline", "team_description", "cta_headline", "cta_description", "cta_button_text", "cta_button_link", "updated_at", "created_at") VALUES
  (1, 'Mirai Softnet Technology', 'PT Mirai Softnet Technology adalah penyedia solusi IT yang berpikiran maju yang didedikasikan untuk memberdayakan bisnis melalui teknologi inovatif dan transformasi digital. Didirikan di Indonesia, Mirai Softnet Technology menggabungkan keahlian teknis, desain kreatif, dan wawasan strategis untuk memberikan solusi IT yang andal dan dapat diskalakan bagi klien di berbagai industri.

Kami hadir sebagai mitra teknologi yang berfokus pada penyediaan solusi yang efektif, efisien, dan berorientasi pada kebutuhan pelanggan. Melalui layanan di bidang infrastruktur jaringan, pengembangan perangkat lunak, solusi cloud, keamanan sistem, serta dukungan teknologi informasi, kami berkomitmen membantu organisasi meningkatkan produktivitas dan mencapai tujuan bisnisnya.', 83, 'Menjadi mitra teknologi terkemuka di Asia Tenggara, memungkinkan inovasi digital dan pertumbuhan berkelanjutan melalui solusi IT mutakhir.', 'Perjalanan Kami', 'Bertumbuh Bersama Tim yang Berkompeten', 'Kombinasi pengalaman, kompetensi, dan semangat inovasi yang menjadi fondasi dalam menghadirkan solusi teknologi yang andal dan berkelanjutan.', 'Wujudkan Solusi IT yang Tepat untuk Bisnis Anda', 'Sebagai mitra teknologi terpercaya, PT Mirai Softnet Technology siap membantu Anda menghadirkan solusi IT yang inovatif, terintegrasi, dan berkelanjutan untuk mendukung pertumbuhan bisnis.', 'Hubungi Kami', 'https://wa.me/6281188862020', '2026-06-19T02:06:38.525Z', '2026-05-25T06:43:06.896Z');

-- Data untuk tabel: "about_us_core_values" (5 rows)
TRUNCATE TABLE "about_us_core_values" CASCADE;
INSERT INTO "about_us_core_values" ("_order", "_parent_id", "id", "icon_id", "title", "description") VALUES
  (1, 1, '6a13ed703bcda97b3e55b269', 98, ' Inovasi', 'Merangkul kreativitas dan teknologi baru untuk mendorong kemajuan.'),
  (2, 1, '6a13ed7a3bcda97b3e55b26b', 99, 'Integritas', 'Berkomitmen pada transparansi, kejujuran, dan praktik bisnis yang etis.'),
  (3, 1, '6a20d362a9b77edca6c92652', 100, 'Keunggulan', 'Memberikan standar layanan dan solusi tertinggi.'),
  (4, 1, '6a20d374a9b77edca6c92653', 101, 'Kolaborasi', 'Bermitra dengan klien dan pemangku kepentingan untuk kesuksesan bersama.'),
  (5, 1, '6a20d385a9b77edca6c92654', 29, 'Fokus Pelanggan', 'Memahami tujuan klien dan melampaui harapan.');

-- Data untuk tabel: "about_us_industries" (5 rows)
TRUNCATE TABLE "about_us_industries" CASCADE;
INSERT INTO "about_us_industries" ("_order", "_parent_id", "id", "icon_id", "name") VALUES
  (1, 1, '6a13eef43bcda97b3e55b277', 102, 'Manufacturing'),
  (2, 1, '6a13ef203bcda97b3e55b279', 103, 'Logistics'),
  (3, 1, '6a20d8cfa9b77edca6c92659', 104, 'Healthcare'),
  (4, 1, '6a20d8dca9b77edca6c9265a', 105, 'Education'),
  (5, 1, '6a20d8e9a9b77edca6c9265b', 106, 'Private Sector');

-- Data untuk tabel: "about_us_milestones" (3 rows)
TRUNCATE TABLE "about_us_milestones" CASCADE;
INSERT INTO "about_us_milestones" ("_order", "_parent_id", "id", "year", "title", "description") VALUES
  (1, 1, '6a13eea33bcda97b3e55b26f', '2024', 'Awal Perjalanan', 'Memulai langkah sebagai penyedia solusi teknologi yang berfokus pada inovasi dan transformasi digital.'),
  (2, 1, '6a13eec23bcda97b3e55b271', '2025', 'Pengembangan Layanan', 'Memperluas layanan dan solusi teknologi untuk mendukung kebutuhan bisnis yang terus berkembang.'),
  (3, 1, '6a20d78fa9b77edca6c92656', '2025 - Sekarang', 'Pertumbuhan & Kemitraan', 'Menghadirkan solusi IT yang terintegrasi serta membangun kemitraan strategis dengan berbagai brand teknologi terkemuka.');

-- Data untuk tabel: "about_us_mission_list" (4 rows)
TRUNCATE TABLE "about_us_mission_list" CASCADE;
INSERT INTO "about_us_mission_list" ("_order", "_parent_id", "id", "mission_text") VALUES
  (1, 1, '6a13ed4d3bcda97b3e55b263', 'Memberikan solusi dan layanan IT yang inovatif, aman, dan andal yang disesuaikan dengan kebutuhan klien.'),
  (2, 1, '6a13ed553bcda97b3e55b265', 'Bangun kemitraan jangka panjang berdasarkan kepercayaan, kualitas, dan kesuksesan bersama.'),
  (3, 1, '6a13ed633bcda97b3e55b267', 'Berdayakan bisnis dengan alat dan pengetahuan untuk berkembang di era digital.'),
  (4, 1, '6a20d2f0a9b77edca6c92651', 'Menumbuhkan budaya inovasi, integritas, dan peningkatan berkelanjutan.');

-- Data untuk tabel: "about_us_strengths" (4 rows)
TRUNCATE TABLE "about_us_strengths" CASCADE;
INSERT INTO "about_us_strengths" ("_order", "_parent_id", "id", "title", "description") VALUES
  (1, 1, '6a13eed53bcda97b3e55b273', 'Tim Profesional Berpengalaman  ', 'Didukung oleh tenaga profesional IT yang kompeten dan berpengalaman, kami menghadirkan solusi teknologi yang dirancang sesuai kebutuhan bisnis serta mengikuti standar industri terkini.'),
  (2, 1, '6a13eee13bcda97b3e55b275', 'Rekam Jejak Proyek yang Terpercaya ', 'Kami memiliki pengalaman dalam menangani berbagai implementasi solusi teknologi, mulai dari pengembangan sistem hingga pengelolaan infrastruktur IT untuk mendukung operasional bisnis pelanggan.'),
  (3, 1, '6a20d846a9b77edca6c92657', 'Fokus pada Inovasi dan Kepuasan Pelanggan', 'Kami terus berinovasi untuk menghadirkan solusi yang relevan dengan perkembangan teknologi, dengan mengutamakan kualitas layanan dan kepuasan pelanggan sebagai prioritas utama.'),
  (4, 1, '6a20d85ba9b77edca6c92658', 'Kemitraan Strategis dengan Brand Teknologi  ', 'Melalui kerja sama dengan berbagai vendor dan brand teknologi terkemuka, kami mampu menyediakan solusi yang lebih lengkap, terpercaya, dan sesuai dengan kebutuhan bisnis yang terus berkembang.');

-- Data untuk tabel: "about_us_team_members" (5 rows)
TRUNCATE TABLE "about_us_team_members" CASCADE;
INSERT INTO "about_us_team_members" ("_order", "_parent_id", "id", "photo_id", "name", "position", "linkedin") VALUES
  (1, 1, '6a13ef443bcda97b3e55b27b', 78, 'Saputro Dwi Novianto', 'Sales Manager', ''),
  (2, 1, '6a13ef563bcda97b3e55b27d', 79, 'Dasep Depiyawan', 'Fullstack Developer', ''),
  (3, 1, '6a20db5aa9b77edca6c9265c', 80, 'M Alfin Pangestu', 'Frontend Developer & UI/UX Designer', 'https://www.linkedin.com/in/fin-pangestu/'),
  (4, 1, '6a20db9ba9b77edca6c9265d', 81, 'Asmaul Fauzyah', 'Accounting & Tax', NULL),
  (5, 1, '6a20dbcea9b77edca6c9265e', 82, 'Adella Berliana', 'Purchasing', NULL);

-- Data untuk tabel: "careers" (1 rows)
TRUNCATE TABLE "careers" CASCADE;
INSERT INTO "careers" ("id", "title", "slug", "is_urgent", "category", "image_id", "short_description", "skill", "experience", "location", "type", "content", "updated_at", "created_at") VALUES
  (1, 'Backend Developer', 'backend-developer', TRUE, 'developer', 52, 'Kami mencari talenta berpengalaman yang siap mengambil peran krusial dalam arsitektur pengembangan Enterprise Systems unggulan kami (seperti bit HRMS dan BPS).', 'GoLang', '2 Tahun', 'On-Site', 'Contract', '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"tag":"h4","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jobdesk","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Merancang, mengembangkan, dan memelihara sistem enterprise dan aplikasi web menggunakan ekosistem ASP.NET.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Membangun antarmuka (frontend) yang interaktif dan responsif, serta mengintegrasikannya dengan arsitektur backend yang tangguh.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengelola, mengoptimalkan, dan merancang struktur database relasional (seperti SQL Server) untuk menangani beban data perusahaan berskala besar.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"tag":"h4","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Requirement","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Memiliki pengalaman kerja profesional minimal 2 - 4 tahun sebagai Fullstack Developer, Backend Developer, atau peran serupa.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemahaman mendalam tentang bahasa pemrograman C# dan framework ASP.NET (MVC atau Core).","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null}],"direction":null}}'::jsonb, '2026-05-20T04:13:45.352Z', '2026-05-20T03:30:36.383Z');

-- Data untuk tabel: "customers" (6 rows)
TRUNCATE TABLE "customers" CASCADE;
INSERT INTO "customers" ("id", "name", "logo_id", "updated_at", "created_at") VALUES
  (1, 'Toyota Boshoku Indonesia', 1, '2026-05-18T01:29:37.603Z', '2026-05-18T01:29:37.603Z'),
  (2, 'Bonecom Tricom', 2, '2026-05-18T01:32:41.113Z', '2026-05-18T01:32:41.112Z'),
  (3, 'Bonecom Tricom Paintech', 3, '2026-05-18T01:34:51.243Z', '2026-05-18T01:34:51.243Z'),
  (4, 'Sankeikid Manutech Indonesia', 4, '2026-05-18T01:35:23.329Z', '2026-05-18T01:35:23.329Z'),
  (5, 'Ravalia Inti Mandiri', 5, '2026-05-18T01:35:57.082Z', '2026-05-18T01:35:57.082Z'),
  (6, 'Rajawali Mitra Pratama', 6, '2026-05-18T01:36:22.762Z', '2026-05-18T01:36:22.762Z');

-- Data untuk tabel: "faqs" (3 rows)
TRUNCATE TABLE "faqs" CASCADE;
INSERT INTO "faqs" ("id", "category_name", "icon_id", "updated_at", "created_at") VALUES
  (1, 'General', 50, '2026-05-29T06:20:23.911Z', '2026-05-20T01:27:50.150Z'),
  (2, 'Produk', 28, '2026-05-29T06:21:28.077Z', '2026-05-20T01:29:41.713Z'),
  (3, 'Layanan &  Jasa', 51, '2026-05-29T06:22:20.981Z', '2026-05-20T01:32:52.463Z');

-- Data untuk tabel: "faqs_qna_list" (9 rows)
TRUNCATE TABLE "faqs_qna_list" CASCADE;
INSERT INTO "faqs_qna_list" ("_order", "_parent_id", "id", "question", "answer") VALUES
  (1, 1, '6a0d0da09069fe528b7a112d', 'Apa itu Mirai Softnet Technology?', 'Mirai Softnet Technology adalah perusahaan penyedia solusi teknologi informasi yang fokus pada jasa pengembangan aplikasi (software development) kustom dan penyediaan sistem berbasis SaaS (Software as a Service) untuk membantu akselerasi bisnis Anda.'),
  (2, 1, '6a0d0dae9069fe528b7a112f', 'Apa saja layanan utama yang ditawarkan?', 'Kami menawarkan jasa pengembangan aplikasi end-to-end (Web, Mobile, dan Desktop), konsultasi sistem, serta berbagai produk SaaS siap pakai yang dapat disesuaikan dengan kebutuhan operasional perusahaan.'),
  (3, 1, '6a0d0df79069fe528b7a1131', 'Bagaimana cara memulai kerja sama dengan Mirai Softnet?', 'Anda dapat menghubungi tim kami melalui tombol "Hubungi Kami" di situs ini, atau melalui kontak yang tersedia, untuk menjadwalkan konsultasi gratis mengenai kebutuhan proyek atau sistem Anda.'),
  (1, 2, '6a0d0e529069fe528b7a1137', 'Bagaimana cara berlangganan produk SaaS dari Mirai Softnet?', 'Anda dapat memilih produk yang sesuai melalui menu "Katalog", lalu melakukan registrasi akun dan mengikuti alur berlangganan yang tersedia di dasbor produk.'),
  (2, 2, '6a0d0e5e9069fe528b7a1139', 'Apakah sistem SaaS bisa disesuaikan (customized)?', 'Ya, kami memahami setiap bisnis memiliki alur kerja yang berbeda. Kami menyediakan opsi penyesuaian (customization) atau fitur tambahan pada sistem SaaS kami agar lebih pas dengan kebutuhan spesifik bisnis Anda.'),
  (3, 2, '6a0d0e6c9069fe528b7a113b', 'Bagaimana dengan dukungan teknis untuk produk SaaS?', 'Setiap pelanggan SaaS mendapatkan akses ke pusat bantuan, dokumentasi teknis, serta dukungan tim support kami melalui ticketing system atau kanal komunikasi resmi yang telah disediakan.'),
  (1, 3, '6a0d0f1d9069fe528b7a1141', 'Teknologi apa saja yang digunakan dalam pengembangan aplikasi?', 'Kami menggunakan teknologi modern dan teruji seperti Flutter untuk aplikasi mobile, serta berbagai framework backend dan frontend yang populer (seperti Laravel, Node.js, React, dll) untuk memastikan performa aplikasi yang cepat, aman, dan skalabel.'),
  (2, 3, '6a0d0f219069fe528b7a1143', 'Berapa lama waktu pengerjaan proyek aplikasi?', 'Waktu pengerjaan bergantung pada kompleksitas fitur dan skala proyek. Setelah proses diskusi teknis, kami akan memberikan estimasi waktu pengerjaan (timeline) yang terukur dan transparan.'),
  (3, 3, '6a0d0f2d9069fe528b7a1145', 'Apakah ada layanan pemeliharaan (maintenance) setelah aplikasi selesai?', 'Tentu. Kami menyediakan paket layanan pemeliharaan dan support berkelanjutan untuk memastikan aplikasi Anda tetap berjalan optimal, aman, dan mendapatkan pembaruan sesuai perkembangan kebutuhan pasar.');

-- Data untuk tabel: "industries" (10 rows)
TRUNCATE TABLE "industries" CASCADE;
INSERT INTO "industries" ("id", "name", "slug", "description", "order", "updated_at", "created_at") VALUES
  (9, 'Sektor Publik & Pemerintah', 'public-sector-goverment', NULL, '1', '2026-09-23T08:11:41.592Z', '2026-09-23T08:05:36.297Z'),
  (10, 'Manufaktur', 'manufacturing', NULL, '2', '2026-09-23T08:11:58.693Z', '2026-09-23T08:05:54.566Z'),
  (11, 'Ritel & E-Commerce', 'retail-e-commerce', NULL, '3', '2026-09-23T08:12:18.843Z', '2026-09-23T08:06:18.988Z'),
  (12, 'Layanan kesehatan', 'healthcare-kesehatan', NULL, '4', '2026-09-23T08:12:35.777Z', '2026-09-23T08:06:46.838Z'),
  (13, 'Telekomunikasi', 'telecommunication', NULL, '5', '2026-09-23T08:12:56.199Z', '2026-09-23T08:07:12.234Z'),
  (14, 'Layanan Keuangan', 'financial-services-banking-insurance-fintech', NULL, '6', '2026-09-23T08:13:09.252Z', '2026-09-23T08:08:39.684Z'),
  (15, 'Logistik & Transportasi', 'logistics-transportation', NULL, '7', '2026-09-23T08:13:26.816Z', '2026-09-23T08:09:08.178Z'),
  (16, 'Pendidikan', 'education', NULL, '8', '2026-09-23T08:13:44.327Z', '2026-09-23T08:09:29.657Z'),
  (17, 'Perhotelan & Pariwisata', 'hospital-tourism', NULL, '9', '2026-09-23T08:14:03.838Z', '2026-09-23T08:09:47.396Z'),
  (18, 'Industri Umum', 'general-industry', NULL, '10', '2026-09-23T08:14:41.363Z', '2026-09-23T08:10:04.313Z');

-- Data untuk tabel: "media" (209 rows)
TRUNCATE TABLE "media" CASCADE;
INSERT INTO "media" ("id", "alt", "updated_at", "created_at", "url", "thumbnail_u_r_l", "filename", "mime_type", "filesize", "width", "height", "focal_x", "focal_y", "sizes_thumbnail_url", "sizes_thumbnail_width", "sizes_thumbnail_height", "sizes_thumbnail_mime_type", "sizes_thumbnail_filesize", "sizes_thumbnail_filename", "sizes_hero_url", "sizes_hero_width", "sizes_hero_height", "sizes_hero_mime_type", "sizes_hero_filesize", "sizes_hero_filename", "sizes_card_url", "sizes_card_width", "sizes_card_height", "sizes_card_mime_type", "sizes_card_filesize", "sizes_card_filename") VALUES
  (5, 'ravalia-logo', '2026-05-18T01:35:53.664Z', '2026-05-18T01:35:53.664Z', '/api/media/file/ravalia.png', '/api/media/file/ravalia.png', 'ravalia.png', 'image/png', '30207', '400', '120', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (7, 'hp-logo', '2026-05-18T02:04:02.609Z', '2026-05-18T02:04:02.609Z', '/api/media/file/hp.png', '/api/media/file/hp.png', 'hp.png', 'image/png', '12250', '144', '144', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9, 'kaspersky-logo', '2026-05-18T02:08:38.983Z', '2026-05-18T02:08:38.983Z', '/api/media/file/kaspersky.png', '/api/media/file/kaspersky.png', 'kaspersky.png', 'image/png', '10025', '692', '144', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (11, 'mirai-default-logo', '2026-05-18T02:11:45.218Z', '2026-05-18T02:11:45.218Z', '/api/media/file/mirai-black.png', '/api/media/file/mirai-black.png', 'mirai-black.png', 'image/png', '23326', '328', '140', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (14, 'table-freeze-column-and-row-dismiss-24-regular', '2026-05-18T03:33:25.690Z', '2026-05-18T03:33:25.690Z', '/api/media/file/table-freeze-column-and-row-dismiss-24-regular.svg', '/api/media/file/table-freeze-column-and-row-dismiss-24-regular.svg', 'table-freeze-column-and-row-dismiss-24-regular.svg', 'image/svg+xml', '2820', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (16, 'panel-left-text-dismiss-24-regular', '2026-05-18T03:36:16.516Z', '2026-05-18T03:36:16.516Z', '/api/media/file/panel-left-text-dismiss-24-regular.svg', '/api/media/file/panel-left-text-dismiss-24-regular.svg', 'panel-left-text-dismiss-24-regular.svg', 'image/svg+xml', '3697', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (17, 'document-search-24-regular', '2026-05-18T03:39:08.670Z', '2026-05-18T03:39:08.670Z', '/api/media/file/document-search-24-regular.svg', '/api/media/file/document-search-24-regular.svg', 'document-search-24-regular.svg', 'image/svg+xml', '2131', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (19, 'code-24-regular', '2026-05-18T03:43:16.101Z', '2026-05-18T03:43:16.101Z', '/api/media/file/code-24-regular.svg', '/api/media/file/code-24-regular.svg', 'code-24-regular.svg', 'image/svg+xml', '2237', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (21, 'rocket-20-regular', '2026-05-18T03:50:28.336Z', '2026-05-18T03:50:28.336Z', '/api/media/file/rocket-20-regular.svg', '/api/media/file/rocket-20-regular.svg', 'rocket-20-regular.svg', 'image/svg+xml', '5389', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (23, 'playstore-button', '2026-05-18T06:27:00.862Z', '2026-05-18T06:27:00.862Z', '/api/media/file/playstore-button.svg', '/api/media/file/playstore-button.svg', 'playstore-button.svg', 'image/svg+xml', '18428', '136', '46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (25, 'bit-hrms-logo', '2026-05-18T06:40:57.092Z', '2026-05-18T06:40:57.092Z', '/api/media/file/bit-hrms.png', '/api/media/file/bit-hrms.png', 'bit-hrms.png', 'image/png', '942376', '4096', '4096', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (27, 'document-toolbox-24-regular', '2026-05-18T06:45:50.125Z', '2026-05-18T06:45:50.125Z', '/api/media/file/document-toolbox-24-regular.svg', '/api/media/file/document-toolbox-24-regular.svg', 'document-toolbox-24-regular.svg', 'image/svg+xml', '2183', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (29, 'task-list-square-person-24-regular', '2026-05-18T06:51:04.494Z', '2026-05-18T06:51:04.494Z', '/api/media/file/task-list-square-person-24-regular.svg', '/api/media/file/task-list-square-person-24-regular.svg', 'task-list-square-person-24-regular.svg', 'image/svg+xml', '3080', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (31, 'globe-shield-20-regular', '2026-05-19T03:03:01.802Z', '2026-05-19T03:03:01.802Z', '/api/media/file/globe-shield-20-regular.svg', '/api/media/file/globe-shield-20-regular.svg', 'globe-shield-20-regular.svg', 'image/svg+xml', '2520', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (33, 'person-24-regular', '2026-05-19T03:21:21.633Z', '2026-05-19T03:21:21.633Z', '/api/media/file/person-24-regular.svg', '/api/media/file/person-24-regular.svg', 'person-24-regular.svg', 'image/svg+xml', '1698', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (35, 'calendar-arrow-counterclockwise-24-regular', '2026-05-19T03:27:23.503Z', '2026-05-19T03:27:23.503Z', '/api/media/file/calendar-arrow-counterclockwise-24-regular.svg', '/api/media/file/calendar-arrow-counterclockwise-24-regular.svg', 'calendar-arrow-counterclockwise-24-regular.svg', 'image/svg+xml', '3713', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (37, 'section-service-1-asset', '2026-05-19T07:06:31.735Z', '2026-05-19T07:06:31.733Z', '/api/media/file/section-service-1.png', '/api/media/file/section-service-1.png', 'section-service-1.png', 'image/png', '7584754', '2731', '4096', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (38, 'section-service-2-asset', '2026-05-19T07:07:49.359Z', '2026-05-19T07:07:49.359Z', '/api/media/file/section-service-2.png', '/api/media/file/section-service-2.png', 'section-service-2.png', 'image/png', '16009348', '4096', '2731', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (40, 'aspnet-logo', '2026-05-19T07:13:37.977Z', '2026-05-19T07:13:37.977Z', '/api/media/file/aspnet-logo.png', '/api/media/file/aspnet-logo.png', 'aspnet-logo.png', 'image/png', '69190', '2000', '964', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (42, 'flutter-logo', '2026-05-19T07:15:19.641Z', '2026-05-19T07:15:19.641Z', '/api/media/file/flutter-logo.png', '/api/media/file/flutter-logo.png', 'flutter-logo.png', 'image/png', '17490', '2000', '726', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (44, 'mysql-logo', '2026-05-19T07:15:52.897Z', '2026-05-19T07:15:52.897Z', '/api/media/file/mysql-logo.png', '/api/media/file/mysql-logo.png', 'mysql-logo.png', 'image/png', '41327', '2000', '1040', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (46, 'plug-connected-checkmark-20-regular', '2026-05-19T07:27:01.383Z', '2026-05-19T07:27:01.383Z', '/api/media/file/plug-connected-checkmark-20-regular.svg', '/api/media/file/plug-connected-checkmark-20-regular.svg', 'plug-connected-checkmark-20-regular.svg', 'image/svg+xml', '3483', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (4, 'sankeikid-logo', '2026-05-18T01:35:21.450Z', '2026-05-18T01:35:21.449Z', '/api/media/file/sankeikid.png', '/api/media/file/sankeikid.png', 'sankeikid.png', 'image/png', '8297', '400', '120', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (47, 'gantt-chart-20-regular', '2026-05-19T07:27:33.348Z', '2026-05-19T07:27:33.348Z', '/api/media/file/gantt-chart-20-regular.svg', '/api/media/file/gantt-chart-20-regular.svg', 'gantt-chart-20-regular.svg', 'image/svg+xml', '2245', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (48, 'person-support-20-regular', '2026-05-19T07:27:55.060Z', '2026-05-19T07:27:55.060Z', '/api/media/file/person-support-20-regular.svg', '/api/media/file/person-support-20-regular.svg', 'person-support-20-regular.svg', 'image/svg+xml', '3454', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (49, 'toyota-portfolio-asset', '2026-05-19T08:29:56.728Z', '2026-05-19T08:29:56.728Z', '/api/media/file/toyota-portfolio.jpg', '/api/media/file/toyota-portfolio.jpg', 'toyota-portfolio.jpg', 'image/jpeg', '8227372', '4096', '2731', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (50, 'info-24-regular', '2026-05-20T01:25:49.892Z', '2026-05-20T01:25:49.892Z', '/api/media/file/info-24-regular.svg', '/api/media/file/info-24-regular.svg', 'info-24-regular.svg', 'image/svg+xml', '1702', '28', '28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (51, 'server-multiple-20-regular', '2026-05-20T01:31:53.736Z', '2026-05-20T01:31:53.736Z', '/api/media/file/server-multiple-20-regular.svg', '/api/media/file/server-multiple-20-regular.svg', 'server-multiple-20-regular.svg', 'image/svg+xml', '2937', '28', '28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (52, 'career-be-asset', '2026-05-20T03:27:04.831Z', '2026-05-20T03:27:04.831Z', '/api/media/file/career-be.png', '/api/media/file/career-be.png', 'career-be.png', 'image/png', '424716', '2000', '2000', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (53, 'about-us-hero-asset', '2026-05-21T02:49:46.038Z', '2026-05-21T02:49:46.038Z', '/api/media/file/about-us-hero.jpg', '/api/media/file/about-us-hero.jpg', 'about-us-hero.jpg', 'image/jpeg', '1864729', '5158', '3438', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (55, 'network-check-20-filled', '2026-05-22T07:31:51.234Z', '2026-05-22T07:31:51.234Z', '/api/media/file/network-check-20-filled.svg', '/api/media/file/network-check-20-filled.svg', 'network-check-20-filled.svg', 'image/svg+xml', '3927', '34', '34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (56, 'server-link-20-regular', '2026-05-22T07:38:33.939Z', '2026-05-22T07:38:33.939Z', '/api/media/file/server-link-20-regular.svg', '/api/media/file/server-link-20-regular.svg', 'server-link-20-regular.svg', 'image/svg+xml', '3373', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (57, 'camera-dome-24-regular', '2026-05-22T07:40:11.563Z', '2026-05-22T07:40:11.563Z', '/api/media/file/camera-dome-24-regular.svg', '/api/media/file/camera-dome-24-regular.svg', 'camera-dome-24-regular.svg', 'image/svg+xml', '2057', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (58, 'device-meeting-room-remote-20-regular', '2026-05-22T07:40:59.811Z', '2026-05-22T07:40:59.810Z', '/api/media/file/device-meeting-room-remote-20-regular.svg', '/api/media/file/device-meeting-room-remote-20-regular.svg', 'device-meeting-room-remote-20-regular.svg', 'image/svg+xml', '2451', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (59, 'cloud-sync-24-regular', '2026-05-22T07:44:58.013Z', '2026-05-22T07:44:58.013Z', '/api/media/file/cloud-sync-24-regular.svg', '/api/media/file/cloud-sync-24-regular.svg', 'cloud-sync-24-regular.svg', 'image/svg+xml', '3242', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (60, 'calibrate', '2026-05-22T07:48:14.094Z', '2026-05-22T07:48:14.094Z', '/api/media/file/calibrate.svg', '/api/media/file/calibrate.svg', 'calibrate.svg', 'image/svg+xml', '2537', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (61, 'laptop-shield-20-regular', '2026-05-22T07:50:55.955Z', '2026-05-22T07:50:55.955Z', '/api/media/file/laptop-shield-20-regular.svg', '/api/media/file/laptop-shield-20-regular.svg', 'laptop-shield-20-regular.svg', 'image/svg+xml', '1562', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (62, 'bit-icon-logo', '2026-05-28T02:52:29.676Z', '2026-05-28T02:52:29.672Z', '/api/media/file/bit_icon_logo_new.png', '/api/media/file/bit_icon_logo_new-400x300.png', 'bit_icon_logo_new.png', 'image/png', '499719', '2808', '2808', '50', '50', '/api/media/file/bit_icon_logo_new-400x300.png', '400', '300', 'image/png', '37305', 'bit_icon_logo_new-400x300.png', '/api/media/file/bit_icon_logo_new-1920x1080.png', '1920', '1080', 'image/png', '235833', 'bit_icon_logo_new-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (74, 'WMS', '2026-06-03T03:35:40.546Z', '2026-06-03T03:35:40.546Z', '/api/media/file/Gemini_Generated_Image_gvbghcgvbghcgvbg.png', '/api/media/file/Gemini_Generated_Image_gvbghcgvbghcgvbg-400x300.png', 'Gemini_Generated_Image_gvbghcgvbghcgvbg.png', 'image/png', '6817791', '2848', '1490', '50', '50', '/api/media/file/Gemini_Generated_Image_gvbghcgvbghcgvbg-400x300.png', '400', '300', 'image/png', '270685', 'Gemini_Generated_Image_gvbghcgvbghcgvbg-400x300.png', '/api/media/file/Gemini_Generated_Image_gvbghcgvbghcgvbg-1920x1080.png', '1920', '1080', 'image/png', '4370267', 'Gemini_Generated_Image_gvbghcgvbghcgvbg-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (71, 'fluent--document-20-regular', '2026-06-05T09:28:49.870Z', '2026-06-03T01:43:55.557Z', '/api/media/file/fluent--document-20-regular.svg', '/api/media/file/fluent--document-20-regular.svg', 'fluent--document-20-regular.svg', 'image/svg+xml', '396', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (54, 'it-infrastructure-hero-asset', '2026-05-22T07:28:15.297Z', '2026-05-22T07:28:15.296Z', '/api/media/file/it-infrastructure-hero.png', '/api/media/file/it-infrastructure-hero-400x300.png', 'it-infrastructure-hero.png', 'image/png', '833374', '2600', '2000', '50', '50', '/api/media/file/it-infrastructure-hero-400x300.png', '400', '300', 'image/png', '59440', 'it-infrastructure-hero-400x300.png', '/api/media/file/it-infrastructure-hero-1920x1080.png', '1920', '1080', 'image/png', '500573', 'it-infrastructure-hero-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (243, 'Pusat Kendali Operasional Rumah Sakit', '2026-10-01T06:38:10.521Z', '2026-10-01T06:38:09.833Z', '/api/media/file/Pusat Kendali Operasional Rumah Sakit.webp', '/api/media/file/Pusat%20Kendali%20Operasional%20Rumah%20Sakit-400x300.webp', 'Pusat Kendali Operasional Rumah Sakit.webp', 'image/webp', '136374', '1376', '768', '50', '50', '/api/media/file/Pusat Kendali Operasional Rumah Sakit-400x300.webp', '400', '300', 'image/webp', '32498', 'Pusat Kendali Operasional Rumah Sakit-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pusat Kendali Operasional Rumah Sakit-800x600.webp', '800', '600', 'image/webp', '83456', 'Pusat Kendali Operasional Rumah Sakit-800x600.webp'),
  (79, 'Dasep Depiyawan', '2026-06-04T01:56:11.895Z', '2026-06-04T01:56:11.895Z', '/api/media/file/4.png', '/api/media/file/4-400x300.png', '4.png', 'image/png', '348033', '650', '650', '50', '50', '/api/media/file/4-400x300.png', '400', '300', 'image/png', '119991', '4-400x300.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (80, 'M Alfin Pangestu', '2026-06-04T01:57:14.319Z', '2026-06-04T01:57:14.319Z', '/api/media/file/3.png', '/api/media/file/3-400x300.png', '3.png', 'image/png', '289401', '650', '650', '50', '50', '/api/media/file/3-400x300.png', '400', '300', 'image/png', '102621', '3-400x300.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (81, 'Asmaul Fauzyah', '2026-06-04T01:58:22.466Z', '2026-06-04T01:58:22.466Z', '/api/media/file/1.png', '/api/media/file/1-400x300.png', '1.png', 'image/png', '344416', '650', '650', '50', '50', '/api/media/file/1-400x300.png', '400', '300', 'image/png', '118780', '1-400x300.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (82, 'Adella Berliana', '2026-06-04T01:59:12.255Z', '2026-06-04T01:59:12.255Z', '/api/media/file/2.png', '/api/media/file/2-400x300.png', '2.png', 'image/png', '330641', '650', '650', '50', '50', '/api/media/file/2-400x300.png', '400', '300', 'image/png', '116978', '2-400x300.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (84, 'bps-mockup-asset', '2026-06-04T04:22:52.954Z', '2026-06-04T04:22:52.954Z', '/api/media/file/bps-mockup.png', '/api/media/file/bps-mockup-400x300.png', 'bps-mockup.png', 'image/png', '12875957', '2731', '4096', '50', '50', '/api/media/file/bps-mockup-400x300.png', '400', '300', 'image/png', '265293', 'bps-mockup-400x300.png', '/api/media/file/bps-mockup-1920x1080.png', '1920', '1080', 'image/png', '3544907', 'bps-mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (87, 'fluent--chart-multiple-20-regular', '2026-06-05T09:26:02.080Z', '2026-06-05T09:26:02.080Z', '/api/media/file/fluent--chart-multiple-20-regular (1).svg', '/api/media/file/fluent--chart-multiple-20-regular (1).svg', 'fluent--chart-multiple-20-regular (1).svg', 'image/svg+xml', '596', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (88, 'fluent--accessibility-checkmark-20-regular', '2026-06-05T09:28:04.709Z', '2026-06-05T09:28:04.709Z', '/api/media/file/fluent--accessibility-checkmark-20-regular.svg', '/api/media/file/fluent--accessibility-checkmark-20-regular.svg', 'fluent--accessibility-checkmark-20-regular.svg', 'image/svg+xml', '952', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (98, 'fluent--lightbulb-filament-20-regular-icon', '2026-06-08T00:55:02.095Z', '2026-06-08T00:55:02.095Z', '/api/media/file/fluent--lightbulb-filament-20-regular-1.svg', '/api/media/file/fluent--lightbulb-filament-20-regular-1.svg', 'fluent--lightbulb-filament-20-regular-1.svg', 'image/svg+xml', '1039', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (100, 'fluent--ribbon-star-20-regular-icon', '2026-06-08T00:55:35.184Z', '2026-06-08T00:55:35.184Z', '/api/media/file/fluent--ribbon-star-20-regular-1.svg', '/api/media/file/fluent--ribbon-star-20-regular-1.svg', 'fluent--ribbon-star-20-regular-1.svg', 'image/svg+xml', '736', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (102, 'fluent--building-factory-20-regular.-icon', '2026-06-08T00:58:08.919Z', '2026-06-08T00:58:08.919Z', '/api/media/file/fluent--building-factory-20-regular.svg', '/api/media/file/fluent--building-factory-20-regular.svg', 'fluent--building-factory-20-regular.svg', 'image/svg+xml', '663', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (103, 'fluent--vehicle-truck-cube-20-regular-icon', '2026-06-08T00:58:26.056Z', '2026-06-08T00:58:26.055Z', '/api/media/file/fluent--vehicle-truck-cube-20-regular.svg', '/api/media/file/fluent--vehicle-truck-cube-20-regular.svg', 'fluent--vehicle-truck-cube-20-regular.svg', 'image/svg+xml', '1011', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (105, 'fluent--hat-graduation-20-regular-icon', '2026-06-08T00:58:59.594Z', '2026-06-08T00:58:59.594Z', '/api/media/file/fluent--hat-graduation-20-regular.svg', '/api/media/file/fluent--hat-graduation-20-regular.svg', 'fluent--hat-graduation-20-regular.svg', 'image/svg+xml', '739', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (111, 'android-seeklogo-logo', '2026-06-18T03:49:26.798Z', '2026-06-18T03:49:26.798Z', '/api/media/file/android-seeklogo.png', '/api/media/file/android-seeklogo-400x300.png', 'android-seeklogo.png', 'image/png', '46304', '1705', '2000', '50', '50', '/api/media/file/android-seeklogo-400x300.png', '400', '300', 'image/png', '15329', 'android-seeklogo-400x300.png', '/api/media/file/android-seeklogo-1920x1080.png', '1920', '1080', 'image/png', '85425', 'android-seeklogo-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (113, 'dashboard', '2026-06-18T05:18:30.560Z', '2026-06-18T04:58:51.340Z', '/api/media/file/tabler--dashboard(4).svg', '/api/media/file/tabler--dashboard(4).svg', 'tabler--dashboard(4).svg', 'image/svg+xml', '347', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (78, 'Saputro Dwi Novianto', '2026-06-04T01:55:27.727Z', '2026-06-04T01:55:27.727Z', '/api/media/file/5.png', '/api/media/file/5-400x300.png', '5.png', 'image/png', '261419', '650', '650', '50', '50', '/api/media/file/5-400x300.png', '400', '300', 'image/png', '94978', '5-400x300.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (121, 'sap', '2026-06-18T06:59:56.992Z', '2026-06-18T06:59:56.992Z', '/api/media/file/cib--sap.svg', '/api/media/file/cib--sap.svg', 'cib--sap.svg', 'image/svg+xml', '1114', '38', '38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (124, 'software', '2026-06-18T08:05:33.005Z', '2026-06-18T08:05:33.005Z', '/api/media/file/mdi--antivirus-outline.svg', '/api/media/file/mdi--antivirus-outline.svg', 'mdi--antivirus-outline.svg', 'image/svg+xml', '503', '38', '38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (125, 'pc', '2026-06-18T08:15:35.913Z', '2026-06-18T08:15:35.913Z', '/api/media/file/streamline-cyber--computer-pc-4.svg', '/api/media/file/streamline-cyber--computer-pc-4.svg', 'streamline-cyber--computer-pc-4.svg', 'image/svg+xml', '385', '38', '38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (126, 'mtc', '2026-06-18T08:18:46.641Z', '2026-06-18T08:18:46.641Z', '/api/media/file/grommet-icons--services.svg', '/api/media/file/grommet-icons--services.svg', 'grommet-icons--services.svg', 'image/svg+xml', '478', '38', '38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (127, 'e0vis', '2026-06-18T08:22:44.319Z', '2026-06-18T08:22:44.319Z', '/api/media/file/E-VISITORS.png', '/api/media/file/E-VISITORS.png', 'E-VISITORS.png', 'image/png', '151771', '262', '254', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (131, 'fluent--qr-code-20-regular-icon', '2026-06-19T00:48:50.088Z', '2026-06-19T00:45:29.911Z', '/api/media/file/fluent--qr-code-20-regular-1.svg', '/api/media/file/fluent--qr-code-20-regular-1.svg', 'fluent--qr-code-20-regular-1.svg', 'image/svg+xml', '663', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (132, 'fluent--document-bullet-list-20-regular-icon', '2026-06-19T00:51:34.938Z', '2026-06-19T00:51:34.938Z', '/api/media/file/fluent--document-bullet-list-20-regular.svg', '/api/media/file/fluent--document-bullet-list-20-regular.svg', 'fluent--document-bullet-list-20-regular.svg', 'image/svg+xml', '648', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (134, 'visitor-evisitor-mockup-asset', '2026-06-19T01:01:31.482Z', '2026-06-19T01:01:31.482Z', '/api/media/file/visitor-evisitor-mockup.png', '/api/media/file/visitor-evisitor-mockup-400x300.png', 'visitor-evisitor-mockup.png', 'image/png', '8650785', '3000', '2000', '50', '50', '/api/media/file/visitor-evisitor-mockup-400x300.png', '400', '300', 'image/png', '255764', 'visitor-evisitor-mockup-400x300.png', '/api/media/file/visitor-evisitor-mockup-1920x1080.png', '1920', '1080', 'image/png', '4124429', 'visitor-evisitor-mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (135, 'qr-evisitor-mockup-asset', '2026-06-19T01:26:12.483Z', '2026-06-19T01:26:12.483Z', '/api/media/file/qr-evisitor-mockup.png', '/api/media/file/qr-evisitor-mockup-400x300.png', 'qr-evisitor-mockup.png', 'image/png', '12755135', '4500', '3000', '50', '50', '/api/media/file/qr-evisitor-mockup-400x300.png', '400', '300', 'image/png', '166463', 'qr-evisitor-mockup-400x300.png', '/api/media/file/qr-evisitor-mockup-1920x1080.png', '1920', '1080', 'image/png', '2802764', 'qr-evisitor-mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (138, 'fluent--briefcase-medical-20-regular-icon', '2026-06-19T01:39:13.119Z', '2026-06-19T01:39:13.119Z', '/api/media/file/fluent--briefcase-medical-20-regular.svg', '/api/media/file/fluent--briefcase-medical-20-regular.svg', 'fluent--briefcase-medical-20-regular.svg', 'image/svg+xml', '574', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (140, 'citadel-life-safety-K4dBR3TiH4U-unsplash-asset', '2026-06-19T03:06:05.629Z', '2026-06-19T03:06:05.629Z', '/api/media/file/citadel-life-safety-K4dBR3TiH4U-unsplash.jpg', '/api/media/file/citadel-life-safety-K4dBR3TiH4U-unsplash-400x300.jpg', 'citadel-life-safety-K4dBR3TiH4U-unsplash.jpg', 'image/jpeg', '223234', '2400', '1309', '50', '50', '/api/media/file/citadel-life-safety-K4dBR3TiH4U-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '13085', 'citadel-life-safety-K4dBR3TiH4U-unsplash-400x300.jpg', '/api/media/file/citadel-life-safety-K4dBR3TiH4U-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '101290', 'citadel-life-safety-K4dBR3TiH4U-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (141, 'jakub-zerdzicki-Wut0F41K9ZU-unsplash', '2026-06-19T03:07:02.443Z', '2026-06-19T03:07:02.443Z', '/api/media/file/jakub-zerdzicki-Wut0F41K9ZU-unsplash.jpg', '/api/media/file/jakub-zerdzicki-Wut0F41K9ZU-unsplash-400x300.jpg', 'jakub-zerdzicki-Wut0F41K9ZU-unsplash.jpg', 'image/jpeg', '232229', '2400', '1587', '50', '50', '/api/media/file/jakub-zerdzicki-Wut0F41K9ZU-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '10923', 'jakub-zerdzicki-Wut0F41K9ZU-unsplash-400x300.jpg', '/api/media/file/jakub-zerdzicki-Wut0F41K9ZU-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '102302', 'jakub-zerdzicki-Wut0F41K9ZU-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (142, 'fluent--branch-fork-hint-20-regular-icon', '2026-06-19T03:15:38.998Z', '2026-06-19T03:13:52.145Z', '/api/media/file/fluent--branch-fork-hint-20-regular (1).svg', '/api/media/file/fluent--branch-fork-hint-20-regular (1).svg', 'fluent--branch-fork-hint-20-regular (1).svg', 'image/svg+xml', '752', '34', '34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (143, 'fluent--branch-fork-hint-24-regular-icon', '2026-06-19T03:16:43.529Z', '2026-06-19T03:16:43.529Z', '/api/media/file/fluent--branch-fork-hint-24-regular.svg', '/api/media/file/fluent--branch-fork-hint-24-regular.svg', 'fluent--branch-fork-hint-24-regular.svg', 'image/svg+xml', '811', '34', '34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (244, 'Pusat Pemantauan & Otomatisasi Operasional Jaringan Cerdas', '2026-10-02T01:30:36.437Z', '2026-10-02T01:30:31.304Z', '/api/media/file/Pusat Pemantauan & Otomatisasi Operasional Jaringan Cerdas.webp', '/api/media/file/Pusat%20Pemantauan%20%26%20Otomatisasi%20Operasional%20Jaringan%20Cerdas-400x300.webp', 'Pusat Pemantauan & Otomatisasi Operasional Jaringan Cerdas.webp', 'image/webp', '99652', '1376', '768', '50', '50', '/api/media/file/Pusat Pemantauan & Otomatisasi Operasional Jaringan Cerdas-400x300.webp', '400', '300', 'image/webp', '27572', 'Pusat Pemantauan & Otomatisasi Operasional Jaringan Cerdas-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pusat Pemantauan & Otomatisasi Operasional Jaringan Cerdas-800x600.webp', '800', '600', 'image/webp', '66870', 'Pusat Pemantauan & Otomatisasi Operasional Jaringan Cerdas-800x600.webp'),
  (83, 'Tampak Depan Kantor', '2026-06-04T02:33:06.790Z', '2026-06-04T02:22:32.984Z', '/api/media/file/ChatGPT Image Jun 4, 2026, 09_21_48 AM.png', '/api/media/file/ChatGPT Image Jun 4, 2026, 09_21_48 AM-400x300.png', 'ChatGPT Image Jun 4, 2026, 09_21_48 AM.png', 'image/png', '2230870', '1000', '1000', '50', '50', '/api/media/file/ChatGPT Image Jun 4, 2026, 09_21_48 AM-400x300.png', '400', '300', 'image/png', '296374', 'ChatGPT Image Jun 4, 2026, 09_21_48 AM-400x300.png', '/api/media/file/ChatGPT%20Image%20Jun%204%2C%202026%2C%2009_21_48%20AM-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (118, 'payroll', '2026-06-18T06:39:49.470Z', '2026-06-18T06:39:49.470Z', '/api/media/file/fluent--money-hand-16-regular.svg', '/api/media/file/fluent--money-hand-16-regular.svg', 'fluent--money-hand-16-regular.svg', 'image/svg+xml', '1060', '38', '38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (129, 'ess_mockup_asset', '2026-06-18T08:33:44.199Z', '2026-06-18T08:33:44.199Z', '/api/media/file/ess_mockup.png', '/api/media/file/ess_mockup-400x300.png', 'ess_mockup.png', 'image/png', '5100225', '3000', '2000', '50', '50', '/api/media/file/ess_mockup-400x300.png', '400', '300', 'image/png', '232298', 'ess_mockup-400x300.png', '/api/media/file/ess_mockup-1920x1080.png', '1920', '1080', 'image/png', '3219057', 'ess_mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (145, 'fluent--shield-task-24-regular-icon', '2026-06-19T03:20:04.943Z', '2026-06-19T03:20:04.943Z', '/api/media/file/fluent--shield-task-24-regular.svg', '/api/media/file/fluent--shield-task-24-regular.svg', 'fluent--shield-task-24-regular.svg', 'image/svg+xml', '620', '34', '34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (146, 'fluent--wrench-settings-24-regular-icon', '2026-06-19T03:21:34.379Z', '2026-06-19T03:21:34.378Z', '/api/media/file/fluent--wrench-settings-24-regular.svg', '/api/media/file/fluent--wrench-settings-24-regular.svg', 'fluent--wrench-settings-24-regular.svg', 'image/svg+xml', '1141', '34', '34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (151, 'growtika-WELyMatW3mw-unsplash-asset', '2026-06-19T03:32:38.836Z', '2026-06-19T03:32:38.836Z', '/api/media/file/growtika-WELyMatW3mw-unsplash.jpg', '/api/media/file/growtika-WELyMatW3mw-unsplash-400x300.jpg', 'growtika-WELyMatW3mw-unsplash.jpg', 'image/jpeg', '188421', '2400', '1350', '50', '50', '/api/media/file/growtika-WELyMatW3mw-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '13756', 'growtika-WELyMatW3mw-unsplash-400x300.jpg', '/api/media/file/growtika-WELyMatW3mw-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '98774', 'growtika-WELyMatW3mw-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (152, 'fluent--money-hand-20-regular-icon', '2026-06-19T03:45:44.138Z', '2026-06-19T03:45:44.138Z', '/api/media/file/fluent--money-hand-20-regular.svg', '/api/media/file/fluent--money-hand-20-regular.svg', 'fluent--money-hand-20-regular.svg', 'image/svg+xml', '1245', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (155, 'communication-flat-icon-asset', '2026-06-20T03:57:55.817Z', '2026-06-20T03:57:55.817Z', '/api/media/file/communication-flat-icon.png', '/api/media/file/communication-flat-icon-400x300.png', 'communication-flat-icon.png', 'image/png', '846317', '2000', '1560', '50', '50', '/api/media/file/communication-flat-icon-400x300.png', '400', '300', 'image/png', '67656', 'communication-flat-icon-400x300.png', '/api/media/file/communication-flat-icon-1920x1080.png', '1920', '1080', 'image/png', '831828', 'communication-flat-icon-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (183, 'BIT-HRIS-Kelola-Absensi-Shift-2K', '2026-08-24T08:47:37.794Z', '2026-08-24T08:47:37.794Z', '/api/media/file/BIT-HRIS-Kelola-Absensi-Shift-2K.jpeg', '/api/media/file/BIT-HRIS-Kelola-Absensi-Shift-2K-400x300.jpg', 'BIT-HRIS-Kelola-Absensi-Shift-2K.jpeg', 'image/jpeg', '987765', '2560', '1710', '50', '50', '/api/media/file/BIT-HRIS-Kelola-Absensi-Shift-2K-400x300.jpg', '400', '300', 'image/jpeg', '31252', 'BIT-HRIS-Kelola-Absensi-Shift-2K-400x300.jpg', '/api/media/file/BIT-HRIS-Kelola-Absensi-Shift-2K-1920x1080.jpg', '1920', '1080', 'image/jpeg', '229022', 'BIT-HRIS-Kelola-Absensi-Shift-2K-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (13, 'software-dev-hero-asset', '2026-05-18T03:18:40.880Z', '2026-05-18T03:18:40.880Z', '/api/media/file/software-dev-hero.png', '/api/media/file/software-dev-hero.png', 'software-dev-hero.png', 'image/png', '2524200', '4096', '3413', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (73, 'ERP', '2026-06-03T02:12:07.294Z', '2026-06-03T02:12:07.294Z', '/api/media/file/Gemini_Generated_Image_n5ud0hn5ud0hn5ud.png', '/api/media/file/Gemini_Generated_Image_n5ud0hn5ud0hn5ud-400x300.png', 'Gemini_Generated_Image_n5ud0hn5ud0hn5ud.png', 'image/png', '6597793', '2834', '1472', '50', '50', '/api/media/file/Gemini_Generated_Image_n5ud0hn5ud0hn5ud-400x300.png', '400', '300', 'image/png', '264852', 'Gemini_Generated_Image_n5ud0hn5ud0hn5ud-400x300.png', '/api/media/file/Gemini_Generated_Image_n5ud0hn5ud0hn5ud-1920x1080.png', '1920', '1080', 'image/png', '4121367', 'Gemini_Generated_Image_n5ud0hn5ud0hn5ud-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (148, 'fluent--cloud-dismiss-20-regular-icon', '2026-06-19T03:27:17.752Z', '2026-06-19T03:27:17.751Z', '/api/media/file/fluent--cloud-dismiss-20-regular.svg', '/api/media/file/fluent--cloud-dismiss-20-regular.svg', 'fluent--cloud-dismiss-20-regular.svg', 'image/svg+xml', '816', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (149, 'fluent--clock-dismiss-20-regular-icon', '2026-06-19T03:28:48.181Z', '2026-06-19T03:28:48.181Z', '/api/media/file/fluent--clock-dismiss-20-regular.svg', '/api/media/file/fluent--clock-dismiss-20-regular.svg', 'fluent--clock-dismiss-20-regular.svg', 'image/svg+xml', '617', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (150, 'fluent--document-text-clock-20-regular-icon', '2026-06-19T03:29:40.022Z', '2026-06-19T03:29:40.021Z', '/api/media/file/fluent--document-text-clock-20-regular.svg', '/api/media/file/fluent--document-text-clock-20-regular.svg', 'fluent--document-text-clock-20-regular.svg', 'image/svg+xml', '677', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (156, 'fluent--arrow-trending-down-24-regular-icon', '2026-06-20T04:03:09.408Z', '2026-06-20T04:03:09.407Z', '/api/media/file/fluent--arrow-trending-down-24-regular.svg', '/api/media/file/fluent--arrow-trending-down-24-regular.svg', 'fluent--arrow-trending-down-24-regular.svg', 'image/svg+xml', '556', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (157, 'fluent--arrow-trending-down-24-regular-icon', '2026-06-20T04:05:21.228Z', '2026-06-20T04:05:21.228Z', '/api/media/file/fluent--arrow-trending-down-24-regular-1.svg', '/api/media/file/fluent--arrow-trending-down-24-regular-1.svg', 'fluent--arrow-trending-down-24-regular-1.svg', 'image/svg+xml', '556', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (159, 'fluent--money-dismiss-24-regular-icon', '2026-06-20T04:08:18.881Z', '2026-06-20T04:08:18.881Z', '/api/media/file/fluent--money-dismiss-24-regular.svg', '/api/media/file/fluent--money-dismiss-24-regular.svg', 'fluent--money-dismiss-24-regular.svg', 'image/svg+xml', '1031', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (162, '11668583_20945597-asset', '2026-06-20T04:20:41.238Z', '2026-06-20T04:20:41.238Z', '/api/media/file/11668583_20945597.jpg', '/api/media/file/11668583_20945597-400x300.jpg', '11668583_20945597.jpg', 'image/jpeg', '2331376', '7730', '7730', '50', '50', '/api/media/file/11668583_20945597-400x300.jpg', '400', '300', 'image/jpeg', '14143', '11668583_20945597-400x300.jpg', '/api/media/file/11668583_20945597-1920x1080.jpg', '1920', '1080', 'image/jpeg', '85415', '11668583_20945597-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (163, 'fluent--bug-24-regular-icon', '2026-06-20T04:26:28.136Z', '2026-06-20T04:26:28.136Z', '/api/media/file/fluent--bug-24-regular.svg', '/api/media/file/fluent--bug-24-regular.svg', 'fluent--bug-24-regular.svg', 'image/svg+xml', '975', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (164, 'fluent--cellular-data-unavailable-24-regular', '2026-06-20T06:13:00.402Z', '2026-06-20T06:13:00.402Z', '/api/media/file/fluent--cellular-data-unavailable-24-regular.svg', '/api/media/file/fluent--cellular-data-unavailable-24-regular.svg', 'fluent--cellular-data-unavailable-24-regular.svg', 'image/svg+xml', '916', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (165, 'fluent--text-bullet-list-square-warning-24-regular', '2026-06-20T06:14:21.838Z', '2026-06-20T06:14:21.838Z', '/api/media/file/fluent--text-bullet-list-square-warning-24-regular.svg', '/api/media/file/fluent--text-bullet-list-square-warning-24-regular.svg', 'fluent--text-bullet-list-square-warning-24-regular.svg', 'image/svg+xml', '903', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (167, 'microsoft-copilot-pEVjp7yIc2A-unsplash', '2026-06-20T06:18:24.158Z', '2026-06-20T06:18:24.158Z', '/api/media/file/microsoft-copilot-pEVjp7yIc2A-unsplash.jpg', '/api/media/file/microsoft-copilot-pEVjp7yIc2A-unsplash-400x300.jpg', 'microsoft-copilot-pEVjp7yIc2A-unsplash.jpg', 'image/jpeg', '802028', '2400', '3598', '50', '50', '/api/media/file/microsoft-copilot-pEVjp7yIc2A-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '22122', 'microsoft-copilot-pEVjp7yIc2A-unsplash-400x300.jpg', '/api/media/file/microsoft-copilot-pEVjp7yIc2A-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '185813', 'microsoft-copilot-pEVjp7yIc2A-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (169, 'fluent--timer-20-regular-icon', '2026-06-20T06:22:52.294Z', '2026-06-20T06:22:52.294Z', '/api/media/file/fluent--timer-20-regular.svg', '/api/media/file/fluent--timer-20-regular.svg', 'fluent--timer-20-regular.svg', 'image/svg+xml', '394', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (170, 'fluent--task-list-square-20-regular-icon', '2026-06-20T06:23:29.392Z', '2026-06-20T06:23:29.391Z', '/api/media/file/fluent--task-list-square-20-regular.svg', '/api/media/file/fluent--task-list-square-20-regular.svg', 'fluent--task-list-square-20-regular.svg', 'image/svg+xml', '631', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (171, '11668822_20945385-asset', '2026-06-20T06:25:17.822Z', '2026-06-20T06:25:17.822Z', '/api/media/file/11668822_20945385.jpg', '/api/media/file/11668822_20945385-400x300.jpg', '11668822_20945385.jpg', 'image/jpeg', '2887075', '7730', '7730', '50', '50', '/api/media/file/11668822_20945385-400x300.jpg', '400', '300', 'image/jpeg', '17710', '11668822_20945385-400x300.jpg', '/api/media/file/11668822_20945385-1920x1080.jpg', '1920', '1080', 'image/jpeg', '104952', '11668822_20945385-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (172, 'fluent--clock-warning-24-regular-icon', '2026-06-20T06:26:12.141Z', '2026-06-20T06:26:12.141Z', '/api/media/file/fluent--clock-warning-24-regular.svg', '/api/media/file/fluent--clock-warning-24-regular.svg', 'fluent--clock-warning-24-regular.svg', 'image/svg+xml', '711', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (104, 'fluent--heart-pulse-20-regular-icon', '2026-06-08T00:58:40.273Z', '2026-06-08T00:58:40.273Z', '/api/media/file/fluent--heart-pulse-20-regular.svg', '/api/media/file/fluent--heart-pulse-20-regular.svg', 'fluent--heart-pulse-20-regular.svg', 'image/svg+xml', '863', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (245, 'Platform Analitik Pengalaman & Kepuasan Pelanggan', '2026-10-02T01:36:42.751Z', '2026-10-02T01:36:41.682Z', '/api/media/file/Platform Analitik Pengalaman & Kepuasan Pelanggan.webp', '/api/media/file/Platform%20Analitik%20Pengalaman%20%26%20Kepuasan%20Pelanggan-400x300.webp', 'Platform Analitik Pengalaman & Kepuasan Pelanggan.webp', 'image/webp', '89688', '1376', '768', '50', '50', '/api/media/file/Platform Analitik Pengalaman & Kepuasan Pelanggan-400x300.webp', '400', '300', 'image/webp', '23186', 'Platform Analitik Pengalaman & Kepuasan Pelanggan-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Platform Analitik Pengalaman & Kepuasan Pelanggan-800x600.webp', '800', '600', 'image/webp', '56098', 'Platform Analitik Pengalaman & Kepuasan Pelanggan-800x600.webp');
INSERT INTO "media" ("id", "alt", "updated_at", "created_at", "url", "thumbnail_u_r_l", "filename", "mime_type", "filesize", "width", "height", "focal_x", "focal_y", "sizes_thumbnail_url", "sizes_thumbnail_width", "sizes_thumbnail_height", "sizes_thumbnail_mime_type", "sizes_thumbnail_filesize", "sizes_thumbnail_filename", "sizes_hero_url", "sizes_hero_width", "sizes_hero_height", "sizes_hero_mime_type", "sizes_hero_filesize", "sizes_hero_filename", "sizes_card_url", "sizes_card_width", "sizes_card_height", "sizes_card_mime_type", "sizes_card_filesize", "sizes_card_filename") VALUES
  (173, 'fluent--tab-shield-dismiss-24-regular-icon', '2026-06-20T06:27:24.701Z', '2026-06-20T06:27:24.701Z', '/api/media/file/fluent--tab-shield-dismiss-24-regular.svg', '/api/media/file/fluent--tab-shield-dismiss-24-regular.svg', 'fluent--tab-shield-dismiss-24-regular.svg', 'image/svg+xml', '1034', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (110, 'apple-seeklogo-logo', '2026-06-18T03:49:05.352Z', '2026-06-18T03:49:05.352Z', '/api/media/file/apple-seeklogo.png', '/api/media/file/apple-seeklogo-400x300.png', 'apple-seeklogo.png', 'image/png', '25466', '1630', '2000', '50', '50', '/api/media/file/apple-seeklogo-400x300.png', '400', '300', 'image/png', '10766', 'apple-seeklogo-400x300.png', '/api/media/file/apple-seeklogo-1920x1080.png', '1920', '1080', 'image/png', '70614', 'apple-seeklogo-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (147, 'employee-working-office-interior-workplace-flat-vector-illustration-asset', '2026-06-19T03:24:37.214Z', '2026-06-19T03:24:37.214Z', '/api/media/file/employee-working-office-interior-workplace-flat-vector-illustration.png', '/api/media/file/employee-working-office-interior-workplace-flat-vector-illustration-400x300.png', 'employee-working-office-interior-workplace-flat-vector-illustration.png', 'image/png', '1044838', '2000', '2000', '50', '50', '/api/media/file/employee-working-office-interior-workplace-flat-vector-illustration-400x300.png', '400', '300', 'image/png', '69074', 'employee-working-office-interior-workplace-flat-vector-illustration-400x300.png', '/api/media/file/employee-working-office-interior-workplace-flat-vector-illustration-1920x1080.png', '1920', '1080', 'image/png', '706499', 'employee-working-office-interior-workplace-flat-vector-illustration-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (191, 'Gemini_Generated_Image_ru1fburu1fburu1f', '2026-09-25T03:39:51.925Z', '2026-09-25T03:39:51.389Z', '/api/media/file/Gemini_Generated_Image_ru1fburu1fburu1f.webp', '/api/media/file/Gemini_Generated_Image_ru1fburu1fburu1f-400x300.webp', 'Gemini_Generated_Image_ru1fburu1fburu1f.webp', 'image/webp', '189426', '2400', '1792', '50', '50', '/api/media/file/Gemini_Generated_Image_ru1fburu1fburu1f-400x300.webp', '400', '300', 'image/webp', '21584', 'Gemini_Generated_Image_ru1fburu1fburu1f-400x300.webp', '/api/media/file/Gemini_Generated_Image_ru1fburu1fburu1f-1920x1080.webp', '1920', '1080', 'image/webp', '118344', 'Gemini_Generated_Image_ru1fburu1fburu1f-1920x1080.webp', '/api/media/file/Gemini_Generated_Image_ru1fburu1fburu1f-800x600.webp', '800', '600', 'image/webp', '47984', 'Gemini_Generated_Image_ru1fburu1fburu1f-800x600.webp'),
  (192, 'Untitled (1920 x 1080 px)', '2026-09-25T03:40:58.199Z', '2026-09-25T03:40:57.867Z', '/api/media/file/Untitled (1920 x 1080 px).webp', '/api/media/file/Untitled%20(1920%20x%201080%20px)-400x300.webp', 'Untitled (1920 x 1080 px).webp', 'image/webp', '51662', '1920', '1080', '50', '50', '/api/media/file/Untitled (1920 x 1080 px)-400x300.webp', '400', '300', 'image/webp', '9124', 'Untitled (1920 x 1080 px)-400x300.webp', '/api/media/file/Untitled (1920 x 1080 px)-1920x1080.webp', '1920', '1080', 'image/webp', '51662', 'Untitled (1920 x 1080 px)-1920x1080.webp', '/api/media/file/Untitled (1920 x 1080 px)-800x600.webp', '800', '600', 'image/webp', '21786', 'Untitled (1920 x 1080 px)-800x600.webp'),
  (194, 'Gemini_Generated_Image_xxox3exxox3exxox', '2026-09-25T03:42:43.718Z', '2026-09-25T03:42:43.176Z', '/api/media/file/Gemini_Generated_Image_xxox3exxox3exxox.webp', '/api/media/file/Gemini_Generated_Image_xxox3exxox3exxox-400x300.webp', 'Gemini_Generated_Image_xxox3exxox3exxox.webp', 'image/webp', '201998', '2560', '1429', '50', '50', '/api/media/file/Gemini_Generated_Image_xxox3exxox3exxox-400x300.webp', '400', '300', 'image/webp', '21570', 'Gemini_Generated_Image_xxox3exxox3exxox-400x300.webp', '/api/media/file/Gemini_Generated_Image_xxox3exxox3exxox-1920x1080.webp', '1920', '1080', 'image/webp', '143488', 'Gemini_Generated_Image_xxox3exxox3exxox-1920x1080.webp', '/api/media/file/Gemini_Generated_Image_xxox3exxox3exxox-800x600.webp', '800', '600', 'image/webp', '52994', 'Gemini_Generated_Image_xxox3exxox3exxox-800x600.webp'),
  (196, 'Untitled (1920 x 1080 px) (2)', '2026-09-25T06:38:35.997Z', '2026-09-25T06:38:35.256Z', '/api/media/file/Untitled (1920 x 1080 px) (2).webp', '/api/media/file/Untitled%20(1920%20x%201080%20px)%20(2)-400x300.webp', 'Untitled (1920 x 1080 px) (2).webp', 'image/webp', '115900', '1920', '1080', '50', '50', '/api/media/file/Untitled (1920 x 1080 px) (2)-400x300.webp', '400', '300', 'image/webp', '19258', 'Untitled (1920 x 1080 px) (2)-400x300.webp', '/api/media/file/Untitled (1920 x 1080 px) (2)-1920x1080.webp', '1920', '1080', 'image/webp', '115900', 'Untitled (1920 x 1080 px) (2)-1920x1080.webp', '/api/media/file/Untitled (1920 x 1080 px) (2)-800x600.webp', '800', '600', 'image/webp', '45518', 'Untitled (1920 x 1080 px) (2)-800x600.webp'),
  (1, 'tbina-logo', '2026-05-18T01:29:33.482Z', '2026-05-18T01:29:33.482Z', '/api/media/file/tbina.png', '/api/media/file/tbina.png', 'tbina.png', 'image/png', '46265', '390', '120', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (2, 'bonecom-logo', '2026-05-18T01:32:38.213Z', '2026-05-18T01:32:38.213Z', '/api/media/file/bonecom.png', '/api/media/file/bonecom.png', 'bonecom.png', 'image/png', '15301', '400', '120', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (3, 'bonecom-paintech-logo', '2026-05-18T01:34:49.225Z', '2026-05-18T01:34:49.225Z', '/api/media/file/bonecom-paintech.png', '/api/media/file/bonecom-paintech.png', 'bonecom-paintech.png', 'image/png', '17666', '400', '120', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (6, 'rmp-logo', '2026-05-18T01:36:21.606Z', '2026-05-18T01:36:21.606Z', '/api/media/file/rmp.png', '/api/media/file/rmp.png', 'rmp.png', 'image/png', '21068', '390', '120', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (8, 'dell-logo', '2026-05-18T02:04:50.718Z', '2026-05-18T02:04:50.718Z', '/api/media/file/dell.png', '/api/media/file/dell.png', 'dell.png', 'image/png', '4718', '144', '144', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (176, 'tdps_tbina-asset', '2026-06-22T06:07:19.816Z', '2026-06-22T06:07:19.816Z', '/api/media/file/tdps_tbina.png', '/api/media/file/tdps_tbina-400x300.png', 'tdps_tbina.png', 'image/png', '11958072', '4096', '2731', '50', '50', '/api/media/file/tdps_tbina-400x300.png', '400', '300', 'image/png', '274625', 'tdps_tbina-400x300.png', '/api/media/file/tdps_tbina-1920x1080.png', '1920', '1080', 'image/png', '4053505', 'tdps_tbina-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (177, 'news-asset-digitalisasi-hr', '2026-08-07T02:56:12.712Z', '2026-08-07T02:56:12.711Z', '/api/media/file/MacBook Pro.png', '/api/media/file/MacBook Pro-400x300.png', 'MacBook Pro.png', 'image/png', '12585752', '4500', '3000', '50', '50', '/api/media/file/MacBook Pro-400x300.png', '400', '300', 'image/png', '273353', 'MacBook Pro-400x300.png', '/api/media/file/MacBook Pro-1920x1080.png', '1920', '1080', 'image/png', '4071799', 'MacBook Pro-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (178, 'digitalisasi-hr-illustration-asset', '2026-08-07T03:09:17.076Z', '2026-08-07T03:09:17.076Z', '/api/media/file/digitalisasi-hr-illustration-asset.jpeg', '/api/media/file/digitalisasi-hr-illustration-asset-400x300.jpg', 'digitalisasi-hr-illustration-asset.jpeg', 'image/jpeg', '132655', '1280', '896', '50', '50', '/api/media/file/digitalisasi-hr-illustration-asset-400x300.jpg', '400', '300', 'image/jpeg', '22585', 'digitalisasi-hr-illustration-asset-400x300.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (180, 'compare-excel-vs-hrms-asset', '2026-08-14T02:40:14.715Z', '2026-08-14T02:40:14.715Z', '/api/media/file/pasted-image.png', '/api/media/file/pasted-image-400x300.png', 'pasted-image.png', 'image/png', '975591', '1194', '796', '50', '50', '/api/media/file/pasted-image-400x300.png', '400', '300', 'image/png', '111527', 'pasted-image-400x300.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (181, 'banyak-karyawan-asset', '2026-08-24T08:34:57.821Z', '2026-08-24T08:34:57.819Z', '/api/media/file/pasted-image.jpeg', '/api/media/file/pasted-image-400x300.jpg', 'pasted-image.jpeg', 'image/jpeg', '228629', '1886', '990', '50', '50', '/api/media/file/pasted-image-400x300.jpg', '400', '300', 'image/jpeg', '28952', 'pasted-image-400x300.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (185, 'banyak-karyawan-banyak-data-asset', '2026-08-24T08:49:49.595Z', '2026-08-24T08:49:49.595Z', '/api/media/file/pasted-image-1.jpeg', '/api/media/file/pasted-image-1-400x300.jpg', 'pasted-image-1.jpeg', 'image/jpeg', '221241', '1886', '989', '50', '50', '/api/media/file/pasted-image-1-400x300.jpg', '400', '300', 'image/jpeg', '27018', 'pasted-image-1-400x300.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (186, 'BIT-HRIS-Pekerjaan-HR-Manufaktur-2K', '2026-08-24T09:08:06.700Z', '2026-08-24T09:08:06.700Z', '/api/media/file/BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-1.jpeg', '/api/media/file/BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-1-400x300.jpg', 'BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-1.jpeg', 'image/jpeg', '936112', '2560', '1600', '50', '50', '/api/media/file/BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-1-400x300.jpg', '400', '300', 'image/jpeg', '30027', 'BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-1-400x300.jpg', '/api/media/file/BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-1-1920x1080.jpg', '1920', '1080', 'image/jpeg', '241982', 'BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-1-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (188, 'bonecom-protfolio-asset', '2026-09-09T01:50:34.709Z', '2026-09-09T01:50:34.708Z', '/api/media/file/Gemini_Generated_Image_n5ud0hn5ud0hn5ud.webp', '/api/media/file/Gemini_Generated_Image_n5ud0hn5ud0hn5ud-400x300.webp', 'Gemini_Generated_Image_n5ud0hn5ud0hn5ud.webp', 'image/webp', '209244', '2560', '1330', '50', '50', '/api/media/file/Gemini_Generated_Image_n5ud0hn5ud0hn5ud-400x300.webp', '400', '300', 'image/webp', '20608', 'Gemini_Generated_Image_n5ud0hn5ud0hn5ud-400x300.webp', '/api/media/file/Gemini_Generated_Image_n5ud0hn5ud0hn5ud-1920x1080.webp', '1920', '1080', 'image/webp', '160040', 'Gemini_Generated_Image_n5ud0hn5ud0hn5ud-1920x1080.webp', '/api/media/file/Gemini_Generated_Image_n5ud0hn5ud0hn5ud-800x600.webp', '800', '600', 'image/webp', '59978', 'Gemini_Generated_Image_n5ud0hn5ud0hn5ud-800x600.webp'),
  (233, 'Pendeteksi Kecurangan E-Commerce', '2026-10-01T06:33:36.528Z', '2026-10-01T06:33:35.880Z', '/api/media/file/Pendeteksi Kecurangan E-Commerce.webp', '/api/media/file/Pendeteksi%20Kecurangan%20E-Commerce-400x300.webp', 'Pendeteksi Kecurangan E-Commerce.webp', 'image/webp', '84890', '1376', '768', '50', '50', '/api/media/file/Pendeteksi Kecurangan E-Commerce-400x300.webp', '400', '300', 'image/webp', '24434', 'Pendeteksi Kecurangan E-Commerce-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pendeteksi Kecurangan E-Commerce-800x600.webp', '800', '600', 'image/webp', '56090', 'Pendeteksi Kecurangan E-Commerce-800x600.webp'),
  (246, 'Platform Komunikasi & Kolaborasi Kerja', '2026-10-02T01:37:13.046Z', '2026-10-02T01:37:12.767Z', '/api/media/file/Platform Komunikasi & Kolaborasi Kerja.webp', '/api/media/file/Platform%20Komunikasi%20%26%20Kolaborasi%20Kerja-400x300.webp', 'Platform Komunikasi & Kolaborasi Kerja.webp', 'image/webp', '110128', '1376', '768', '50', '50', '/api/media/file/Platform Komunikasi & Kolaborasi Kerja-400x300.webp', '400', '300', 'image/webp', '28140', 'Platform Komunikasi & Kolaborasi Kerja-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Platform Komunikasi & Kolaborasi Kerja-800x600.webp', '800', '600', 'image/webp', '68964', 'Platform Komunikasi & Kolaborasi Kerja-800x600.webp'),
  (10, 'huawei-logo', '2026-05-18T02:09:16.650Z', '2026-05-18T02:09:16.650Z', '/api/media/file/huawei.png', '/api/media/file/huawei.png', 'huawei.png', 'image/png', '20539', '144', '144', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (12, 'mirai-white-logo', '2026-05-18T02:12:04.047Z', '2026-05-18T02:12:04.047Z', '/api/media/file/mirai-white.png', '/api/media/file/mirai-white.png', 'mirai-white.png', 'image/png', '26065', '402', '140', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (15, 'plug-disconnected-24-regular', '2026-05-18T03:34:42.737Z', '2026-05-18T03:34:42.737Z', '/api/media/file/plug-disconnected-24-regular.svg', '/api/media/file/plug-disconnected-24-regular.svg', 'plug-disconnected-24-regular.svg', 'image/svg+xml', '3438', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (18, 'target-arrow-20-regular', '2026-05-18T03:41:35.351Z', '2026-05-18T03:41:35.351Z', '/api/media/file/target-arrow-20-regular.svg', '/api/media/file/target-arrow-20-regular.svg', 'target-arrow-20-regular.svg', 'image/svg+xml', '3020', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (20, 'beaker-20-regular', '2026-05-18T03:49:14.528Z', '2026-05-18T03:49:14.527Z', '/api/media/file/beaker-20-regular.svg', '/api/media/file/beaker-20-regular.svg', 'beaker-20-regular.svg', 'image/svg+xml', '1696', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (22, 'bit-hrms-mockup-asset', '2026-05-18T04:18:24.299Z', '2026-05-18T04:18:24.299Z', '/api/media/file/bit-hrms-mockup.png', '/api/media/file/bit-hrms-mockup.png', 'bit-hrms-mockup.png', 'image/png', '15238428', '4096', '2731', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (24, 'appstore-button', '2026-05-18T06:27:16.048Z', '2026-05-18T06:27:16.048Z', '/api/media/file/appstore-button.svg', '/api/media/file/appstore-button.svg', 'appstore-button.svg', 'image/svg+xml', '15143', '129', '46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (26, 'location-24-regular', '2026-05-18T06:42:58.314Z', '2026-05-18T06:42:58.314Z', '/api/media/file/location-24-regular.svg', '/api/media/file/location-24-regular.svg', 'location-24-regular.svg', 'image/svg+xml', '1612', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (28, 'app-generic-20-regular', '2026-05-18T06:47:06.057Z', '2026-05-18T06:47:06.057Z', '/api/media/file/app-generic-20-regular.svg', '/api/media/file/app-generic-20-regular.svg', 'app-generic-20-regular.svg', 'image/svg+xml', '2012', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (30, 'main-hero-asset', '2026-05-18T07:08:11.792Z', '2026-05-18T07:08:11.792Z', '/api/media/file/main-hero.png', '/api/media/file/main-hero.png', 'main-hero.png', 'image/png', '2094247', '4096', '3414', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (32, 'chart-dashboard', '2026-05-19T03:14:40.805Z', '2026-05-19T03:14:40.804Z', '/api/media/file/chart-dashboard.svg', '/api/media/file/chart-dashboard.svg', 'chart-dashboard.svg', 'image/svg+xml', '2418', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (34, 'chart-person-24-regular', '2026-05-19T03:24:05.072Z', '2026-05-19T03:24:05.071Z', '/api/media/file/chart-person-24-regular.svg', '/api/media/file/chart-person-24-regular.svg', 'chart-person-24-regular.svg', 'image/svg+xml', '2558', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (36, 'code-block-edit-24-regular', '2026-05-19T07:00:48.386Z', '2026-05-19T07:00:48.385Z', '/api/media/file/code-block-edit-24-regular.svg', '/api/media/file/code-block-edit-24-regular.svg', 'code-block-edit-24-regular.svg', 'image/svg+xml', '2897', '34', '34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (39, 'section-service-3-asset', '2026-05-19T07:08:55.455Z', '2026-05-19T07:08:55.455Z', '/api/media/file/section-service-3.png', '/api/media/file/section-service-3.png', 'section-service-3.png', 'image/png', '9269930', '4096', '2731', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (41, 'laravel-logo', '2026-05-19T07:15:05.210Z', '2026-05-19T07:15:05.210Z', '/api/media/file/laravel-logo.png', '/api/media/file/laravel-logo.png', 'laravel-logo.png', 'image/png', '27781', '2000', '551', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (43, 'nextjs-logo', '2026-05-19T07:15:35.338Z', '2026-05-19T07:15:35.338Z', '/api/media/file/nextjs-logo.png', '/api/media/file/nextjs-logo.png', 'nextjs-logo.png', 'image/png', '18272', '2000', '404', '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (45, 'puzzle-cube-piece-20-regular', '2026-05-19T07:26:33.895Z', '2026-05-19T07:26:33.895Z', '/api/media/file/puzzle-cube-piece-20-regular.svg', '/api/media/file/puzzle-cube-piece-20-regular.svg', 'puzzle-cube-piece-20-regular.svg', 'image/svg+xml', '1939', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (72, 'fluent--book-database-20-regular', '2026-06-05T09:29:28.709Z', '2026-06-03T01:44:26.399Z', '/api/media/file/fluent--book-database-20-regular.svg', '/api/media/file/fluent--book-database-20-regular.svg', 'fluent--book-database-20-regular.svg', 'image/svg+xml', '696', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (99, 'fluent--handshake-20-regular-icon', '2026-06-08T00:55:17.018Z', '2026-06-08T00:55:17.018Z', '/api/media/file/fluent--handshake-20-regular-1.svg', '/api/media/file/fluent--handshake-20-regular-1.svg', 'fluent--handshake-20-regular-1.svg', 'image/svg+xml', '2314', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (101, 'fluent--people-community-20-regular-icon', '2026-06-08T00:55:53.395Z', '2026-06-08T00:55:53.395Z', '/api/media/file/fluent--people-community-20-regular-1.svg', '/api/media/file/fluent--people-community-20-regular-1.svg', 'fluent--people-community-20-regular-1.svg', 'image/svg+xml', '894', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (106, 'fluent--building-20-regular-icon', '2026-06-08T00:59:18.168Z', '2026-06-08T00:59:18.168Z', '/api/media/file/fluent--building-20-regular.svg', '/api/media/file/fluent--building-20-regular.svg', 'fluent--building-20-regular.svg', 'image/svg+xml', '777', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (112, 'web-site-www-icon-seeklogo-logo', '2026-06-18T03:49:43.128Z', '2026-06-18T03:49:43.128Z', '/api/media/file/web-site-www-icon-seeklogo.png', '/api/media/file/web-site-www-icon-seeklogo-400x300.png', 'web-site-www-icon-seeklogo.png', 'image/png', '41859', '2000', '1094', '50', '50', '/api/media/file/web-site-www-icon-seeklogo-400x300.png', '400', '300', 'image/png', '14721', 'web-site-www-icon-seeklogo-400x300.png', '/api/media/file/web-site-www-icon-seeklogo-1920x1080.png', '1920', '1080', 'image/png', '100816', 'web-site-www-icon-seeklogo-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (117, 'finger', '2026-06-18T06:38:27.345Z', '2026-06-18T06:38:27.345Z', '/api/media/file/ion--finger-print-outline.svg', '/api/media/file/ion--finger-print-outline.svg', 'ion--finger-print-outline.svg', 'image/svg+xml', '2159', '38', '38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (119, 'self', '2026-06-18T06:42:12.554Z', '2026-06-18T06:42:12.554Z', '/api/media/file/streamline-ultimate--office-employee.svg', '/api/media/file/streamline-ultimate--office-employee.svg', 'streamline-ultimate--office-employee.svg', 'image/svg+xml', '637', '38', '38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (122, 'my-visitors-mockup-assets', '2026-06-18T07:06:44.121Z', '2026-06-18T07:06:44.121Z', '/api/media/file/my-visitors-mockup.png', '/api/media/file/my-visitors-mockup-400x300.png', 'my-visitors-mockup.png', 'image/png', '9668301', '4096', '2731', '50', '50', '/api/media/file/my-visitors-mockup-400x300.png', '400', '300', 'image/png', '246534', 'my-visitors-mockup-400x300.png', '/api/media/file/my-visitors-mockup-1920x1080.png', '1920', '1080', 'image/png', '3395759', 'my-visitors-mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (123, 'attendance_mockup_asset', '2026-06-18T08:04:48.383Z', '2026-06-18T08:04:48.383Z', '/api/media/file/attendance_mockup.png', '/api/media/file/attendance_mockup-400x300.png', 'attendance_mockup.png', 'image/png', '7854358', '4500', '3000', '50', '50', '/api/media/file/attendance_mockup-400x300.png', '400', '300', 'image/png', '157948', 'attendance_mockup-400x300.png', '/api/media/file/attendance_mockup-1920x1080.png', '1920', '1080', 'image/png', '2118085', 'attendance_mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (128, 'auto_payroll_mockup_asset', '2026-06-18T08:25:06.211Z', '2026-06-18T08:25:06.211Z', '/api/media/file/auto_payroll_mockup.png', '/api/media/file/auto_payroll_mockup-400x300.png', 'auto_payroll_mockup.png', 'image/png', '6402390', '3000', '2000', '50', '50', '/api/media/file/auto_payroll_mockup-400x300.png', '400', '300', 'image/png', '204662', 'auto_payroll_mockup-400x300.png', '/api/media/file/auto_payroll_mockup-1920x1080.png', '1920', '1080', 'image/png', '3235580', 'auto_payroll_mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (130, 'mcu_mockup_asset', '2026-06-18T08:36:51.252Z', '2026-06-18T08:36:51.252Z', '/api/media/file/mcu_mockup.png', '/api/media/file/mcu_mockup-400x300.png', 'mcu_mockup.png', 'image/png', '14423174', '4096', '2731', '50', '50', '/api/media/file/mcu_mockup-400x300.png', '400', '300', 'image/png', '186722', 'mcu_mockup-400x300.png', '/api/media/file/mcu_mockup-1920x1080.png', '1920', '1080', 'image/png', '3366576', 'mcu_mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (133, 'dashboard-evisitor-mockup-asset', '2026-06-19T00:56:28.973Z', '2026-06-19T00:56:28.973Z', '/api/media/file/dashboard-evisitor-mockup.png', '/api/media/file/dashboard-evisitor-mockup-400x300.png', 'dashboard-evisitor-mockup.png', 'image/png', '7134710', '3000', '2000', '50', '50', '/api/media/file/dashboard-evisitor-mockup-400x300.png', '400', '300', 'image/png', '287916', 'dashboard-evisitor-mockup-400x300.png', '/api/media/file/dashboard-evisitor-mockup-1920x1080.png', '1920', '1080', 'image/png', '4071753', 'dashboard-evisitor-mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (136, 'report-evisitor-mockup-asset', '2026-06-19T01:29:04.994Z', '2026-06-19T01:29:04.994Z', '/api/media/file/report-evisitor-mockup.png', '/api/media/file/report-evisitor-mockup-400x300.png', 'report-evisitor-mockup.png', 'image/png', '11710596', '4500', '3000', '50', '50', '/api/media/file/report-evisitor-mockup-400x300.png', '400', '300', 'image/png', '221597', 'report-evisitor-mockup-400x300.png', '/api/media/file/report-evisitor-mockup-1920x1080.png', '1920', '1080', 'image/png', '3375964', 'report-evisitor-mockup-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (139, 'kevin-ache-2JJ3wBHu4_0-unsplash-assset', '2026-06-19T03:05:00.275Z', '2026-06-19T03:05:00.275Z', '/api/media/file/kevin-ache-2JJ3wBHu4_0-unsplash.jpg', '/api/media/file/kevin-ache-2JJ3wBHu4_0-unsplash-400x300.jpg', 'kevin-ache-2JJ3wBHu4_0-unsplash.jpg', 'image/jpeg', '540721', '2400', '1600', '50', '50', '/api/media/file/kevin-ache-2JJ3wBHu4_0-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '21904', 'kevin-ache-2JJ3wBHu4_0-unsplash-400x300.jpg', '/api/media/file/kevin-ache-2JJ3wBHu4_0-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '213067', 'kevin-ache-2JJ3wBHu4_0-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (144, 'fluent--phone-laptop-24-regular-icon', '2026-06-19T03:18:34.350Z', '2026-06-19T03:18:34.350Z', '/api/media/file/fluent--phone-laptop-24-regular.svg', '/api/media/file/fluent--phone-laptop-24-regular.svg', 'fluent--phone-laptop-24-regular.svg', 'image/svg+xml', '728', '34', '34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (247, 'Pusat Kendali Keamanan Siber Jaringan', '2026-10-02T01:37:42.627Z', '2026-10-02T01:37:41.564Z', '/api/media/file/Pusat Kendali Keamanan Siber Jaringan.webp', '/api/media/file/Pusat%20Kendali%20Keamanan%20Siber%20Jaringan-400x300.webp', 'Pusat Kendali Keamanan Siber Jaringan.webp', 'image/webp', '119462', '1376', '768', '50', '50', '/api/media/file/Pusat Kendali Keamanan Siber Jaringan-400x300.webp', '400', '300', 'image/webp', '33846', 'Pusat Kendali Keamanan Siber Jaringan-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pusat Kendali Keamanan Siber Jaringan-800x600.webp', '800', '600', 'image/webp', '83486', 'Pusat Kendali Keamanan Siber Jaringan-800x600.webp'),
  (153, 'fluent--arrow-growth-20-regular-icon', '2026-06-19T03:49:50.437Z', '2026-06-19T03:49:50.437Z', '/api/media/file/fluent--arrow-growth-20-regular.svg', '/api/media/file/fluent--arrow-growth-20-regular.svg', 'fluent--arrow-growth-20-regular.svg', 'image/svg+xml', '538', '24', '24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (154, 'e-visitor-logo', '2026-06-19T07:31:22.303Z', '2026-06-19T07:28:31.022Z', '/api/media/file/Untitled-1.png', '/api/media/file/Untitled-1-400x300.png', 'Untitled-1.png', 'image/png', '384654', '1080', '1080', '50', '50', '/api/media/file/Untitled-1-400x300.png', '400', '300', 'image/png', '90046', 'Untitled-1-400x300.png', '/api/media/file/Untitled-1-1920x1080.png', '1920', '1080', 'image/png', '515990', 'Untitled-1-1920x1080.png', NULL, NULL, NULL, NULL, NULL, NULL),
  (158, 'fluent--link-dismiss-24-regular-icon', '2026-06-20T04:06:23.937Z', '2026-06-20T04:06:23.937Z', '/api/media/file/fluent--link-dismiss-24-regular.svg', '/api/media/file/fluent--link-dismiss-24-regular.svg', 'fluent--link-dismiss-24-regular.svg', 'image/svg+xml', '716', '48', '48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (160, 'dell-Gi3iUJ1FwxI-unsplash-asset', '2026-06-20T04:14:23.764Z', '2026-06-20T04:14:23.764Z', '/api/media/file/dell-Gi3iUJ1FwxI-unsplash.jpg', '/api/media/file/dell-Gi3iUJ1FwxI-unsplash-400x300.jpg', 'dell-Gi3iUJ1FwxI-unsplash.jpg', 'image/jpeg', '442445', '2400', '1350', '50', '50', '/api/media/file/dell-Gi3iUJ1FwxI-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '24402', 'dell-Gi3iUJ1FwxI-unsplash-400x300.jpg', '/api/media/file/dell-Gi3iUJ1FwxI-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '217371', 'dell-Gi3iUJ1FwxI-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (161, 'olivier-collet-JMwCe3w7qKk-unsplash-asset', '2026-06-20T04:16:22.775Z', '2026-06-20T04:16:22.775Z', '/api/media/file/olivier-collet-JMwCe3w7qKk-unsplash.jpg', '/api/media/file/olivier-collet-JMwCe3w7qKk-unsplash-400x300.jpg', 'olivier-collet-JMwCe3w7qKk-unsplash.jpg', 'image/jpeg', '618152', '2400', '1800', '50', '50', '/api/media/file/olivier-collet-JMwCe3w7qKk-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '28544', 'olivier-collet-JMwCe3w7qKk-unsplash-400x300.jpg', '/api/media/file/olivier-collet-JMwCe3w7qKk-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '249047', 'olivier-collet-JMwCe3w7qKk-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (166, 'dan-nelson-AvSFPw5Tp68-unsplash-asset', '2026-06-20T06:17:03.190Z', '2026-06-20T06:17:03.190Z', '/api/media/file/dan-nelson-AvSFPw5Tp68-unsplash.jpg', '/api/media/file/dan-nelson-AvSFPw5Tp68-unsplash-400x300.jpg', 'dan-nelson-AvSFPw5Tp68-unsplash.jpg', 'image/jpeg', '386840', '2400', '1352', '50', '50', '/api/media/file/dan-nelson-AvSFPw5Tp68-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '20465', 'dan-nelson-AvSFPw5Tp68-unsplash-400x300.jpg', '/api/media/file/dan-nelson-AvSFPw5Tp68-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '165099', 'dan-nelson-AvSFPw5Tp68-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (168, 'microsoft-copilot-7R3PqLcVnzQ-unsplash-asset', '2026-06-20T06:20:24.784Z', '2026-06-20T06:20:24.784Z', '/api/media/file/microsoft-copilot-7R3PqLcVnzQ-unsplash.jpg', '/api/media/file/microsoft-copilot-7R3PqLcVnzQ-unsplash-400x300.jpg', 'microsoft-copilot-7R3PqLcVnzQ-unsplash.jpg', 'image/jpeg', '798824', '2400', '3598', '50', '50', '/api/media/file/microsoft-copilot-7R3PqLcVnzQ-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '21874', 'microsoft-copilot-7R3PqLcVnzQ-unsplash-400x300.jpg', '/api/media/file/microsoft-copilot-7R3PqLcVnzQ-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '175222', 'microsoft-copilot-7R3PqLcVnzQ-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (174, 'thisisengineering-32PpagSzeGs-unsplash-assset', '2026-06-20T06:30:06.637Z', '2026-06-20T06:30:06.637Z', '/api/media/file/thisisengineering-32PpagSzeGs-unsplash.jpg', '/api/media/file/thisisengineering-32PpagSzeGs-unsplash-400x300.jpg', 'thisisengineering-32PpagSzeGs-unsplash.jpg', 'image/jpeg', '355029', '2400', '1601', '50', '50', '/api/media/file/thisisengineering-32PpagSzeGs-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '14786', 'thisisengineering-32PpagSzeGs-unsplash-400x300.jpg', '/api/media/file/thisisengineering-32PpagSzeGs-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '132873', 'thisisengineering-32PpagSzeGs-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (175, 'ruthson-zimmerman-FVwG5OzPuzo-unsplash-asset', '2026-06-20T06:35:35.115Z', '2026-06-20T06:35:35.115Z', '/api/media/file/ruthson-zimmerman-FVwG5OzPuzo-unsplash.jpg', '/api/media/file/ruthson-zimmerman-FVwG5OzPuzo-unsplash-400x300.jpg', 'ruthson-zimmerman-FVwG5OzPuzo-unsplash.jpg', 'image/jpeg', '778851', '2400', '1600', '50', '50', '/api/media/file/ruthson-zimmerman-FVwG5OzPuzo-unsplash-400x300.jpg', '400', '300', 'image/jpeg', '27062', 'ruthson-zimmerman-FVwG5OzPuzo-unsplash-400x300.jpg', '/api/media/file/ruthson-zimmerman-FVwG5OzPuzo-unsplash-1920x1080.jpg', '1920', '1080', 'image/jpeg', '279174', 'ruthson-zimmerman-FVwG5OzPuzo-unsplash-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (179, 'news-asset-excel-vs-hrms', '2026-08-14T02:39:24.906Z', '2026-08-14T02:39:24.906Z', '/api/media/file/Image Aug 14, 2026, 08_56_25 AM.png', '/api/media/file/Image Aug 14, 2026, 08_56_25 AM-400x300.png', 'Image Aug 14, 2026, 08_56_25 AM.png', 'image/png', '1859884', '1536', '1024', '50', '50', '/api/media/file/Image Aug 14, 2026, 08_56_25 AM-400x300.png', '400', '300', 'image/png', '223121', 'Image Aug 14, 2026, 08_56_25 AM-400x300.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (182, 'BIT-HRIS-Pekerjaan-HR-Manufaktur-2K', '2026-08-24T08:39:37.343Z', '2026-08-24T08:39:37.343Z', '/api/media/file/BIT-HRIS-Pekerjaan-HR-Manufaktur-2K.jpeg', '/api/media/file/BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-400x300.jpg', 'BIT-HRIS-Pekerjaan-HR-Manufaktur-2K.jpeg', 'image/jpeg', '866789', '2560', '1343', '50', '50', '/api/media/file/BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-400x300.jpg', '400', '300', 'image/jpeg', '31391', 'BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-400x300.jpg', '/api/media/file/BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-1920x1080.jpg', '1920', '1080', 'image/jpeg', '240775', 'BIT-HRIS-Pekerjaan-HR-Manufaktur-2K-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (184, 'BIT-HRIS-Cek-Sebelum-Payroll-2K', '2026-08-24T08:49:14.783Z', '2026-08-24T08:49:14.782Z', '/api/media/file/BIT-HRIS-Cek-Sebelum-Payroll-2K.jpeg', '/api/media/file/BIT-HRIS-Cek-Sebelum-Payroll-2K-400x300.jpg', 'BIT-HRIS-Cek-Sebelum-Payroll-2K.jpeg', 'image/jpeg', '793634', '2560', '1343', '50', '50', '/api/media/file/BIT-HRIS-Cek-Sebelum-Payroll-2K-400x300.jpg', '400', '300', 'image/jpeg', '27906', 'BIT-HRIS-Cek-Sebelum-Payroll-2K-400x300.jpg', '/api/media/file/BIT-HRIS-Cek-Sebelum-Payroll-2K-1920x1080.jpg', '1920', '1080', 'image/jpeg', '221875', 'BIT-HRIS-Cek-Sebelum-Payroll-2K-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (187, 'BIT-HRIS-Cek-Sebelum-Payroll-2K', '2026-08-24T09:08:38.155Z', '2026-08-24T09:08:38.155Z', '/api/media/file/BIT-HRIS-Cek-Sebelum-Payroll-2K-1.jpeg', '/api/media/file/BIT-HRIS-Cek-Sebelum-Payroll-2K-1-400x300.jpg', 'BIT-HRIS-Cek-Sebelum-Payroll-2K-1.jpeg', 'image/jpeg', '851469', '2560', '1600', '50', '50', '/api/media/file/BIT-HRIS-Cek-Sebelum-Payroll-2K-1-400x300.jpg', '400', '300', 'image/jpeg', '26815', 'BIT-HRIS-Cek-Sebelum-Payroll-2K-1-400x300.jpg', '/api/media/file/BIT-HRIS-Cek-Sebelum-Payroll-2K-1-1920x1080.jpg', '1920', '1080', 'image/jpeg', '217279', 'BIT-HRIS-Cek-Sebelum-Payroll-2K-1-1920x1080.jpg', NULL, NULL, NULL, NULL, NULL, NULL),
  (190, 'Gemini_Generated_Image_ieewqxieewqxieew', '2026-09-25T03:39:35.867Z', '2026-09-25T03:39:33.989Z', '/api/media/file/Gemini_Generated_Image_ieewqxieewqxieew.webp', '/api/media/file/Gemini_Generated_Image_ieewqxieewqxieew-400x300.webp', 'Gemini_Generated_Image_ieewqxieewqxieew.webp', 'image/webp', '203372', '2560', '1429', '50', '50', '/api/media/file/Gemini_Generated_Image_ieewqxieewqxieew-400x300.webp', '400', '300', 'image/webp', '22994', 'Gemini_Generated_Image_ieewqxieewqxieew-400x300.webp', '/api/media/file/Gemini_Generated_Image_ieewqxieewqxieew-1920x1080.webp', '1920', '1080', 'image/webp', '147284', 'Gemini_Generated_Image_ieewqxieewqxieew-1920x1080.webp', '/api/media/file/Gemini_Generated_Image_ieewqxieewqxieew-800x600.webp', '800', '600', 'image/webp', '56864', 'Gemini_Generated_Image_ieewqxieewqxieew-800x600.webp'),
  (193, 'Gemini_Generated_Image_ecfpf4ecfpf4ecfp', '2026-09-25T03:41:10.636Z', '2026-09-25T03:41:10.135Z', '/api/media/file/Gemini_Generated_Image_ecfpf4ecfpf4ecfp.webp', '/api/media/file/Gemini_Generated_Image_ecfpf4ecfpf4ecfp-400x300.webp', 'Gemini_Generated_Image_ecfpf4ecfpf4ecfp.webp', 'image/webp', '118508', '2398', '1792', '50', '50', '/api/media/file/Gemini_Generated_Image_ecfpf4ecfpf4ecfp-400x300.webp', '400', '300', 'image/webp', '13782', 'Gemini_Generated_Image_ecfpf4ecfpf4ecfp-400x300.webp', '/api/media/file/Gemini_Generated_Image_ecfpf4ecfpf4ecfp-1920x1080.webp', '1920', '1080', 'image/webp', '69990', 'Gemini_Generated_Image_ecfpf4ecfpf4ecfp-1920x1080.webp', '/api/media/file/Gemini_Generated_Image_ecfpf4ecfpf4ecfp-800x600.webp', '800', '600', 'image/webp', '30392', 'Gemini_Generated_Image_ecfpf4ecfpf4ecfp-800x600.webp'),
  (195, 'Gemini_Generated_Image_iog2zjiog2zjiog2', '2026-09-25T03:43:04.090Z', '2026-09-25T03:43:03.483Z', '/api/media/file/Gemini_Generated_Image_iog2zjiog2zjiog2.webp', '/api/media/file/Gemini_Generated_Image_iog2zjiog2zjiog2-400x300.webp', 'Gemini_Generated_Image_iog2zjiog2zjiog2.webp', 'image/webp', '154154', '2398', '1792', '50', '50', '/api/media/file/Gemini_Generated_Image_iog2zjiog2zjiog2-400x300.webp', '400', '300', 'image/webp', '12414', 'Gemini_Generated_Image_iog2zjiog2zjiog2-400x300.webp', '/api/media/file/Gemini_Generated_Image_iog2zjiog2zjiog2-1920x1080.webp', '1920', '1080', 'image/webp', '94492', 'Gemini_Generated_Image_iog2zjiog2zjiog2-1920x1080.webp', '/api/media/file/Gemini_Generated_Image_iog2zjiog2zjiog2-800x600.webp', '800', '600', 'image/webp', '32658', 'Gemini_Generated_Image_iog2zjiog2zjiog2-800x600.webp'),
  (197, 'Untitled (1920 x 1080 px) (1)', '2026-09-25T06:38:51.014Z', '2026-09-25T06:38:46.852Z', '/api/media/file/Untitled (1920 x 1080 px) (1).webp', '/api/media/file/Untitled%20(1920%20x%201080%20px)%20(1)-400x300.webp', 'Untitled (1920 x 1080 px) (1).webp', 'image/webp', '162244', '1920', '1080', '50', '50', '/api/media/file/Untitled (1920 x 1080 px) (1)-400x300.webp', '400', '300', 'image/webp', '27734', 'Untitled (1920 x 1080 px) (1)-400x300.webp', '/api/media/file/Untitled (1920 x 1080 px) (1)-1920x1080.webp', '1920', '1080', 'image/webp', '162244', 'Untitled (1920 x 1080 px) (1)-1920x1080.webp', '/api/media/file/Untitled (1920 x 1080 px) (1)-800x600.webp', '800', '600', 'image/webp', '65776', 'Untitled (1920 x 1080 px) (1)-800x600.webp'),
  (198, 'Gemini_Generated_Image_22vy8922vy8922vy', '2026-09-25T06:39:10.161Z', '2026-09-25T06:39:09.501Z', '/api/media/file/Gemini_Generated_Image_22vy8922vy8922vy.webp', '/api/media/file/Gemini_Generated_Image_22vy8922vy8922vy-400x300.webp', 'Gemini_Generated_Image_22vy8922vy8922vy.webp', 'image/webp', '204776', '2400', '1792', '50', '50', '/api/media/file/Gemini_Generated_Image_22vy8922vy8922vy-400x300.webp', '400', '300', 'image/webp', '17180', 'Gemini_Generated_Image_22vy8922vy8922vy-400x300.webp', '/api/media/file/Gemini_Generated_Image_22vy8922vy8922vy-1920x1080.webp', '1920', '1080', 'image/webp', '122690', 'Gemini_Generated_Image_22vy8922vy8922vy-1920x1080.webp', '/api/media/file/Gemini_Generated_Image_22vy8922vy8922vy-800x600.webp', '800', '600', 'image/webp', '42496', 'Gemini_Generated_Image_22vy8922vy8922vy-800x600.webp'),
  (248, 'Transformasi & Skalabilitas Infrastruktur Pusat Data Cerdas', '2026-10-02T01:38:19.694Z', '2026-10-02T01:38:18.283Z', '/api/media/file/Transformasi & Skalabilitas Infrastruktur Pusat Data Cerdas.webp', '/api/media/file/Transformasi%20%26%20Skalabilitas%20Infrastruktur%20Pusat%20Data%20Cerdas-400x300.webp', 'Transformasi & Skalabilitas Infrastruktur Pusat Data Cerdas.webp', 'image/webp', '129154', '1375', '768', '50', '50', '/api/media/file/Transformasi & Skalabilitas Infrastruktur Pusat Data Cerdas-400x300.webp', '400', '300', 'image/webp', '35604', 'Transformasi & Skalabilitas Infrastruktur Pusat Data Cerdas-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Transformasi & Skalabilitas Infrastruktur Pusat Data Cerdas-800x600.webp', '800', '600', 'image/webp', '89414', 'Transformasi & Skalabilitas Infrastruktur Pusat Data Cerdas-800x600.webp'),
  (256, 'Otomasi Pelaporan Regulasi & Kepatuhan Audit', '2026-10-02T01:47:49.613Z', '2026-10-02T01:47:49.146Z', '/api/media/file/Otomasi Pelaporan Regulasi & Kepatuhan Audit.webp', '/api/media/file/Otomasi%20Pelaporan%20Regulasi%20%26%20Kepatuhan%20Audit-400x300.webp', 'Otomasi Pelaporan Regulasi & Kepatuhan Audit.webp', 'image/webp', '83232', '1376', '768', '50', '50', '/api/media/file/Otomasi Pelaporan Regulasi & Kepatuhan Audit-400x300.webp', '400', '300', 'image/webp', '22614', 'Otomasi Pelaporan Regulasi & Kepatuhan Audit-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Otomasi Pelaporan Regulasi & Kepatuhan Audit-800x600.webp', '800', '600', 'image/webp', '53664', 'Otomasi Pelaporan Regulasi & Kepatuhan Audit-800x600.webp'),
  (249, 'Modernisasi Operasional & Layanan Kantor Cabang Pintar', '2026-10-02T01:39:28.529Z', '2026-10-02T01:39:25.296Z', '/api/media/file/Modernisasi Operasional & Layanan Kantor Cabang Pintar.webp', '/api/media/file/Modernisasi%20Operasional%20%26%20Layanan%20Kantor%20Cabang%20Pintar-400x300.webp', 'Modernisasi Operasional & Layanan Kantor Cabang Pintar.webp', 'image/webp', '125132', '1376', '768', '50', '50', '/api/media/file/Modernisasi Operasional & Layanan Kantor Cabang Pintar-400x300.webp', '400', '300', 'image/webp', '30702', 'Modernisasi Operasional & Layanan Kantor Cabang Pintar-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Modernisasi Operasional & Layanan Kantor Cabang Pintar-800x600.webp', '800', '600', 'image/webp', '72232', 'Modernisasi Operasional & Layanan Kantor Cabang Pintar-800x600.webp'),
  (250, 'Pencegahan Kecurangan & Kebocoran Pendapatan Telekomunikasi', '2026-10-02T01:39:59.293Z', '2026-10-02T01:39:57.604Z', '/api/media/file/Pencegahan Kecurangan & Kebocoran Pendapatan Telekomunikasi.webp', '/api/media/file/Pencegahan%20Kecurangan%20%26%20Kebocoran%20Pendapatan%20Telekomunikasi-400x300.webp', 'Pencegahan Kecurangan & Kebocoran Pendapatan Telekomunikasi.webp', 'image/webp', '101662', '1376', '768', '50', '50', '/api/media/file/Pencegahan Kecurangan & Kebocoran Pendapatan Telekomunikasi-400x300.webp', '400', '300', 'image/webp', '26536', 'Pencegahan Kecurangan & Kebocoran Pendapatan Telekomunikasi-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pencegahan Kecurangan & Kebocoran Pendapatan Telekomunikasi-800x600.webp', '800', '600', 'image/webp', '64034', 'Pencegahan Kecurangan & Kebocoran Pendapatan Telekomunikasi-800x600.webp'),
  (251, 'Pusat Keamanan Siber & Tanggap Insiden Finansial', '2026-10-02T01:40:40.818Z', '2026-10-02T01:40:39.697Z', '/api/media/file/Pusat Keamanan Siber & Tanggap Insiden Finansial.webp', '/api/media/file/Pusat%20Keamanan%20Siber%20%26%20Tanggap%20Insiden%20Finansial-400x300.webp', 'Pusat Keamanan Siber & Tanggap Insiden Finansial.webp', 'image/webp', '129792', '1376', '768', '50', '50', '/api/media/file/Pusat Keamanan Siber & Tanggap Insiden Finansial-400x300.webp', '400', '300', 'image/webp', '30448', 'Pusat Keamanan Siber & Tanggap Insiden Finansial-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pusat Keamanan Siber & Tanggap Insiden Finansial-800x600.webp', '800', '600', 'image/webp', '75710', 'Pusat Keamanan Siber & Tanggap Insiden Finansial-800x600.webp'),
  (252, 'Proteksi Data Finansial & Kepatuhan Regulasi', '2026-10-02T01:42:00.270Z', '2026-10-02T01:41:59.760Z', '/api/media/file/Proteksi Data Finansial & Kepatuhan Regulasi.webp', '/api/media/file/Proteksi%20Data%20Finansial%20%26%20Kepatuhan%20Regulasi-400x300.webp', 'Proteksi Data Finansial & Kepatuhan Regulasi.webp', 'image/webp', '96626', '1376', '768', '50', '50', '/api/media/file/Proteksi Data Finansial & Kepatuhan Regulasi-400x300.webp', '400', '300', 'image/webp', '26056', 'Proteksi Data Finansial & Kepatuhan Regulasi-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Proteksi Data Finansial & Kepatuhan Regulasi-800x600.webp', '800', '600', 'image/webp', '62894', 'Proteksi Data Finansial & Kepatuhan Regulasi-800x600.webp'),
  (253, 'Platform Analitik Perilaku & Personalisasi Nasabah', '2026-10-02T01:42:27.656Z', '2026-10-02T01:42:26.572Z', '/api/media/file/Platform Analitik & Personalisasi Nasabah.webp', '/api/media/file/Platform%20Analitik%20%26%20Personalisasi%20Nasabah-400x300.webp', 'Platform Analitik & Personalisasi Nasabah.webp', 'image/webp', '98246', '1376', '768', '50', '50', '/api/media/file/Platform Analitik & Personalisasi Nasabah-400x300.webp', '400', '300', 'image/webp', '27500', 'Platform Analitik & Personalisasi Nasabah-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Platform Analitik & Personalisasi Nasabah-800x600.webp', '800', '600', 'image/webp', '64814', 'Platform Analitik & Personalisasi Nasabah-800x600.webp'),
  (234, 'Kasir Otomatis & Toko Tanpa Kasir', '2026-10-01T06:33:59.703Z', '2026-10-01T06:33:59.393Z', '/api/media/file/Kasir Otomatis & Toko Tanpa Kasir.webp', '/api/media/file/Kasir%20Otomatis%20%26%20Toko%20Tanpa%20Kasir-400x300.webp', 'Kasir Otomatis & Toko Tanpa Kasir.webp', 'image/webp', '73944', '1376', '768', '50', '50', '/api/media/file/Kasir Otomatis & Toko Tanpa Kasir-400x300.webp', '400', '300', 'image/webp', '18988', 'Kasir Otomatis & Toko Tanpa Kasir-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Kasir Otomatis & Toko Tanpa Kasir-800x600.webp', '800', '600', 'image/webp', '44296', 'Kasir Otomatis & Toko Tanpa Kasir-800x600.webp'),
  (239, 'Pusat Keamanan Siber & Kepatuhan Medis', '2026-10-01T06:36:51.244Z', '2026-10-01T06:36:49.077Z', '/api/media/file/Pusat Keamanan Siber & Kepatuhan Medis.webp', '/api/media/file/Pusat%20Keamanan%20Siber%20%26%20Kepatuhan%20Medis-400x300.webp', 'Pusat Keamanan Siber & Kepatuhan Medis.webp', 'image/webp', '84010', '1376', '768', '50', '50', '/api/media/file/Pusat Keamanan Siber & Kepatuhan Medis-400x300.webp', '400', '300', 'image/webp', '21768', 'Pusat Keamanan Siber & Kepatuhan Medis-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pusat Keamanan Siber & Kepatuhan Medis-800x600.webp', '800', '600', 'image/webp', '50920', 'Pusat Keamanan Siber & Kepatuhan Medis-800x600.webp'),
  (241, 'Diagnosis Radiologi Cepat & Akurat Berbasis AI', '2026-10-01T06:37:29.072Z', '2026-10-01T06:37:28.141Z', '/api/media/file/Diagnosis Radiologi Cepat & Akurat Berbasis AI.webp', '/api/media/file/Diagnosis%20Radiologi%20Cepat%20%26%20Akurat%20Berbasis%20AI-400x300.webp', 'Diagnosis Radiologi Cepat & Akurat Berbasis AI.webp', 'image/webp', '101850', '1376', '768', '50', '50', '/api/media/file/Diagnosis Radiologi Cepat & Akurat Berbasis AI-400x300.webp', '400', '300', 'image/webp', '28472', 'Diagnosis Radiologi Cepat & Akurat Berbasis AI-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Diagnosis Radiologi Cepat & Akurat Berbasis AI-800x600.webp', '800', '600', 'image/webp', '69584', 'Diagnosis Radiologi Cepat & Akurat Berbasis AI-800x600.webp'),
  (254, 'Digitalisasi Kantor Cabang & Kios Layanan Mandiri Finansial', '2026-10-02T01:42:55.043Z', '2026-10-02T01:42:54.362Z', '/api/media/file/Digitalisasi Kantor Cabang & Kios Layanan Mandiri Finansial.webp', '/api/media/file/Digitalisasi%20Kantor%20Cabang%20%26%20Kios%20Layanan%20Mandiri%20Finansial-400x300.webp', 'Digitalisasi Kantor Cabang & Kios Layanan Mandiri Finansial.webp', 'image/webp', '94002', '1376', '768', '50', '50', '/api/media/file/Digitalisasi Kantor Cabang & Kios Layanan Mandiri Finansial-400x300.webp', '400', '300', 'image/webp', '22606', 'Digitalisasi Kantor Cabang & Kios Layanan Mandiri Finansial-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Digitalisasi Kantor Cabang & Kios Layanan Mandiri Finansial-800x600.webp', '800', '600', 'image/webp', '52610', 'Digitalisasi Kantor Cabang & Kios Layanan Mandiri Finansial-800x600.webp'),
  (215, 'Sistem Pemantauan Terpadu untuk Kesehatan & Keselamatan Publik', '2026-10-01T01:36:05.578Z', '2026-10-01T01:36:01.272Z', '/api/media/file/Sistem Pemantauan Terpadu untuk Kesehatan & Keselamatan Publik.webp', '/api/media/file/Sistem%20Pemantauan%20Terpadu%20untuk%20Kesehatan%20%26%20Keselamatan%20Publik-400x300.webp', 'Sistem Pemantauan Terpadu untuk Kesehatan & Keselamatan Publik.webp', 'image/webp', '107396', '1365', '768', '50', '50', '/api/media/file/Sistem Pemantauan Terpadu untuk Kesehatan & Keselamatan Publik-400x300.webp', '400', '300', 'image/webp', '18996', 'Sistem Pemantauan Terpadu untuk Kesehatan & Keselamatan Publik-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Sistem Pemantauan Terpadu untuk Kesehatan & Keselamatan Publik-800x600.webp', '800', '600', 'image/webp', '51650', 'Sistem Pemantauan Terpadu untuk Kesehatan & Keselamatan Publik-800x600.webp'),
  (216, 'Pusat Operasi Keamanan Siber Terpadu (Security Operations Center - SOC)', '2026-10-01T01:36:50.768Z', '2026-10-01T01:36:50.037Z', '/api/media/file/Pusat Operasi Keamanan Siber Terpadu (Security Operations Center - SOC).webp', '/api/media/file/Pusat%20Operasi%20Keamanan%20Siber%20Terpadu%20(Security%20Operations%20Center%20-%20SOC)-400x300.webp', 'Pusat Operasi Keamanan Siber Terpadu (Security Operations Center - SOC).webp', 'image/webp', '91660', '1280', '720', '50', '50', '/api/media/file/Pusat Operasi Keamanan Siber Terpadu (Security Operations Center - SOC)-400x300.webp', '400', '300', 'image/webp', '21698', 'Pusat Operasi Keamanan Siber Terpadu (Security Operations Center - SOC)-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pusat Operasi Keamanan Siber Terpadu (Security Operations Center - SOC)-800x600.webp', '800', '600', 'image/webp', '61880', 'Pusat Operasi Keamanan Siber Terpadu (Security Operations Center - SOC)-800x600.webp'),
  (217, 'Sistem Digitalisasi & Pengarsipan Dokumen Terpadu', '2026-10-01T01:38:04.126Z', '2026-10-01T01:38:03.456Z', '/api/media/file/Sistem Digitalisasi & Pengarsipan Dokumen Terpadu.webp', '/api/media/file/Sistem%20Digitalisasi%20%26%20Pengarsipan%20Dokumen%20Terpadu-400x300.webp', 'Sistem Digitalisasi & Pengarsipan Dokumen Terpadu.webp', 'image/webp', '86386', '1280', '720', '50', '50', '/api/media/file/Sistem Digitalisasi & Pengarsipan Dokumen Terpadu-400x300.webp', '400', '300', 'image/webp', '21990', 'Sistem Digitalisasi & Pengarsipan Dokumen Terpadu-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Sistem Digitalisasi & Pengarsipan Dokumen Terpadu-800x600.webp', '800', '600', 'image/webp', '60230', 'Sistem Digitalisasi & Pengarsipan Dokumen Terpadu-800x600.webp'),
  (218, 'Sistem Manajemen Lalu Lintas Cerdas Terintegrasi Berbasis AI', '2026-10-01T01:38:48.039Z', '2026-10-01T01:38:47.381Z', '/api/media/file/Sistem Manajemen Lalu Lintas Cerdas Terintegrasi Berbasis AI.webp', '/api/media/file/Sistem%20Manajemen%20Lalu%20Lintas%20Cerdas%20Terintegrasi%20Berbasis%20AI-400x300.webp', 'Sistem Manajemen Lalu Lintas Cerdas Terintegrasi Berbasis AI.webp', 'image/webp', '151364', '1379', '752', '50', '50', '/api/media/file/Sistem Manajemen Lalu Lintas Cerdas Terintegrasi Berbasis AI-400x300.webp', '400', '300', 'image/webp', '31900', 'Sistem Manajemen Lalu Lintas Cerdas Terintegrasi Berbasis AI-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Sistem Manajemen Lalu Lintas Cerdas Terintegrasi Berbasis AI-800x600.webp', '800', '600', 'image/webp', '86628', 'Sistem Manajemen Lalu Lintas Cerdas Terintegrasi Berbasis AI-800x600.webp'),
  (219, 'Sistem Manajemen Gedung Cerdas (Smart Building System) Terintegrasi', '2026-10-01T01:39:21.113Z', '2026-10-01T01:39:20.243Z', '/api/media/file/Sistem Manajemen Gedung Cerdas (Smart Building System) Terintegrasi.webp', '/api/media/file/Sistem%20Manajemen%20Gedung%20Cerdas%20(Smart%20Building%20System)%20Terintegrasi-400x300.webp', 'Sistem Manajemen Gedung Cerdas (Smart Building System) Terintegrasi.webp', 'image/webp', '118208', '1280', '720', '50', '50', '/api/media/file/Sistem Manajemen Gedung Cerdas (Smart Building System) Terintegrasi-400x300.webp', '400', '300', 'image/webp', '29996', 'Sistem Manajemen Gedung Cerdas (Smart Building System) Terintegrasi-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Sistem Manajemen Gedung Cerdas (Smart Building System) Terintegrasi-800x600.webp', '800', '600', 'image/webp', '79190', 'Sistem Manajemen Gedung Cerdas (Smart Building System) Terintegrasi-800x600.webp'),
  (220, 'Portal Layanan Publik Digital Terpadu (One-Stop Digital Citizen Portal)', '2026-10-01T01:39:54.085Z', '2026-10-01T01:39:53.611Z', '/api/media/file/Portal Layanan Publik Digital Terpadu (One-Stop Digital Citizen Portal).webp', '/api/media/file/Portal%20Layanan%20Publik%20Digital%20Terpadu%20(One-Stop%20Digital%20Citizen%20Portal)-400x300.webp', 'Portal Layanan Publik Digital Terpadu (One-Stop Digital Citizen Portal).webp', 'image/webp', '94750', '1280', '720', '50', '50', '/api/media/file/Portal Layanan Publik Digital Terpadu (One-Stop Digital Citizen Portal)-400x300.webp', '400', '300', 'image/webp', '21528', 'Portal Layanan Publik Digital Terpadu (One-Stop Digital Citizen Portal)-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Portal Layanan Publik Digital Terpadu (One-Stop Digital Citizen Portal)-800x600.webp', '800', '600', 'image/webp', '57044', 'Portal Layanan Publik Digital Terpadu (One-Stop Digital Citizen Portal)-800x600.webp'),
  (221, 'Pusat Komando Kota Cerdas Terpadu (Integrated Smart City Command Center)', '2026-10-01T01:40:25.356Z', '2026-10-01T01:40:24.774Z', '/api/media/file/Pusat Komando Kota Cerdas Terpadu (Integrated Smart City Command Center).webp', '/api/media/file/Pusat%20Komando%20Kota%20Cerdas%20Terpadu%20(Integrated%20Smart%20City%20Command%20Center)-400x300.webp', 'Pusat Komando Kota Cerdas Terpadu (Integrated Smart City Command Center).webp', 'image/webp', '109388', '1280', '720', '50', '50', '/api/media/file/Pusat Komando Kota Cerdas Terpadu (Integrated Smart City Command Center)-400x300.webp', '400', '300', 'image/webp', '22408', 'Pusat Komando Kota Cerdas Terpadu (Integrated Smart City Command Center)-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pusat Komando Kota Cerdas Terpadu (Integrated Smart City Command Center)-800x600.webp', '800', '600', 'image/webp', '63356', 'Pusat Komando Kota Cerdas Terpadu (Integrated Smart City Command Center)-800x600.webp'),
  (222, 'Modernisasi Data Center & Infrastruktur Cloud Sektor Publik Terpadu', '2026-10-01T01:41:00.250Z', '2026-10-01T01:40:59.604Z', '/api/media/file/Modernisasi Data Center & Infrastruktur Cloud Sektor Publik Terpadu.webp', '/api/media/file/Modernisasi%20Data%20Center%20%26%20Infrastruktur%20Cloud%20Sektor%20Publik%20Terpadu-400x300.webp', 'Modernisasi Data Center & Infrastruktur Cloud Sektor Publik Terpadu.webp', 'image/webp', '84706', '1280', '720', '50', '50', '/api/media/file/Modernisasi Data Center & Infrastruktur Cloud Sektor Publik Terpadu-400x300.webp', '400', '300', 'image/webp', '19702', 'Modernisasi Data Center & Infrastruktur Cloud Sektor Publik Terpadu-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Modernisasi Data Center & Infrastruktur Cloud Sektor Publik Terpadu-800x600.webp', '800', '600', 'image/webp', '50950', 'Modernisasi Data Center & Infrastruktur Cloud Sektor Publik Terpadu-800x600.webp'),
  (223, 'Pemantauan Keselamatan & Kepatuhan Kerja', '2026-10-01T03:51:59.988Z', '2026-10-01T03:51:54.549Z', '/api/media/file/Pemantauan Keselamatan & Kepatuhan Kerja.webp', '/api/media/file/Pemantauan%20Keselamatan%20%26%20Kepatuhan%20Kerja-400x300.webp', 'Pemantauan Keselamatan & Kepatuhan Kerja.webp', 'image/webp', '97918', '1376', '768', '50', '50', '/api/media/file/Pemantauan Keselamatan & Kepatuhan Kerja-400x300.webp', '400', '300', 'image/webp', '29958', 'Pemantauan Keselamatan & Kepatuhan Kerja-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pemantauan Keselamatan & Kepatuhan Kerja-800x600.webp', '800', '600', 'image/webp', '68046', 'Pemantauan Keselamatan & Kepatuhan Kerja-800x600.webp'),
  (224, 'Transparansi & Pelacakan Rantai Pasok Cerdas', '2026-10-01T03:53:06.722Z', '2026-10-01T03:53:05.355Z', '/api/media/file/Transparansi & Pelacakan Rantai Pasok Cerdas.webp', '/api/media/file/Transparansi%20%26%20Pelacakan%20Rantai%20Pasok%20Cerdas-400x300.webp', 'Transparansi & Pelacakan Rantai Pasok Cerdas.webp', 'image/webp', '96900', '1376', '768', '50', '50', '/api/media/file/Transparansi & Pelacakan Rantai Pasok Cerdas-400x300.webp', '400', '300', 'image/webp', '26050', 'Transparansi & Pelacakan Rantai Pasok Cerdas-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Transparansi & Pelacakan Rantai Pasok Cerdas-800x600.webp', '800', '600', 'image/webp', '60404', 'Transparansi & Pelacakan Rantai Pasok Cerdas-800x600.webp'),
  (225, 'Sistem Keamanan Siber Industri & Operasional Pabrik', '2026-10-01T03:53:37.431Z', '2026-10-01T03:53:35.738Z', '/api/media/file/Sistem Keamanan Siber Industri & Operasional Pabrik.webp', '/api/media/file/Sistem%20Keamanan%20Siber%20Industri%20%26%20Operasional%20Pabrik-400x300.webp', 'Sistem Keamanan Siber Industri & Operasional Pabrik.webp', 'image/webp', '136102', '1376', '768', '50', '50', '/api/media/file/Sistem Keamanan Siber Industri & Operasional Pabrik-400x300.webp', '400', '300', 'image/webp', '29792', 'Sistem Keamanan Siber Industri & Operasional Pabrik-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Sistem Keamanan Siber Industri & Operasional Pabrik-800x600.webp', '800', '600', 'image/webp', '78048', 'Sistem Keamanan Siber Industri & Operasional Pabrik-800x600.webp'),
  (227, 'Sistem Otomatisasi & Pelacakan Gudang', '2026-10-01T03:54:47.127Z', '2026-10-01T03:54:46.865Z', '/api/media/file/Sistem Otomatisasi & Pelacakan Gudang.webp', '/api/media/file/Sistem%20Otomatisasi%20%26%20Pelacakan%20Gudang-400x300.webp', 'Sistem Otomatisasi & Pelacakan Gudang.webp', 'image/webp', '169252', '1380', '752', '50', '50', '/api/media/file/Sistem Otomatisasi & Pelacakan Gudang-400x300.webp', '400', '300', 'image/webp', '32584', 'Sistem Otomatisasi & Pelacakan Gudang-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Sistem Otomatisasi & Pelacakan Gudang-800x600.webp', '800', '600', 'image/webp', '92902', 'Sistem Otomatisasi & Pelacakan Gudang-800x600.webp'),
  (228, 'Pusat Kendali Pabrik Cerdas', '2026-10-01T03:55:40.659Z', '2026-10-01T03:55:39.596Z', '/api/media/file/Pusat Kendali Pabrik Cerdas.webp', '/api/media/file/Pusat%20Kendali%20Pabrik%20Cerdas-400x300.webp', 'Pusat Kendali Pabrik Cerdas.webp', 'image/webp', '110976', '1376', '768', '50', '50', '/api/media/file/Pusat Kendali Pabrik Cerdas-400x300.webp', '400', '300', 'image/webp', '26358', 'Pusat Kendali Pabrik Cerdas-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pusat Kendali Pabrik Cerdas-800x600.webp', '800', '600', 'image/webp', '68604', 'Pusat Kendali Pabrik Cerdas-800x600.webp'),
  (238, 'Sistem Ambulans Cerdas & Tanggap Darurat', '2026-10-01T06:36:24.405Z', '2026-10-01T06:36:23.471Z', '/api/media/file/Sistem Ambulans Cerdas & Tanggap Darurat.webp', '/api/media/file/Sistem%20Ambulans%20Cerdas%20%26%20Tanggap%20Darurat-400x300.webp', 'Sistem Ambulans Cerdas & Tanggap Darurat.webp', 'image/webp', '117164', '1376', '768', '50', '50', '/api/media/file/Sistem Ambulans Cerdas & Tanggap Darurat-400x300.webp', '400', '300', 'image/webp', '31104', 'Sistem Ambulans Cerdas & Tanggap Darurat-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Sistem Ambulans Cerdas & Tanggap Darurat-800x600.webp', '800', '600', 'image/webp', '76908', 'Sistem Ambulans Cerdas & Tanggap Darurat-800x600.webp'),
  (240, 'Otomatisasi Farmasi & Apotek Cerdas', '2026-10-01T06:37:10.213Z', '2026-10-01T06:37:08.865Z', '/api/media/file/Otomatisasi Farmasi & Apotek Cerdas.webp', '/api/media/file/Otomatisasi%20Farmasi%20%26%20Apotek%20Cerdas-400x300.webp', 'Otomatisasi Farmasi & Apotek Cerdas.webp', 'image/webp', '96268', '1376', '768', '50', '50', '/api/media/file/Otomatisasi Farmasi & Apotek Cerdas-400x300.webp', '400', '300', 'image/webp', '25208', 'Otomatisasi Farmasi & Apotek Cerdas-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Otomatisasi Farmasi & Apotek Cerdas-800x600.webp', '800', '600', 'image/webp', '58510', 'Otomatisasi Farmasi & Apotek Cerdas-800x600.webp'),
  (242, 'Digitalisasi & Integrasi Rekam Medis', '2026-10-01T06:37:49.400Z', '2026-10-01T06:37:48.774Z', '/api/media/file/Digitalisasi & Integrasi Rekam Medis.webp', '/api/media/file/Digitalisasi%20%26%20Integrasi%20Rekam%20Medis-400x300.webp', 'Digitalisasi & Integrasi Rekam Medis.webp', 'image/webp', '77970', '1376', '768', '50', '50', '/api/media/file/Digitalisasi & Integrasi Rekam Medis-400x300.webp', '400', '300', 'image/webp', '23040', 'Digitalisasi & Integrasi Rekam Medis-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Digitalisasi & Integrasi Rekam Medis-800x600.webp', '800', '600', 'image/webp', '57048', 'Digitalisasi & Integrasi Rekam Medis-800x600.webp');
INSERT INTO "media" ("id", "alt", "updated_at", "created_at", "url", "thumbnail_u_r_l", "filename", "mime_type", "filesize", "width", "height", "focal_x", "focal_y", "sizes_thumbnail_url", "sizes_thumbnail_width", "sizes_thumbnail_height", "sizes_thumbnail_mime_type", "sizes_thumbnail_filesize", "sizes_thumbnail_filename", "sizes_hero_url", "sizes_hero_width", "sizes_hero_height", "sizes_hero_mime_type", "sizes_hero_filesize", "sizes_hero_filename", "sizes_card_url", "sizes_card_width", "sizes_card_height", "sizes_card_mime_type", "sizes_card_filesize", "sizes_card_filename") VALUES
  (226, 'Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan', '2026-10-01T03:54:11.727Z', '2026-10-01T03:54:06.781Z', '/api/media/file/Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan.webp', '/api/media/file/Optimalisasi%20Energi%20%26%20Pemantauan%20Keberlanjutan%20Lingkungan-400x300.webp', 'Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan.webp', 'image/webp', '277820', '2560', '1440', '50', '50', '/api/media/file/Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan-400x300.webp', '400', '300', 'image/webp', '27978', 'Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan-400x300.webp', '/api/media/file/Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan-1920x1080.webp', '1920', '1080', 'image/webp', '200618', 'Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan-1920x1080.webp', '/api/media/file/Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan-800x600.webp', '800', '600', 'image/webp', '77038', 'Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan-800x600.webp'),
  (255, 'Ketahanan Operasional & Pemulihan Bencana Sistem Finansial', '2026-10-02T01:43:16.240Z', '2026-10-02T01:43:14.885Z', '/api/media/file/Ketahanan Operasional & Pemulihan Bencana Sistem Finansial.webp', '/api/media/file/Ketahanan%20Operasional%20%26%20Pemulihan%20Bencana%20Sistem%20Finansial-400x300.webp', 'Ketahanan Operasional & Pemulihan Bencana Sistem Finansial.webp', 'image/webp', '101242', '1376', '768', '50', '50', '/api/media/file/Ketahanan Operasional & Pemulihan Bencana Sistem Finansial-400x300.webp', '400', '300', 'image/webp', '30188', 'Ketahanan Operasional & Pemulihan Bencana Sistem Finansial-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Ketahanan Operasional & Pemulihan Bencana Sistem Finansial-800x600.webp', '800', '600', 'image/webp', '72634', 'Ketahanan Operasional & Pemulihan Bencana Sistem Finansial-800x600.webp'),
  (229, 'Inspeksi Kualitas Berbasis AI', '2026-10-01T03:56:15.231Z', '2026-10-01T03:56:13.034Z', '/api/media/file/Inspeksi Kualitas Berbasis AI.webp', '/api/media/file/Inspeksi%20Kualitas%20Berbasis%20AI-400x300.webp', 'Inspeksi Kualitas Berbasis AI.webp', 'image/webp', '235776', '2560', '1440', '50', '50', '/api/media/file/Inspeksi Kualitas Berbasis AI-400x300.webp', '400', '300', 'image/webp', '20314', 'Inspeksi Kualitas Berbasis AI-400x300.webp', '/api/media/file/Inspeksi Kualitas Berbasis AI-1920x1080.webp', '1920', '1080', 'image/webp', '170466', 'Inspeksi Kualitas Berbasis AI-1920x1080.webp', '/api/media/file/Inspeksi Kualitas Berbasis AI-800x600.webp', '800', '600', 'image/webp', '55216', 'Inspeksi Kualitas Berbasis AI-800x600.webp'),
  (230, 'Sistem Pemeliharaan Prediktif', '2026-10-01T03:56:38.779Z', '2026-10-01T03:56:38.435Z', '/api/media/file/Sistem Pemeliharaan Prediktif.webp', '/api/media/file/Sistem%20Pemeliharaan%20Prediktif-400x300.webp', 'Sistem Pemeliharaan Prediktif.webp', 'image/webp', '86192', '1376', '768', '50', '50', '/api/media/file/Sistem Pemeliharaan Prediktif-400x300.webp', '400', '300', 'image/webp', '24610', 'Sistem Pemeliharaan Prediktif-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Sistem Pemeliharaan Prediktif-800x600.webp', '800', '600', 'image/webp', '56804', 'Sistem Pemeliharaan Prediktif-800x600.webp'),
  (231, 'Pemantauan Energi & Lingkungan Toko Cerdas', '2026-10-01T06:32:37.282Z', '2026-10-01T06:32:36.554Z', '/api/media/file/Pemantauan Energi & Lingkungan Toko Cerdas.webp', '/api/media/file/Pemantauan%20Energi%20%26%20Lingkungan%20Toko%20Cerdas-400x300.webp', 'Pemantauan Energi & Lingkungan Toko Cerdas.webp', 'image/webp', '92098', '1376', '768', '50', '50', '/api/media/file/Pemantauan Energi & Lingkungan Toko Cerdas-400x300.webp', '400', '300', 'image/webp', '23872', 'Pemantauan Energi & Lingkungan Toko Cerdas-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pemantauan Energi & Lingkungan Toko Cerdas-800x600.webp', '800', '600', 'image/webp', '55070', 'Pemantauan Energi & Lingkungan Toko Cerdas-800x600.webp'),
  (232, 'Gudang & Pemenuhan Pesanan Cerdas', '2026-10-01T06:33:02.353Z', '2026-10-01T06:33:01.476Z', '/api/media/file/Gudang & Pemenuhan Pesanan Cerdas.webp', '/api/media/file/Gudang%20%26%20Pemenuhan%20Pesanan%20Cerdas-400x300.webp', 'Gudang & Pemenuhan Pesanan Cerdas.webp', 'image/webp', '103302', '1376', '768', '50', '50', '/api/media/file/Gudang & Pemenuhan Pesanan Cerdas-400x300.webp', '400', '300', 'image/webp', '27432', 'Gudang & Pemenuhan Pesanan Cerdas-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Gudang & Pemenuhan Pesanan Cerdas-800x600.webp', '800', '600', 'image/webp', '64914', 'Gudang & Pemenuhan Pesanan Cerdas-800x600.webp'),
  (235, 'Analitik Perilaku Pelanggan Berbasis AI', '2026-10-01T06:34:26.451Z', '2026-10-01T06:34:25.217Z', '/api/media/file/Analitik Perilaku Pelanggan Berbasis AI.webp', '/api/media/file/Analitik%20Perilaku%20Pelanggan%20Berbasis%20AI-400x300.webp', 'Analitik Perilaku Pelanggan Berbasis AI.webp', 'image/webp', '95754', '1376', '768', '50', '50', '/api/media/file/Analitik Perilaku Pelanggan Berbasis AI-400x300.webp', '400', '300', 'image/webp', '23112', 'Analitik Perilaku Pelanggan Berbasis AI-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Analitik Perilaku Pelanggan Berbasis AI-800x600.webp', '800', '600', 'image/webp', '55114', 'Analitik Perilaku Pelanggan Berbasis AI-800x600.webp'),
  (236, 'Pelacakan Aset Medis Rumah Sakit', '2026-10-01T06:35:37.707Z', '2026-10-01T06:35:37.044Z', '/api/media/file/Pelacakan Aset Medis Rumah Sakit.webp', '/api/media/file/Pelacakan%20Aset%20Medis%20Rumah%20Sakit-400x300.webp', 'Pelacakan Aset Medis Rumah Sakit.webp', 'image/webp', '94458', '1376', '768', '50', '50', '/api/media/file/Pelacakan Aset Medis Rumah Sakit-400x300.webp', '400', '300', 'image/webp', '23666', 'Pelacakan Aset Medis Rumah Sakit-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pelacakan Aset Medis Rumah Sakit-800x600.webp', '800', '600', 'image/webp', '58816', 'Pelacakan Aset Medis Rumah Sakit-800x600.webp'),
  (237, 'Pemantauan Energi & Lingkungan Rumah Sakit', '2026-10-01T06:36:01.307Z', '2026-10-01T06:36:00.687Z', '/api/media/file/Pemantauan Energi & Lingkungan Rumah Sakit.webp', '/api/media/file/Pemantauan%20Energi%20%26%20Lingkungan%20Rumah%20Sakit-400x300.webp', 'Pemantauan Energi & Lingkungan Rumah Sakit.webp', 'image/webp', '110168', '1376', '768', '50', '50', '/api/media/file/Pemantauan Energi & Lingkungan Rumah Sakit-400x300.webp', '400', '300', 'image/webp', '30884', 'Pemantauan Energi & Lingkungan Rumah Sakit-400x300.webp', NULL, NULL, NULL, NULL, NULL, NULL, '/api/media/file/Pemantauan Energi & Lingkungan Rumah Sakit-800x600.webp', '800', '600', 'image/webp', '72536', 'Pemantauan Energi & Lingkungan Rumah Sakit-800x600.webp');

-- Data untuk tabel: "news" (6 rows)
TRUNCATE TABLE "news" CASCADE;
INSERT INTO "news" ("id", "title", "slug", "category", "date", "image_id", "short_description", "content", "updated_at", "created_at", "thumbnail_id") VALUES
  (4, 'Cara Mengelola Absensi Karyawan dengan Sistem Shift', 'cara-mengelola-absensi-karyawan-dengan-sistem-shift', 'teknologi', '2026-08-24T12:00:00.000Z', 190, 'Ketahui cara mengelola absensi karyawan dengan sistem shift, mulai dari jadwal kerja, kehadiran, keterlambatan, lembur, hingga perubahan shift agar data HR tetap rapi dan terkontrol.', '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sistem kerja shift banyak digunakan oleh perusahaan yang membutuhkan operasional berjalan dalam waktu yang lebih panjang, seperti perusahaan manufaktur, logistik, retail, hingga layanan kesehatan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Berbeda dengan jam kerja reguler, sistem shift membuat pengelolaan absensi menjadi lebih kompleks karena setiap karyawan dapat memiliki jadwal masuk dan pulang yang berbeda.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Karena itu, perusahaan perlu memastikan jadwal kerja, kehadiran, perubahan shift, keterlambatan, hingga lembur dapat tercatat dengan baik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Berikut beberapa hal dasar yang perlu diperhatikan dalam mengelola absensi karyawan dengan sistem shift.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pastikan Jadwal Shift Tersusun dengan Jelas","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Hal pertama yang perlu diperhatikan adalah jadwal kerja setiap karyawan. Perusahaan dapat memiliki beberapa pembagian waktu kerja seperti shift pagi, siang,","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"maupun malam. Jadwal tersebut perlu disusun secara jelas agar HR maupun karyawan mengetahui kapan waktu masuk dan pulang yang berlaku.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jadwal yang terorganisir juga membantu HR membedakan keterlambatan dengan karyawan yang memang memiliki waktu kerja berbeda.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":2,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Catat Absensi Sesuai Jadwal Kerja","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Absensi karyawan shift tidak cukup hanya mencatat siapa yang hadir dan tidak hadir.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Waktu masuk dan pulang juga perlu disesuaikan dengan jadwal shift masing-masing karyawan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sebagai contoh, karyawan pada shift pagi tentu memiliki jam kerja berbeda dengan karyawan shift malam. Jika seluruh data diperlakukan dengan aturan waktu yang sama, hasil rekap absensi dapat menjadi kurang akurat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Karena itu, data kehadiran sebaiknya selalu terhubung dengan jadwal kerja yang berlaku.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":3,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perhatikan Perubahan atau Pertukaran Shift","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dalam operasional sehari-hari, perubahan jadwal dapat terjadi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Karyawan mungkin perlu bertukar shift, menggantikan rekan kerja, atau mengalami perubahan jadwal karena kebutuhan operasional.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Setiap perubahan tersebut perlu diperbarui agar data jadwal dan absensi tetap sesuai.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jika perubahan shift hanya disampaikan melalui pesan atau dicatat secara terpisah, HR perlu melakukan pengecekan kembali ketika melakukan rekap data.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":4,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":4,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kelola Data Keterlambatan dengan Tepat","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Keterlambatan juga perlu dihitung berdasarkan jadwal kerja masing-masing karyawan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Misalnya, seorang karyawan dijadwalkan masuk pukul 07.00 tetapi melakukan absensi pukul 07.20. Data tersebut perlu tercatat sebagai keterlambatan sesuai kebijakan perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Semakin banyak karyawan dan variasi shift yang digunakan, semakin banyak pula data waktu kerja yang perlu diperiksa oleh HR.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":5,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":5,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Catat Jam Lembur Karyawan","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pada perusahaan dengan sistem shift, lembur dapat terjadi ketika karyawan bekerja melewati jadwal kerja yang telah ditentukan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Karena itu, waktu lembur perlu dicatat secara terpisah dari jam kerja reguler.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data lembur yang rapi membantu perusahaan saat melakukan pemeriksaan jam kerja maupun ketika data tersebut digunakan untuk kebutuhan administrasi dan payroll.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":6,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":6,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Lakukan Rekap Absensi Secara Berkala","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Semua data mulai dari kehadiran, keterlambatan, perubahan shift, izin, hingga lembur perlu direkap secara rutin.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Rekap data membantu HR mengetahui kondisi kehadiran karyawan sekaligus memastikan informasi yang akan digunakan untuk proses berikutnya sudah sesuai.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pada perusahaan dengan jumlah karyawan yang masih sedikit, proses ini mungkin masih mudah dilakukan secara manual.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Namun ketika jumlah karyawan, pembagian shift, dan aktivitas lembur semakin banyak, data yang perlu dicocokkan juga ikut bertambah.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengelola Sistem Shift Membutuhkan Data yang Terorganisir","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sistem shift membantu perusahaan menjaga kegiatan operasional tetap berjalan sesuai kebutuhan. Namun di sisi lain, pola kerja tersebut membuat pengelolaan absensi membutuhkan perhatian lebih.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jadwal kerja, kehadiran, perubahan shift, keterlambatan, dan lembur perlu saling terhubung agar HR tidak perlu memeriksa banyak data secara terpisah.","type":"text","style":"","detail":0,"format":0,"version":1},{"type":"linebreak","version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Bukan berarti pencatatan manual selalu salah. Hanya saja, semakin kompleks operasional perusahaan, semakin banyak pula data yang harus dicatat, dicocokkan, dan diperiksa kembali.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengelolaan HR yang lebih terintegrasi dapat membantu perusahaan menjaga data absensi dan jadwal kerja tetap rapi sekaligus membuat pekerjaan administratif HR menjadi lebih efisien.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Ingin mengetahui bagaimana sistem HRIS dapat membantu mengelola proses HR dengan lebih terintegrasi?","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pelajari solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"HRIS BIT ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"selengkapnya melalui website ","type":"text","style":"","detail":0,"format":0,"version":1},{"id":"6a8c0547acd8f568b4dcd730","type":"link","fields":{"url":"https://mybit.id/","newTab":true,"linkType":"custom"},"format":"","indent":0,"version":3,"children":[{"mode":"normal","text":"mybit.id","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb, '2026-09-25T03:39:54.293Z', '2026-08-24T08:48:18.059Z', 191),
  (3, 'Apa Saja yang Biasanya Dikerjakan HR di Perusahaan Manufaktur? ', 'apa-saja-yang-biasanya-dikerjakan-hr', 'teknologi', '2026-08-24T12:00:00.000Z', 192, 'HR di perusahaan manufaktur menangani berbagai proses penting, mulai dari data karyawan, absensi, pengaturan shift, lembur, cuti, hingga payroll untuk mendukung operasional perusahaan tetap berjalan dengan baik. ', '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di perusahaan manufaktur, HR memiliki peran penting dalam memastikan kebutuhan administrasi dan pengelolaan karyawan berjalan dengan baik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Apalagi jika perusahaan memiliki banyak karyawan, pembagian shift, lembur, hingga beberapa bagian produksi. Semakin kompleks operasional perusahaan, semakin banyak pula data yang perlu dikelola oleh HR.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Lalu, apa saja pekerjaan HR yang biasanya dilakukan di perusahaan manufaktur?","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengelola Data Karyawan","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"HR bertanggung jawab memastikan data setiap karyawan tercatat dan selalu diperbarui.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data tersebut dapat meliputi identitas karyawan, jabatan, bagian atau divisi, status kerja, hingga informasi administratif lainnya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengelolaan data yang rapi membantu perusahaan ketika membutuhkan informasi karyawan untuk berbagai proses HR.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":2,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengelola Absensi Karyawan","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null}],"listType":"number","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Absensi menjadi salah satu pekerjaan rutin HR, terutama pada perusahaan manufaktur dengan jumlah karyawan yang cukup banyak.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"HR perlu memastikan data kehadiran, keterlambatan, izin, maupun ketidakhadiran karyawan tercatat dengan benar.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data absensi ini nantinya juga dapat menjadi bagian dari proses administrasi lainnya, termasuk perhitungan payroll.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":3,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengatur Shift Kerja","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null}],"listType":"number","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Operasional manufaktur sering kali berjalan menggunakan sistem shift.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Karena itu, HR perlu membantu mengelola jadwal kerja agar setiap bagian memiliki jumlah tenaga kerja yang sesuai dengan kebutuhan operasional.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Semakin banyak karyawan dan pola shift yang digunakan, semakin banyak pula data yang perlu diperiksa dan disesuaikan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":4,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":4,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mencatat dan Mengelola Lembur","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null}],"listType":"number","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Selain jam kerja reguler, perusahaan manufaktur juga dapat memiliki aktivitas lembur sesuai kebutuhan operasional.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"HR perlu memastikan data lembur karyawan tercatat dengan baik, mulai dari waktu lembur hingga informasi yang diperlukan untuk proses administrasi dan payroll.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":5,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":5,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengelola Cuti dan Izin","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null}],"listType":"number","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengajuan cuti dan izin juga menjadi bagian dari aktivitas HR sehari-hari.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"HR perlu mencatat pengajuan, memastikan proses persetujuan berjalan, sekaligus memperbarui informasi cuti karyawan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jika jumlah karyawan semakin banyak, pengelolaan cuti secara manual juga dapat membutuhkan lebih banyak waktu untuk diperiksa.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":6,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":6,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengelola Payroll","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Payroll merupakan salah satu proses penting dalam pengelolaan karyawan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"HR perlu memastikan berbagai data yang berkaitan dengan penggajian telah sesuai, termasuk data kehadiran, lembur, maupun komponen lain yang digunakan perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Karena melibatkan banyak data, proses payroll membutuhkan ketelitian agar informasi yang digunakan tetap akurat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":7,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":7,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Menangani Administrasi Karyawan","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null}],"listType":"number","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Selain proses di atas, HR juga menangani berbagai kebutuhan administrasi karyawan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mulai dari pembaruan dokumen, informasi status karyawan, hingga kebutuhan administratif lainnya yang mendukung operasional perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Semakin besar perusahaan, aktivitas administratif tersebut biasanya ikut bertambah.","type":"text","style":"","detail":0,"format":0,"version":1},{"type":"linebreak","version":1}],"direction":null,"textStyle":"","textFormat":0},{"id":"6a8c04e6acd8f568b4dcd72f","type":"upload","value":181,"fields":null,"format":"","version":3,"relationTo":"media"},{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Semakin Banyak Karyawan, Semakin Kompleks Proses HR","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pada perusahaan dengan jumlah karyawan yang masih sedikit, beberapa proses HR mungkin masih mudah dikelola secara manual.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Namun ketika jumlah karyawan bertambah, terdapat banyak shift, lembur, dan bagian kerja, data yang perlu dicatat serta diperiksa juga semakin banyak.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Bukan berarti proses manual selalu salah. Hanya saja, semakin kompleks kebutuhan perusahaan, semakin banyak waktu yang diperlukan HR untuk mencatat, mencocokkan, dan mengecek kembali data.","type":"text","style":"","detail":0,"format":0,"version":1},{"type":"linebreak","version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Karena itu, pengelolaan proses HR yang lebih terintegrasi dapat membantu perusahaan menjaga data tetap rapi sekaligus membuat pekerjaan administratif lebih efisien.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb, '2026-09-25T03:41:12.813Z', '2026-08-24T08:39:47.104Z', 193),
  (6, 'Cara Mengelola Cuti dan Izin Karyawan Secara Efektif ', 'cara-mengelola-cuti-dan-izin-karyawan-secara-efektif', 'teknologi', '2026-09-25T12:00:00.000Z', 194, 'Cuti dan izin adalah hak yang hampir setiap saat diajukan karyawan, baik untuk keperluan pribadi, kesehatan, maupun kepentingan mendesak lainnya.', '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Cuti dan izin adalah hak yang hampir setiap saat diajukan karyawan, baik untuk keperluan pribadi, kesehatan, maupun kepentingan mendesak lainnya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sekilas terlihat sederhana, tetapi ketika jumlah karyawan semakin banyak, pengajuan cuti dan izin bisa datang dari berbagai arah dalam waktu yang bersamaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jika prosesnya masih mengandalkan form kertas, chat pribadi, atau catatan Excel yang terpisah, HR perlu memeriksa satu per satu untuk memastikan data yang digunakan tetap akurat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Lalu, apa saja yang perlu diperhatikan agar pengelolaan cuti dan izin karyawan dapat berjalan lebih efektif?","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h2","type":"heading","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"1. Tetapkan Kebijakan Cuti yang Jelas","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Sebelum bicara soal proses, perusahaan perlu memastikan kebijakan cuti dan izin sudah jelas sejak awal.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Jenis cuti, jumlah kuota, hingga ketentuan pengajuan sebaiknya dipahami baik oleh karyawan maupun HR.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Kebijakan yang jelas membantu mengurangi pertanyaan berulang dan membuat proses pengajuan lebih konsisten untuk semua karyawan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"2. Sediakan Saluran Pengajuan yang Mudah Diakses","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Karyawan perlu memiliki cara yang mudah untuk mengajukan cuti atau izin, tanpa harus bertanya dulu ke HR mengenai formatnya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Ketika pengajuan masih tersebar di berbagai saluran seperti pesan pribadi, form manual, atau permintaan lisan, data menjadi lebih sulit dipantau dan berisiko ada yang terlewat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h2","type":"heading","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"3. Pastikan Proses Approval Berjalan Cepat","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Setelah diajukan, karyawan tentu berharap mengetahui status pengajuannya dengan segera.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Proses approval yang lambat, atau harus menunggu atasan sempat membuka pesan, dapat membuat karyawan menunggu tanpa kepastian.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Alur persetujuan yang jelas membantu proses ini berjalan lebih cepat, sekaligus memudahkan HR memantau pengajuan mana yang masih perlu ditindaklanjuti.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h2","type":"heading","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"4. Catat Sisa Cuti Secara Akurat","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Setiap pengajuan cuti yang disetujui perlu langsung memengaruhi sisa kuota karyawan yang bersangkutan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Jika pencatatan masih dilakukan secara terpisah dari proses approval, ada risiko data sisa cuti tidak diperbarui tepat waktu, sehingga rawan terjadi selisih saat karyawan menanyakan sisa cutinya sendiri.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h2","type":"heading","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"5. Perhatikan Cuti dan Izin yang Beririsan dengan Jadwal Kerja","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Pada perusahaan dengan sistem shift atau operasional yang padat, cuti dan izin perlu dilihat juga dari sisi jadwal kerja.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"HR perlu memastikan pengajuan tidak mengganggu kebutuhan operasional, terutama jika beberapa karyawan di bagian yang sama mengajukan cuti pada waktu yang berdekatan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h2","type":"heading","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"6. Lakukan Rekap Data Secara Berkala","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Seluruh data cuti dan izin, mulai dari pengajuan, status approval, hingga sisa kuota, perlu direkap secara rutin.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Rekap yang teratur membantu HR memiliki gambaran yang jelas mengenai pola cuti karyawan, sekaligus memastikan data tersebut siap digunakan untuk kebutuhan administrasi lain, termasuk payroll.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Semakin Banyak Karyawan, Semakin Penting Pengelolaan Cuti yang Rapi","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Pada perusahaan dengan jumlah karyawan yang masih sedikit, pengajuan cuti dan izin mungkin masih mudah dipantau secara manual.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Namun ketika jumlah karyawan bertambah, pengajuan datang dari berbagai bagian, dan approval melibatkan beberapa pihak, HR membutuhkan lebih banyak waktu untuk memastikan setiap data tetap sesuai.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Bukan berarti cara manual selalu salah. Hanya saja, semakin banyak pengajuan yang perlu diproses, semakin besar pula peluang terjadinya keterlambatan approval atau selisih pencatatan sisa cuti.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengelolaan cuti dan izin yang lebih terintegrasi dapat membantu perusahaan menjaga data tetap rapi, sekaligus membuat proses pengajuan dan approval berjalan lebih efisien bagi karyawan maupun HR.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Ingin mengetahui lebih lanjut bagaimana sistem HR yang terintegrasi dapat membantu mengelola cuti dan izin karyawan dengan lebih mudah?","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Pelajari solusi HRIS dari ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"MyBIT ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"selengkapnya di ","type":"text","style":"","detail":0,"format":0,"version":1},{"id":"6ab5ee0f9c0e1142875b6877","type":"link","fields":{"url":"https://mybit.id/","newTab":true,"linkType":"custom"},"format":"","indent":0,"version":3,"children":[{"mode":"normal","text":"mybit.id.","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb, '2026-09-25T03:44:33.758Z', '2026-09-25T03:44:33.757Z', 195),
  (2, 'Excel vs HRMS: Mana yang Lebih Efisien untuk Mengelola HR?', 'excel-vs-hrms', 'teknologi', '2026-08-14T12:00:00.000Z', 179, 'Excel vs HRMS: ketahui perbedaan, kelebihan, dan tantangan masing-masing dalam mengelola data karyawan, absensi, cuti, payroll, dan laporan HR.', '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Excel vs HRMS","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" sering menjadi pertimbangan perusahaan ketika mulai ingin merapikan proses administrasi HR. Excel sudah lama digunakan untuk mengelola data karyawan, absensi, cuti, lembur, hingga payroll. Namun, ketika jumlah karyawan dan kebutuhan perusahaan semakin bertambah, pengelolaan HR dengan Excel bisa menjadi lebih kompleks.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Lalu, apakah perusahaan harus langsung beralih ke HRMS? Atau Excel sebenarnya masih cukup?","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jawabannya tergantung pada kebutuhan dan kondisi perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Excel Masih Bisa Digunakan, Tapi Ada Batasnya","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Excel memang praktis. Hampir semua orang sudah familiar dengan penggunaannya dan perusahaan tidak membutuhkan proses belajar yang terlalu panjang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Untuk perusahaan dengan jumlah karyawan yang masih sedikit, Excel mungkin masih cukup untuk kebutuhan seperti:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data karyawan ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Rekap absensi ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengajuan dan rekap cuti ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":4,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perhitungan lembur ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":5,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data payroll ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":6,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Laporan sederhana ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Masalah biasanya mulai muncul ketika data semakin banyak dan proses HR semakin kompleks.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Misalnya, HR harus membuka beberapa file untuk mencari data karyawan, memperbarui data secara manual, atau memastikan apakah file yang digunakan merupakan versi terbaru.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Hal-hal sederhana seperti ini mungkin tidak terasa berat jika dilakukan sesekali.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Tapi kalau harus dilakukan setiap hari atau setiap bulan, waktu yang digunakan bisa cukup banyak.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Apa yang Sering Menjadi Kendala Saat Menggunakan Excel?","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Salah satu tantangan terbesar dalam penggunaan Excel untuk administrasi HR adalah pengelolaan data yang masih banyak dilakukan secara manual.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Beberapa kendala yang mungkin muncul antara lain:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"1. Risiko Human Error","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data yang dimasukkan atau diperbarui secara manual memiliki kemungkinan terjadi kesalahan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Salah input angka, data yang belum diperbarui, atau rumus yang berubah bisa memengaruhi hasil laporan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"2. Banyak File yang Harus Dikelola","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Ketika kebutuhan HR bertambah, jumlah file Excel juga bisa ikut bertambah.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Ada file absensi, file lembur, file cuti, file payroll, dan data karyawan yang mungkin berada di file berbeda.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Akhirnya muncul pertanyaan:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"“Yang terbaru yang mana?”","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"3. Rekap dan Pelaporan Membutuhkan Waktu","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"HR mungkin perlu menggabungkan beberapa data terlebih dahulu sebelum membuat laporan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Semakin banyak data yang harus diperiksa, semakin banyak waktu yang dibutuhkan untuk memastikan laporan sudah benar.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"4. Data Tidak Selalu Terintegrasi","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Ketika data masih dikelola dalam beberapa file, HR perlu melakukan pengecekan atau input ulang agar informasi dari satu proses dapat digunakan untuk proses lainnya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di sinilah pekerjaan administratif bisa menjadi semakin panjang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Lalu, Apa Bedanya dengan HRMS?","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"HRMS (Human Resources Management System)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" merupakan sistem yang dirancang untuk membantu perusahaan mengelola berbagai proses HR dalam satu sistem.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Daripada menyimpan dan mengelola setiap proses dalam file yang berbeda, perusahaan dapat menggunakan sistem untuk mengelola data karyawan, absensi, cuti, payroll, dan proses HR lainnya secara lebih terintegrasi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Tujuannya bukan untuk menghilangkan peran HR.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Justru, HRMS membantu mengurangi pekerjaan administratif yang berulang sehingga HR bisa memiliki lebih banyak waktu untuk pekerjaan yang membutuhkan perhatian dan pengambilan keputusan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Excel vs HRMS: Apa Perbedaannya?","type":"text","style":"","detail":0,"format":1,"version":1},{"id":"6a7e800db647b1023d60e098","type":"upload","value":180,"fields":{},"format":"","version":3,"relationTo":"media"}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jadi, Mana yang Lebih Efisien?","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sebenarnya bukan berarti Excel buruk dan HRMS selalu lebih baik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Excel masih menjadi pilihan yang masuk akal untuk perusahaan dengan kebutuhan sederhana dan jumlah data yang belum terlalu banyak.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Namun, ketika perusahaan mulai berkembang, jumlah karyawan bertambah, dan proses HR semakin banyak, penggunaan HRMS dapat membantu membuat pengelolaan data menjadi lebih terstruktur.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pertanyaannya bukan hanya:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"“Excel masih bisa digunakan atau tidak?”","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Tetapi:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"“Apakah cara kerja yang digunakan sekarang masih efisien untuk kebutuhan perusahaan?”","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kalau HR mulai menghabiskan banyak waktu untuk mencari file, melakukan input ulang, mengecek data, atau membuat laporan secara manual, mungkin sudah saatnya perusahaan mempertimbangkan sistem HR yang lebih terintegrasi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"HRMS untuk Membantu Pengelolaan HR yang Lebih Terintegrasi","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Digitalisasi HR tidak harus berarti semua pekerjaan HR dilakukan oleh sistem.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Peran HR tetap penting dalam mengelola karyawan, menyelesaikan masalah, mengambil keputusan, dan mengembangkan lingkungan kerja yang lebih baik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Teknologi hanya membantu bagian-bagian administratif agar dapat dilakukan dengan lebih sederhana dan terstruktur.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kalau ingin melihat bagaimana sistem HR dapat membantu proses administrasi di perusahaan, Anda bisa mengenal lebih lanjut ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"My BIT","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" melalui ","type":"text","style":"","detail":0,"format":0,"version":1},{"id":"6a7e8045b647b1023d60e099","type":"link","fields":{"url":"https://mybit.id/","newTab":true,"linkType":"custom"},"format":"","indent":0,"version":3,"children":[{"mode":"normal","text":"mybit.id","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"mode":"normal","text":".","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb, '2026-09-25T03:46:37.695Z', '2026-08-14T02:41:31.620Z', 179),
  (1, 'Digitalisasi HR: Manfaat dan Pentingnya HRIS bagi Perusahaan', 'digitalisasi-hr-manfaat-dan-pentingnya-hris-bagi-perusahaan', 'teknologi', '2026-08-07T12:00:00.000Z', 178, 'Pelajari mengapa digitalisasi HR menjadi kebutuhan perusahaan modern. Ketahui manfaat HRIS untuk absensi, pengajuan cuti, payroll, dan pengelolaan data karyawan agar proses kerja lebih efisien.', '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengapa Digitalisasi HR Menjadi Kebutuhan Perusahaan Modern?","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di setiap perusahaan, tim Human Resources (HR) memiliki peran penting dalam memastikan berbagai proses administrasi berjalan dengan baik. Mulai dari mengelola absensi, menerima pengajuan cuti, memperbarui data karyawan, hingga memproses payroll, hampir seluruh aktivitas administrasi karyawan melibatkan tim HR.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pada perusahaan dengan jumlah karyawan yang masih sedikit, proses tersebut mungkin masih dapat dilakukan secara manual. Namun, seiring pertumbuhan perusahaan, jumlah data dan aktivitas administrasi juga ikut meningkat. Jika tidak didukung dengan sistem yang tepat, pekerjaan administratif dapat menyita banyak waktu dan mengurangi efisiensi kerja.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Inilah mengapa ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"digitalisasi HR","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" kini menjadi salah satu langkah yang mulai diterapkan oleh banyak perusahaan. Bukan sekadar mengikuti perkembangan teknologi, tetapi sebagai upaya untuk menciptakan proses kerja yang lebih efektif, akurat, dan mudah dikelola.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Tantangan Pengelolaan HR Secara Manual","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Masih banyak perusahaan yang mengelola administrasi HR menggunakan proses manual. Misalnya, karyawan mengisi formulir pengajuan cuti secara tertulis, data absensi direkap satu per satu, atau informasi karyawan disimpan di beberapa file yang berbeda.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Cara kerja seperti ini memang sudah lama digunakan. Namun, ketika jumlah karyawan bertambah, proses manual mulai menghadirkan berbagai tantangan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sebagai contoh, pengajuan cuti yang masih menggunakan formulir kertas harus melalui beberapa tahapan. Karyawan mengisi formulir, kemudian meminta persetujuan atasan, lalu menyerahkannya kepada HR untuk dicatat kembali. Jika dokumen tertunda atau terselip, proses administrasi pun ikut terhambat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Hal serupa juga dapat terjadi pada proses absensi, payroll, maupun pembaruan data karyawan. Selain membutuhkan waktu lebih lama, pekerjaan yang dilakukan secara manual juga memiliki risiko kesalahan pencatatan yang lebih tinggi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Akibatnya, tim HR lebih banyak menghabiskan waktu untuk pekerjaan administratif yang berulang dibandingkan menjalankan peran strategis seperti pengembangan karyawan atau peningkatan ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"employee experience","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":".","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengapa Digitalisasi HR Menjadi Solusi?","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Digitalisasi HR merupakan proses memanfaatkan teknologi untuk membantu pengelolaan administrasi sumber daya manusia menjadi lebih efisien.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"HRIS (Human Resource Information System), ","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"berbagai proses seperti absensi, pengajuan cuti, payroll, hingga pengelolaan data karyawan dapat dilakukan dalam satu sistem yang saling terintegrasi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan proses yang lebih terstruktur, perusahaan dapat mengurangi pekerjaan administratif yang berulang serta mempermudah pengelolaan data. Informasi juga menjadi lebih mudah diakses ketika dibutuhkan, sehingga proses kerja dapat berjalan lebih cepat dan akurat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perlu dipahami bahwa digitalisasi bukan berarti menggantikan peran HR. Sebaliknya, teknologi hadir untuk membantu HR mengurangi pekerjaan administratif sehingga memiliki lebih banyak waktu untuk fokus pada pengembangan karyawan dan kebutuhan bisnis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Manfaat Digitalisasi HR bagi Perusahaan","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Penerapan sistem HR digital memberikan berbagai manfaat, tidak hanya bagi tim HR tetapi juga bagi perusahaan secara keseluruhan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Beberapa manfaat yang dapat dirasakan antara lain:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mempermudah pengelolaan absensi karyawan. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mempercepat proses pengajuan dan persetujuan cuti. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Membantu proses payroll menjadi lebih efisien dan akurat. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":4,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mengurangi risiko kesalahan akibat pencatatan manual. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":5,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Menyimpan data karyawan dalam satu sistem yang lebih terorganisir. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":6,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mempermudah penyusunan laporan HR. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":7,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Membantu manajemen memperoleh data yang lebih cepat untuk mendukung pengambilan keputusan. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan proses administrasi yang lebih sederhana, tim HR dapat mengalokasikan waktu untuk menjalankan fungsi yang lebih strategis, seperti pengembangan kompetensi karyawan, perencanaan tenaga kerja, dan peningkatan pengalaman kerja.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Tanda Perusahaan Mulai Membutuhkan HRIS","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Setiap perusahaan memiliki kebutuhan yang berbeda. Namun, ada beberapa kondisi yang dapat menjadi tanda bahwa perusahaan sudah mulai membutuhkan sistem HRIS, di antaranya:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jumlah karyawan terus bertambah. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengajuan cuti masih menggunakan formulir manual. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Rekap absensi membutuhkan waktu yang lama. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":4,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Payroll dilakukan secara manual setiap akhir bulan. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":5,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data karyawan tersebar di banyak file atau dokumen. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":6,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Tim HR lebih banyak menghabiskan waktu untuk pekerjaan administratif dibandingkan pekerjaan strategis. ","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jika beberapa kondisi tersebut mulai sering terjadi, perusahaan dapat mempertimbangkan digitalisasi HR sebagai salah satu langkah untuk meningkatkan efisiensi operasional.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Digitalisasi HR Bukan Menggantikan Peran Manusia","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Masih ada anggapan bahwa penerapan teknologi akan menggantikan pekerjaan HR. Padahal, tujuan digitalisasi bukanlah menggantikan manusia, melainkan membantu menyederhanakan proses kerja.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Keputusan terkait pengelolaan karyawan, pengembangan talenta, hingga membangun budaya perusahaan tetap membutuhkan peran HR. Teknologi hanya membantu mengurangi pekerjaan administratif yang bersifat berulang sehingga HR dapat memberikan kontribusi yang lebih besar bagi organisasi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perkembangan perusahaan membawa tantangan baru dalam pengelolaan sumber daya manusia. Semakin banyak karyawan yang dikelola, semakin kompleks pula proses administrasi yang harus dijalankan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui digitalisasi HR, perusahaan dapat menyederhanakan berbagai proses seperti absensi, pengajuan cuti, payroll, hingga pengelolaan data karyawan. Selain meningkatkan efisiensi, sistem yang terintegrasi juga membantu mengurangi risiko kesalahan dan memberikan lebih banyak waktu bagi tim HR untuk fokus pada pekerjaan yang memberikan nilai tambah bagi perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Waktunya HR Bertransformasi ke Sistem Digital","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Digitalisasi bukan hanya tentang penggunaan teknologi, tetapi tentang membangun proses kerja yang lebih efektif untuk mendukung pertumbuhan bisnis dalam jangka panjang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Setiap perusahaan memiliki kebutuhan yang berbeda dalam mengelola proses HR. Memahami tantangan yang dihadapi merupakan langkah awal untuk menentukan solusi yang tepat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jika Anda ingin mempelajari bagaimana sistem ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"HRIS","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" dapat membantu menyederhanakan proses absensi, pengajuan cuti, payroll, hingga pengelolaan data karyawan, Anda dapat mengunjungi ","type":"text","style":"","detail":0,"format":0,"version":1},{"id":"6a754a7f95af24e692ded3a6","type":"link","fields":{"url":"https://mybit.id/","newTab":true,"linkType":"custom"},"format":"","indent":0,"version":3,"children":[{"mode":"normal","text":"mybit.id","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"mode":"normal","text":" untuk mendapatkan informasi lebih lanjut mengenai solusi yang sesuai dengan kebutuhan perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb, '2026-09-25T03:46:51.276Z', '2026-08-07T02:57:40.887Z', 178),
  (5, 'Apa Saja yang Perlu Dicek Sebelum Payroll?', 'apa-saja-yang-perlu-dicek-sebelum-payroll', 'teknologi', '2026-08-24T12:00:00.000Z', 196, 'Sebelum payroll diproses, pastikan data absensi, shift, lembur, cuti/izin, dan data karyawan sudah diperiksa agar perhitungan gaji tetap akurat.', '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Payroll bukan hanya soal menghitung gaji. Sebelum proses penggajian dilakukan, HR perlu memastikan berbagai data pendukung sudah sesuai agar hasil perhitungan tidak perlu diperiksa berulang kali.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Apalagi pada perusahaan dengan banyak karyawan, sistem shift, lembur, serta perubahan data yang terjadi selama satu periode kerja.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Berikut beberapa data yang sebaiknya diperiksa sebelum payroll diproses.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data Absensi Karyawan","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Pastikan data kehadiran karyawan sudah lengkap dan sesuai.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mulai dari jam masuk, jam pulang, keterlambatan, ketidakhadiran, hingga data absensi yang mungkin belum tercatat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data absensi yang belum lengkap dapat membuat HR perlu melakukan pengecekan ulang saat proses payroll berjalan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":2,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jadwal dan Shift Kerja","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Untuk perusahaan yang menggunakan sistem shift, jadwal kerja setiap karyawan perlu diperiksa.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pastikan absensi sudah sesuai dengan shift yang dijalankan, termasuk jika terdapat perubahan atau pertukaran jadwal selama periode tersebut.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":3,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data Lembur","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Jam lembur juga perlu diperiksa sebelum payroll.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pastikan durasi lembur, tanggal pelaksanaan, serta status persetujuannya sudah sesuai dengan data yang digunakan perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Semakin banyak aktivitas lembur, semakin penting pencatatannya dilakukan dengan rapi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":4,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":4,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Cuti dan Izin","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"justify","indent":0,"version":1,"children":[{"mode":"normal","text":"Periksa kembali data cuti, izin, maupun ketidakhadiran lainnya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pastikan setiap pengajuan sudah memiliki status yang jelas sehingga data tersebut tidak berbeda dengan catatan kehadiran karyawan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":5,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":5,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perubahan Data Karyawan","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dalam satu periode payroll, data karyawan dapat mengalami perubahan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Misalnya perubahan jabatan, bagian kerja, status karyawan, maupun informasi administratif lainnya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Karena itu, pastikan payroll menggunakan data terbaru yang sesuai dengan kondisi karyawan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":6,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":6,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Komponen Payroll","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Setelah data kehadiran diperiksa, pastikan kembali komponen payroll yang digunakan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Setiap perusahaan dapat memiliki komponen yang berbeda sesuai kebijakan masing-masing. Yang terpenting, seluruh data berasal dari periode yang benar dan sudah diperiksa sebelum perhitungan dilakukan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ol","type":"list","start":7,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":7,"format":"","indent":0,"version":1,"children":[{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Lakukan Pengecekan Akhir","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textFormat":1}],"listType":"number","direction":null,"textFormat":1},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sebelum payroll diproses, lakukan pengecekan terakhir terhadap data utama:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Absensi • Shift • Lembur • Cuti/Izin • Data Karyawan • Komponen Payroll","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengecekan akhir membantu HR memastikan tidak ada informasi penting yang tertinggal sebelum proses penggajian dilanjutkan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[],"direction":null,"textStyle":"","textFormat":0},{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Semakin Banyak Karyawan, Semakin Banyak Data yang Perlu Dicocokkan","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"id":"6ab617152220db2242f513bd","type":"upload","value":197,"fields":null,"format":"","version":3,"relationTo":"media"},{"mode":"normal","text":"Pada perusahaan dengan jumlah karyawan yang masih sedikit, pengecekan payroll mungkin masih relatif sederhana.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Namun ketika jumlah karyawan bertambah, terdapat lebih banyak absensi, shift, lembur, cuti, izin, dan perubahan data yang perlu diperiksa dalam periode yang sama.","type":"text","style":"","detail":0,"format":0,"version":1},{"type":"linebreak","version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Bukan berarti proses manual selalu salah. Namun semakin banyak data yang digunakan, semakin banyak pula waktu yang dibutuhkan untuk mencatat, mencocokkan, dan mengecek kembali informasi sebelum payroll.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Karena itu, pengelolaan data HR yang lebih terintegrasi dapat membantu perusahaan menjaga informasi tetap rapi sekaligus membuat proses administrasi dan payroll menjadi lebih efisien.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kelola Data HR dengan Lebih Terintegrasi","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Data payroll akan lebih mudah diperiksa ketika informasi absensi, shift, lembur, cuti, dan data karyawan dapat dikelola secara terpusat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan sistem HRIS, HR dapat mengurangi proses pengecekan data yang tersebar dan lebih fokus memastikan proses penggajian berjalan dengan baik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"h3","type":"heading","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Ingin mengetahui bagaimana HRIS dapat membantu proses HR dan payroll?","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pelajari solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"HRIS BIT ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"selengkapnya melalui website ","type":"text","style":"","detail":0,"format":0,"version":1},{"id":"6a8c05b2acd8f568b4dcd735","type":"link","fields":{"url":"https://mybit.id/","newTab":true,"linkType":"custom"},"format":"","indent":0,"version":3,"children":[{"mode":"normal","text":"mybit.id","type":"text","style":"","detail":0,"format":1,"version":1}],"direction":null}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb, '2026-09-25T06:39:24.474Z', '2026-08-24T08:50:03.105Z', 198);

-- Data untuk tabel: "partnership_solutions" (85 rows)
TRUNCATE TABLE "partnership_solutions" CASCADE;
INSERT INTO "partnership_solutions" ("id", "name", "updated_at", "created_at") VALUES
  (7, 'Emudhra', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (8, 'CYBLE', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (9, 'SUPERMICRO', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (10, 'AXIS', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (11, 'CISCO', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (12, 'APPCAMO', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (13, 'SOPHOS', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (14, 'HUAWEI', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (15, 'RUCKUS', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (16, 'FORCEPOINT', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (17, 'Nimble Storage', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (18, 'DEVO', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (19, 'EC Council', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (20, 'ACER', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (21, 'Trend Micro', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (22, 'DELL', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (23, 'ALLIED TELESIS', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (24, 'SAMSUNG', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (25, 'Commvault', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (26, 'ADLINK', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (27, 'ASUS', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (28, 'MICROSOFT', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (29, 'SYNOLOGY', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (30, 'Hennge', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (31, 'NUTANIX', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (32, 'KEYSIGHT', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (33, 'SEAGATE INTERNAL', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (34, 'FORTINET', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (35, 'TELTONIKA', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (36, 'GIGABYTE', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (37, 'NETAPP', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (38, 'QNAP', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (39, 'IBM', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (40, 'INFORMATICA', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (41, 'Omada', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (42, 'HIKVISION', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (43, 'Efficient IP', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (44, 'CITRIX', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (45, 'BOSCH', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (46, 'INFOBLOX', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (47, 'MERCUSYS', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (48, 'OpenText', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (49, 'VERSA', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (50, 'HPE', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (51, 'ORACLE', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (52, 'SANGFOR', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (53, 'TPLink', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (54, 'LENOVO', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (55, 'Vigi', '2026-09-29T02:08:25.859Z', '2026-09-29T02:08:25.859Z'),
  (56, 'PHILIPS', '2026-09-29T04:24:43.566Z', '2026-09-29T04:24:43.566Z'),
  (57, 'COOCAA', '2026-09-29T04:24:43.566Z', '2026-09-29T04:24:43.566Z'),
  (58, 'MENDIX', '2026-09-29T04:24:43.566Z', '2026-09-29T04:24:43.566Z'),
  (66, 'Hisense', '2026-09-29T07:11:14.394Z', '2026-09-29T07:11:14.394Z'),
  (67, 'Hiscreen', '2026-09-29T07:11:14.394Z', '2026-09-29T07:11:14.394Z'),
  (68, 'PyxScreen', '2026-09-29T07:11:14.394Z', '2026-09-29T07:11:14.394Z'),
  (69, 'INFINIX', '2026-09-29T07:11:14.394Z', '2026-09-29T07:11:14.394Z'),
  (70, 'ITEL', '2026-09-29T07:11:14.394Z', '2026-09-29T07:11:14.394Z'),
  (71, 'MOTOROLA', '2026-09-29T07:11:14.394Z', '2026-09-29T07:11:14.394Z'),
  (72, 'INOI', '2026-09-29T07:11:14.394Z', '2026-09-29T07:11:14.394Z'),
  (83, 'FALCONSTOR', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (84, 'RUBRIK', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (85, 'VEEAM', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (86, 'ARCTERA', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (87, 'COHESITY', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (88, 'APC RR', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (89, 'EATON', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (90, 'VERTIV', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (91, 'SOCOMEC', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (92, 'ICA', '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (102, 'BLUEPRINT', '2026-09-29T08:16:57.316Z', '2026-09-29T08:16:57.316Z'),
  (103, 'EPSON', '2026-09-29T08:16:57.316Z', '2026-09-29T08:16:57.316Z'),
  (104, 'HP', '2026-09-29T08:16:57.316Z', '2026-09-29T08:16:57.316Z'),
  (105, 'LG', '2026-09-29T08:16:57.316Z', '2026-09-29T08:16:57.316Z'),
  (106, 'MAXHUB', '2026-09-29T08:16:57.316Z', '2026-09-29T08:16:57.316Z'),
  (107, 'MSI', '2026-09-29T08:16:57.316Z', '2026-09-29T08:16:57.316Z'),
  (108, 'VIEWSONIC', '2026-09-29T08:16:57.316Z', '2026-09-29T08:16:57.316Z'),
  (109, 'ZEBRA', '2026-09-29T08:16:57.316Z', '2026-09-29T08:16:57.316Z'),
  (110, 'Aorus', '2026-09-29T08:16:57.316Z', '2026-09-29T08:16:57.316Z'),
  (118, 'ANYDESK', '2026-09-30T03:11:33.388Z', '2026-09-30T03:11:33.388Z'),
  (119, 'AUTODESK', '2026-09-30T03:11:33.388Z', '2026-09-30T03:11:33.388Z'),
  (120, 'HULFT', '2026-09-30T03:11:33.388Z', '2026-09-30T03:11:33.388Z'),
  (121, 'LOGITECH', '2026-09-30T03:11:33.388Z', '2026-09-30T03:11:33.388Z'),
  (122, 'SUSE', '2026-09-30T03:11:33.388Z', '2026-09-30T03:11:33.388Z'),
  (123, 'TEAMVIEWER', '2026-09-30T03:11:33.388Z', '2026-09-30T03:11:33.388Z'),
  (124, 'Sherpa', '2026-09-30T03:11:33.388Z', '2026-09-30T03:11:33.388Z');

-- Data untuk tabel: "partnerships" (4 rows)
TRUNCATE TABLE "partnerships" CASCADE;
INSERT INTO "partnerships" ("id", "name", "logo_id", "updated_at", "created_at") VALUES
  (1, 'HP', 7, '2026-05-18T02:04:04.479Z', '2026-05-18T02:04:04.479Z'),
  (2, 'Dell', 8, '2026-05-18T02:04:51.692Z', '2026-05-18T02:04:51.692Z'),
  (3, 'Kaspersky', 9, '2026-05-18T02:08:41.215Z', '2026-05-18T02:08:41.215Z'),
  (4, 'Huawei', 10, '2026-05-18T02:09:18.142Z', '2026-05-18T02:09:18.142Z');

-- Data untuk tabel: "payload_locked_documents" (3 rows)
TRUNCATE TABLE "payload_locked_documents" CASCADE;
INSERT INTO "payload_locked_documents" ("id", "global_slug", "updated_at", "created_at") VALUES
  (79, NULL, '2026-06-08T00:29:39.795Z', '2026-06-08T00:29:39.795Z'),
  (390, NULL, '2026-10-02T01:43:22.912Z', '2026-10-02T01:43:22.911Z'),
  (391, NULL, '2026-10-02T01:47:59.858Z', '2026-10-02T01:47:59.858Z');

-- Data untuk tabel: "payload_locked_documents_rels" (4 rows)
TRUNCATE TABLE "payload_locked_documents_rels" CASCADE;
INSERT INTO "payload_locked_documents_rels" ("id", "order", "parent_id", "path", "users_id", "media_id", "services_id", "customers_id", "partnerships_id", "careers_id", "products_id", "faqs_id", "portfolios_id", "visitors_id", "pricing_faqs_id", "problems_id", "news_id", "solutions_id", "industries_id", "solution_categories_id", "partnership_solutions_id") VALUES
  (741, NULL, 391, 'document', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 76, NULL, NULL, NULL),
  (742, NULL, 391, 'user', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (739, NULL, 390, 'document', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 77, NULL, NULL, NULL),
  (740, NULL, 390, 'user', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Data untuk tabel: "payload_migrations" (1 rows)
TRUNCATE TABLE "payload_migrations" CASCADE;
INSERT INTO "payload_migrations" ("id", "name", "batch", "updated_at", "created_at") VALUES
  (1, 'dev', '-1', '2026-10-02T01:13:34.420Z', '2026-05-16T04:43:35.033Z');

-- Data untuk tabel: "payload_preferences" (27 rows)
TRUNCATE TABLE "payload_preferences" CASCADE;
INSERT INTO "payload_preferences" ("id", "key", "value", "updated_at", "created_at") VALUES
  (3, 'collection-media', '{"limit":25,"editViewType":"default"}'::jsonb, '2026-06-19T01:41:19.284Z', '2026-05-16T06:33:17.562Z'),
  (20, 'collection-services-5', '{"fields":{"_index-9":{"tabIndex":3}}}'::jsonb, '2026-06-20T04:18:24.346Z', '2026-06-19T07:01:56.779Z'),
  (1, 'collection-users', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-05-16T04:53:11.786Z', '2026-05-16T04:46:10.547Z'),
  (14, 'global-about-us', '{"fields":{"_index-0":{"tabIndex":6},"coreValues":{"collapsed":["6a13ed883bcda97b3e55b26d"]},"milestones":{"collapsed":[]}},"editViewType":"default"}'::jsonb, '2026-06-19T02:06:45.720Z', '2026-05-21T02:07:58.767Z'),
  (17, 'collection-faqs-3', '{"fields":{"qnaList":{"collapsed":["6a0d0f329069fe528b7a1147"]}}}'::jsonb, '2026-05-29T06:22:17.147Z', '2026-05-29T06:21:36.033Z'),
  (16, 'collection-services-3', '{"fields":{"_index-7":{"tabIndex":2},"_index-9":{"tabIndex":2}}}'::jsonb, '2026-06-19T03:04:43.371Z', '2026-05-22T07:32:17.977Z'),
  (12, 'collection-services-2', '{"fields":{"_index-7":{"tabIndex":6},"_index-9":{"tabIndex":5},"pricing.tiers":{"collapsed":[]},"pricing.tiers.0.features":{"collapsed":["6a0d5a853596dbd86f463377"]}}}'::jsonb, '2026-06-20T06:21:23.848Z', '2026-05-20T04:14:00.303Z'),
  (6, 'collection-partnerships', '{"editViewType":"default"}'::jsonb, '2026-05-18T01:26:53.550Z', '2026-05-18T01:26:53.456Z'),
  (19, 'collection-services-6', '{"fields":{"_index-9":{"tabIndex":5}}}'::jsonb, '2026-06-20T06:22:39.086Z', '2026-06-19T06:37:11.992Z'),
  (7, 'collection-customers', '{"editViewType":"default"}'::jsonb, '2026-05-18T01:29:09.527Z', '2026-05-18T01:29:05.564Z'),
  (18, 'collection-services-4', '{"fields":{"_index-9":{"tabIndex":6}}}'::jsonb, '2026-06-19T03:49:57.863Z', '2026-06-18T07:01:42.314Z'),
  (4, 'collection-services', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-05-18T04:13:15.495Z', '2026-05-16T07:20:08.974Z'),
  (8, 'collection-products', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-05-18T04:19:15.717Z', '2026-05-18T04:15:36.728Z'),
  (9, 'collection-portfolios', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-05-19T08:32:57.319Z', '2026-05-19T08:27:26.839Z'),
  (21, 'collection-services-7', '{"fields":{"_index-9":{"tabIndex":5}}}'::jsonb, '2026-06-20T06:39:30.012Z', '2026-06-19T07:36:44.727Z'),
  (10, 'collection-visitors', '{"editViewType":"default"}'::jsonb, '2026-05-20T01:22:56.884Z', '2026-05-19T08:45:57.115Z'),
  (11, 'collection-faqs', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-05-20T01:42:30.287Z', '2026-05-20T01:23:06.516Z'),
  (5, 'collection-careers', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-05-20T03:31:45.270Z', '2026-05-16T07:32:45.524Z'),
  (22, 'collection-news', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-07-31T01:45:30.496Z', '2026-07-31T01:05:56.289Z'),
  (2, 'nav', '{"open":true,"groups":{"Collections":{"open":true}}}'::jsonb, '2026-09-09T01:40:03.310Z', '2026-05-16T04:49:34.827Z'),
  (15, 'collection-problems', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-05-22T01:15:02.507Z', '2026-05-22T01:05:57.474Z'),
  (13, 'collection-pricing-faqs', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-05-21T01:49:54.791Z', '2026-05-21T00:52:33.174Z'),
  (25, 'collection-solution-categories', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-09-22T07:05:18.417Z', '2026-09-22T03:58:45.454Z'),
  (23, 'collection-solutions', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-09-22T07:05:22.764Z', '2026-09-22T02:11:20.608Z'),
  (28, 'collection-partnership-solutions', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-09-23T08:04:42.432Z', '2026-09-23T07:24:55.344Z'),
  (24, 'collection-industries', '{"limit":10,"editViewType":"default"}'::jsonb, '2026-09-23T08:04:48.699Z', '2026-09-22T03:34:55.359Z'),
  (26, 'collection-solutions', '{"sort":"-publishedDate","limit":10}'::jsonb, '2026-10-01T02:03:52.963Z', '2026-09-22T07:05:20.620Z');

-- Data untuk tabel: "payload_preferences_rels" (30 rows)
TRUNCATE TABLE "payload_preferences_rels" CASCADE;
INSERT INTO "payload_preferences_rels" ("id", "order", "parent_id", "path", "users_id") VALUES
  (235, NULL, 3, 'user', 1),
  (295, NULL, 20, 'user', 1),
  (5, NULL, 1, 'user', 1),
  (128, NULL, 17, 'user', 1),
  (239, NULL, 14, 'user', 1),
  (241, NULL, 16, 'user', 1),
  (301, NULL, 12, 'user', 1),
  (16, NULL, 6, 'user', 1),
  (302, NULL, 19, 'user', 1),
  (18, NULL, 7, 'user', 1),
  (21, NULL, 4, 'user', 1),
  (249, NULL, 18, 'user', 1),
  (24, NULL, 8, 'user', 1),
  (26, NULL, 9, 'user', 1),
  (306, NULL, 21, 'user', 1),
  (28, NULL, 10, 'user', 1),
  (31, NULL, 11, 'user', 1),
  (309, NULL, 22, 'user', 1),
  (33, NULL, 5, 'user', 1),
  (310, NULL, 22, 'user', 1),
  (312, NULL, 2, 'user', 1),
  (95, NULL, 15, 'user', 1),
  (43, NULL, 13, 'user', 1),
  (319, NULL, 25, 'user', 1),
  (322, NULL, 23, 'user', 1),
  (345, NULL, 28, 'user', 1),
  (346, NULL, 28, 'user', 1),
  (347, NULL, 24, 'user', 1),
  (348, NULL, 24, 'user', 1),
  (351, NULL, 26, 'user', 1);

-- Data untuk tabel: "portfolios" (3 rows)
TRUNCATE TABLE "portfolios" CASCADE;
INSERT INTO "portfolios" ("id", "client_name", "customer_id", "description", "image_id", "updated_at", "created_at") VALUES
  (3, 'PT Ravalia Inti Mandiri', 5, 'Implementasi Warehouse Management System (WMS) untuk digitalisasi operasional gudang, menggantikan pencatatan manual dengan sistem pelacakan data yang terpusat dan akurat.', 74, '2026-06-15T03:33:18.812Z', '2026-06-03T03:35:45.319Z'),
  (1, 'Toyota Boshoku Indonesia', 1, 'Pengembangan sistem TDPS kustom berbasis web dan mobile, dipadukan dengan implementasi serta integrasi modul SAP secara menyeluruh.', 176, '2026-06-22T06:07:44.810Z', '2026-05-22T08:16:32.092Z'),
  (2, 'PT Bonecom Tricom', 2, 'Pengembangan dan implementasi Enterprise Resource Planning (ERP) khusus manufaktur untuk mendigitalisasi proses operasional perusahaan melalui sistem yang terpusat.', 188, '2026-09-09T01:50:44.981Z', '2026-06-03T03:03:33.925Z');

-- Data untuk tabel: "portfolios_achievements" (8 rows)
TRUNCATE TABLE "portfolios_achievements" CASCADE;
INSERT INTO "portfolios_achievements" ("_order", "_parent_id", "id", "text") VALUES
  (1, 3, '6a2f726dcf6453b1d66c200b', 'Real-time Stock Movement Tracking (Inbound & Outbound).'),
  (2, 3, '6a2f7273cf6453b1d66c200c', 'Material Availability Monitoring.'),
  (3, 3, '6a2f7278cf6453b1d66c200d', 'Warehouse Performance Trend Analysis.'),
  (1, 1, '6a1010bd9bfa303fb2f31a9f', 'Customized TDPS System (Web & Mobile Applications).'),
  (2, 1, '6a1010c69bfa303fb2f31aa1', 'SAP Module Integration & Implementation.'),
  (1, 2, '6a2f71cfcf6453b1d66c2008', 'Manufacturing ERP System Implementation.'),
  (2, 2, '6a2f71d7cf6453b1d66c2009', 'Core Modules Integration (Finance, Quality, Production, & Production Control).'),
  (3, 2, '6a2f71e1cf6453b1d66c200a', 'Digital Kanban System for Real-time Tracking & Inventory Optimization.');

-- Data untuk tabel: "portfolios_rels" (3 rows)
TRUNCATE TABLE "portfolios_rels" CASCADE;
INSERT INTO "portfolios_rels" ("id", "order", "parent_id", "path", "services_id") VALUES
  (7, 1, 3, 'relatedServices', 2),
  (8, 1, 1, 'relatedServices', 2),
  (9, 1, 2, 'relatedServices', 2);

-- Data untuk tabel: "portfolios_tags" (3 rows)
TRUNCATE TABLE "portfolios_tags" CASCADE;
INSERT INTO "portfolios_tags" ("_order", "_parent_id", "id", "label", "theme") VALUES
  (1, 3, '6a1fa0f31597132a6358123f', 'Warehouse Management System', 'software'),
  (1, 1, '6a1010cb9bfa303fb2f31aa3', 'Software', 'software'),
  (1, 2, '6a1f999ed3a8e59e1324bc23', 'Software ERP', 'software');

-- Data untuk tabel: "problems" (6 rows)
TRUNCATE TABLE "problems" CASCADE;
INSERT INTO "problems" ("id", "title", "description", "icon_id", "updated_at", "created_at") VALUES
  (1, 'Keamanan & Keandalan', 'Menghadirkan solusi dan layanan IT yang terjamin aman, andal, dan mematuhi standar enterprise untuk melindungi aset digital Anda.', 31, '2026-05-22T07:14:52.541Z', '2026-05-22T07:14:52.539Z'),
  (2, 'Solusi Kustom & Terintegrasi', 'Kami merancang dan mengintegrasikan sistem (termasuk ERP, WMS, dan modul SAP) yang disesuaikan secara presisi dengan alur kerja spesifik perusahaan.', 28, '2026-05-22T07:15:23.621Z', '2026-05-22T07:15:23.621Z'),
  (3, 'Skalabilitas Fleksibel', 'Mengembangkan infrastruktur dan aplikasi yang dirancang untuk dapat diskalakan (scalable) dengan mudah seiring dengan percepatan pertumbuhan bisnis Anda.', 32, '2026-05-22T07:15:59.667Z', '2026-05-22T07:15:59.667Z'),
  (4, 'Keahlian Teknis Terpadu', 'Menggabungkan keahlian teknis yang mendalam, desain kreatif (UI/UX), dan wawasan strategis untuk memecahkan berbagai kompleksitas operasional.', 33, '2026-05-22T07:16:28.082Z', '2026-05-22T07:16:28.082Z'),
  (5, 'Inovasi yang Berkelanjutan', 'Selalu selangkah di depan dalam mengadopsi teknologi mutakhir guna memastikan bisnis Anda tetap adaptif di era lanskap digital yang dinamis.', 34, '2026-05-22T07:16:52.487Z', '2026-05-22T07:16:52.486Z'),
  (6, 'Kemitraan Jangka Panjang', 'Kami bukan sekadar vendor, melainkan mitra strategis yang membangun kolaborasi jangka panjang berdasarkan kepercayaan, kualitas, dan kesuksesan bersama.', 35, '2026-05-22T07:17:21.241Z', '2026-05-22T07:17:21.241Z');

-- Data untuk tabel: "products" (2 rows)
TRUNCATE TABLE "products" CASCADE;
INSERT INTO "products" ("id", "name", "product_url", "badge", "headline", "description", "image_id", "updated_at", "created_at", "subtitle", "icon_title_id", "cta_text", "full_description", "slug", "benefit_title", "benefit_description") VALUES
  (6, 'MyBIT', 'https://mybit.id/', 'MANAJEMEN SDM TERPADU', 'Kelola Karyawan Lebih Mudah, Cepat, dan Akurat.', 'Tingkatkan efisiensi HR perusahaan Anda dengan BIT HRMS. Solusi lengkap mulai dari absensi, otomatisasi payroll, hingga manajemen data karyawan dalam satu platform yang terpusat dan aman.', 37, '2026-06-19T01:39:17.012Z', '2026-06-17T03:15:45.133Z', 'HR System Management', 25, 'Kunjungi Website', NULL, 'hr-sistem-management', 'Kendali Penuh di Satu Platform Terpusat', 'Tinggalkan proses manual yang memakan waktu. BIT HRMS mengotomatisasi tugas administratif agar tim Anda dapat fokus pada strategi pengembangan talenta dan pertumbuhan bisnis.'),
  (7, 'E-Visitor', 'https://evisitor.bonecomtricom.net/login', 'MANAJEMEN VISITOR SYSTEM', 'E-Visitor: Era Baru Manajemen Buku Tamu Digital', 'Sambut tamu perusahaan Anda dengan pengalaman check-in yang modern, cepat, dan tanpa kontak fisik. E-Visitor menyederhanakan proses resepsionis sekaligus memberikan kesan pertama yang profesional bagi klien dan pengunjung Anda.', 133, '2026-06-19T07:28:33.322Z', '2026-06-18T03:57:57.305Z', 'Visitor Management System', 154, 'Kunjungi Website', NULL, 'e-visitor', 'Tingkatkan Keamanan dan Profesionalisme Area Perusahaan Anda', 'Tinggalkan buku tamu manual yang rentan rusak dan tidak aman. Sistem kami dirancang untuk menyederhanakan proses penerimaan tamu, memberikan impresi pertama yang modern, sekaligus memastikan keamanan fasilitas Anda tetap terjaga dengan rekam jejak yang akurat.');

-- Data untuk tabel: "products_benefits" (8 rows)
TRUNCATE TABLE "products_benefits" CASCADE;
INSERT INTO "products_benefits" ("_order", "_parent_id", "id", "title", "description") VALUES
  (1, 6, '6a320d4623c7c16b91233e10', 'Efisiensi Waktu & Biaya Operasional', 'Tinggalkan tumpukan kertas dan minimalkan kesalahan hitung manual yang merugikan. Otomatisasi alur kerja kami terbukti menghemat waktu tim administratif Anda secara signifikan.'),
  (2, 6, '6a320d5d23c7c16b91233e12', 'Kepatuhan Regulasi (Compliance) Otomatis', 'Tidak perlu khawatir dengan perubahan aturan. Perhitungan pajak (PPh 21), BPJS Kesehatan, dan Ketenagakerjaan selalu disesuaikan dengan regulasi pemerintah terbaru.'),
  (3, 6, '6a320d7123c7c16b91233e14', 'Skalabilitas Fleksibel untuk Pertumbuhan', 'Infrastruktur sistem kami dirancang untuk tumbuh bersama bisnis Anda. Tambahkan modul fitur atau kapasitas pengguna baru dengan mudah tanpa mengganggu operasional yang sedang berjalan.'),
  (4, 6, '6a320d9323c7c16b91233e16', 'Keamanan Data Tingkat Perusahaan', 'Privasi karyawan adalah prioritas. Kami melindungi seluruh data sensitif perusahaan dengan protokol enkripsi modern dan pencadangan data (backup) berkala.'),
  (1, 7, '6a336d3f0d24402d46ab4ce9', 'Keamanan Fasilitas Lebih Terjamin', 'Cegah akses tidak sah dengan pencatatan identitas tamu yang valid dan pelacakan status kunjungan secara real-time. Tim keamanan dapat memantau siapa saja yang sedang berada di dalam gedung kapan saja.'),
  (2, 7, '6a336d930d24402d46ab4ced', 'Proses Check-in Cepat & Efisien (Contactless)', 'Kurangi antrean panjang di meja resepsionis. Dengan dukungan fitur undangan QR Code, tamu dapat melakukan pemindaian mandiri secara instan, menghemat waktu operasional staf Anda.'),
  (3, 7, '6a336d9a0d24402d46ab4cee', 'Tingkatkan Citra Profesional Perusahaan', 'Berikan kesan pertama yang modern, rapi, dan berkelas kepada setiap klien, investor, atau mitra bisnis yang berkunjung sejak mereka melangkahkan kaki di lobi Anda.'),
  (4, 7, '6a3371860d24402d46ab4cf4', 'Laporan Otomatis & Bebas Repot', 'Dapatkan wawasan operasional dari data kunjungan secara instan. Fitur pelaporan memudahkan tim GA (General Affairs) atau HR untuk melakukan rekapitulasi dan audit bulanan tanpa perlu memindahkan data secara manual.');

-- Data untuk tabel: "products_clients" (7 rows)
TRUNCATE TABLE "products_clients" CASCADE;
INSERT INTO "products_clients" ("_order", "_parent_id", "id", "client_logo_id", "client_name") VALUES
  (1, 6, '6a3210e823c7c16b91233e36', 2, 'Bonecom Tricom'),
  (2, 6, '6a3210f523c7c16b91233e38', 3, 'Bonecom Paintech'),
  (3, 6, '6a32110223c7c16b91233e3a', 5, 'Ravalia Inti Mandiri'),
  (4, 6, '6a32111a23c7c16b91233e3c', 6, 'Rajawali Mitra Pratama'),
  (1, 7, '6a336dc70d24402d46ab4cf0', 2, 'PT Bonecom Tricom'),
  (2, 7, '6a336e2d0d24402d46ab4cf1', 3, 'PT Bonecom Tricom Paintech'),
  (3, 7, '6a336e550d24402d46ab4cf2', 5, 'PT Ravalia Inti Mandiri');

-- Data untuk tabel: "products_features" (8 rows)
TRUNCATE TABLE "products_features" CASCADE;
INSERT INTO "products_features" ("_order", "_parent_id", "id", "icon_id", "title", "description", "picture_id") VALUES
  (1, 6, '6a320dc523c7c16b91233e18', 117, 'Manajemen Absensi & Kehadiran Real-time', 'Pantau jam kerja, cuti, lembur, dan shift karyawan secara akurat. Terintegrasi dengan sistem absensi digital untuk mencegah kecurangan dan mempermudah rekapitulasi data setiap bulannya.', 123),
  (2, 6, '6a320e6f23c7c16b91233e1a', 118, 'Otomatisasi Payroll & Pajak Terpercaya', 'Ucapkan selamat tinggal pada perhitungan manual yang rentan human error. Hitung gaji, potongan BPJS, dan PPh 21 secara otomatis agar karyawan menerima haknya tepat waktu.', 128),
  (3, 6, '6a320e8323c7c16b91233e1c', 119, 'Employee Self-Service (ESS)', 'Berikan kemandirian kepada karyawan Anda. Melalui aplikasi, mereka dapat mengajukan cuti, melakukan clock-in/out, mengunduh slip gaji, hingga memperbarui data personal tanpa harus bolak-balik ke tim HR.', 129),
  (4, 6, '6a320e9523c7c16b91233e1e', 138, 'Manajemen Kesehatan & Rekap MCU', 'Arsipkan riwayat kesehatan dan hasil Medical Checkup (MCU) karyawan secara digital dan terpusat. Pantau kondisi kebugaran tim Anda dengan rapi untuk mendukung lingkungan kerja yang sehat dan produktif.', 130),
  (1, 7, '6a336d490d24402d46ab4cea', 32, 'Dashboard Interaktif & Real-time', 'Pantau seluruh aktivitas tamu, status kunjungan, dan statistik operasional harian secara real-time dalam satu tampilan antarmuka yang modern, informatif, dan mudah dipahami.', 122),
  (2, 7, '6a336d870d24402d46ab4cec', 72, 'Manajemen Data Tamu & Kunjungan', 'Catat dan kelola informasi detail setiap tamu yang datang secara terpusat. Lacak riwayat kunjungan harian dengan rapi untuk meningkatkan standar keamanan dan ketertiban area perusahaan Anda.', 134),
  (3, 7, '6a336db30d24402d46ab4cef', 131, 'Undangan Cerdas Berbasis QR Code', 'Tingkatkan pengalaman tamu dengan mengirimkan undangan digital berupa kode QR sebelum kedatangan. Proses check-in di resepsionis menjadi jauh lebih cepat, modern, dan minim kontak fisik (contactless).', 135),
  (4, 7, '6a336f720d24402d46ab4cf3', 132, 'Laporan Kunjungan Komprehensif', 'Hasilkan rekapitulasi buku tamu secara otomatis. Ekspor data kunjungan berdasarkan periode waktu tertentu untuk memudahkan kebutuhan audit, pelaporan manajemen, dan evaluasi keamanan perusahaan.', 136);

-- Data untuk tabel: "products_integrations" (3 rows)
TRUNCATE TABLE "products_integrations" CASCADE;
INSERT INTO "products_integrations" ("_order", "_parent_id", "id", "logo_id", "name") VALUES
  (1, 6, '6a3210d723c7c16b91233e30', 111, 'Android'),
  (2, 6, '6a3210dc23c7c16b91233e32', 110, 'iOS'),
  (3, 6, '6a3210e123c7c16b91233e34', 112, 'Website');

-- Data untuk tabel: "products_use_cases" (1 rows)
TRUNCATE TABLE "products_use_cases" CASCADE;
INSERT INTO "products_use_cases" ("_order", "_parent_id", "id", "industry") VALUES
  (1, 7, '6a336d550d24402d46ab4ceb', 'Manufactur , Retail , Technology');

-- Data untuk tabel: "services" (6 rows)
TRUNCATE TABLE "services" CASCADE;
INSERT INTO "services" ("id", "title", "slug", "hero_badge", "hero_description", "hero_image_id", "hero_btn1_text", "hero_btn1_link", "hero_btn2_text", "hero_btn2_link", "show_problem", "problem_badge", "problem_title", "problem_subtitle", "show_solution", "solution_badge", "solution_title", "show_process", "process_badge", "process_title", "process_subtitle", "show_framework", "framework_title", "framework_subtitle", "show_benefit", "benefit_badge", "benefit_title", "benefit_subtitle", "updated_at", "created_at", "show_pricing", "pricing_pricing_headline", "pricing_pricing_description", "subtitle", "icon_title_id", "dashboard_badge", "dashboard_title", "dashboard_subtitle", "category", "floating_cards_top_left_title", "floating_cards_top_left_subtitle", "floating_cards_top_left_dot_color", "floating_cards_bottom_right_title", "floating_cards_bottom_right_subtitle", "floating_cards_bottom_right_dot_color") VALUES
  (4, 'SAP Integration Consultant', 'sap', 'INTEGRASI SAP ENTERPRISE', 'Hubungkan ekosistem digital perusahaan Anda tanpa batas. Sistem kami menjembatani SAP ERP dengan berbagai aplikasi pihak ketiga (HRIS, CRM, Web Portal), mengotomatisasi sinkronisasi data secara real-time, dan memecah data silos untuk pengambilan keputusan yang lebih cepat dan akurat.', 147, 'Konsultasi Integrasi', 'https://wa.me/6283821619460', NULL, NULL, TRUE, 'Problem', 'TANTANGAN BISNIS', 'Mengapa Operasional Perusahaan Anda Terhambat?', TRUE, 'Solusi', 'SOLUSI KAMI', FALSE, 'Proces 1', ' 12123', '3232', TRUE, NULL, NULL, TRUE, 'KEUNTUNGAN BISNIS', 'Maksimalkan Potensi Investasi ERP Anda', 'Implementasi integrasi SAP yang tepat tidak hanya menyelesaikan masalah teknis operasional, tetapi juga memberikan dampak positif secara langsung pada skalabilitas dan profitabilitas perusahaan Anda.', '2026-06-19T06:07:58.966Z', '2026-06-18T06:47:10.545Z', TRUE, NULL, NULL, 'Solusi integrasi SAP paling andal', 121, 'KONSULTASI & IMPLEMENTASI', 'Optimalkan Ekosistem Bisnis dengan Integrasi SAP yang Cerdas', 'im konsultan ahli kami siap merancang, membangun, dan mengelola jembatan integrasi antara modul SAP Anda dengan berbagai aplikasi pihak ketiga atau sistem internal. Kami memastikan sinkronisasi data yang akurat, mengurangi beban input manual, dan memecah batasan antar platform demi kelancaran operasional skala enterprise.', 'Software', 'Seamless Integration', 'Penghubung antar sistem tanpa hambatan', 'green', 'Real-Time Sync', 'Sinkronisasi data bisnis secara instan', 'blue'),
  (7, 'Maintenance Services', 'mtc', 'IT Maintenance & Support Services', 'Jangan biarkan downtime menghentikan bisnis Anda. Layanan maintenance IT komprehensif dari TokoMirai memastikan perangkat keras, lisensi software, dan sistem keamanan Anda selalu beroperasi pada performa puncak secara konsisten.', 171, 'Konsultasi Layanan', NULL, NULL, NULL, TRUE, 'Risiko Tanpa Perawatan', 'Kerusakan Sistem Mendadak Menghambat Produktivitas?', 'Mengabaikan pemeliharaan rutin pada perangkat keras dan pembaruan sistem keamanan dapat berakibat fatal bagi kelancaran operasional dan data perusahaan.', TRUE, 'Solusi Maintenance Terpadu', 'Perawatan Proaktif untuk Stabilitas Jangka Panjang', FALSE, NULL, NULL, NULL, FALSE, NULL, NULL, TRUE, 'Keunggulan Layanan', 'Investasi IT yang Tenang dan Bebas Risiko', 'Maksimalkan uptime perusahaan dan lindungi aset digital Anda dengan layanan maintenance komprehensif yang dikelola oleh ahlinya.', '2026-06-20T06:53:05.037Z', '2026-06-18T06:56:19.983Z', TRUE, NULL, NULL, 'Dukungan teknis untuk keandalan sistem', 146, 'Maintenance Services', 'Dukungan Teknis & Pemeliharaan Rutin untuk Keandalan Sistem', 'Pastikan kelancaran bisnis Anda dengan dukungan teknis yang responsif. Tim ahli kami siap menangani perawatan rutin hingga penyelesaian masalah (troubleshooting) secara komprehensif, sehingga Anda dapat fokus penuh pada target bisnis tanpa khawatir akan gangguan sistem.', 'Maintenance', 'Preventive Care', 'Perawatan sistem secara berkala', 'green', 'Fast Response', 'Penanganan kendala teknis dengan cepat', 'orange'),
  (2, 'Software Development', 'software-development', 'Bangun Solusi Software Kustom yang Adaptif dan Inovatif', 'Kami merancang dan membangun ekosistem perangkat lunak yang disesuaikan 100% dengan alur kerja unik perusahaan Anda. Dengan teknologi terbaru, kami memastikan aplikasi Anda tidak hanya berfungsi dengan baik hari ini, tetapi juga siap tumbuh bersama skala bisnis Anda di masa depan.', 13, 'Konsultasi Sekarang', NULL, 'Lihat Katalog', NULL, TRUE, 'TANTANGAN', 'Mengapa Software Standar Sering Kali Tidak Cukup?', 'Mengandalkan proses manual atau perangkat lunak standar yang kaku sering kali menghambat produktivitas. Banyak perusahaan terjebak dalam masalah operasional yang membatasi potensi pertumbuhan mereka.', TRUE, 'KAPABILITAS UTAMA', 'Solusi Kustom untuk Mengatasi Hambatan Operasional', TRUE, 'PROSES', 'Metodologi Kerja Terstruktur & Transparan', 'Dari konsultasi awal hingga dukungan dokumentasi, kami memastikan setiap tahapan proyek berjalan sesuai standar kualitas tinggi untuk kesuksesan digital Anda.', TRUE, ' Teknologi Modern di Balik Sistem yang Tangguh', 'Kami mengandalkan ekosistem framework dan bahasa pemrograman mutakhir yang menjamin keamanan, kecepatan, dan skalabilitas untuk setiap solusi perangkat lunak yang kami kembangkan.', TRUE, 'BENEFIT', 'Mengapa Memilih Mirai untuk Pengembangan Software?', 'Kami tidak sekadar vendor IT, melainkan mitra strategis yang memastikan investasi teknologi Anda memberikan dampak langsung pada efisiensi operasional dan pertumbuhan bisnis.', '2026-06-15T07:18:59.355Z', '2026-05-19T07:28:31.767Z', TRUE, 'Mengapa Memilih Layanan Software Development Kami?', 'Kami membangun solusi perangkat lunak custom yang dirancang untuk meningkatkan efisiensi operasional dan mendorong pertumbuhan bisnis Anda melalui teknologi terkini.', 'Pembuatan Aplikasi dan Integrasi Sistem', 36, 'Development', 'Custom Web & Mobile Applications', 'Bangun aplikasi web dan mobile yang sesuai dengan proses bisnis Anda. Solusi kustom kami membantu mengotomatisasi pekerjaan, meningkatkan efisiensi operasional, dan memberikan pengalaman pengguna yang lebih baik.
', 'ENTERPRISE SOFTWARE', 'Agile Process', 'Pengiriman fitur lebih cepat', 'green', 'Scalable Tech', 'Siap untuk pertumbuhan bisnis', 'orange'),
  (6, 'Softwares & Antivirus', 'antivirus', 'Enterprise Security & Software', 'Lindungi aset digital perusahaan dan tingkatkan produktivitas tim. Kami menyediakan lisensi software bisnis resmi dan solusi antivirus perlindungan tingkat tinggi untuk ekosistem IT Anda dari berbagai ancaman siber.', 162, 'Info Lanjut', NULL, NULL, NULL, TRUE, 'Risiko Keamanan Digital', 'Sistem Perusahaan Anda Rentan Terhadap Serangan Siber?', 'Ancaman virus, ransomware, dan kebocoran data mengintai setiap saat. Jangan biarkan keamanan operasional bisnis Anda menjadi korban.', TRUE, 'Solusi Keamanan & Produktivitas', 'Ekosistem Perangkat Lunak Terintegrasi untuk Bisnis Anda', FALSE, NULL, NULL, NULL, TRUE, NULL, NULL, TRUE, 'Keunggulan Layanan', 'Mengapa Beli Lisensi Software di Sini?', 'Kami membuat proses pembelian dan aktivasi perangkat lunak menjadi sangat cepat, aman, dan tanpa kerumitan.', '2026-06-20T06:50:40.618Z', '2026-06-18T06:55:35.859Z', TRUE, NULL, NULL, 'Benteng pertahanan untuk data Anda', 145, 'Softwares & Antivirus', 'Lindungi Aset Digital dengan Perangkat Lunak & Antivirus Premium', 'Bangun benteng pertahanan digital yang kokoh untuk data krusial Anda. Kami menghadirkan perlindungan proaktif melalui software keamanan dan antivirus terbaik di kelasnya, memastikan sistem operasional Anda berjalan stabil, aman, dan terhindar dari risiko kebocoran data.', 'Security', 'Data Protection', 'Keamanan tingkat enterprise', 'blue', 'Licensed Software', 'Perangkat lunak legal dan resmi', 'green'),
  (3, 'IT Infrastrucutre', 'it-infrastructure', 'Infrastruktur Server, CCTV & IoT untuk Keamanan Terpusat', 'Solusi perancangan pusat data, pengawasan fisik terintegrasi, hingga integrasi perangkat pintar (IoT). Kami memastikan fondasi fisik operasional Anda kokoh, aman, dan dapat dipantau 24/7.', 54, 'Konsultasi Sekarang', '#', 'Lihat Katalog', '#', TRUE, 'TANTANGAN', 'Risiko Operasional dari Infrastruktur Fisik yang Lemah', 'Perangkat lunak secanggih apa pun akan gagal jika ditopang oleh server yang rentan dan pengawasan aset fisik yang tidak memadai.', TRUE, 'KAPABILITAS UTAMA', 'Ekosistem Perangkat Keras yang Cerdas & Tangguh', TRUE, 'PROSES', 'Instalasi Presisi & Pemeliharaan Berkala', 'Metodologi end-to-end kami memastikan setiap perangkat keras yang dipasang berfungsi sempurna dan diintegrasikan secara presisi ke dalam perangkat lunak Anda.', FALSE, NULL, NULL, TRUE, 'BENEFIT', 'Alasan Mempercayakan Aset Fisik pada Mirai', 'Kami tidak sekadar merakit perangkat, kami merancang ekosistem keamanan dan komputasi yang memastikan bisnis Anda tidak pernah terhenti.', '2026-06-19T03:07:05.233Z', '2026-05-22T07:32:13.381Z', TRUE, 'Siap Memodernisasi Tulang Punggung Teknologi Anda?', 'Beralihlah ke infrastruktur IT yang tangguh dan modern. Kami membantu mengelola cloud, jaringan perusahaan, dan sistem penyimpanan data Anda untuk memastikan kelancaran operasional sehari-hari dengan downtime yang minimal.', 'Solusi Infrastruktur dan Sistem Jaringan', 55, 'Infrastructure', 'IT Infrastructure', 'Infrastruktur IT yang kuat adalah kunci bisnis yang produktif. Kami membantu membangun sistem yang cepat, aman, dan scalable untuk mendukung pertumbuhan perusahaan Anda.
', 'MANAGED SERVICES', 'End-to-End Setup', 'Dari survei fisik hingga implementasi', 'green', 'Hardware Integration', 'Pemasangan dan sinkronisasi', 'blue'),
  (5, 'PC, Laptop & Servers', 'pc', 'Hardware & Enterprise Solutions', 'Penuhi kebutuhan komputasi personal dan perusahaan Anda di satu tempat. Menyediakan berbagai lini Laptop, PC, dan Server berkualitas tinggi yang siap mendukung akselerasi digital Anda.', 155, 'Info Lanjut', NULL, NULL, NULL, TRUE, 'Tantangan IT', 'Kendala Infrastruktur Menghambat Pertumbuhan Bisnis?', 'Perangkat yang lambat dan server yang sering down tidak hanya membuang waktu, tetapi juga merugikan operasional perusahaan Anda.', TRUE, 'Solusi Kami', 'Infrastruktur IT Andal untuk Mendukung Skalabilitas Anda', FALSE, NULL, NULL, NULL, FALSE, NULL, NULL, FALSE, NULL, NULL, NULL, '2026-06-20T06:46:51.586Z', '2026-06-18T06:52:50.076Z', FALSE, NULL, NULL, 'Benteng pertahanan untuk data Anda', 144, 'PC, Laptop & Servers', 'Solusi Hardware Andal untuk Performa Bisnis yang Optimal', 'Fasilitasi tim Anda dengan perangkat keras yang tangguh. Kami menyediakan solusi pengadaan PC, laptop, dan server berspesifikasi tinggi yang disesuaikan dengan beban kerja Anda. Setiap perangkat disiapkan untuk memastikan stabilitas dan kelancaran operasional sehari-hari tanpa hambatan.', 'Hardware', 'Enterprise Grade', 'Perangkat tangguh standar industri', 'green', 'Reliable Support', 'Dukungan teknis dan garansi terjamin', 'orange');

-- Data untuk tabel: "services_benefit_cards" (16 rows)
TRUNCATE TABLE "services_benefit_cards" CASCADE;
INSERT INTO "services_benefit_cards" ("_order", "_parent_id", "id", "icon_id", "title", "description") VALUES
  (1, 2, '6a0c0e53e61eae70b2f72ef1', 45, 'Kustomisasi Presisi', 'Berbeda dengan software generik, kami membangun sistem dari nol yang dirancang khusus untuk mengikuti alur kerja unik perusahaan Anda, bukan sebaliknya.'),
  (2, 2, '6a0c10b5e61eae70b2f72ef3', 46, 'Integrasi Tanpa Hambatan', 'Kami memastikan aplikasi baru terhubung mulus dengan infrastruktur data Anda yang sudah ada, termasuk kelancaran integrasi dengan modul SAP atau sistem ERP (seperti BPS).'),
  (3, 2, '6a0c10d3e61eae70b2f72ef5', 47, 'Arsitektur Tangguh & Skalabel', 'Dibangun dengan tumpukan teknologi modern, sistem kami dirancang agar tetap responsif dan mudah dikembangkan seiring dengan bertambahnya pengguna dan beban operasional bisnis Anda.'),
  (4, 2, '6a0c10ede61eae70b2f72ef7', 48, 'Maintenance & Dukungan Purna Jual', 'Tanggung jawab kami tidak berhenti saat aplikasi diluncurkan. Kami menyediakan layanan pemeliharaan proaktif untuk memastikan performa sistem tetap stabil 24/7.'),
  (1, 4, '6a339a9a0d24402d46ab4cfe', 152, 'Penghematan Biaya & Peningkatan ROI', 'Kurangi biaya operasional yang timbul akibat redundansi pekerjaan dan inefisiensi waktu. Integrasi sistem mempercepat siklus bisnis Anda, menekan biaya overhead, dan secara signifikan meningkatkan Return on Investment (ROI) dari SAP Anda.'),
  (2, 4, '6a339aa50d24402d46ab4cff', 145, 'Keamanan & Kepatuhan Tingkat Enterprise', 'Kami menerapkan protokol keamanan dan enkripsi standar industri terketat dalam setiap jalur perpindahan data. Pastikan pertukaran informasi sensitif perusahaan antar platform tetap terlindungi dan mematuhi regulasi kepatuhan (compliance) yang berlaku.'),
  (3, 4, '6a339ab60d24402d46ab4d00', 32, 'Skalabilitas Fleksibel Tanpa Batas', 'Arsitektur integrasi yang kami bangun dirancang untuk siap menghadapi masa depan (future-proof). Tambahkan aplikasi, platform e-commerce, atau modul sistem baru ke dalam ekosistem SAP Anda kapan saja tanpa perlu merombak infrastruktur yang sudah ada.'),
  (4, 4, '6a339acc0d24402d46ab4d01', 153, 'Fokus pada Inovasi, Bukan Administrasi', 'Bebaskan tim IT dan operasional Anda dari beban tugas pemeliharaan dan rekonsiliasi data yang repetitif. Biarkan sistem yang bekerja secara otomatis, sehingga tim Anda dapat mengalokasikan waktu untuk strategi bisnis dan inovasi.'),
  (1, 3, '6a100a999bfa303fb2f31a8d', 56, 'Keandalan Server Maksimal', 'Desain infrastruktur pusat data yang memperhitungkan redundansi daya dan manajemen suhu untuk menekan risiko server down hingga mendekati titik nol.'),
  (2, 3, '6a100aaa9bfa303fb2f31a8f', 61, 'Keamanan Visual & Digital Terpadu', 'Perlindungan holistik yang menggabungkan pengamanan siber pada server data dengan pengamanan ruang fisik melalui CCTV dan sensor kontrol akses.'),
  (3, 3, '6a100ae29bfa303fb2f31a91', 57, 'Optimalisasi Umur Perangkat', 'Mencegah pemborosan anggaran IT dengan mendeteksi potensi kerusakan hardware lebih dini melalui perawatan yang terjadwal dan komprehensif.'),
  (4, 3, '6a100af09bfa303fb2f31a93', 58, 'Skalabilitas Infrastruktur Fisik', 'Kami merancang tata letak server dan titik keamanan (CCTV/IoT) yang fleksibel. Saat perusahaan Anda berkembang, penambahan kapasitas perangkat keras dapat dilakukan dengan cepat tanpa merombak instalasi dasar yang sudah ada.'),
  (1, 6, '6a34e4229ab84bdaf632e13e', 169, 'Pengiriman Lisensi Instan', 'Tidak perlu menunggu kurir. Product Key asli beserta panduan instalasi akan langsung dikirim ke email Anda dalam hitungan menit setelah pembayaran terkonfirmasi.'),
  (2, 6, '6a34e4269ab84bdaf632e13f', 170, 'Panduan Instalasi Super Mudah', 'Pemula dalam urusan IT? Jangan khawatir. Kami menyertakan langkah-langkah aktivasi yang sangat jelas dan mudah diikuti oleh siapa saja.'),
  (1, 7, '6a34f68ffe4c415346df0250', 118, 'Efisiensi Biaya Operasional', 'Perawatan preventif kami mendeteksi anomali pada hardware dan software sebelum menjadi kerusakan fatal, menghemat anggaran perusahaan dari biaya penggantian perangkat mendadak.'),
  (2, 7, '6a34f692fe4c415346df0251', 145, 'Keamanan Data Terjamin', 'Tidak ada lagi celah keamanan. Kami mengelola pembaruan sistem operasi dan definisi antivirus secara rutin untuk memblokir ancaman ransomware terbaru.');

-- Data untuk tabel: "services_framework_logos" (5 rows)
TRUNCATE TABLE "services_framework_logos" CASCADE;
INSERT INTO "services_framework_logos" ("_order", "_parent_id", "id", "logo_id") VALUES
  (1, 2, '6a0c0d65e61eae70b2f72ee7', 40),
  (2, 2, '6a0c0da4e61eae70b2f72ee9', 41),
  (3, 2, '6a0c0dfbe61eae70b2f72eeb', 42),
  (4, 2, '6a0c0e09e61eae70b2f72eed', 43),
  (5, 2, '6a0c0e1be61eae70b2f72eef', 44);

-- Data untuk tabel: "services_pricing_tiers" (4 rows)
TRUNCATE TABLE "services_pricing_tiers" CASCADE;
INSERT INTO "services_pricing_tiers" ("_order", "_parent_id", "id", "is_popular", "tier_name", "price", "price_suffix", "description", "button_text", "button_link") VALUES
  (1, 2, '6a0d5a133596dbd86f463375', FALSE, 'Essential', 'Rp 15 Jt', NULL, 'Cocok untuk bisnis yang baru mulai digitalisasi.', 'Konsultasi Sekarang', NULL),
  (2, 2, '6a0d5b873596dbd86f463381', TRUE, 'Professional', 'Rp 19 Jt', '', 'Untuk operasional bisnis yang mulai kompleks.', 'Konsultasi Sekarang', NULL),
  (3, 2, '6a0d5c093596dbd86f46338d', FALSE, 'Enterprise', 'Hubungi Kami', NULL, 'Solusi khusus untuk perusahaan dengan kebutuhan besar.', 'Konsultasi Khusus', NULL),
  (1, 3, '6a100b229bfa303fb2f31a95', TRUE, 'Enterprise', 'Hubungi Kami', '', 'Didedikasikan untuk korporasi besar dengan kebutuhan infrastruktur kompleks dan pemantauan 24/7.', 'Konsultasi Khusus', '#');

-- Data untuk tabel: "services_pricing_tiers_features" (19 rows)
TRUNCATE TABLE "services_pricing_tiers_features" CASCADE;
INSERT INTO "services_pricing_tiers_features" ("_order", "_parent_id", "id", "feature_item") VALUES
  (1, '6a100b229bfa303fb2f31a95', '6a100b4b9bfa303fb2f31a97', 'Dukungan Prioritas 24/7'),
  (2, '6a100b229bfa303fb2f31a95', '6a100b509bfa303fb2f31a99', 'Dedicated IT Engineer On-Site'),
  (3, '6a100b229bfa303fb2f31a95', '6a100b559bfa303fb2f31a9b', 'Audit Keamanan Mendalam'),
  (4, '6a100b229bfa303fb2f31a95', '6a100b5a9bfa303fb2f31a9d', 'Custom IT Master Plan'),
  (1, '6a0d5a133596dbd86f463375', '6a0d5ab93596dbd86f463379', 'Landing page / company profile'),
  (2, '6a0d5a133596dbd86f463375', '6a0d5ac93596dbd86f46337b', 'Admin dashboard sederhana'),
  (3, '6a0d5a133596dbd86f463375', '6a0d5ad43596dbd86f46337d', '1–2 fitur utama'),
  (4, '6a0d5a133596dbd86f463375', '6a0d5ae03596dbd86f46337f', 'Mobile responsive'),
  (5, '6a0d5a133596dbd86f463375', '6a18e92fd35b0a34e134bda3', 'Free maintenance 1 bulan'),
  (1, '6a0d5b873596dbd86f463381', '6a0d5bd43596dbd86f463383', 'Sistem custom sesuai workflow'),
  (2, '6a0d5b873596dbd86f463381', '6a0d5bf13596dbd86f463387', 'Multi user & role management'),
  (3, '6a0d5b873596dbd86f463381', '6a0d5bf93596dbd86f463389', 'Integrasi WhatsApp / Email'),
  (4, '6a0d5b873596dbd86f463381', '6a0d5c003596dbd86f46338b', 'Reporting & analytics'),
  (5, '6a0d5b873596dbd86f463381', '6a18ea25d35b0a34e134bda4', 'Support prioritas'),
  (1, '6a0d5c093596dbd86f46338d', '6a0d5c2f3596dbd86f46338f', 'Integrasi ERP / HRIS / Finance'),
  (2, '6a0d5c093596dbd86f46338d', '6a0d5c3e3596dbd86f463391', 'High traffic architecture'),
  (3, '6a0d5c093596dbd86f46338d', '6a0d5c473596dbd86f463393', 'API integration'),
  (4, '6a0d5c093596dbd86f46338d', '6a0d5c4d3596dbd86f463395', 'Dedicated support team'),
  (5, '6a0d5c093596dbd86f46338d', '6a18ea79d35b0a34e134bda5', 'SLA & maintenance khusus');

-- Data untuk tabel: "services_problem_cards" (18 rows)
TRUNCATE TABLE "services_problem_cards" CASCADE;
INSERT INTO "services_problem_cards" ("_order", "_parent_id", "id", "icon_id", "title", "description") VALUES
  (1, 3, '6a10069b9bfa303fb2f31a77', 56, 'Kegagalan Server & Data Hilang', 'Ruang server yang tidak memenuhi standar suhu, daya, dan konfigurasi backup sangat rentan mengalami overheat yang memicu hilangnya aset data krusial perusahaan.'),
  (2, 3, '6a1006b19bfa303fb2f31a79', 57, 'Titik Buta Keamanan Fisik', 'Area perkantoran atau pabrik tanpa integrasi CCTV dan kontrol akses pintu berisiko tinggi terhadap pelanggaran keamanan dan penyalahgunaan wewenang internal.'),
  (3, 3, '6a1006b69bfa303fb2f31a7b', 58, 'Usia Pakai Perangkat Pendek', 'Ratusan PC operasional, mesin, dan perangkat keras yang tidak dirawat secara rutin akan cepat rusak, meningkatkan biaya penggantian IT secara drastis.'),
  (1, 5, '6a34e974b7ac3134812d0882', 157, 'Produktivitas Tim Menurun', 'Perangkat lama yang lambat membuat pekerjaan terhambat, sering hang saat multitasking, dan menurunkan moral karyawan.'),
  (2, 5, '6a34e976b7ac3134812d0883', 158, 'Risiko Downtime Server', 'Server yang tidak stabil membahayakan keamanan data operasional dan menghentikan layanan krusial perusahaan Anda secara tiba-tiba.'),
  (3, 5, '6a34e984b7ac3134812d0884', 159, 'Biaya Maintenance Membengkak', 'Terus-menerus mengeluarkan biaya untuk servis PC atau server lama yang sudah sering rusak dan outdated.'),
  (1, 6, '6a34e39f9ab84bdaf632e138', 163, 'Ancaman Malware & Ransomware', 'Serangan virus dapat mengunci data penting perusahaan dan melumpuhkan sistem operasional dalam hitungan detik.'),
  (2, 6, '6a34e3a79ab84bdaf632e139', 164, 'Risiko Kebocoran Data', 'Pencurian data sensitif klien dan rahasia perusahaan akibat kurangnya lapisan keamanan endpoint yang memadai.'),
  (3, 6, '6a34e4029ab84bdaf632e13d', 165, 'Bahaya Software Tidak Resmi', 'Penggunaan software bajakan tidak hanya membuka celah keamanan fatal, tetapi juga berisiko terkena sanksi hukum bagi perusahaan.'),
  (1, 4, '6a33993b0d24402d46ab4cf5', 148, 'Data Tersekat (Data Silos)', 'Informasi penting perusahaan terpecah di berbagai aplikasi yang tidak saling berkomunikasi dengan SAP. Hal ini menyebabkan ketidakselarasan data antar departemen, miskomunikasi, dan inefisiensi alur kerja.'),
  (2, 4, '6a3399e70d24402d46ab4cf7', 149, 'Proses Manual & Rentan Kesalahan', 'Staf Anda membuang waktu berharga untuk melakukan entri data ganda (copy-paste) antar platform. Proses manual ini sangat rentan terhadap human error yang dapat berujung pada kerugian material dan ketidakakuratan laporan.'),
  (3, 4, '6a339a020d24402d46ab4cf8', 150, 'Visibilitas Data Terlambat', 'Tanpa integrasi real-time, manajemen kesulitan memantau metrik performa perusahaan secara aktual. Pengambilan keputusan strategis seringkali terlambat karena harus menunggu laporan rekonsiliasi yang memakan waktu berhari-hari.'),
  (1, 7, '6a34f194fe4c415346df024a', 172, 'Usia Perangkat Lebih Pendek', 'PC atau server yang tidak dirawat rentan mengalami overheating dan penumpukan debu, memicu kerusakan komponen mahal dan menuntut biaya penggantian yang tinggi.'),
  (2, 7, '6a34f2b7fe4c415346df024c', 173, 'Celah Keamanan & Sistem Usang', 'Lisensi yang tidak diperbarui dan antivirus yang outdated membuka lebar pintu jaringan Anda bagi serangan ransomware dan kebocoran data sensitif.'),
  (3, 7, '6a34f2bdfe4c415346df024d', 159, 'Kerugian Akibat Downtime', 'Sistem yang tiba-tiba error tidak hanya menghentikan pekerjaan tim, tetapi juga menyebabkan kerugian finansial yang signifikan setiap jamnya.'),
  (1, 2, '6a0c0affe61eae70b2f72ed1', 14, 'Proses Manual & Rentan Kesalahan', 'Ketergantungan pada spreadsheet (Excel) dan pencatatan kertas memakan waktu berjam-jam, memicu inefisiensi, dan sangat rentan terhadap human error hingga manipulasi data operasional.'),
  (2, 2, '6a0c0b26e61eae70b2f72ed3', 15, 'Sistem Terpisah & Data Terisolasi', 'Menggunakan berbagai aplikasi operasional yang tidak saling terintegrasi membuat aliran data terhambat. Hal ini menyulitkan pelacakan dan membuat manajemen terlambat mengambil keputusan strategis.'),
  (3, 2, '6a0c0b58e61eae70b2f72ed5', 16, 'Perangkat Lunak yang Kaku', ' Aplikasi standar (off-the-shelf) sering kali memaksakan alur kerja yang tidak sesuai dengan kebutuhan spesifik perusahaan Anda dan sangat sulit untuk diskalakan seiring dengan pertumbuhan bisnis.');

-- Data untuk tabel: "services_process_steps" (13 rows)
TRUNCATE TABLE "services_process_steps" CASCADE;
INSERT INTO "services_process_steps" ("_order", "_parent_id", "id", "icon_id", "title", "description") VALUES
  (1, 2, '6a0c0ca3e61eae70b2f72edd', 17, 'Analisis Kebutuhan Mendalam', 'Pemetaan alur operasional dan diskusi intensif untuk merumuskan spesifikasi teknologi yang paling presisi dan efisien.'),
  (2, 2, '6a0c0cd1e61eae70b2f72edf', 18, 'Perancangan Solusi Strategis', 'Pembuatan arsitektur sistem yang skalabel dan purwarupa desain (UI/UX) yang intuitif sebelum tahap pengodean.'),
  (3, 2, '6a0c0cebe61eae70b2f72ee1', 19, 'Pembangunan & Integrasi Sistem', 'Pengembangan perangkat lunak dengan standar modern, mencakup integrasi mulus dengan modul existing'),
  (4, 2, '6a0c0d1de61eae70b2f72ee3', 20, 'Uji Coba Ketat & Validasi', 'Pengujian performa, keamanan, dan pembersihan bug secara menyeluruh untuk memastikan sistem siap beroperasi secara optimal.'),
  (5, 2, '6a0c0d3de61eae70b2f72ee5', 21, 'Implementasi & Dukungan Berkelanjutan', 'Peluncuran sistem ke server produksi, pelatihan pengguna (training), serta layanan pemeliharaan IT 24/7.'),
  (1, 3, '6a1008ee9bfa303fb2f31a83', 17, 'Site Audit & Analysis', 'Survei lokasi untuk memetakan tata letak ruang server, titik buta CCTV, dan mendata aset keras existing.'),
  (2, 3, '6a1008f59bfa303fb2f31a85', 51, 'Hardware Sizing Planning', 'Perancangan spesifikasi perangkat (kapasitas storage, resolusi kamera) yang paling efisien dengan anggaran.'),
  (3, 3, '6a1008fe9bfa303fb2f31a87', 59, 'Deployment & Integration', 'Proses instalasi fisik rak server, pemasangan kamera pengawas, dan penempatan sensor IoT di area kerja.'),
  (4, 3, '6a1009079bfa303fb2f31a89', 60, 'System Calibration', 'Pengaturan sudut pandang kamera, uji coba daya tahan server, dan sinkronisasi alat fisik dengan dashboard pemantauan.'),
  (5, 3, '6a10090f9bfa303fb2f31a8b', 48, 'Routine Maintenance', 'Pengecekan kesehatan harddisk berkala, pembersihan pada server/PC, dan layanan teknisi proaktif.'),
  (1, 4, '6a339a790d24402d46ab4cfb', NULL, '32', '323'),
  (2, 4, '6a339a7e0d24402d46ab4cfc', NULL, '3232', '2323'),
  (3, 4, '6a339a840d24402d46ab4cfd', NULL, '323', '232323');

-- Data untuk tabel: "services_solution_list" (18 rows)
TRUNCATE TABLE "services_solution_list" CASCADE;
INSERT INTO "services_solution_list" ("_order", "_parent_id", "id", "badge", "title", "description", "image_id") VALUES
  (1, 3, '6a10089d9bfa303fb2f31a7d', 'Server', 'Pengelolaan Server & Pusat Data', 'Kami membangun pusat saraf data Anda. Mulai dari penataan server rack, pengaturan suhu (cooling system), instalasi OS Server, hingga sistem cadangan data otomatis agar informasi perusahaan selalu terlindungi dari kegagalan sistem.', 139),
  (2, 3, '6a1008ac9bfa303fb2f31a7f', 'CCTV & Access Control', 'Keamanan Fisik & Pemantauan Sentral', 'Pantau aset Anda dari mana saja. Kami menyediakan instalasi sistem kamera pengawas (CCTV) beresolusi tinggi, integrasi Face Recognition, dan kontrol akses pintu (door access) yang terhubung langsung dengan dashboard pemantauan manajerial.', 140),
  (3, 3, '6a1008bb9bfa303fb2f31a81', 'IoT', 'Integrasi Sensor Pintar (IoT) & Pemeliharaan', 'Kami menghubungkan alat fisik dengan perangkat lunak melalui sensor IoT untuk otomatisasi industri. Selain itu, kami melakukan preventive maintenance untuk PC dan perangkat kantor agar kinerjanya selalu seperti baru.', 141),
  (1, 6, '6a34e3c79ab84bdaf632e13a', 'Endpoint Protection', 'Keamanan Siber Tingkat Lanjut', 'Lindungi seluruh aset digital perusahaan dengan solusi antivirus enterprise. Deteksi proaktif dan perlindungan ransomware waktu nyata memastikan operasional berjalan tanpa hambatan dari ancaman luar.', 166),
  (2, 6, '6a34e3ea9ab84bdaf632e13b', 'Software Produktivitas', 'Maksimalkan Efisiensi Tim Anda', 'Lengkapi infrastruktur IT dengan sistem operasi dan aplikasi perkantoran resmi. Tingkatkan kolaborasi tim dengan fitur cloud canggih dan pembaruan sistem yang selalu mutakhir.', 167),
  (3, 6, '6a34e3f09ab84bdaf632e13c', 'Lisensi Resmi', 'Jaminan Originalitas & Dukungan Penuh', 'Toko Mirai hanya mendistribusikan lisensi perangkat lunak 100% original. Dapatkan ketenangan pikiran dengan kepatuhan hukum penuh dan dukungan teknis khusus untuk klien korporat.', 168),
  (1, 7, '6a34f1cdfe4c415346df024b', 'Pemeliharaan Perangkat Keras', 'Perawatan Preventif PC & Server', 'Tim teknisi ahli kami melakukan pembersihan fisik berkala, pengecekan integritas komponen, dan optimalisasi hardware untuk mencegah overheating dan memperpanjang usia pakai aset IT Anda.', 174),
  (2, 7, '6a34f2fffe4c415346df024e', 'Manajemen Keamanan', 'Pembaruan Sistem & Audit Keamanan', 'Kami memastikan seluruh lisensi software Anda beroperasi secara legal dan mutakhir. Layanan kami mencakup update definisi virus rutin dan audit kerentanan untuk menangkal ancaman siber terbaru.', 175),
  (3, 7, '6a34f328fe4c415346df024f', 'Dukungan Teknis Prioritas', 'Respons Cepat & Troubleshooting', 'Hadapi kendala sistem di tengah pekerjaan? Layanan dukungan IT kami siap memberikan perbaikan yang responsif, baik melalui penanganan jarak jauh (remote) maupun kunjungan langsung (on-site), agar bisnis Anda segera berjalan normal.', 140),
  (1, 4, '6a3399cc0d24402d46ab4cf6', 'KONEKTIVITAS SEAMLESS', 'Sentralisasi Data Tanpa Batas', 'Kami membangun arsitektur integrasi API yang aman untuk menghubungkan SAP dengan seluruh aplikasi pihak ketiga (CRM, HRIS, E-commerce, dll). Semua departemen kini berbagi satu sumber kebenaran data (Single Source of Truth) yang tersinkronisasi secara harmonis.', 74),
  (2, 4, '6a339a460d24402d46ab4cf9', 'OTOMATISASI ALUR KERJA', 'Eliminasi Entri Manual & Human Error', 'Tingkatkan efisiensi tim Anda secara drastis dengan mengotomatiskan aliran data antar sistem operasional. Tidak ada lagi proses copy-paste atau entri ganda; sistem kami memastikan pembaruan data berjalan dengan presisi tinggi di latar belakang.', 123),
  (3, 4, '6a339a500d24402d46ab4cfa', 'VISIBILITAS REAL-TIME', 'Akses Data & Keputusan Bisnis Instan', 'Transformasikan cara Anda memantau bisnis. Dengan aliran data real-time yang langsung masuk ke ekosistem SAP Anda, jajaran manajemen dapat mengakses laporan yang selalu up-to-date untuk pengambilan keputusan strategis yang jauh lebih cepat.', 84),
  (1, 2, '6a0c0ba8e61eae70b2f72ed7', 'Application', 'Transformasi Proses Manual ke Digital', 'Tinggalkan tumpukan kertas dan spreadsheet yang rentan error. Kami merancang aplikasi web dan mobile kustom untuk mendigitalkan dan mengotomatisasi alur kerja Anda, memastikan operasional harian selesai lebih cepat dan akurat.', 37),
  (2, 2, '6a0c0bfae61eae70b2f72ed9', 'System Integration', 'Penyatuan Ekosistem Data Terpusat', 'Kami membongkar batasan antar-aplikasi di perusahaan Anda. Melalui pengembangan API yang solid—termasuk sinkronisasi dengan modul SAP atau ERP—kami menyatukan data yang terfragmentasi menjadi satu ekosistem utuh yang transparan.', 38),
  (3, 2, '6a0c0c48e61eae70b2f72edb', 'Scalability & UI/UX', 'Software yang Tumbuh Bersama Bisnis', 'Sistem yang kami bangun dirancang untuk jangka panjang. Dengan arsitektur yang fleksibel (scalable) dan desain antarmuka (UI/UX) yang intuitif, aplikasi Anda tidak hanya tangguh menghadapi beban kerja, tetapi juga sangat mudah diadaptasi oleh karyawan.', 39),
  (1, 5, '6a34e9c8b7ac3134812d0885', 'Pilihan Terlengkap', 'Katalog Laptop untuk Segala Kebutuhan', 'Dari laptop gaming dengan refresh rate tinggi hingga laptop desain grafis dengan akurasi warna tajam. Temukan spesifikasi impian Anda dengan harga yang kompetitif.', 160),
  (2, 5, '6a34e9ccb7ac3134812d0886', 'Custom Build', 'Rakit PC dengan Spesifikasi Bebas Pilih', 'Anda tentukan komponennya, kami rakitkan untuk Anda. Dapatkan PC dengan manajemen kabel yang rapi, pengujian stress-test menyeluruh, dan siap langsung digunakan.', 161),
  (3, 5, '6a34eb1bb7ac3134812d0887', 'Enterprise Ready', 'Pengadaan Server Mudah & Cepat', 'Tidak perlu pusing mengurus infrastruktur. Kami menyediakan solusi server terintegrasi lengkap dengan garansi resmi dan dukungan teknis yang responsif.', 139);

-- Data untuk tabel: "solution_categories" (14 rows)
TRUNCATE TABLE "solution_categories" CASCADE;
INSERT INTO "solution_categories" ("id", "name", "slug", "badge_color", "description", "updated_at", "created_at") VALUES
  (12, 'Data & Analitycs', 'data-analitycs', 'teal', NULL, '2026-09-29T01:46:15.596Z', '2026-09-29T01:46:15.595Z'),
  (13, 'Network & Security', 'network-security', 'teal', NULL, '2026-09-29T01:46:38.778Z', '2026-09-29T01:46:38.778Z'),
  (14, 'Server & Storage', 'server-storage', 'teal', NULL, '2026-09-29T01:47:30.084Z', '2026-09-29T01:47:30.084Z'),
  (15, 'Surveillance & Security System', 'surveillance-security-system', 'teal', NULL, '2026-09-29T01:47:45.059Z', '2026-09-29T01:47:45.058Z'),
  (16, 'IaaS (Infrastructure as a Service)', 'iaas-infrastructure-as-a-service', 'teal', NULL, '2026-09-29T04:19:33.339Z', '2026-09-29T04:16:37.734Z'),
  (17, 'Electronics & Lightings', 'electronics-lightings', 'teal', NULL, '2026-09-29T05:31:59.354Z', '2026-09-29T04:24:40.097Z'),
  (18, 'SaaS (Software as a Service)', 'saas-software-as-a-service', 'teal', NULL, '2026-09-29T05:32:08.209Z', '2026-09-29T04:24:40.097Z'),
  (23, 'Audio Visual', 'audio-visual', 'teal', NULL, '2026-09-29T07:11:14.394Z', '2026-09-29T07:11:14.394Z'),
  (27, 'Data Protection', 'data-protection', 'teal', NULL, '2026-09-29T07:16:35.562Z', '2026-09-29T07:16:35.562Z'),
  (28, 'Rack, Power & Cooling', 'rack-power-cooling', 'teal', NULL, '2026-09-29T07:18:36.641Z', '2026-09-29T07:16:35.562Z'),
  (30, 'Printing, Peripheral & Tools', 'printing-peripheral-tools', 'teal', NULL, '2026-09-29T08:19:14.409Z', '2026-09-29T08:16:57.316Z'),
  (32, 'Productivity', 'productivity', 'teal', NULL, '2026-09-30T03:11:33.388Z', '2026-09-30T03:11:33.388Z'),
  (24, 'Devices and Smartphone', 'devices-and-smartphone', 'teal', NULL, '2026-09-30T03:51:18.053Z', '2026-09-29T07:11:14.394Z'),
  (35, 'Data Governance', 'data-governance', 'teal', NULL, '2026-10-01T01:23:28.709Z', '2026-10-01T01:23:28.709Z');

-- Data untuk tabel: "solutions" (65 rows)
TRUNCATE TABLE "solutions" CASCADE;
INSERT INTO "solutions" ("id", "title", "slug", "published_date", "excerpt", "cover_image_id", "updated_at", "created_at", "industry_id", "description") VALUES
  (20, 'Transparansi & Pelacakan Rantai Pasok Cerdas', 'transparansi-pelacakan-rantai-pasok-cerdas', '2026-09-29T08:29:50.834Z', 'Solusi pelacakan berbasis IoT, RFID, dan analitik cerdas untuk memantau pergerakan material, mengoptimalkan rute pengiriman, serta mencegah risiko keterlambatan secara real-time.', 224, '2026-10-01T03:53:09.469Z', '2026-09-29T08:29:50.834Z', 10, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri manufaktur modern, alur distribusi barang semakin rumit karena melibatkan jaringan pemasok, pabrik, gudang penyimpanan, dan armada logistik lintas daerah. Tanpa pengawasan langsung, perusahaan rentan mengalami keterlambatan pengiriman bahan baku, stok gudang yang tidak seimbang, hingga koordinasi logistik yang terhambat. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Transparansi & Pelacakan Rantai Pasok Cerdas","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk memberikan kontrol penuh terhadap seluruh aliran logistik dari hulu ke hilir.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pelacakan Posisi & Pergerakan Barang:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggunakan sensor IoT, label RFID, dan sistem GPS untuk memantau pergerakan material dan produk jadi secara akurat dan tanpa jeda.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Data & Analitik Prediktif:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggabungkan seluruh data operasional ke dalam satu platform analitik berbasis kecerdasan buatan (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"AI","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":") guna memantau ketersediaan stok, aktivitas gudang, dan mengantisipasi potensi risiko hambatan sebelum berdampak ke proses produksi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Kendali Terpusat (","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Command Center","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":"):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memudahkan manajer operasional dan logistik mendeteksi titik macet (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"bottleneck","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), merespons kendala jalur distribusi dengan cepat, dan mengoptimalkan rute armada pengiriman.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui integrasi data logistik yang menyeluruh ini, perusahaan manufaktur dapat memangkas waktu tunggu pengiriman, meningkatkan efisiensi biaya operasional, serta memastikan seluruh rantai pasok berjalan transparan, tepat waktu, dan lebih tahan terhadap gangguan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (24, 'Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan', 'optimalisasi-energi-pemantauan-keberlanjutan-lingkungan', '2026-09-29T08:47:00.978Z', 'Solusi pemantauan konsumsi energi dan emisi karbon berbasis IoT serta analitik cerdas untuk menekan biaya operasional pabrik dan mewujudkan industri ramah lingkungan.', 226, '2026-10-01T03:54:23.574Z', '2026-09-29T08:47:00.978Z', 10, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sektor manufaktur merupakan salah satu konsumen energi terbesar, yang berpengaruh langsung terhadap lonjakan biaya operasional dan dampak lingkungan. Namun, banyak pabrik masih kesulitan melacak penggunaan listrik dan daya secara detail di tiap mesin, lini produksi, maupun fasilitas gedung. Hal ini kerap memicu pemborosan daya dan menyulitkan pemenuhan standar regulasi hijau. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Optimalisasi Energi & Pemantauan Keberlanjutan Lingkungan","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir menggunakan meteran pintar (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"smart meters","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), sensor IoT, dan sistem terhubung guna memantau pola konsumsi energi serta kondisi lingkungan pabrik secara kontinu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Energi Menyeluruh:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggunakan sensor IoT dan ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"smart meters","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" untuk melacak penggunaan daya listrik, performa mesin, dan parameter lingkungan di seluruh area pabrik secara ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"real-time","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":".","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Cerdas & Prediksi Kebutuhan Energi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Seluruh data dihimpun ke platform terpusat yang didukung ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"AI","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" untuk mendeteksi titik-titik pemborosan, memprediksi kebutuhan daya harian, serta merekomendasikan efisiensi beban kerja mesin.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Emisi & Kendali Terpusat (","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Command Center","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":"):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memudahkan manajemen memantau kinerja energi, menghitung jejak emisi karbon secara akurat, dan memastikan operasional tetap patuh pada target keberlanjutan serta regulasi pemerintah.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui integrasi data energi yang akurat dan transparan ini, perusahaan manufaktur dapat memangkas biaya operasional secara signifikan, meningkatkan efisiensi penggunaan daya, serta mempercepat langkah transformasi menuju operasional pabrik yang ramah lingkungan dan berkelanjutan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (27, 'Sistem Otomatisasi & Pelacakan Gudang', 'sistem-otomatisasi-pelacakan-gudang', '2026-09-30T02:47:46.946Z', 'Solusi modernisasi gudang berbasis robotik, IoT, dan RFID untuk mempercepat pemrosesan pesanan, memastikan akurasi stok, serta memantau operasional gudang secara real-time.', 227, '2026-10-01T03:55:11.489Z', '2026-09-30T02:47:46.946Z', 10, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Efisiensi operasional gudang memegang peranan krusial dalam industri manufaktur, namun banyak fasilitas masih mengandalkan pencatatan manual dan sistem yang terpisah-pisah untuk mengelola stok serta pemenuhan pesanan. Pola kerja manual ini kerap memicu kekeliruan data stok, keterlambatan pengiriman pesanan, hingga pemanfaatan ruang gudang yang tidak optimal. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Otomatisasi & Pelacakan Gudang Terpadu","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menjawab kendala tersebut dengan mengintegrasikan teknologi pelacakan modern dan sistem otomatisasi fisik guna menciptakan alur kerja gudang yang ringkas, cepat, dan presisi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Otomatisasi Operasional & Robotik:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengintegrasikan sistem konveyor, robot pemilah (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"robotic picking","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), serta kendaraan terpandu otomatis (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Automated Guided Vehicles","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" / AGV) untuk memindahkan dan menyortir barang secara cepat dan minim kesalahan tenaga kerja.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pelacakan Posisi & Stok Akurat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan pemindai kode batang (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"barcode","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), label RFID, dan sensor IoT untuk mendata setiap pergerakan barang, status pesanan, serta jumlah persediaan secara ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"real-time","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":".","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Analitik & Pusat Kendali (","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Command Center","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":"):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyatukan seluruh data gudang ke dalam satu platform analitik terpusat agar manajemen dapat mengidentifikasi titik hambatan (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"bottleneck","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), mengoptimalkan tata letak penyimpanan, dan memantau kinerja staf gudang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan beralih ke pengelolaan gudang berbasis data dan teknologi otomatis ini, perusahaan manufaktur dapat menekan biaya operasional, mempercepat siklus pengiriman barang ke pelanggan, serta menciptakan rantai pasok yang jauh lebih lincah dan responsif terhadap dinamika pasar.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (29, 'Pusat Kendali Pabrik Cerdas', 'pusat-kendali-pabrik-cerdas', '2026-09-30T02:51:35.243Z', 'Platform dasbor pemantauan terpusat berbasis AI dan IoT untuk mengawasi seluruh lini produksi, kesehatan mesin, dan performa pabrik secara real-time.', 228, '2026-10-01T03:55:45.968Z', '2026-09-30T02:51:35.243Z', 10, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Operasional manufaktur modern semakin kompleks dengan banyaknya lini produksi, mesin, dan sistem pendukung yang berjalan secara bersamaan. Tanpa adanya pemantauan terpusat, manajemen kesulitan melacak performa operasional, mendeteksi masalah sejak dini, dan mengoordinasikan tindakan perbaikan dengan cepat. Hambatan ini kerap memicu mesin mati mendadak (unplanned downtime), penurunan mutu produk, serta inefisiensi biaya. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Kendali Pabrik Cerdas (Smart Factory Command Center)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mengintegrasikan seluruh aliran data mesin, sistem produksi, dan sensor ke dalam satu platform kendali terpadu dengan visibilitas menyeluruh di area lantai pabrik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi & Dasbor Pemantauan Terpusat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyatukan data lintas sistem ke dalam satu layar utama untuk memantau volume produksi harian, metrik kualitas produk, hingga status operasional mesin secara real-time.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemeliharaan Prediktif Berbasis AI (Predictive Maintenance):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan analitik lanjutan dan kecerdasan buatan untuk mendeteksi anomali kinerja mesin lebih awal, memungkinkan perbaikan preventif sebelum terjadi kerusakan komponen yang menghentikan produksi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Koordinasi Cepat & Optimasi Berkelanjutan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengirimkan notifikasi dan peringatan insiden langsung ke tim operasional agar kendala di lini perakitan dapat segera ditangani tanpa memicu efek domino.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui transformasi data operasional yang terisolasi menjadi wawasan yang siap ditindaklanjuti (actionable insights), perusahaan manufaktur dapat meminimalkan waktu henti mesin secara drastis, menjaga konsistensi standar mutu produk, serta mewujudkan ekosistem pabrik pintar yang lincah dan berlandaskan data.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (31, 'Inspeksi Kualitas Berbasis AI', 'inspeksi-kualitas-berbasis-ai', '2026-09-30T03:07:08.812Z', 'Solusi inspeksi otomatis berbasis computer vision dan machine learning untuk mendeteksi cacat produk, memeriksa dimensi, dan menjaga standar kualitas secara presisi dan real-time.', 229, '2026-10-01T03:56:17.295Z', '2026-09-30T03:07:08.812Z', 10, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri manufaktur modern, menjaga konsistensi mutu produk di tengah kecepatan produksi yang tinggi menjadi tantangan tersendiri. Inspeksi manual oleh tenaga kerja kerap terkendala oleh keterbatasan kecepatan, kelelahan mata, serta potensi ketidakstabilan standar penilaian. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Inspeksi Kualitas Berbasis AI","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir dengan menggabungkan teknologi pemrosesan citra (computer vision) dan pembelajaran mesin (machine learning) untuk memindai setiap unit produk yang melintas di lini produksi secara otomatis, akurat, dan tanpa memperlambat alur kerja.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Cacat Presisi Tinggi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Model AI yang dilatih dengan ribuan sampel dapat mengenali berbagai bentuk cacat—mulai dari cacat permukaan, sambungan las, lapisan pelindung (coating), kesalahan perakitan, hingga kemasan—dengan tingkat akurasi dan kecepatan yang melampaui inspeksi manual.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Kamera & Sensor IoT:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan kamera resolusi tinggi (surveillance-grade) dan sensor IoT untuk menangkap detail visual produk secara kontinu serta memantau kondisi fisik seperti suhu, getaran, dan presisi posisi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Notifikasi & Analitik Akar Masalah Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mesin AI mendeteksi anomali secara instan, memicu peringatan otomatis saat ditemukan produk cacat, dan menyajikan tren data pada dasbor untuk membantu tim menganalisis akar penyebab masalah (root cause).","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":4,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Ekosistem Terintegrasi dari SMI:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Didukung penuh oleh Synnex Metrodata Indonesia melalui penyediaan perangkat kamera & IoT, platform data & analitik untuk pelatihan model AI, infrastruktur server & penyimpanan berkecepatan tinggi, hingga sistem jaringan yang aman.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan inspeksi otomatis berbasis AI ini, perusahaan manufaktur dapat menekan tingkat sampah produksi (waste), meminimalkan risiko penarikan produk (recall), menjaga reputasi merek, serta memastikan setiap produk yang keluar ke pasaran memenuhi standar kualitas tertinggi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (35, 'Pemantauan Energi & Lingkungan Toko Cerdas', 'pemantauan-energi-lingkungan-toko-cerdas', '2026-09-30T03:28:45.751Z', 'Solusi pemantauan berbasis IoT dan analitik cerdas untuk mengoptimalkan penggunaan energi, menjaga kenyamanan lingkungan toko, dan menekan biaya operasional secara real-time.', 231, '2026-10-01T06:32:41.948Z', '2026-09-30T03:28:45.751Z', 11, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah persaingan bisnis ritel yang ketat, efisiensi energi dan pengelolaan lingkungan toko bukan lagi sekadar pilihan, melainkan kunci keberhasilan operasional dan reputasi merek. Banyak gerai ritel masih menghadapi tantangan pemborosan listrik dari sistem pencahayaan, AC (HVAC), hingga mesin pendingin yang tidak terpantau secara optimal. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pemantauan Energi & Lingkungan Toko Cerdas","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mengubah toko konvensional menjadi ekosistem cerdas dengan memanfaatkan sensor IoT, perangkat pintar, dan analitik data terpusat guna menjaga kondisi toko tetap ideal sekaligus hemat energi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan & Kontrol Otomatis Perangkat Toko:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengumpulkan dan menganalisis data secara kontinu dari sistem pencahayaan, pendingin ruangan (HVAC), refrigrasi/freezer, hingga papan reklame digital untuk menyesuaikan penggunaan daya secara dinamis sesuai kondisi toko dan lalu lintas pengunjung.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengawasan Kualitas Lingkungan & Kesehatan Alat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Melacak kualitas udara, suhu ruangan, serta tingkat emisi karbon untuk memastikan kenyamanan konsumen saat berbelanja sekaligus mendeteksi gangguan kinerja peralatan sebelum terjadi kerusakan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Kendali Terpusat & Peringatan Dini:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan data performa energi di seluruh gerai pada satu dasbor utama, memungkinkan manajer toko mendeteksi anomali pemborosan, mencegah downtime mesin, dan mengambil keputusan berbasis data secara langsung.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem pemantauan energi dan lingkungan yang cerdas ini, pelaku bisnis ritel dapat menekan biaya operasional secara signifikan, meningkatkan kepercayaan pelanggan, serta membangun operasional toko yang efisien, tangguh, dan ramah lingkungan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (43, 'Analitik Perilaku Pelanggan Berbasis AI', 'analitik-perilaku-pelanggan-berbasis-ai', '2026-09-30T03:46:05.560Z', 'Solusi pemantauan berbasis AI, computer vision, dan IoT untuk menganalisis alur belanja pelanggan, memprediksi tren, serta personalisasi strategi pemasaran secara real-time.', 235, '2026-10-01T06:34:35.869Z', '2026-09-30T03:46:05.560Z', 11, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri ritel dan e-commerce saat ini, memahami preferensi serta kebiasaan pelanggan merupakan kunci utama untuk memenangkan persaingan. Tanpa data yang terukur, pemilik bisnis sering kesulitan mengetahui area toko yang paling diminati, alasan produk kurang dilirik, hingga perilaku navigasi konsumen saat berbelanja. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Analitik Perilaku Pelanggan Berbasis AI","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mengubah kumpulan data mentah dari aktivitas pelanggan—baik di toko fisik maupun platform digital—menjadi wawasan strategis yang presisi dan siap ditindaklanjuti.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analisis Lalu Lintas & Interaksi Produk:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggabungkan computer vision, sensor IoT, dan machine learning untuk memantau kepadatan pengunjung (foot traffic), durasi pengamatan produk (dwell time), hingga pola navigasi belanja pelanggan secara real-time.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Personalisasi & Prediksi Preferensi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengelompokkan pelanggan berdasarkan perilaku belanja untuk menyajikan rekomendasi produk yang relevan, promosi yang tersasar, serta pengalaman omnichannel yang seamless di setiap titik interaksi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Terpusat & Optimasi Strategi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan hasil analisis pada dasbor pemantauan utama guna memudahkan manajemen dalam mengoptimalkan tata letak toko (store layout), menata penempatan produk, dan mengevaluasi efektivitas kampanye pemasaran secara cepat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan memanfaatkan analitik perilaku pelanggan yang cerdas ini, perusahaan ritel dan e-commerce dapat mengantisipasi kebutuhan konsumen secara proaktif, meningkatkan angka konversi penjualan, serta membangun loyalitas pelanggan jangka panjang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (45, 'Pelacakan Aset Medis Rumah Sakit', 'pelacakan-aset-medis-rumah-sakit', '2026-09-30T07:05:16.518Z', 'Solusi pelacakan berbasis RFID, BLE, dan IoT untuk memantau lokasi, status, serta ketersediaan peralatan medis secara real-time guna mempercepat penanganan pasien.', 236, '2026-10-01T06:35:43.145Z', '2026-09-30T07:05:16.518Z', 12, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di lingkungan pelayanan kesehatan, kecepatan dalam menemukan dan menyiapkan peralatan medis kritis sangat memengaruhi keselamatan pasien. Rumah sakit kerap menghadapi kendala lambatnya proses pencarian unit alat kesehatan, inventaris yang tercecer lintas departemen, hingga risiko pemborosan akibat pembelian alat yang tidak efisien. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pelacakan Aset Medis Rumah Sakit (Healthcare Asset Tracking)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk memberikan transparansi penuh terhadap posisi dan penggunaan aset medis penting—seperti pompa infus, ventilator, kursi roda, hingga alat pemantau medis—secara otomatis dan akurat dari hulu ke hilir.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pelacakan Lokasi & Ketersediaan Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggunakan label RFID, Bluetooth Low Energy (BLE), dan sensor IoT untuk melacak pergerakan dan status peralatan di seluruh area rumah sakit, mulai dari ruang ICU, ruang operasi, hingga bangsal perawatan umum.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perawatan Prediktif & Pencegahan Kerusakan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengirimkan peringatan jadwal pemeliharaan berkala dan deteksi dini masalah alat, memastikan seluruh perangkat siap pakai saat dibutuhkan dan mencegah kerusakan mendadak.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Kendali & Efisiensi Biaya:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan wawasan tingkat penggunaan (utilisasi) aset pada dasbor terpusat, membantu manajemen mengoptimalkan alokasi inventaris, mencegah risiko kehilangan barang, dan menghindari pembelian alat baru yang tidak diperlukan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem pelacakan aset medis yang responsif dan terintegrasi ini, tenaga medis dapat memangkas waktu pencarian alat, memfokuskan lebih banyak waktu untuk perawatan pasien, serta membangun operasional rumah sakit yang lebih efisien, aman, dan berlandaskan data.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (49, 'Sistem Ambulans Cerdas & Tanggap Darurat', 'sistem-ambulans-cerdas-tanggap-darurat', '2026-09-30T07:27:25.985Z', 'Solusi unit gawat darurat bergerak berbasis IoT dan telemedisin untuk transmisi data vital pasien, panduan medis jarak jauh, dan optimasi rute secara real-time.', 238, '2026-10-01T06:36:26.730Z', '2026-09-30T07:27:25.985Z', 12, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dalam kondisi medis darurat, setiap detik sangat berharga dan dapat menentukan keselamatan nyawa pasien. Pelayanan darurat konvensional kerap menghadapi kendala berupa keterbatasan komunikasi data kondisi pasien selama perjalanan, sehingga tim rumah sakit baru bisa bersiap saat ambulans tiba. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Sistem Ambulans Cerdas & Tanggap Darurat (Smart Ambulance System)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mentransformasi ambulans biasa menjadi unit perawatan bergerak yang terhubung secara digital, memungkinkan pertolongan pertama berjalan optimal sejak pasien dijemput hingga sampai di rumah sakit.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Tanda Vital & Transmisi Data Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggunakan perangkat medis terintegrasi IoT untuk memantau detak jantung, kadar oksigen, dan tekanan darah pasien secara kontinu, lalu mengirimkan datanya langsung ke pusat kendali rumah sakit selama perjalanan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Telemedisin & Panduan Dokter Jarak Jauh:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menghubungkan paramedis di dalam ambulans dengan dokter spesialis di rumah sakit secara langsung melalui panggilan video dan audio berkualitas tinggi untuk mendapatkan arahan tindakan medis darurat di tempat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Optimasi Rute GPS & Notifikasi Pra-Kedatangan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan pelacakan GPS dan navigasi cerdas untuk memilih jalur tercepat guna menghindari kemacetan, sekaligus memberi notifikasi otomatis ke ruang IGD agar tim medis dan peralatan siap menyambut pasien tanpa penundaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui integrasi data medis yang cepat dan akurat ini, rumah sakit dapat memangkas waktu respons kritis, menjembatani penanganan pra-rumah sakit dengan tindakan medis lanjutan, serta meningkatkan peluang keberhasilan penyelamatan pasien gawat darurat secara signifikan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (51, 'Pusat Keamanan Siber & Kepatuhan Medis', 'pusat-keamanan-siber-kepatuhan-medis', '2026-09-30T07:30:09.550Z', 'Solusi pusat komando berbasis AI dan SIEM untuk melindungi data rekam medis, mengamankan perangkat klinis dari ancaman siber, dan memastikan kepatuhan regulasi secara real-time.', 239, '2026-10-01T06:36:52.873Z', '2026-09-30T07:30:09.550Z', 12, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di era digitalisasi fasilitas kesehatan, perlindungan data privasi pasien dan pemenuhan standar kepatuhan regulasi menjadi prioritas utama. Rumah sakit dan fasilitas medis modern sangat rentan terhadap serangan siber, seperti penyusupan data rekam medis elektronik, peretasan perangkat medis terhubung (IoMT), hingga ancaman ransomware yang dapat melumpuhkan layanan gawat darurat. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Keamanan Siber & Kepatuhan Medis (Healthcare Cybersecurity & Compliance Center)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai pusat komando terpadu untuk mengawasi, mendeteksi, dan menangkal ancaman keamanan siber pada seluruh ekosistem layanan medis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Ancaman Cerdas & SIEM Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengintegrasikan platform SIEM (Security Information and Event Management) dan analitik berbasis AI untuk memantau jaringan, sistem rekam medis, serta perangkat klinis guna mendeteksi upaya peretasan atau malware sebelum mengganggu operasional rumah sakit.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Manajemen Akses Identitas & Jejak Audit Otomatis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menerapkan kontrol akses ketat (Identity and Access Management / IAM) dan pencatatan riwayat aktivitas (audit trails) digital secara otomatis guna mencegah kebocoran data pasien oleh pihak yang tidak berwenang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pelaporan Kepatuhan Regulasi & Penilaian Kerentanan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyediakan dasbor pemantauan terpusat dengan laporan otomatis untuk menjamin kepatuhan terhadap regulasi privasi data kesehatan nasional maupun global, serta menjalankan pemindaian risiko secara proaktif.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem perlindungan siber dan kepatuhan yang menyeluruh ini, rumah sakit dapat melindungi kerahasiaan data pasien, meminimalkan risiko gangguan sistem medis, serta membangun reputasi dan kepercayaan publik terhadap layanan kesehatan yang aman dan andal.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (53, 'Otomatisasi Farmasi & Apotek Cerdas', 'otomatisasi-farmasi-apotek-cerdas', '2026-09-30T07:32:53.293Z', 'Solusi pengelolaan obat berbasis robotik dan IoT untuk memverifikasi resep, mengambil serta meracik obat secara presisi, dan memantau stok secara real-time.', 240, '2026-10-01T06:37:12.043Z', '2026-09-30T07:32:53.293Z', 12, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di fasilitas pelayanan kesehatan modern, akurasi dan kecepatan dalam pengelolaan obat sangat berpengaruh terhadap keselamatan pasien. Proses farmasi konvensional sering kali dibebani oleh tugas manual yang berulang—mulai dari pencatatan resep, pemilahan, hingga penyiapan obat—yang rentan memicu waktu tunggu antrean yang lama dan risiko kesalahan pemberian obat (medication error). Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Otomatisasi Farmasi & Apotek Cerdas (Smart Pharmacy Automation)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mentransformasi alur kerja apotek dan instalasi farmasi rumah sakit menjadi ekosistem otomatis yang presisi, aman, dan terintegrasi dari hulu ke hilir.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Peracikan & Pengambilan Obat Robotik:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggunakan teknologi robotik otomatis untuk memverifikasi resep digital, mengambil, melabeli, dan mengemas obat dengan tingkat presisi tinggi sehingga meminimalkan potensi kesalahan manusia.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pelacakan Stok & Manajemen Kedaluwarsa Proaktif:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan sensor IoT dan perangkat lunak cerdas untuk memantau pergerakan obat dan tingkat persediaan secara real-time, sekaligus memberi peringatan dini terkait masa kedaluwarsa serta mencegah kekosongan stok obat vital.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Sistem Rumah Sakit & Dasbor Terpusat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Terhubung langsung dengan sistem informasi rumah sakit (SIMRS) dan rekam medis elektronik, memudahkan tenaga farmasi memantau ketersediaan obat lintas departemen serta memvalidasi kesesuaian dosis secara instan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem otomatisasi farmasi ini, rumah sakit dan apotek dapat memangkas waktu tunggu pasien, menekan risiko kesalahan pemberian obat hingga titik terendah, serta memungkinkan apoteker lebih fokus pada konsultasi klinis dan pendampingan perawatan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (55, 'Diagnosis Radiologi Cepat & Akurat Berbasis AI', 'diagnosis-radiologi-cepat-akurat-berbasis-ai', '2026-09-30T07:37:07.599Z', 'Solusi radiologi cerdas berbasis machine learning untuk mendeteksi anomali pada MRI, CT scan, dan X-ray secara cepat, akurat, dan terintegrasi dengan sistem rumah sakit.', 241, '2026-10-01T06:37:31.213Z', '2026-09-30T07:37:07.599Z', 12, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kecepatan dan ketepatan diagnosis radiologi sangat menentukan keberhasilan penanganan pasien dan pencegahan keparahan penyakit. Namun, tingginya volume pemindaian medis sering kali membebani dokter spesialis radiologi, memperpanjang waktu tunggu hasil analisis, dan meningkatkan risiko terlewatnya anomali kecil pada citra medis. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Diagnosis Radiologi Cepat & Akurat Berbasis AI","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mentransformasi alur kerja diagnosis medis dengan menggabungkan algoritma pembelajaran mesin tingkat lanjut pada berbagai modalitas pencitraan seperti MRI, CT scan, dan foto Rontgen (X-ray).","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Anomali & Pembacaan Presisi Tinggi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggunakan model AI terlatih untuk memindai citra medis secara otomatis dan menyorot potensi kelainan—seperti tumor, fraktur mikro, pendarahan, atau lesi jaringan—yang kerap sulit terdeteksi oleh mata secara sekilas.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Prioritas Kasus & Efisiensi Alur Kerja:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memfilter serta memprioritaskan kasus-kasus berisiko tinggi secara otomatis di antrean pembacaan, sehingga pasien dalam kondisi kritis dapat memperoleh tindakan intervensi medis lebih awal tanpa memperlambat alur diagnosis pasien lain.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi PACS/RIS & Dasbor Intuitif:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Terhubung mulus dengan sistem penyimpanan dan komunikasi gambar medis (Picture Archiving and Communication System / PACS) serta sistem informasi radiologi (RIS) untuk menyajikan wawasan visual pendukung langsung ke meja kerja dokter.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan teknologi pencitraan medis berbasis AI ini, fasilitas kesehatan dapat memangkas durasi pembacaan hasil rontgen dan scan, menekan angka kesalahan diagnosis klinis, serta meningkatkan peluang keberhasilan terapi melalui deteksi penyakit yang jauh lebih dini dan akurat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (57, 'Digitalisasi & Integrasi Rekam Medis', 'digitalisasi-integrasi-rekam-medis', '2026-09-30T07:39:22.363Z', 'Platform rekam medis digital terpusat untuk mengakses riwayat pasien, hasil lab, dan resep secara real-time guna mempercepat koordinasi klinis antar-departemen.', 242, '2026-10-01T06:37:51.198Z', '2026-09-30T07:39:22.363Z', 12, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di ekosistem pelayanan kesehatan modern, ketersediaan informasi pasien yang cepat, akurat, dan berkesinambungan menjadi kunci utama penanganan medis yang optimal. Penggunaan berkas medis fisik manual sering kali memicu penumpukan dokumen, risiko salah baca catatan, serta keterlambatan koordinasi antar-dokter spesialis atau departemen. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Digitalisasi & Integrasi Rekam Medis Terpadu (Electronic Medical Record / EMR)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menyatukan seluruh siklus data pasien—mulai dari pendaftaran, diagnosis, hasil pemeriksaan laboratorium, riwayat tindakan, hingga resep obat—ke dalam satu platform digital yang aman dan dapat diakses seketika.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Akses Riwayat Pasien Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyediakan data riwayat klinis, hasil laboratorium, catatan tindakan, dan resep secara instan melalui satu layar, memudahkan tim medis mengambil keputusan medis yang tepat tanpa jeda birokrasi manual.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Lintas Unit Layanan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menghubungkan alur kerja dokter langsung dengan instalasi laboratorium, farmasi, kasir, dan penunjang medis lainnya, memangkas proses administrasi berulang serta mempercepat durasi pelayanan pasien.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sistem Pendukung Keputusan Klinis (CDSS):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Dilengkapi fitur notifikasi otomatis untuk mengingatkan potensi alergi obat, interaksi zat berbahaya, atau anomali parameter vital, sehingga menekan risiko human error dalam perawatan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengadopsi sistem rekam medis digital terintegrasi ini, rumah sakit dan klinik dapat memangkas beban kerja administratif tenaga kesehatan, mempercepat alur pelayanan pasien dari hulu ke hilir, serta menjamin kesinambungan perawatan medis yang aman, patuh regulasi, dan terpercaya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (59, 'Pusat Kendali Operasional Rumah Sakit', 'pusat-kendali-operasional-rumah-sakit', '2026-09-30T07:42:23.207Z', 'Platform komando terpusat berbasis AI dan IoT untuk memantau ketersediaan ranjang, arus pasien, status darurat, dan alokasi fasilitas medis secara real-time.', 243, '2026-10-01T06:38:11.394Z', '2026-09-30T07:42:23.207Z', 12, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah tingginya dinamika layanan kesehatan, rumah sakit dituntut beroperasi dengan kecepatan tinggi, akurasi tinggi, serta koordinasi tanpa hambatan antar-unit. Pemantauan fasilitas yang terpisah-pisah kerap menimbulkan kendala penumpukan pasien di IGD, keterlambatan informasi ketersediaan ranjang rawat inap, hingga lambatnya respons penanganan situasi kritis. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Kendali Operasional Rumah Sakit Terpadu (Smart Hospital Command Center)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai pusat kendali utama yang mengintegrasikan aliran data dari rekam medis elektronik (EMR), sensor IoT, monitor tanda vital pasien, serta manajemen gedung ke dalam satu layar kendali menyeluruh.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Visibilitas Operasional & Arus Pasien Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan data keterisian tempat tidur (bed occupancy), antrean IGD, jadwal ruang operasi, dan pergerakan pasien secara langsung untuk mempercepat alur penerimaan hingga pemulangan pasien.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Prediktif & Pencegahan Kemacetan Layanan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan analitik cerdas untuk memproyeksikan lonjakan kebutuhan ranjang dan mendeteksi potensi hambatan alur (bottleneck) layanan, memungkinkan alokasi tenaga medis dan peralatan dilakukan lebih awal.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Koordinasi Tanggap Darurat Lintas Unit:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menghubungkan komunikasi darurat dari armada ambulans, ruang gawat darurat, unit perawatan intensif (ICU), hingga laboratorium penunjang guna mempercepat pengambilan keputusan klinis saat krisis terjadi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengimplementasikan pusat kendali operasional pintar ini, manajemen rumah sakit dapat mengoptimalkan kapasitas sumber daya medis, memangkas waktu tunggu layanan secara signifikan, serta memastikan perawatan pasien berjalan aman, responsif, dan terkoordinasi secara presisi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (73, 'Pusat Pemantauan & Otomasi Operasional Jaringan Cerdas', 'pusat-pemantauan-otomasi-operasional-jaringan-cerdas', '2026-09-30T08:01:28.221Z', 'Solusi modernisasi NOC berbasis AI dan telemetri real-time untuk mendeteksi anomali jaringan, memprediksi potensi gangguan, dan memulihkan insiden secara otomatis.', 244, '2026-10-02T01:30:44.693Z', '2026-09-30T08:01:28.221Z', 13, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah pesatnya perkembangan layanan digital, menjaga keandalan performa dan ketersediaan jaringan telekomunikasi tanpa henti menjadi tolok ukur utama keberhasilan operator. Sistem pemantauan jaringan konvensional sering kali bersifat reaktif—tim operasional baru bertindak setelah gangguan terjadi atau setelah menerima laporan keluhan dari pelanggan. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Pemantauan & Otomasi Operasional Jaringan Cerdas (NOC Modernization)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk merevolusi pusat operasi jaringan menjadi ekosistem proaktif dan cerdas yang memanfaatkan telemetri real-time, analitik berbasis AI, serta alur kerja otomatisasi menyeluruh.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Gangguan Dini & Analisis Akar Masalah:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memantau lalu lintas jaringan di seluruh lapisan core, edge, hingga access secara kontinu guna mengenali anomali performa dan mendeteksi sumber kegagalan sistem (root cause analysis) sebelum berdampak luas pada pengguna.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Otomasi Pemulihan Insiden & Efisiensi Operasional:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengurangi kebutuhan intervensi manual melalui skrip perbaikan dan orkestrasi otomatis, mempercepat waktu pemulihan jaringan (MTTR), serta menjaga konsistensi kualitas layanan saat beban jaringan memuncak.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perencanaan Kapasitas Prediktif & Kesiapan 5G:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggunakan analitik prediktif untuk memproyeksikan lonjakan trafik data akibat ekspansi layanan 5G dan IoT, memudahkan operator mengoptimalkan alokasi bandwidth serta kapasitas infrastruktur secara tepat sasaran.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui modernisasi pusat operasi jaringan ini, operator telekomunikasi dapat mengeliminasi risiko downtime, memangkas biaya pemeliharaan jaringan, serta menjamin konektivitas berkecepatan tinggi yang stabil dan andal bagi seluruh pelanggan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (65, 'Transformasi & Skalabilitas Infrastruktur Pusat Data Cerdas', 'transformasi-skalabilitas-infrastruktur-pusat-data-cerdas', '2026-09-30T07:52:54.575Z', 'Solusi modernisasi pusat data berbasis software-defined, hybrid cloud, dan otomasi orkestrasi untuk mempercepat peluncuran layanan 5G/IoT serta menjamin keandalan sistem tanpa henti.', 248, '2026-10-02T01:38:24.491Z', '2026-09-30T07:52:54.575Z', 13, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pesatnya lonjakan konsumsi data digital dan tingginya kebutuhan konektivitas berkecepatan tinggi menuntut infrastruktur telekomunikasi beroperasi jauh lebih fleksibel, cepat, dan tangguh. Pusat data konvensional berbasis perangkat keras kaku (legacy hardware) kerap mengalami kendala keterbatasan kapasitas, tingginya biaya perawatan, serta lambatnya penyediaan sumber daya saat peluncuran layanan digital baru. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Transformasi & Skalabilitas Infrastruktur Pusat Data Cerdas (Data Center Modernization)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk merevolusi arsitektur pusat data operator menjadi lingkungan software-defined yang lincah melalui pemanfaatan teknologi virtualisasi, komputasi awan hibrida (hybrid cloud), dan kontainerisasi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Data Berbasis Perangkat Lunak (Software-Defined Architecture):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyatukan komputasi (compute), penyimpanan (storage), dan jaringan (networking) ke dalam platform virtual terpadu, memungkinkan pembagian beban kerja secara dinamis dan adaptif terhadap lonjakan lalu lintas data.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Otomasi Orkestrasi & Perawatan Prediktif:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengurangi intervensi konfigurasi manual guna meminimalkan risiko downtime, mempercepat pemulihan sistem, serta menggunakan analitik cerdas untuk memproyeksikan kebutuhan kapasitas ruang penyimpanan di masa depan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kesiapan Layanan Edge & Jaringan 5G:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengintegrasikan komputasi edge terdistribusi untuk memproses data langsung di lokasi terdekat dengan pengguna, menghadirkan latensi ultra-rendah untuk mendukung ekosistem 5G, perangkat IoT, dan aplikasi real-time.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menjalankan modernisasi infrastruktur pusat data secara terarah ini, operator telekomunikasi dapat menekan biaya operasional perangkat keras, mempercepat siklus inovasi produk ke pasar (time-to-market), serta menghadirkan layanan digital generasi baru yang stabil dan memiliki skalabilitas tinggi tanpa batas.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (63, 'Modernisasi Operasional & Layanan Kantor Cabang Pintar', 'modernisasi-operasional-layanan-kantor-cabang-pintar', '2026-09-30T07:50:55.820Z', 'Solusi digitalisasi kantor cabang berbasis SD-WAN, IoT, dan manajemen antrean cerdas untuk mempercepat layanan pelanggan serta memantau performa jaringan lintas lokasi secara real-time.', 249, '2026-10-02T01:39:31.236Z', '2026-09-30T07:50:55.820Z', 13, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri telekomunikasi yang dinamis, kantor cabang bukan lagi sekadar loket pelayanan statis, melainkan garda terdepan penentu kepuasan pelanggan dan efisiensi operasional perusahaan. Pengelolaan cabang konvensional sering kali terkendala jaringan yang lambat atau tidak stabil, antrean layanan yang menumpuk, serta keterbatasan tim IT pusat dalam memantau dan menangani kendala teknis di berbagai daerah. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Modernisasi Operasional & Layanan Kantor Cabang Pintar (Smart Branch Office)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mentransformasi gerai pelayanan konvensional menjadi fasilitas modern yang terhubung penuh, aman, dan berlandaskan data.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Konektivitas Andal & Pengelolaan Jaringan Jarak Jauh:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan arsitektur SD-WAN dan perangkat IoT untuk memastikan stabilitas koneksi, sekaligus memungkinkan tim IT pusat memantau kesehatan jaringan, memperbarui sistem, dan mengatasi gangguan teknis di cabang mana pun secara remote tanpa perlu kunjungan fisik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Manajemen Antrean & Pengalaman Pelanggan Cepat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengintegrasikan analitik arus pengunjung dan sistem antrean cerdas untuk mempercepat transaksi layanan rutin—seperti registrasi kartu SIM, pembayaran tagihan, hingga konsultasi teknis—sehingga memangkas waktu tunggu secara signifikan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Kendali Terpusat & Optimasi Staf:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan data interaksi pelanggan, tingkat utilisasi staf pelayanan (customer service), dan status perangkat di seluruh cabang ke dalam satu platform pemantauan, memudahkan evaluasi performa gerai secara objektif.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan ekosistem kantor cabang pintar yang terintegrasi ini, operator telekomunikasi dapat menekan biaya operasional pemeliharaan cabang, menjaga konsistensi standar layanan di seluruh wilayah, serta menghadirkan pengalaman bertransaksi yang cepat, nyaman, dan berkelas bagi para pelanggan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (61, 'Pencegahan Kecurangan & Kebocoran Pendapatan Telekomunikasi', 'pencegahan-kecurangan-kebocoran-pendapatan-telekomunikasi', '2026-09-30T07:44:43.705Z', 'Solusi keamanan berbasis AI dan analitik perilaku untuk mendeteksi SIM swap, anomali lalu lintas data, dan kebocoran tagihan secara real-time guna melindungi pendapatan operator.', 250, '2026-10-02T01:40:00.823Z', '2026-09-30T07:44:43.705Z', 13, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri telekomunikasi yang bergerak cepat, lonjakan volume transaksi digital dan aktivitas jaringan membuka celah besar bagi aksi kejahatan siber serta kebocoran pendapatan (revenue leakage). Operator sering kali terlambat mendeteksi manipulasi jaringan atau pola panggilan ilegal, yang berujung pada kerugian finansial bernilai besar dan menurunnya kepercayaan pelanggan. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pencegahan Kecurangan & Kebocoran Pendapatan Telekomunikasi (Fraud Detection & Risk Analytics)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai lapisan intelijen pintar yang memantau pola panggilan, konsumsi data, aktivitas tagihan, serta perilaku pelanggan secara berkesinambungan dan tanpa jeda.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Anomali & Modus Kejahatan Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan algoritma AI untuk mengenali kejahatan telekomunikasi secara instan, seperti pembajakan kartu SIM (SIM swap fraud), penipuan bagi hasil internasional (IRSF), hingga lonjakan penggunaan pulsa dan kuota yang mencurigakan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Penilaian Risiko Dinamis & Analisis Perilaku:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menetapkan skor risiko pada setiap aktivitas nomor secara otomatis tanpa mengganggu kenyamanan pengguna sah (frictionless), sekaligus menghentikan transaksi berbahaya sebelum berdampak ke sistem keuangan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Penjaminan Pendapatan (Revenue Assurance):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Terhubung langsung dengan sistem penagihan (billing), CRM, dan infrastruktur inti jaringan untuk menyajikan visibilitas risiko menyeluruh pada dasbor terpusat serta mengirimkan peringatan dini kepada tim keamanan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem deteksi kecurangan dan analitik risiko berbasis AI ini, operator telekomunikasi dapat mengamankan arus pendapatan dari kebocoran, melindungi data serta identitas pelanggan, dan menjaga keberlanjutan bisnis di tengah lanskap ancaman digital yang kian kompleks.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (16, 'Modernisasi Data Center & Infrastruktur Cloud Sektor Publik', 'modernisasi-data-center-infrastruktur-cloud-sektor-publik', '2026-09-29T07:16:35.562Z', 'Solusi transformasi data center konvensional menjadi infrastruktur tervirtualisasi dan terotomasi tinggi berbasis hybrid cloud, menjamin ketersediaan tinggi (high availability), perlindungan data pemulihan bencana (disaster recovery), serta efisiensi operasional layanan digital.', 222, '2026-10-01T01:41:03.273Z', '2026-09-29T07:16:35.562Z', 9, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Akselerasi transformasi digital di sektor publik menuntut infrastruktur TI yang tangguh, aman, dan berkapasitas lentur (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"scalable","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"). Namun, banyak instansi pemerintah masih bergantung pada sistem ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"data center","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" warisan masa lalu (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"legacy systems","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":") yang kaku, membutuhkan biaya pemeliharaan tinggi, serta sulit diintegrasikan dengan aplikasi modern. Keterbatasan ini kerap memicu penurunan performa beban kerja, risiko gangguan layanan publik (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"downtime","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), dan kerentanan keamanan siber.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Modernisasi Data Center (E-Government Data Center Modernization)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" menghadirkan arsitektur komputasi modern yang siap mendukung lonjakan kebutuhan layanan digital masa kini dan mendatang:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Virtualisasi & Integrasi Hybrid Cloud:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengubah infrastruktur server fisik menjadi platform tervirtualisasi yang dinamis, memadukan fleksibilitas cloud dengan kendali keamanan pusat data lokal (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"on-premises","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":").","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Arsitektur High-Availability & Disaster Recovery Otomatis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Dilengkapi sistem ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"backup","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" otomatis, replikasi data multi-lokasi, dan mekanisme ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"disaster recovery","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" siap siaga guna memastikan kelangsungan operasional tanpa henti saat terjadi kegagalan sistem maupun bencana.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Monitoring Infrastruktur Terpusat (","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"IT Command Center","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":"):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memberikan visibilitas menyeluruh bagi tim TI secara ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"real-time","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" untuk memantau kesehatan server, beban komputasi, penggunaan penyimpanan, ketersediaan jaringan, hingga postur keamanan data melalui dashboard analitik terpadu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Langkah modernisasi ini memungkinkan instansi menghadirkan layanan publik yang jauh lebih cepat, stabil, dan terpercaya, sekaligus mengoptimalkan efisiensi anggaran TI jangka panjang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (110, 'Pusat Operasi Keamanan Siber & Tanggap Ancaman', 'pusat-operasi-keamanan-siber-tanggap-ancaman', '2026-10-01T03:09:55.310Z', 'Pusat komando pertahanan siber 24/7 berbasis SIEM, SOAR, dan intelijen ancaman untuk mendeteksi anomali jaringan, merespons insiden secara otomatis, serta melindungi aset digital perusahaan.', NULL, '2026-10-01T03:21:47.734Z', '2026-10-01T03:09:55.310Z', 18, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah ekosistem bisnis modern yang saling terhubung dan bergantung pada infrastruktur komputasi awan, volume serta tingkat kecanggihan serangan siber kian melonjak tajam. Tim keamanan TI kerap kewalahan menghadapi ribuan peringatan keamanan yang terfragmentasi di berbagai perangkat jaringan, endpoint, dan aplikasi, sehingga memperbesar risiko lolosnya serangan tersembunyi seperti malware, pembobolan akun, maupun eksfiltrasi data penting. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Operasi Keamanan Siber & Tanggap Ancaman Terpadu (Cybersecurity Operations Center / SOC)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai pusat komando pertahanan tunggal yang memberikan visibilitas penuh, pemantauan real-time, dan netralisasi ancaman siber lintas lingkungan digital perusahaan tanpa henti.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Terintegrasi & Deteksi Anomali Berkelanjutan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyatukan teknologi SIEM (Security Information and Event Management), EDR (Endpoint Detection and Response), serta analitik korelasi data untuk memindai lalu lintas jaringan dan perilaku pengguna secara langsung guna mengenali indikasi intrusi sejak dini.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Orkestrasi & Otomasi Respons Insiden (SOAR):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan skrip respon otomatis (playbooks) untuk mengisolasi perangkat terinfeksi, memblokir alamat IP berbahaya, dan menahan laju penyebaran ancaman dalam hitungan detik guna meminimalkan waktu henti sistem dan kesalahan manusia.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Intelijen Ancaman Proaktif & Kesiapan Audit Kepatuhan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengintegrasikan umpan intelijen ancaman global (threat intelligence) ke dalam dasbor postur keamanan terpadu, memudahkan penyesuaian strategi mitigasi terhadap vektor serangan terbaru sekaligus menyediakan bukti kepatuhan regulasi perlindungan data secara transparan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengadopsi platform pusat komando keamanan siber ini, perusahaan dapat memperkuat ketahanan infrastruktur TI, merespons setiap potensi krisis siber secara cepat dan terukur, serta menjamin kesinambungan operasional bisnis yang aman dan tepercaya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (18, 'Pemantauan Keselamatan & Kepatuhan Kerja', 'pemantauan-keselamatan-kepatuhan-kerja', '2026-09-29T08:16:57.316Z', 'Solusi pemantauan keselamatan kerja berbasis IoT dan analitik cerdas untuk mendeteksi bahaya, memastikan kepatuhan APD, dan mencegah kecelakaan kerja di lini manufaktur secara real-time.', 223, '2026-10-01T03:52:07.261Z', '2026-09-29T08:16:57.316Z', 10, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di lingkungan manufaktur modern, interaksi manusia dan mesin berjalan berdampingan dengan risiko kerja yang tinggi. Sistem ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pemantauan Keselamatan & Kepatuhan Kerja","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk melindungi pekerja sekaligus menjaga kelancaran operasional pabrik melalui pendekatan yang proaktif dan terintegrasi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Bahaya & Kepatuhan APD Otomatis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Sistem mendeteksi potensi bahaya secara langsung, mulai dari kelengkapan Alat Pelindung Diri (APD) seperti helm, sarung tangan, kacamata pelindung, respirator, hingga indikator kelelahan pekerja dan jarak yang terlalu dekat dengan mesin bergerak.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Peringatan ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Real-Time","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":" di Area Kritis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menjangkau titik-titik berisiko tinggi seperti lini produksi, dok bongkar muat, dan zona pemeliharaan (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"maintenance","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"). Peringatan otomatis langsung dikirimkan saat terjadi potensi bahaya, memungkinkan tindakan pencegahan cepat sebelum insiden terjadi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik & Evaluasi Standar K3:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Data rekaman insiden diolah menjadi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"insight","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" analitik yang komprehensif, membantu manajemen mengevaluasi pola risiko berulang serta memperkuat standar kepatuhan K3 secara berkelanjutan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":4,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Solusi Terintegrasi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Didukung ekosistem terpadu dari Synnex Metrodata Indonesia yang mencakup perangkat sensor & IoT, platform data dan analitik, infrastruktur server dan penyimpanan data, hingga sistem jaringan yang aman.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan sistem pemantauan yang cerdas dan terintegrasi ini, perusahaan manufaktur tidak hanya melindungi keselamatan para pekerjanya, tetapi juga mampu membangun operasional industri yang lebih aman, patuh terhadap regulasi, serta tangguh dalam menjaga kelangsungan bisnis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (22, 'Sistem Keamanan Siber Industri & Operasional Pabrik', 'sistem-keamanan-siber-industri-operasional-pabrik', '2026-09-29T08:34:16.250Z', 'Solusi perlindungan siber terpadu untuk mengamankan jaringan IT dan mesin operasional pabrik (OT) dari ancaman peretasan, ransomware, dan gangguan produksi secara real-time.', 225, '2026-10-01T03:53:38.873Z', '2026-09-29T08:34:16.250Z', 10, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di era digital, pabrik semakin terhubung dengan mengintegrasikan sistem IT perusahaan dan teknologi operasional (OT) seperti PLC, SCADA, serta mesin kontrol industri. Meski meningkatkan otomatisasi dan efisiensi, konektivitas ini membuka celah keamanan baru terhadap ancaman siber seperti ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"ransomware","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":", penyusupan data tanpa izin, hingga sabotase industri. Perlindungan IT konvensional tidak lagi cukup untuk menjaga mesin pabrik. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Sistem Keamanan Siber Industri & Operasional Pabrik","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menjembatani dan mengamankan seluruh ekosistem produksi secara menyeluruh.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perlindungan Terpadu IT & Mesin Pabrik (OT):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengamankan tidak hanya server dan komputer kantor, tetapi juga perangkat kontrol mesin fisik, sensor industri, dan jaringan pabrik yang rentan terhadap intrusi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Ancaman & Anomali ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Real-Time","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":":","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengumpulkan dan menganalisis aktivitas data dari perangkat industri dan jaringan secara berkelanjutan untuk mendeteksi perilaku mencurigakan atau pola serangan siber seketika.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Komando Keamanan (","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Security Command Center","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":"):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyediakan dasbor pemantauan terpusat yang memudahkan tim keamanan siber merespons dan mengisolasi potensi ancaman sebelum mengganggu jalannya lini produksi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem pertahanan siber yang proaktif dan menyeluruh ini, perusahaan manufaktur dapat menjaga aset penting dan data rahasia tetap aman, mencegah terjadinya ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"downtime","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" mesin yang merugikan, serta memastikan kelangsungan operasional pabrik berjalan stabil di tengah transformasi industri digital.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (69, 'Platform Komunikasi & Kolaborasi Kerja', 'platform-komunikasi-kolaborasi-kerja', '2026-09-30T07:57:18.811Z', 'Solusi integrasi panggilan suara, konferensi video, perpesanan, dan alat kerja digital dalam satu platform untuk mendukung produktivitas kerja hibrida secara fleksibel.', 246, '2026-10-02T01:37:14.278Z', '2026-09-30T07:57:18.811Z', 13, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah dinamika kerja modern yang menuntut kecepatan dan fleksibilitas, kelancaran komunikasi antar-tim menjadi penentu utama efisiensi bisnis. Penggunaan aplikasi komunikasi yang terpisah-pisah kerap menimbulkan hambatan pertukaran informasi, kebingungan kanal koordinasi, serta penurunan produktivitas karyawan saat bekerja secara jarak jauh (remote). Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Platform Komunikasi & Kolaborasi Kerja Terpadu (Unified Communications Platform)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menyatukan panggilan suara, konferensi video, ruang obrolan, dan sarana kolaborasi dokumen ke dalam satu lingkungan digital yang terhubung mulus di berbagai perangkat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Seluruh Kanal Komunikasi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggabungkan layanan telepon kantor, rapat video, pesan instan, dan kolaborasi berkas dalam satu aplikasi yang dapat diakses dari komputer kerja, laptop, maupun ponsel pintar kapan pun dan di mana pun.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Alur Kerja & Aplikasi Bisnis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menghubungkan jalur komunikasi langsung dengan aplikasi produktivitas dan sistem manajemen perusahaan, mempermudah koordinasi lintas divisi dan mempercepat pengambilan keputusan bersama.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Kualitas & Analisis Penggunaan Terpusat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Dilengkapi dasbor analitik untuk memantau performa jaringan panggilan, tingkat kestabilan koneksi rapat, pola penggunaan layanan, hingga pengaturan perutean panggilan (call routing) secara otomatis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengadopsi platform komunikasi terpadu ini, perusahaan dapat memfasilitasi model kerja hibrida secara efektif, mengeliminasi biaya infrastruktur komunikasi terpisah, serta menciptakan koordinasi tim yang jauh lebih gesit, solid, dan produktif.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (5, 'Pusat Operasi Keamanan Siber Terpadu (Security Operations Center - SOC)', 'pusat-operasi-keamanan-siber-terpadu-security-operations-center---soc', '2026-09-29T02:16:38.845Z', 'Solusi perlindungan aset digital komprehensif yang mengintegrasikan pemantauan lalu lintas jaringan, deteksi ancaman berbasis AI, dan respons insiden terpusat secara real-time untuk menjaga kelangsungan operasional dan keamanan data penting.', 216, '2026-10-01T01:36:54.992Z', '2026-09-29T02:16:38.845Z', 9, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Ketergantungan instansi dan perusahaan terhadap ekosistem digital untuk melayani publik, mengelola data sensitif, serta menjalankan infrastruktur krusial kini semakin tinggi. Namun, pesatnya digitalisasi ini juga memperluas celah serangan siber—mulai dari ancaman ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"ransomware","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":", kebocoran data (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"data breaches","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), hingga serangan siber tingkat lanjut (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"advanced persistent threats","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"). Perangkat keamanan konvensional yang bekerja terpisah (silo) sering kali lambat dalam mendeteksi dan mengantisipasi ancaman canggih tersebut.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Operasi Keamanan Siber (SOC)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" dirancang untuk memberikan visibilitas penuh dan kendali terpusat terhadap seluruh lingkungan digital Anda:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Keamanan Menyeluruh:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggabungkan log dan data keamanan dari seluruh jaringan, ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"endpoint","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":", aplikasi, hingga infrastruktur server ke dalam satu platform analitik cerdas.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Ancaman Proaktif & AI:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan pemantauan ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"real-time","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":", analisis big data, dan ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"threat intelligence","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" untuk mengidentifikasi anomali, serangan siber, atau akses mencurigakan sebelum sempat mengganggu layanan penting.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Komando & Penanganan Insiden Terkoordinasi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Disajikan melalui dashboard ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"command center","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" visual yang interaktif, tim keamanan siber dapat segera melakukan investigasi dan menanggulangi insiden secara cepat dan terarah.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan memperkuat visibilitas dan kesiapsiagaan digital, solusi SOC memastikan ketahanan siber organisasi tetap kokoh, melindungi kerahasiaan data berharga, serta menjamin kelangsungan operasional layanan tanpa henti.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (6, 'Sistem Digitalisasi & Pengarsipan Dokumen', 'sistem-digitalisasi-pengarsipan-dokumen', '2026-09-29T02:51:59.143Z', 'Solusi transformasi digital dokumen kertas menjadi arsip digital terstruktur secara otomatis menggunakan pemindaian berkecepatan tinggi, teknologi OCR, dan integrasi cloud storage untuk kemudahan temu kembali dokumen serta perlindungan data jangka panjang.', 217, '2026-10-01T01:38:07.714Z', '2026-09-29T02:51:59.143Z', 9, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Setiap hari, instansi dan organisasi mengelola volume dokumen fisik yang sangat besar—mulai dari berkas layanan publik, perizinan, dokumen legal, hingga catatan administratif. Pengelolaan berkas secara manual tidak hanya memperlambat alur kerja layanan, namun juga memakan ruang penyimpanan yang luas dan meningkatkan risiko dokumen rusak, hilang, atau diakses tanpa izin.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sistem Digitalisasi & Pengarsipan Dokumen Terpadu","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" mengonversi tumpukan dokumen fisik menjadi arsip digital yang rapi, aman, dan mudah diakses:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemindaian Berkecepatan Tinggi & OCR Cerdas:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengonversi kertas fisik menjadi data digital siap pakai menggunakan teknologi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Optical Character Recognition","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" (OCR) dan klasifikasi otomatis berkas.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Repositori & Metadata Terpusat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Dokumen tersimpan rapi dalam arsip digital berbasis cloud dan lokal (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"redundant storage","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), dilengkapi penandaan metadata otomatis sehingga pencarian dan temu kembali (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"search & retrieval","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":") berkas dapat dilakukan dalam hitungan detik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kepatuhan & Pengendalian Hak Akses:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Dilengkapi dashboard manajemen berkas untuk melacak riwayat dokumen (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"audit trail","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), mengatur hak otorisasi akses secara ketat, serta menjamin preservasi data penting dalam jangka panjang secara aman.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menghadirkan sistem arsip modern ini, efisiensi operasional meningkat secara signifikan, keamanan data terjaga, dan alur pelayanan menjadi jauh lebih cepat, transparan, dan profesional.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (7, 'Sistem Manajemen Lalu Lintas Cerdas Terintegrasi Berbasis AI', 'sistem-manajemen-lalu-lintas-cerdas-terintegrasi-berbasis-ai', '2026-09-29T04:16:37.734Z', 'Solusi pengaturan lalu lintas modern berbasis IoT dan AI yang mengoptimalkan durasi lampu sinyal secara adaptif, memantau kepadatan jalan secara real-time, serta mendeteksi insiden lalu lintas lebih cepat untuk mobilitas yang lebih lancar dan aman.', 218, '2026-10-01T01:38:51.857Z', '2026-09-29T04:16:37.734Z', 9, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pertumbuhan pesat populasi dan volume kendaraan di kawasan perkotaan sering kali menimbulkan kemacetan parah, pemborosan waktu tempuh, serta peningkatan risiko kecelakaan lalu lintas. Sistem pengaturan lalu lintas konvensional yang mengandalkan siklus waktu lampu merah tetap (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"fixed-time","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":") terbukti kaku dan tidak mampu merespons lonjakan arus kendaraan yang dinamis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sistem Manajemen Lalu Lintas Cerdas (Smart Traffic Management System)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir mentransformasi jaringan jalan menjadi ekosistem mobilitas terpadu yang adaptif:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Arus Jalan Multi-Sensor:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengintegrasikan kamera pengawas lalu lintas cerdas, sensor induksi jalan (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"loop detector","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), radar kecepatan, dan perangkat IoT untuk merekam volume kendaraan dan kondisi fisik jalanan secara kontinu dan akurat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Optimalisasi Lampu Lalu Lintas Berbasis AI:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Seluruh data diproses melalui platform analitik cloud dan edge computing yang menerapkan algoritma cerdas untuk menyesuaikan durasi lampu hijau secara otomatis sesuai tingkat kepadatan antrean jalan saat itu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Komando & Penanganan Insiden Cepat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Operator di ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"traffic command center","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" dapat memantau peta titik kemacetan secara visual, mendeteksi kecelakaan secara otomatis, serta memberikan prioritas lampu hijau bagi kendaraan darurat (seperti ambulans dan pemadam kebakaran) agar tiba tepat waktu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengubah data lalu lintas menjadi tindakan otomatis dan terarah, solusi ini terbukti efektif mengurai simpul kemacetan, menekan angka kecelakaan, serta menciptakan mobilitas perkotaan yang lebih efisien dan ramah lingkungan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (9, 'Sistem Manajemen Gedung Cerdas (Smart Building System) Terintegrasi', 'sistem-manajemen-gedung-cerdas-smart-building-system-terintegrasi', '2026-09-29T04:24:43.566Z', 'Solusi otomasi fasilitas modern berbasis IoT dan AI yang menyatukan kendali efisiensi energi (HVAC & pencahayaan), pemantauan okupansi ruang, serta sistem keamanan akses ke dalam satu pusat kendali terpadu secara real-time.', 219, '2026-10-01T01:39:27.753Z', '2026-09-29T04:24:43.566Z', 9, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Gedung perkantoran dan fasilitas publik merupakan pusat operasional penting yang melayani banyak aktivitas setiap harinya. Namun, sebagian besar gedung masih mengandalkan sistem konvensional yang berjalan terpisah (silo)—mulai dari pendingin ruangan, lampu, hingga pengawasan keamanan. Kondisi ini menyebabkan tingginya pemborosan energi, biaya perawatan yang membengkak, serta pemanfaatan ruang yang kurang optimal.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sistem Manajemen Gedung Cerdas (Smart Building System)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menyatukan seluruh subsistem fasilitas menjadi ekosistem digital yang efisien dan otomatis:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Otomasi Fasilitas & Penghematan Energi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengintegrasikan sensor pintar untuk mengatur sistem pendingin udara (HVAC) dan pencahayaan cerdas (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"smart lighting","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":") secara adaptif sesuai tingkat okupansi dan waktu operasional.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Keamanan & Kontrol Akses Terpadu:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memadukan pintu akses otomatis (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"access control","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), pemindai identitas, dan kamera pengawas cerdas untuk membatasi akses zona terbatas sekaligus memantau pergerakan pengunjung.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Monitoring Fasilitas (","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Facility Command Center","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":"):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Pengelola gedung dapat memantau konsumsi listrik, kualitas udara dalam ruangan, status kepadatan ruangan (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"occupancy heatmap","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), hingga peringatan insiden operasional secara terpusat melalui dashboard interaktif.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Penerapan solusi ini tidak hanya memangkas biaya operasional gedung secara signifikan, namun juga menciptakan lingkungan kerja yang aman, nyaman, dan mendukung keberlanjutan ramah lingkungan (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"green building","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":").","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (12, 'Portal Layanan Publik Digital Terpadu (One-Stop Digital Citizen Portal)', 'portal-layanan-publik-digital-terpadu-one-stop-digital-citizen-portal', '2026-09-29T07:03:01.774Z', 'Platform layanan digital terintegrasi satu pintu yang menyederhanakan akses masyarakat terhadap pengurusan identitas, perizinan, pembayaran retribusi/pajak, serta layanan kesehatan dalam satu sistem terpusat yang cepat, aman, dan transparan.', 220, '2026-10-01T01:40:01.086Z', '2026-09-29T07:03:01.774Z', 9, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di era serba digital, masyarakat mengharapkan pelayanan publik yang cepat, mudah, dan dapat diakses dari mana saja tanpa kendala birokrasi yang berbelit-belit. Faktanya, sistem operasional di berbagai instansi pemerintahan masih sering terfragmentasi antar-dinas atau departemen. Warga kerap harus datang langsung ke kantor, mengantre lama, serta menyerahkan berkas persyaratan fisik berulang kali.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Portal Layanan Publik Digital Terpadu","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai jembatan transformasi satu pintu (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"single sign-on","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":") yang menghubungkan masyarakat langsung dengan seluruh layanan pemerintah:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Akses Multi-Kanal Terintegrasi:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memungkinkan warga mengakses berbagai urusan administrasi—seperti pendaftaran kependudukan, izin usaha/bangunan, pembayaran pajak/retribusi daerah, hingga integrasi layanan kesehatan—cukup melalui web portal, aplikasi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"mobile","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":", atau kios mandiri (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"self-service kiosk","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":").","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Keamanan Identitas & Interoperabilitas API:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Sistem dilengkapi dengan otentikasi identitas digital yang aman dan gerbang API (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"secure API gateway","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":") yang menghubungkan basis data dinas secara otomatis, mengeliminasi duplikasi data dan penginputan berulang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Monitoring Kinerja Layanan (","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Command Center","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":"):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Manajemen dan pengambil kebijakan dapat memantau volume permohonan warga, kecepatan waktu penyelesaian dokumen (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"service SLA","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), hingga ketersediaan server secara ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"real-time","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":" melalui dashboard terpusat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mendigitalisasi dan menyatukan seluruh kanal layanan, instansi dapat meningkatkan transparansi birokrasi, menghemat biaya operasional, serta secara signifikan mendongkrak indeks kepuasan publik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (14, 'Pusat Komando Kota Cerdas Terpadu (Integrated Smart City Command Center)', 'pusat-komando-kota-cerdas-terpadu-integrated-smart-city-command-center', '2026-09-29T07:11:14.394Z', 'Solusi pusat kendali terintegrasi berbasis AI dan IoT yang menyatukan pemantauan lalu lintas, keselamatan publik, sensor lingkungan, dan tanggap darurat lintas instansi ke dalam satu dashboard real-time untuk tata kelola perkotaan yang responsif dan efisien.', 221, '2026-10-01T01:40:28.512Z', '2026-09-29T07:11:14.394Z', 9, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"start","indent":0,"version":1,"children":[{"mode":"normal","text":"Seiring dengan pesatnya pertumbuhan kawasan perkotaan, kompleksitas pengelolaan operasional kota kian meningkat. Isu kepadatan arus lalu lintas, potensi gangguan ketertiban publik, kualitas lingkungan hidup, hingga penanganan kondisi darurat sering kali membutuhkan koordinasi cepat dari berbagai pihak. Kendalanya, sistem informasi di tiap dinas dan agensi masih sering beroperasi secara terpisah (silo), menyulitkan para pengambil keputusan mendapatkan gambaran kondisi kota secara utuh dan menyeluruh.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"start","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Komando Kota Cerdas Terpadu (Smart City Command Center) hadir sebagai solusi platform terpusat yang mengintegrasikan seluruh denyut operasional kota:","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"start","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Data Multi-Sektor: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengonsolidasikan data dari jaringan kamera pengawas (CCTV surveillance), sensor IoT kualitas udara dan cuaca, sistem kendali lalu lintas cerdas, hingga jaringan komunikasi darurat ke dalam satu platform analitik terpusat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"start","indent":0,"version":1,"children":[{"mode":"normal","text":"Analisis Cerdas & Prediktif Berbasis AI: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memanfaatkan analitik tingkat lanjut dan kecerdasan buatan untuk membaca pola aktivitas kota, mendeteksi anomali insiden secara dini, serta memprediksi potensi masalah sebelum meluas.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"start","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Koordinasi & Tanggap Darurat Lintas Instansi: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Melalui layar visualisasi dashboard interaktif, operator dan jajaran pimpinan daerah dapat memantau status perkotaan secara real-time, mempercepat alur pengambilan keputusan strategis, serta mengarahkan armada lapangan (polisi, ambulans, pemadam kebakaran, dan dinas perhubungan) secara terkoordinasi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"start","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengubah data yang terfragmentasi menjadi wawasan tindakan nyata, solusi ini membantu pemerintah meningkatkan keselamatan warga, mengoptimalkan alokasi sumber daya perkotaan, dan menghadirkan pelayanan publik yang jauh lebih cepat serta terpercaya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (33, 'Sistem Pemeliharaan Prediktif', 'sistem-pemeliharaan-prediktif', '2026-09-30T03:11:33.388Z', 'Solusi pemantauan kondisi mesin berbasis AI dan sensor IoT untuk mendeteksi potensi kerusakan lebih awal, mencegah kerugian akibat downtime, dan mengoptimalkan biaya perawatan secara real-time.', 230, '2026-10-01T03:56:40.628Z', '2026-09-30T03:11:33.388Z', 10, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kerusakan mesin yang mendadak di lingkungan industri manufaktur sering kali memicu penundaan jadwal produksi, penurunan kuantitas output, hingga pembengkakan biaya perbaikan yang tak terduga. Metode pemeliharaan tradisional—baik yang bersifat reaktif (diperbaiki setelah rusak) maupun terjadwal secara berkala—sering kali kurang efektif karena rentan melewatkan gejala kerusakan dini atau justru melakukan perawatan yang belum diperlukan. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Sistem Pemeliharaan Prediktif","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mengatasi kendala ini dengan memantau kondisi kesehatan mesin secara berkesinambungan melalui sensor pintar yang merekam data getaran, suhu, dan metrik kinerja peralatan secara real-time.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Kondisi Mesin Kontinu:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggunakan sensor IoT untuk melacak indikator vital mesin seperti tingkat getaran, suhu operasional, dan metrik performa secara tepat dan konsisten.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Cerdas & Deteksi Dini Berbasis AI:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengolah dan menganalisis aliran data menggunakan kecerdasan buatan (AI) untuk mengenali pola anomali serta memprediksi potensi kerusakan sebelum mesin mengalami kendala.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Peringatan & Perencanaan Terpusat (Command Center):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan status kesehatan mesin pada dasbor pemantauan terpadu, memberikan notifikasi peringatan dini, dan membantu tim teknis menjadwalkan tindakan perbaikan berdasarkan kondisi riil alat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan beralih dari pola pemeliharaan reaktif ke sistem pemeliharaan prediktif ini, perusahaan manufaktur dapat menekan risiko downtime secara signifikan, memperpanjang usia pakai mesin produksi, menghemat biaya operasional perawatan, serta menjaga keandalan proses manufaktur secara berkelanjutan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (112, 'Migrasi Komputasi Awan & Infrastruktur Hibrida Perusahaan', 'migrasi-komputasi-awan-infrastruktur-hibrida-perusahaan', '2026-10-01T03:11:57.001Z', 'Solusi integrasi mulus antara sistem on-premise dan cloud publik/privat untuk modernisasi beban kerja secara bertahap, fleksibel, hemat biaya, dan minim disrupsi.', NULL, '2026-10-01T03:11:57.001Z', '2026-10-01T03:11:57.001Z', 18, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah desakan modernisasi teknologi digital, organisasi kerap menghadapi dilema antara kecepatan inovasi komputasi awan dan keharusan mempertahankan stabilitas sistem warisan (legacy systems) yang sudah berjalan stabil di fasilitas lokal. Migrasi menyeluruh secara tergesa-gesa berisiko menimbulkan disrupsi operasional, lonjakan biaya tak terduga, serta isu kepatuhan kedaulatan data. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Migrasi Komputasi Awan & Infrastruktur Hibrida Perusahaan (Cloud Migration & Hybrid Infrastructure)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir menjembatani kesenjangan tersebut melalui strategi integrasi menyeluruh antara server fisik lokal (on-premise) dan lingkungan komputasi awan (public/private cloud) secara bertahap, aman, dan terkendali.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Strategi Migrasi Bertahap & Arsitektur Fleksibel:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memfasilitasi pemindahan beban kerja dan modernisasi aplikasi secara terukur tanpa menghentikan kelangsungan proses bisnis utama, memungkinkan penempatan data sensitif tetap berada di server lokal sementara aplikasi interaktif berjalan di cloud.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Elastisitas Sumber Daya & Optimasi Biaya (FinOps):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengalokasikan beban komputasi secara dinamis untuk mengantisipasi lonjakan lalu lintas aplikasi pada periode puncak (peak season), dipadukan dengan pemantauan alokasi sumber daya guna mencegah pemborosan anggaran infrastruktur.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Orkestrasi Terpusat & Sinkronisasi Data Lintas Lingkungan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan visibilitas performa, ketersediaan jaringan, dan konsumsi kapasitas di seluruh ekosistem hybrid melalui dasbor kendali terpadu, menjamin sinkronisasi data yang konsisten serta pemeliharaan sistem yang ringkas bagi tim IT.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan infrastruktur hibrida dan migrasi awan yang terencana ini, perusahaan dapat mempercepat siklus inovasi produk digital, meningkatkan skalabilitas sistem operasional, serta membangun fondasi TI yang tangguh, hemat biaya, dan adaptif terhadap perkembangan teknologi masa depan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (37, 'Gudang & Pemenuhan Pesanan Cerdas', 'gudang-pemenuhan-pesanan-cerdas', '2026-09-30T03:32:34.370Z', 'Solusi otomatisasi gudang berbasis IoT, WMS, dan AI untuk mempercepat pemrosesan pesanan, menjamin akurasi stok, serta mengoptimalkan operasional secara real-time.', 232, '2026-10-01T06:33:05.447Z', '2026-09-30T03:32:34.370Z', 11, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri ritel dan e-commerce yang bergerak cepat, kecepatan, akurasi, dan efisiensi menjadi penentu utama kepuasan pelanggan. Pengelolaan gudang konvensional sering kali terkendala oleh lambatnya pencarian barang, risiko kesalahan manusia (human error), serta hambatan ruang penyimpanan saat volume pesanan melonjak. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Gudang & Pemenuhan Pesanan Cerdas (Smart Warehouse & Fulfillment)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mengubah operasional gudang menjadi ekosistem berbasis data yang responsif, mengoptimalkan setiap tahapan mulai dari penerimaan barang masuk hingga pengiriman pesanan ke konsumen.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Otomatisasi Lini Operasional & Robotik:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengintegrasikan sistem pengambilan barang otomatis (automated picking), teknologi robotik, dan alur pemilahan pintar untuk meminimalkan kesalahan manusia serta mempercepat proses pemenuhan pesanan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pelacakan Stok & Transparansi Menyeluruh:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menghubungkan sensor IoT dan sistem manajemen gudang (Warehouse Management System / WMS) untuk memantau pergerakan barang, tingkat persediaan stok, dan status pesanan secara real-time melalui dasbor terpusat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Prediktif & Optimasi Ruang:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan analitik cerdas untuk memprediksi kebutuhan persediaan barang, mengoptimalkan tata ruang gudang, serta mencegah kemacetan alur kerja (bottleneck) sebelum terjadi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan otomatisasi dan pelacakan berbasis data ini, perusahaan ritel dan e-commerce dapat menekan biaya operasional, menangani lonjakan transaksi secara lincah, serta menghadirkan pengalaman berbelanja yang cepat, tepat, dan terpercaya bagi pelanggan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (39, 'Pendeteksi Kecurangan E-Commerce', 'pendeteksi-kecurangan-e-commerce', '2026-09-30T03:39:13.334Z', 'Solusi perlindungan berbasis AI dan pemantauan real-time untuk mendeteksi transaksi mencurigakan, mencegah pengambilalihan akun, serta menjaga keamanan pendapatan bisnis.', 233, '2026-10-01T06:33:38.345Z', '2026-09-30T03:39:13.334Z', 11, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri ritel dan e-commerce yang berkembang pesat, setiap transaksi digital membawa peluang sekaligus risiko keamanan. Tanpa sistem pengawasan yang canggih, bisnis rentan terhadap ancaman kecurangan (fraud) seperti pembajakan akun pelanggan, penyalahgunaan kartu kredit/pembayaran, hingga kerugian akibat klaim pengembalian dana (chargeback). Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pendeteksi Kecurangan E-Commerce","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai lapisan pertahanan pintar yang menganalisis perilaku pengguna dan data transaksi secara kontinu guna mengidentifikasi serta menghentikan potensi kejahatan sebelum merugikan perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Perilaku & Deteksi Transaksi Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan analitik berbasis kecerdasan buatan (AI) untuk melacak pola pembelian tidak wajar, percobaan masuk (login) mencurigakan, anomali metode pembayaran, hingga ketidaksesuaian identitas perangkat secara otomatis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemberian Skor Risiko & Perlindungan Bertingkat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menilai tingkat risiko setiap transaksi secara instan, memungkinkan pengguna sah menikmati proses checkout yang lancar (frictionless) sembari menerapkan autentikasi multifaktor (MFA) pada aktivitas yang berisiko tinggi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Pemantauan Terpusat & Notifikasi Otomatis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan indikasi ancaman pada dasbor terpadu, memberikan notifikasi langsung kepada tim keamanan untuk mengambil tindakan penanganan dengan cepat dan presisi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengintegrasikan sistem deteksi kecurangan yang proaktif ini, pelaku bisnis e-commerce dapat menekan angka kerugian finansial, melindungi data sensitif pelanggan, serta membangun kepercayaan digital yang kokoh untuk mendorong pertumbuhan bisnis secara berkelanjutan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (41, 'Kasir Otomatis & Toko Tanpa Kasir', 'kasir-otomatis-toko-tanpa-kasir', '2026-09-30T03:43:27.548Z', 'Solusi pembelanjaan berbasis AI, computer vision, dan IoT yang memungkinkan pelanggan memilih barang dan langsung keluar toko dengan pembayaran otomatis tanpa perlu mengantre.', 234, '2026-10-01T06:34:02.011Z', '2026-09-30T03:43:27.548Z', 11, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di era ritel modern, kemudahan dan kecepatan menjadi faktor utama dalam menciptakan pengalaman berbelanja pelanggan yang memuaskan. Antrean panjang di area kasir konvensional sering kali menjadi penyebab utama ketidaknyamanan pembeli dan inefisiensi alur toko. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Kasir Otomatis & Toko Tanpa Kasir (Smart Checkout & Cashierless Store)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mentransformasi toko fisik menjadi ekosistem pembelanjaan tanpa hambatan (frictionless), di mana proses transaksi berjalan secara otomatis di latar belakang saat pelanggan mengambil barang dan meninggalkan toko.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi & Pembayaran Otomatis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggabungkan teknologi computer vision, kecerdasan buatan (AI), dan sensor IoT untuk mendeteksi barang yang diambil pelanggan secara akurat serta memproses pembayaran secara digital tanpa perlu memindai barang satu per satu di meja kasir.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Efisiensi Operasional & Pencegahan Kerugian:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Meminimalkan ketergantungan pada proses kasir manual sehingga menekan biaya operasional, mereduksi potensi human error, dan mencegah risiko kehilangan barang (shrinkage) melalui sistem pemantauan terpadu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Perilaku & Dasbor Terpusat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengumpulkan data pergerakan dan pola belanja pengunjung untuk disajikan pada dasbor terpusat, memberikan insight mendalam bagi manajemen dalam mengambil keputusan strategis serta menghadirkan penawaran yang lebih personal.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem toko pintar tanpa kasir ini, pelaku bisnis ritel dapat mengeliminasi antrean, memangkas biaya operasional, serta memberikan pengalaman berbelanja yang serba cepat, praktis, dan modern bagi para pelanggan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (114, 'Modernisasi Pusat Data & Virtualisasi Infrastruktur', 'modernisasi-pusat-data-virtualisasi-infrastruktur', '2026-10-01T03:14:15.130Z', 'Solusi transformasi pusat data berbasis software-defined infrastructure dan virtualisasi untuk mengoptimalkan utilisasi sumber daya, menyederhanakan tata kelola TI, serta memangkas biaya operasional.', NULL, '2026-10-01T03:14:15.130Z', '2026-10-01T03:14:15.130Z', 18, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Seiring melonjaknya kebutuhan komputasi bisnis digital, infrastruktur pusat data tradisional yang kaku, berbasis perangkat keras terpisah (siloed hardware), dan memakan konsumsi daya besar kian membatasi kelincahan organisasi. Ketergantungan pada server fisik mandiri tidak hanya memperlambat proses penyediaan (provisioning) beban kerja baru hingga berpekan-pekan, tetapi juga memicu pemborosan kapasitas komputasi dan membengkaknya biaya pemeliharaan berkala. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Modernisasi Pusat Data & Virtualisasi Infrastruktur Terpadu (Data Center Modernization & Virtualization)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir mentransformasi fasilitas komputasi fisik menjadi ekosistem perangkat lunak terintegrasi (Software-Defined Infrastructure / SDI) yang fleksibel, otomatis, dan berdensitas tinggi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Virtualisasi Penuh Komputasi, Jaringan, & Penyimpanan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengabstraksi server, jaringan, dan media penyimpanan (storage) fisik ke dalam kolam sumber daya virtual yang elastis, memaksimalkan efisiensi utilisasi perangkat keras dan menekan kebutuhan ruang rak (footprint) di data center.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Otomasi Alur Kerja & Akselerasi Workload Deployment:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menerapkan orkestrasi otomatis untuk memfasilitasi peluncuran aplikasi dan konfigurasi lingkungan pengujian dalam hitungan menit alih-alih berhari-hari, membebaskan tim TI dari rutinitas instalasi manual.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kesiapan Ekosistem Hybrid Cloud & Dasbor Analitik Terpusat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menghubungkan pusat data lokal secara mulus dengan berbagai platform komputasi awan publik, dilengkapi dasbor pemantauan kapasitas, metrik performa, dan kesehatan sistem secara real-time untuk menjaga ketersediaan layanan (high availability).","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui modernisasi dan virtualisasi pusat data ini, perusahaan dapat memangkas biaya operasional perangkat keras secara substansial, meningkatkan keandalan sistem terhadap potensi kegagalan teknis, serta membangun fondasi infrastruktur TI yang tangguh dan siap menopang ekspansi bisnis jangka panjang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (67, 'Pusat Kendali Keamanan Siber Jaringan', 'pusat-kendali-keamanan-siber-jaringan', '2026-09-30T07:55:13.714Z', 'Solusi komando siber terintegrasi berbasis AI, SIEM, dan SOAR untuk mendeteksi ancaman jaringan, memitigasi serangan siber secara otomatis, dan menjamin kelancaran layanan digital 24/7.', 247, '2026-10-02T01:37:49.359Z', '2026-09-30T07:55:13.714Z', 13, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri telekomunikasi yang mentransmisikan miliaran paket data setiap detik, menjaga stabilitas dan kedaulatan jaringan dari serangan siber merupakan tantangan yang sangat kompleks. Serangan siber skala masif—mulai dari serangan kelumpuhan server (DDoS), penyusupan jaringan inti, hingga pencurian data pelanggan—dapat memicu padamnya layanan telekomunikasi dan merusak reputasi penyedia layanan secara fatal. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Kendali Keamanan Siber Jaringan (Network Security Operations Center / SOC)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai pusat pertahanan terpadu untuk memantau lalu lintas data, mendeteksi kerentanan, dan mengamankan seluruh simpul jaringan secara kontinu dan real-time.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Ancaman Cerdas & Pemantauan Menyeluruh:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggabungkan SIEM (Security Information and Event Management) dan kecerdasan buatan (AI) untuk mengawasi lalu lintas data di seluruh jaringan inti (core network), pusat data, dan titik edge, mengenali indikasi anomali atau serangan siber secara seketika.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Otomasi Penanganan Insiden Cepat (SOAR):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan orkestrasi keamanan otomatis (Security Orchestration, Automation, and Response) untuk mengisolasi ancaman berbahaya secara mandiri dalam hitungan detik, meminimalkan ketergantungan pada intervensi manual dan mempercepat proses pemulihan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Intelijen Ancaman Terintegrasi & Dasbor Eksekutif:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menghubungkan basis data ancaman global (threat intelligence) ke dalam dasbor pemantauan utama guna memberikan wawasan risiko yang siap ditindaklanjuti serta mempermudah evaluasi postur keamanan jaringan bagi manajemen.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan pusat operasi keamanan jaringan yang proaktif dan terotomatisasi ini, operator telekomunikasi dapat menekan waktu penanganan insiden ke titik terendah, menjaga kelangsungan layanan publik tanpa gangguan, serta membangun fondasi digital yang aman dan tepercaya bagi jutaan pengguna.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (71, 'Platform Analitik Pengalaman & Kepuasan Pelanggan', 'platform-analitik-pengalaman-kepuasan-pelanggan', '2026-09-30T07:59:25.280Z', 'Solusi analitik berbasis AI untuk memantau interaksi pelanggan lintas kanal secara real-time, mendeteksi potensi churn, dan meningkatkan loyalitas pengguna.', 245, '2026-10-02T01:36:46.777Z', '2026-09-30T07:59:25.280Z', 13, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah tingginya persaingan industri telekomunikasi, kepuasan pengalaman pelanggan (customer experience) menjadi faktor pembeda utama untuk mempertahankan pangsa pasar. Interaksi pelanggan yang terfragmentasi di berbagai titik—mulai dari aplikasi seluler, pusat panggilan (call center), hingga gerai layanan fisik—kerap membuat operator lambat merespons keluhan dan kesulitan memahami alasan pelanggan berpindah ke kompetitor (churn). Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Platform Analitik Pengalaman & Kepuasan Pelanggan (Customer Experience Analytics Platform)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menyatukan data interaksi pelanggan dari seluruh titik kontak ke dalam satu tampilan holistis 360 derajat berbasis kecerdasan buatan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Visibilitas Pelanggan 360 Derajat Lintas Kanal:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengumpulkan dan memetakan data interaksi dari aplikasi mobile, layanan pelanggan, gerai resmi, hingga platform digital untuk memahami sentimen dan perilaku pengguna secara utuh.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Prediksi Risiko Berpindah (Churn) & Deteksi Masalah Dini:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan pemodelan prediktif bertenaga AI untuk mengidentifikasi indikasi ketidakpuasan atau gangguan jaringan yang dialami pengguna sebelum berujung pada perpindahan operator.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Personalisasi Penawaran & Dasbor Terpadu:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan tren kepuasan pelanggan pada dasbor pemantauan utama guna mendukung segmentasi pengguna yang presisi, memungkinkan penyampaian promo yang relevan, serta peningkatan kualitas interaksi di setiap jalur layanan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengimplementasikan platform analitik pengalaman pelanggan ini, operator telekomunikasi dapat mengambil langkah retensi yang proaktif, meningkatkan nilai loyalitas pelanggan (customer lifetime value), serta membangun reputasi merek yang andal dan tepercaya secara berkelanjutan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (81, 'Pusat Keamanan Siber & Tanggap Insiden Finansial', 'pusat-keamanan-siber-tanggap-insiden-finansial', '2026-10-01T02:03:20.199Z', 'Solusi pemantauan siber terpusat berbasis AI, SIEM, dan SOAR untuk mendeteksi ancaman transaksi, mengisolasi serangan secara otomatis, dan memastikan kepatuhan regulasi perbankan 24/7.', 251, '2026-10-02T01:40:47.898Z', '2026-10-01T02:03:20.199Z', 14, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri jasa keuangan yang memproses jutaan transaksi bernilai tinggi setiap detik, ketahanan sistem keamanan siber menjadi benteng mutlak penjaga aset dan kepercayaan nasabah. Meningkatnya kompleksitas ancaman digital—seperti serangan ransomware, penyusupan kredensial, manipulasi data transaksi, hingga akses ilegal ke jaringan inti perbankan—dapat memicu kerugian finansial masif dan sanksi kepatuhan yang berat jika terlambat ditangani. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Komando Keamanan Siber & Tanggap Insiden Finansial (Cybersecurity Operations Center / SOC)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai pusat pertahanan terintegrasi yang memantau, mendeteksi, dan menetralkan potensi ancaman keamanan pada seluruh ekosistem perbankan, asuransi, dan fintech secara berkesinambungan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Terpusat & Deteksi Ancaman Cerdas Berbasis AI: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengintegrasikan SIEM (Security Information and Event Management) dengan analitik prediktif untuk memindai aktivitas jaringan, perilaku akun (user behavior), dan aliran data transaksi secara real-time guna mengidentifikasi anomali serta upaya penyusupan sejak dini.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Orkestrasi Tanggap Insiden Otomatis (SOAR): ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memanfaatkan orkestrasi otomatis (Security Orchestration, Automation, and Response) untuk mengisolasi titik kerentanan dan memblokir aktivitas berbahaya dalam hitungan detik, meminimalkan ketergantungan tindakan manual serta mempercepat waktu pemulihan insiden (MTTR).","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Intelijen Ancaman Global & Kepatuhan Audit Finansial: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menghubungkan umpan intelijen ancaman siber terkini ke dalam dasbor pemantauan eksekutif, menyajikan catatan jejak audit digital yang rapi guna menjamin kesiapan audit kepatuhan regulasi otoritas pengawas keuangan secara berkala.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan pusat komando keamanan siber yang proaktif dan terotomatisasi ini, institusi finansial dapat mengamankan infrastruktur perbankan digital dari serangan siber mutakhir, menjamin kelangsungan operasional transaksi tanpa henti, serta mempertahankan integritas dan reputasi bisnis di mata regulator maupun nasabah.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (80, 'Proteksi Data Finansial & Kepatuhan Regulasi Terintegrasi', 'proteksi-data-finansial-kepatuhan-regulasi-terintegrasi', '2026-10-01T02:02:06.688Z', 'Solusi keamanan data terpadu berbasis Data Loss Prevention (DLP) dan pencadangan otomatis untuk mencegah kebocoran informasi sensitif serta menjamin pemulihan data instan.', 252, '2026-10-02T01:42:02.728Z', '2026-10-01T02:02:06.688Z', 14, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri jasa keuangan, perlindungan kerahasiaan data nasabah dan kepatuhan terhadap regulasi privasi data adalah fondasi utama dalam menjaga reputasi serta kelangsungan bisnis. Alur perpindahan informasi yang kompleks di perbankan, asuransi, dan fintech memperbesar risiko kebocoran data penting—seperti nomor rekening, data kartu kredit, dan rekam transaksi—baik akibat serangan siber, kelalaian internal, maupun kegagalan perangkat penyimpanan. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Proteksi Data Finansial & Kepatuhan Regulasi Terintegrasi (Data Protection & Compliance)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir menggabungkan sistem pencegahan kebocoran data (Data Loss Prevention / DLP) dan pencadangan data (backup) otomatis ke dalam satu tata kelola keamanan yang kokoh dan berkesinambungan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pencegahan Kebocoran Data (DLP) & Enkripsi Real-Time: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengawasi pergerakan data sensitif di seluruh jaringan, perangkat akhir (endpoint), dan penyimpanan awan guna mencegah pengiriman atau pengunduhan informasi tanpa izin secara otomatis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pencadangan Otomatis & Pemulihan Cepat (Disaster Recovery): ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menjamin ketersediaan salinan data transaksi yang terenkripsi dan terisolasi secara berkala, memastikan data penting dapat dipulihkan seketika saat terjadi kegagalan sistem, serangan ransomware, maupun human error.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jejak Audit Digital & Pelaporan Kepatuhan Terpusat: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyediakan visibilitas penuh atas aktivitas akses data melalui dasbor pemantauan terpusat dan catatan audit (audit trail) otomatis guna memenuhi standar regulasi kepatuhan privasi data perbankan dan otoritas keuangan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem proteksi data dan pencadangan terpadu ini, institusi keuangan dapat mengeliminasi ancaman kebocoran data rahasia, meminimalkan potensi sanksi hukum dari regulator, serta menjaga kepercayaan penuh nasabah terhadap keamanan ekosistem digital perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (79, 'Platform Analitik Perilaku & Personalisasi Nasabah', 'platform-analitik-perilaku-personalisasi-nasabah', '2026-10-01T01:55:46.186Z', 'Solusi analitik terpadu berbasis AI untuk menyatukan data transaksi nasabah lintas kanal, memprediksi potensi churn, dan mendorong strategi cross-selling yang presisi.', 253, '2026-10-02T01:42:38.218Z', '2026-10-01T01:55:46.186Z', 14, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri jasa keuangan yang kian kompetitif, memahami profil kebutuhan finansial setiap nasabah secara mendalam menjadi kunci utama mempertahankan loyalitas dan memperluas portofolio bisnis. Data interaksi yang terpecah di berbagai kanal—seperti riwayat mutasi rekening, aplikasi mobile banking, loket cabang, hingga interaksi pusat bantuan—kerap menghambat institusi keuangan dalam mengenali potensi nasabah dan terlambat mendeteksi nasabah yang berhenti menggunakan layanan (churn). Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Platform Analitik Perilaku & Personalisasi Nasabah (Customer Analytics Platform)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menyatukan seluruh jejak aktivitas finansial ke dalam satu profil 360 derajat yang akurat dan berbasis analitik prediktif.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Profil Nasabah 360 Derajat Lintas Kanal: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengonsolidasikan data transaksi kartu, penggunaan aplikasi digital, kunjungan cabang, dan riwayat kredit ke dalam satu platform analitik terpadu guna memahami pola kebutuhan finansial secara menyeluruh.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Segmentasi Presisi & Rekomendasi Produk Finansial: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memanfaatkan kecerdasan buatan (AI) untuk mengelompokkan nasabah berdasarkan perilaku transaksi, memungkinkan penawaran produk investasi, pinjaman, atau proteksi asuransi (cross-sell dan upsell) yang relevan pada waktu yang tepat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Prediksi Risiko Berpindah (Churn) & Penyelarasan Profil Risiko: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mendeteksi penurunan aktivitas transaksi atau sinyal ketidakpuasan nasabah lebih awal untuk memicu program retensi proaktif, sembari memastikan setiap rekomendasi produk tetap patuh pada batas toleransi profil risiko regulasi keuangan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengadopsi platform analitik nasabah ini, perbankan, perusahaan asuransi, dan fintech dapat meningkatkan konversi penawaran produk, memaksimalkan nilai loyalitas nasabah (customer lifetime value), serta membangun hubungan finansial yang lebih personal, aman, dan berkesinambungan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (78, 'Digitalisasi Kantor Cabang & Kios Layanan Mandiri Finansial', 'digitalisasi-kantor-cabang-kios-layanan-mandiri-finansial', '2026-10-01T01:34:48.952Z', 'Solusi transformasi kantor cabang berbasis kios swalayan cerdas, verifikasi biometrik, dan integrasi omnichannel untuk mempercepat transaksi nasabah tanpa antrean panjang.', 254, '2026-10-02T01:42:57.323Z', '2026-10-01T01:34:48.952Z', 14, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah evolusi perbankan dan industri keuangan digital, peran kantor cabang fisik bertransformasi dari sekadar loket transaksi tunai menjadi pusat pengalaman dan konsultasi finansial nasabah. Alur pelayanan cabang konvensional sering kali terkendala antrean panjang di loket teller dan proses verifikasi berkas manual yang lambat saat pembukaan rekening atau pengajuan layanan. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Digitalisasi Kantor Cabang & Kios Layanan Mandiri Finansial (Branch Transformation & Smart Kiosk)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk memodernisasi gerai fisik melalui platform kios interaktif mandiri yang terhubung langsung dengan sistem perbankan terpusat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kios Transaksi Mandiri & Digital Onboarding: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memungkinkan nasabah melakukan registrasi akun baru, penggantian kartu, pembayaran tagihan, hingga pembaruan data secara mandiri dalam hitungan menit tanpa harus mengantre di loket teller.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Keamanan Biometrik & Verifikasi Identitas Cepat: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Dilengkapi pemindai sidik jari, pengenalan wajah (facial recognition), dan pembaca identitas digital untuk memvalidasi nasabah secara instan, aman, dan patuh pada regulasi kepatuhan (KYC).","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Omnichannel & Manajemen Antrean Cerdas: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menghubungkan aktivitas di cabang fisik dengan aplikasi perbankan digital nasabah secara mulus, didukung analitik arus pengunjung real-time untuk membantu staf mengalokasikan bantuan secara tepat sasaran.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui modernisasi kantor cabang dan implementasi kios cerdas ini, institusi perbankan, asuransi, serta fintech dapat memangkas biaya operasional transaksi rutin, mengurangi waktu tunggu nasabah secara signifikan, serta mengalihkan fokus staf cabang untuk melayani kebutuhan finansial nasabah yang lebih strategis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (77, 'Ketahanan Operasional & Pemulihan Bencana Sistem Finansial', 'ketahanan-operasional-pemulihan-bencana-sistem-finansial', '2026-10-01T01:32:35.872Z', 'Solusi proteksi data dan pemulihan sistem otomatis berbasis replikasi real-time serta failover cerdas untuk menjamin kelangsungan layanan perbankan dan fintech tanpa jeda.', 255, '2026-10-02T01:43:19.070Z', '2026-10-01T01:32:35.872Z', 14, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri jasa keuangan yang menuntut integritas data dan ketersediaan sistem 24/7, gangguan operasional mendadak dapat berakibat fatal pada hilangnya kepercayaan nasabah serta kerugian finansial bernilai masif. Serangan siber, kegagalan infrastruktur TI, maupun bencana fisik kerap menjadi ancaman serius bagi kelancaran transaksi, pemrosesan klaim, dan layanan perbankan digital. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Ketahanan Operasional & Pemulihan Bencana Sistem Finansial (Business Continuity & Disaster Recovery / BCDR)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk membentengi institusi keuangan melalui arsitektur proteksi terpadu yang memadukan replikasi data instan, pencadangan otomatis, dan pengalihan sistem cadangan secara mulus.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Replikasi Data Real-Time & Failover Cerdas: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyinkronkan data transaksi perbankan secara berkala dan menjalankan pengalihan beban kerja (failover) ke lingkungan sekunder secara otomatis saat terjadi gangguan, memangkas nilai RTO (Recovery Time Objective) dan RPO (Recovery Point Objective) hingga mendekati nol.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Otomasi Pemulihan & Dasbor Kesiapsiagaan Krisis: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyediakan pemantauan status kesehatan infrastruktur cadangan dan proses pemulihan pada dasbor terpusat, meminimalkan intervensi manual yang rentan kesalahan serta mempercepat koordinasi penanganan krisis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kepatuhan Audit & Pengujian Ketahanan Rutin: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mendukung pemenuhan regulasi ketat sektor keuangan melalui pencatatan jejak audit pemulihan yang aman, enkripsi data cadangan, serta fasilitas simulasi pemulihan sistem berkala tanpa mengganggu operasional harian.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan strategi BCDR yang proaktif dan terotomatisasi ini, institusi perbankan, asuransi, dan fintech dapat menjamin kelangsungan transaksi nasabah di segala situasi darurat, mengamankan data sensitif secara konsisten, serta membangun fondasi bisnis yang tangguh terhadap berbagai risiko disrupsi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (4, 'Sistem Pemantauan Terpadu untuk Kesehatan & Keselamatan Publik', 'sistem-pemantauan-terpadu-untuk-kesehatan-keselamatan-publik', '2026-09-29T01:44:53.974Z', 'Solusi pemantauan proaktif berbasis AI dan multi-sensor yang mengintegrasikan kamera pintar, deteksi suhu tubuh, serta sensor lingkungan ke dalam satu dashboard terpusat untuk mendeteksi risiko keamanan dan kesehatan secara real-time.', 215, '2026-10-01T01:36:13.122Z', '2026-09-29T01:50:13.725Z', 9, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Menjaga keselamatan dan kesehatan di ruang publik maupun fasilitas berskala besar kini semakin menantang. Padatnya aktivitas, potensi insiden tak terduga, dan risiko lingkungan dapat memicu bahaya serius jika tidak dideteksi sejak dini. Metode pengawasan konvensional umumnya bersifat reaktif—tindakan baru diambil setelah masalah terjadi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sistem Pemantauan Kesehatan & Keselamatan Publik","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menjembatani celah tersebut melalui pendekatan proaktif dan ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"real-time","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":":","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":1},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Multi-Sensor:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menghubungkan kamera pengawas, pemindai suhu (","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"thermal scanner","type":"text","style":"","detail":0,"format":2,"version":1},{"mode":"normal","text":"), sensor kualitas lingkungan, dan perangkat pintar lainnya di berbagai titik strategis untuk memantau situasi secara terus-menerus.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analisis Cerdas Berbasis AI:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Seluruh aliran data dianalisis secara otomatis di platform terpusat guna mendeteksi anomali, kerumunan berlebih, indikator risiko kesehatan, hingga potensi bahaya sebelum berkembang menjadi insiden fatal.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Kendali Terpusat (","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Command Center","type":"text","style":"","detail":0,"format":3,"version":1},{"mode":"normal","text":"):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Informasi disajikan secara ringkas dan visual melalui dashboard pemantauan, memudahkan pengambil keputusan dan operator merespons keadaan darurat dengan cepat dan tepat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mentransformasi data yang tersebar menjadi wawasan aksi nyata, sistem ini mempercepat waktu tanggap darurat serta menciptakan lingkungan yang jauh lebih aman, nyaman, dan sehat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (76, 'Otomasi Pelaporan Regulasi & Kepatuhan Audit', 'otomasi-pelaporan-regulasi-kepatuhan-audit', '2026-10-01T01:23:28.709Z', 'Solusi agregasi data dan pelaporan otomatis berbasis analitik untuk menyusun laporan kepatuhan finansial secara presisi, memantau risiko, dan memfasilitasi audit tanpa hambatan.', 256, '2026-10-02T01:47:50.807Z', '2026-10-01T01:23:28.709Z', 14, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri jasa keuangan dengan regulasi yang sangat ketat, pemenuhan standar kepatuhan (compliance) dan proses audit merupakan prioritas mendasar yang sering kali membebani operasional. Rekapitulasi data manual yang tersebar di berbagai sistem perbankan, asuransi, maupun fintech kerap memicu keterlambatan pelaporan, inkonsistensi format, hingga tingginya risiko sanksi administratif akibat human error. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Otomasi Pelaporan Regulasi & Kepatuhan Audit Terpadu (Regulatory Reporting & Audit Automation)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mentransformasi alur kepatuhan konvensional menjadi proses cerdas yang terhubung langsung dengan sumber data transaksi secara otomatis dan terpusat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Agregasi Data Multi-Sistem & Mesin Pelaporan Otomatis: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengumpulkan dan menyelaraskan data transaksi lintas sistem secara real-time untuk menghasilkan laporan kepatuhan regulasi yang akurat, terstandardisasi, dan siap diserahkan tepat waktu kepada otoritas pengawas keuangan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Jejak Audit Digital & Validasi Risiko Berkelanjutan: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyediakan pencatatan riwayat perubahan (audit trail) yang transparan dan kontrol validasi otomatis guna mendeteksi anomali atau potensi pelanggaran aturan sebelum berkembang menjadi risiko kepatuhan yang lebih luas.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Visibilitas Eksekutif & Tata Kelola Data: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyajikan status kewajiban pelaporan, pengecualian (exceptions), dan postur risiko pada satu dasbor interaktif, memudahkan petugas kepatuhan dan auditor internal mengambil tindakan mitigasi secara cepat dan terukur.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem pelaporan regulasi dan audit otomatis ini, institusi keuangan dapat memangkas waktu kerja administratif tim audit, meminimalkan risiko kepatuhan dan penalti regulator, serta membangun tata kelola operasional yang tangguh, transparan, dan tepercaya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (83, 'Optimasi Logistik Hijau & Efisiensi Armada Berkelanjutan', 'optimasi-logistik-hijau-efisiensi-armada-berkelanjutan', '2026-10-01T02:07:56.388Z', 'Solusi logistik pintar berbasis IoT dan AI untuk mengoptimalkan rute armada, menghemat bahan bakar, serta memantau jejak emisi karbon secara real-time.', NULL, '2026-10-01T02:07:56.388Z', '2026-10-01T02:07:56.388Z', 15, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri logistik dan transportasi modern, efisiensi operasional dan keberlanjutan lingkungan kini menjadi prioritas yang berjalan beriringan seiring meningkatnya tuntutan efisiensi biaya dan kepatuhan standar lingkungan (ESG). Pola operasional konvensional kerap menghadapi tantangan berupa rute pengiriman yang tidak efisien, tingginya waktu mesin menyala tanpa berjalan (idle time), serta kesulitan memantau konsumsi bahan bakar dan emisi karbon secara akurat. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Optimasi Logistik Hijau & Efisiensi Armada Berkelanjutan (Sustainable Logistics)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menyatukan kekuatan IoT, kecerdasan buatan (AI), dan analitik data terpusat guna merancang rantai pasok yang hemat energi, tangguh, dan ramah lingkungan dari hulu hingga pengiriman jarak akhir (last-mile delivery).","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Optimasi Rute Cerdas & Pengurangan Idle Time: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memanfaatkan algoritma AI untuk memetakan rute tercepat dan paling hemat energi bagi armada kendaraan, menekan waktu tunggu di kemacetan, serta meminimalkan jarak tempuh yang tidak produktif.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Emisi Karbon & Konsumsi Energi Real-Time: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengintegrasikan sensor telematika IoT untuk melacak konsumsi bahan bakar, mengawasi integrasi armada kendaraan listrik (EV), dan mengukur jejak karbon operasional secara otomatis guna memenuhi target keberlanjutan perusahaan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perawatan Prediktif & Dasbor Operasional Terpadu: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memberikan visibilitas penuh terhadap performa mesin armada melalui dasbor komando terpusat, memicu peringatan perawatan kendaraan lebih awal guna mencegah kerusakan berat dan menjaga efisiensi pembakaran mesin tetap prima.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengadopsi platform logistik berkelanjutan ini, penyedia jasa logistik dan transportasi dapat menekan biaya operasional bahan bakar secara signifikan, mematuhi regulasi lingkungan global, serta membangun reputasi rantai pasok yang modern, bertanggung jawab, dan siap bersaing di masa depan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (84, 'Ketahanan Rantai Pasok & Pemulihan Sistem Logistik Cepat', 'ketahanan-rantai-pasok-pemulihan-sistem-logistik-cepat', '2026-10-01T02:09:50.221Z', 'Solusi kesinambungan operasional berbasis cloud failover dan replikasi data real-time untuk mencegah lumpuhnya alur distribusi logistik akibat bencana atau serangan siber.', NULL, '2026-10-01T02:09:50.221Z', '2026-10-01T02:09:50.221Z', 15, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri logistik dan transportasi yang bergantung pada pergerakan armada dan ketepatan koordinasi tanpa henti, disrupsi sistem sekecil apa pun dapat memicu efek domino yang melumpuhkan rantai pasok dan menimbulkan kerugian finansial masif. Gangguan infrastruktur TI, serangan siber pada sistem manajemen gudang (WMS/TMS), maupun bencana alam kerap menghentikan visibilitas pelacakan kargo, memicu penumpukan barang, dan merusak kepercayaan mitra pengiriman. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Ketahanan Rantai Pasok & Pemulihan Sistem Logistik Cepat (Business Continuity & Disaster Recovery / BCDR)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk memastikan sistem operasional inti tetap tangguh dan siap pulih seketika saat terjadi kondisi darurat tak terduga.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Replikasi Data Otomatis & Pemulihan Berbasis Cloud: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyinkronkan data pelacakan pengiriman, inventaris gudang, dan manifest secara kontinu ke lingkungan komputasi awan cadangan, memastikan data dapat dipulihkan dalam hitungan menit tanpa kehilangan riwayat perjalanan kargo.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengalihan Sistem Otomatis (Automated Failover) & Penataan Rute Dinamis: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengalihkan beban kerja operasional ke server cadangan secara instan saat sistem utama terganggu, dipadukan dengan kemampuan penyesuaian rute distribusi dinamis untuk menghindari simpul logistik yang terdampak disrupsi.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Kesiapsiagaan & Mitigasi Risiko Prediktif: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyajikan status kesiapan infrastruktur cadangan dan visibilitas risiko operasional pada satu layar kendali, mempermudah koordinasi penanganan krisis lintas gudang, pelabuhan, dan armada transportasi secara cepat.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan strategi ketahanan dan pemulihan bencana terintegrasi ini, perusahaan logistik dan transportasi dapat mengeliminasi risiko kelumpuhan rantai pasok, meminimalkan keterlambatan pengiriman saat krisis, serta menjaga komitmen keandalan layanan kepada pelanggan di segala kondisi yang menantang.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (85, 'Pelacakan Aset & Mitigasi Kehilangan Kargo Logistik', 'pelacakan-aset-mitigasi-kehilangan-kargo-logistik', '2026-10-01T02:13:06.210Z', 'Solusi pemantauan aset berbasis IoT dan GPS untuk melacak lokasi armada, kontainer, dan kargo berharga secara real-time serta mengamankan pemulihan dari risiko pencurian.', NULL, '2026-10-01T02:13:06.210Z', '2026-10-01T02:13:06.210Z', 15, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri logistik dan transportasi, visibilitas penuh serta kendali terhadap pergerakan aset berharga merupakan kunci utama kelancaran rantai distribusi. Pelacakan konvensional kerap menghadapi titik buta (blind spots) saat kargo berpindah antarmoda transportasi atau melintasi wilayah terpencil, memperbesar risiko kehilangan muatan, pembajakan kontainer, hingga keterlambatan pengiriman yang tidak terdeteksi. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pelacakan Aset & Mitigasi Kehilangan Kargo Logistik (Asset Tracking & Recovery System)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk memberikan transparansi posisi, kondisi, dan status keamanan armada maupun kiriman bernilai tinggi secara berkesinambungan dari titik asal hingga tujuan akhir.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Lokasi & Kondisi Aset Real-Time: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengintegrasikan sensor telematika IoT dan modul GPS berdaya tahan tinggi untuk memantau koordinat, kecepatan, status pintu kontainer, serta pergerakan aset di gudang, pelabuhan, maupun jalan raya secara akurat.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Geofencing & Deteksi Anomali Gerak Otomatis: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menerapkan pembatasan rute virtual (geofencing) yang memicu alarm peringatan seketika saat terdeteksi deviasi rute yang tidak sah, pemberhentian mencurigakan, atau indikasi pembobolan guna mempercepat langkah pemulihan dan penindakan.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Manajemen Armada & Visibilitas Menyeluruh: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Terhubung langsung dengan sistem manajemen transportasi (TMS) dan inventaris gudang melalui dasbor terpusat, mempermudah koordinasi penanganan keterlambatan serta mengoptimalkan perencanaan rute perjalanan berikutnya.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem pelacakan aset dan pemulihan kargo ini, penyedia jasa logistik dapat menekan angka penyusutan barang akibat pencurian, mengeliminasi risiko aset terselip di jalur distribusi, serta menjaga keandalan dan ketepatan waktu pengiriman barang bagi para mitra bisnis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (86, 'Simulasi & Visibilitas Rantai Pasok Berbasis Digital Twin', 'simulasi-visibilitas-rantai-pasok-berbasis-digital-twin', '2026-10-01T02:17:15.679Z', 'Solusi replikasi virtual dinamis berbasis IoT dan AI untuk memantau alur distribusi secara real-time, memprediksi hambatan logistik, dan menguji skenario operasional.', NULL, '2026-10-01T02:17:15.679Z', '2026-10-01T02:17:15.679Z', 15, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah tingginya kompleksitas industri logistik dan transportasi, visibilitas pelacakan pasif saja tidak lagi memadai untuk mengimbangi dinamika pasar—pelaku bisnis dituntut mampu memprediksi hambatan dan beradaptasi sebelum kendala di lapangan terjadi. Ketiadaan ruang uji coba operasional kerap membuat penyesuaian rute pengiriman, alokasi inventaris gudang, atau mitigasi cuaca buruk menjadi langkah spekulatif yang berisiko tinggi terhadap biaya dan waktu. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Simulasi & Visibilitas Rantai Pasok Berbasis Digital Twin (Digital Twin for Supply Chain Visibility)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir menciptakan model replika virtual interaktif dari seluruh jaringan fisik rantai pasok dengan mengintegrasikan data sensor IoT, armada transportasi, dan sistem gudang secara langsung.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Replikasi Virtual & Visibilitas Terpusat Real-Time: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memetakan seluruh aktivitas fisik—mulai dari pergerakan armada, ketersediaan stok di distribution center, hingga status muatan—ke dalam representasi digital terpadu untuk mendeteksi potensi kemacetan dan keterlambatan lebih dini.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemodelan Skenario & Analitik Prediktif Bertenaga AI: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menguji berbagai skenario darurat, fluktuasi permintaan, atau perubahan jadwal kapal secara simulasi digital tanpa risiko fisik, memudahkan tim logistik memilih strategi mitigasi terbaik secara presisi.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengambilan Keputusan Cepat & Rekonfigurasi Jalur Distribusi: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memungkinkan manajer rantai pasok mengubah rute distribusi, menyesuaikan alokasi kapasitas gudang, dan mengoptimalkan pemanfaatan aset transportasi dengan cepat berbasis data proyeksi akurat.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan teknologi kembaran digital ini, perusahaan logistik dapat mentransformasi ekosistem operasional menjadi lebih adaptif dan tahan banting, menekan biaya inefisiensi pengiriman, serta menjamin keandalan layanan rantai pasok di tengah situasi global yang serba dinamis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (87, 'Pusat Operasional Logistik', 'pusat-operasional-logistik', '2026-10-01T02:18:29.311Z', 'Platform komando terpusat berbasis TMS, WMS, dan IoT untuk memantau pergerakan armada, status gudang, serta rute pengiriman secara real-time dari satu layar.', NULL, '2026-10-01T02:18:29.311Z', '2026-10-01T02:18:29.311Z', 15, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri logistik dan transportasi yang serba cepat, koordinasi lintas divisi yang terfragmentasi kerap menjadi akar terjadinya keterlambatan pengiriman, ketidaksesuaian data stok gudang, dan inefisiensi rute perjalanan. Tanpa pusat kendali yang terintegrasi, tim operasional kesulitan merespons gangguan mendadak di jalan raya, penumpukan kargo di terminal transit, maupun penurunan kinerja armada pengiriman. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Komando Operasional Logistik Terpadu (Logistics Command Center)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai pusat kendali utama yang menyatukan seluruh aliran data operasional dari sistem manajemen transportasi (TMS), sistem gudang (WMS), pelacak GPS, hingga sensor IoT ke dalam satu platform visibilitas menyeluruh.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Visibilitas Rantai Pasok Terpadu & Real-Time: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengonsolidasikan pemantauan posisi armada, status muatan kargo, aktivitas bongkar muat di gudang, dan metrik ketepatan waktu pengiriman ke dalam dasbor komando interaktif yang mudah dipahami.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Peringatan Otomatis & Tanggap Gangguan Cepat: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mendeteksi kendala operasional—seperti keterlambatan rute, deviasi perjalanan, atau kemacetan di simpul logistik—secara instan melalui notifikasi otomatis, memungkinkan tim pengawas mengambil langkah korektif tanpa jeda.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Koordinasi Lintas Unit & Analitik Kinerja Cerdas: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menghubungkan komunikasi antara pengelola gudang, pengemudi armada, dan tim distribusi akhir (last-mile) dengan dukungan analitik data untuk mengoptimalkan perutean serta pembagian beban kerja armada.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengimplementasikan pusat komando operasional logistik ini, perusahaan transportasi dan logistik dapat memangkas waktu penanganan masalah operasional, meningkatkan akurasi jadwal pengiriman, serta menghadirkan layanan rantai pasok yang andal, efisien, dan berdaya saing tinggi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (88, 'Perawatan Prediktif & Diagnostik Cerdas Armada', 'perawatan-prediktif-diagnostik-cerdas-armada', '2026-10-01T02:19:27.576Z', 'Solusi pemeliharaan armada berbasis IoT dan AI untuk memantau kesehatan mesin secara real-time, mencegah mogok di jalan, dan mengoptimalkan jadwal servis berkala.', NULL, '2026-10-01T02:19:27.576Z', '2026-10-01T02:19:27.576Z', 15, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri logistik dan transportasi, keandalan armada kendaraan merupakan pilar utama penentu kelancaran distribusi serta ketepatan waktu pengiriman barang. Pendekatan perawatan konvensional yang bersifat reaktif—baru diperbaiki saat kendaraan mogok—atau berbasis jadwal jarak tempuh statis kerap memicu biaya perbaikan darurat yang membengkak, keausan suku cadang tanpa terdeteksi, dan terhentinya operasional pengiriman secara mendadak. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Perawatan Prediktif & Diagnostik Cerdas Armada (Predictive Maintenance for Vehicles)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk mentransformasi tata kelola bengkel armada menjadi strategi proaktif berbasis data kondisi fisik kendaraan yang dipantau secara berkesinambungan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Kesehatan Komponen Kritis & Telematika Real-Time: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memanfaatkan sensor IoT dan telematika untuk mengawasi parameter penting mesin, suhu pengereman, tekanan ban, sistem transmisi, hingga konsumsi oli guna mendeteksi gejala kerusakan sejak dini.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Kerusakan Prediktif Berbasis AI: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menganalisis pola anomali performa kendaraan dan mengirimkan notifikasi peringatan otomatis sebelum terjadi kerusakan fatal (breakdown), memungkinkan tindakan perbaikan dilakukan sebelum armada turun ke jalan.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Optimasi Siklus Servis & Efisiensi Biaya Operasional: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyelaraskan jadwal perawatan dengan tingkat keausan aktual kendaraan alih-alih estimasi waktu rutin semata, memperpanjang usia pakai aset armada, menghemat bahan bakar, serta memangkas biaya pergantian suku cadang yang belum diperlukan.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan platform perawatan prediktif ini, manajer armada logistik dapat mengeliminasi waktu henti kendaraan (downtime) tak terduga, menekan biaya perawatan darurat di jalan, serta menjamin seluruh armada pengiriman selalu beroperasi dalam kondisi prima dan aman.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (89, 'Manajemen Pergudangan Cerdas & Otomasi Inventaris', 'manajemen-pergudangan-cerdas-otomasi-inventaris', '2026-10-01T02:20:32.291Z', 'Solusi digitalisasi gudang berbasis IoT, robotika, dan analitik AI untuk mempercepat pemenuhan pesanan, mengoptimalkan kapasitas ruang, serta mengeliminasi kesalahan stok.', NULL, '2026-10-01T02:20:32.291Z', '2026-10-01T02:20:32.291Z', 15, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah pesatnya pertumbuhan industri logistik modern, fungsi gudang telah bertransformasi dari sekadar ruang penampungan barang menjadi pusat kendali penentu kecepatan dan akurasi rantai pasok. Pengelolaan gudang konvensional yang mengandalkan pencatatan manual sering kali menghadapi kendala lambatnya proses pengambilan barang (picking), tingginya tingkat kesalahan pengemasan barang (sorting), serta penataan ruang simpan yang tidak efisien. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Manajemen Pergudangan Cerdas & Otomasi Inventaris (Smart Warehouse Management)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk merevolusi fasilitas pergudangan melalui integrasi sensor IoT, otomasi robotika, dan analitik cerdas guna mewujudkan alur logistik internal yang cepat, akurat, dan transparan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Otomasi Pemenuhan Pesanan (Automated Fulfillment): ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memanfaatkan sistem pemilahan otomatis, perangkat pemindai IoT, dan integrasi robotika pergudangan untuk mempercepat alur penerimaan barang, penempatan di rak (putaway), hingga proses penyiapan pesanan dengan tingkat akurasi mendekati 100%.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Optimasi Tata Letak Ruang & Proyeksi Stok Berbasis AI: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menerapkan analitik prediktif untuk meramalkan lonjakan permintaan musiman, mengatur tata letak inventaris berdasarkan kecepatan perputaran barang (fast/slow-moving), serta memaksimalkan kapasitas ruang gudang yang tersedia.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Visibilitas Inventaris Real-Time & Integrasi Rantai Pasok: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyajikan status ketersediaan barang dan beban kerja operasional ke dalam dasbor terpusat yang terhubung mulus dengan sistem manajemen transportasi (TMS) dan armada pengiriman untuk memastikan proses distribusi lanjutan berjalan tanpa jeda.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengadopsi platform manajemen pergudangan cerdas ini, perusahaan logistik dapat memangkas waktu pemrosesan pesanan secara drastis, menekan biaya operasional tenaga kerja manual, serta memastikan ketersediaan pasokan barang yang lincah dan adaptif terhadap lonjakan permintaan pasar.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (90, 'Sistem Tanggap Darurat & Keselamatan Kampus', 'sistem-tanggap-darurat-keselamatan-kampus', '2026-10-01T02:22:39.612Z', 'Solusi keamanan lingkungan pendidikan berbasis AI, sensor terpadu, dan notifikasi darurat instan untuk mempercepat respons penanganan insiden dan melindungi seluruh sivitas akademika.', NULL, '2026-10-01T02:22:39.612Z', '2026-10-01T02:22:39.612Z', 16, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Menjamin keselamatan mahasiswa, tenaga pendidik, dan staf di kawasan institusi pendidikan yang luas dan padat merupakan tanggung jawab besar yang kian menantang. Pengawasan manual serta penggunaan sistem keamanan yang terpisah-pisah—mulai dari kamera pengawas pasif hingga alarm independen—kerap memicu keterlambatan koordinasi saat terjadi kebakaran, insiden kriminalitas, maupun kondisi darurat medis. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Sistem Tanggap Darurat & Keselamatan Kampus Terpadu (Emergency Response & Campus Safety System)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir mengintegrasikan pengawasan video, sistem kontrol akses, sensor lingkungan, dan sirene darurat ke dalam satu platform kendali yang memantau kondisi kampus secara real-time.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Ancaman Cerdas & Pemantauan Menyeluruh: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menggabungkan analitik berbasis AI pada jaringan kamera pengawas dan sensor lingkungan untuk mendeteksi kerumunan mencurigakan, kepulan asap/api, atau penyusupan area terlarang secara otomatis.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Notifikasi Darurat Multikanal Cepat: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyebarkan peringatan bahaya, instruksi evakuasi, dan panduan keselamatan dalam hitungan detik melalui integrasi sirene kampus, papan informasi digital, notifikasi SMS, serta aplikasi ponsel sivitas akademika.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Komando Terpusat & Koordinasi Lintas Unit: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyajikan peta lokasi insiden dan rute penanganan darurat pada dasbor terpusat, mempermudah koordinasi tim keamanan internal dengan petugas medis darurat, kepolisian, atau dinas pemadam kebakaran.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem keselamatan kampus modern ini, institusi pendidikan dapat memangkas waktu tanggap darurat secara drastis, meminimalkan risiko kepanikan maupun jatuhnya korban saat insiden, serta mewujudkan ekosistem belajar-mengajar yang aman, nyaman, dan tepercaya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (91, 'Platform Analitik Performa & Pembelajaran Siswa Berbasis AI', 'platform-analitik-performa-pembelajaran-siswa-berbasis-ai', '2026-10-01T02:24:13.297Z', 'Solusi pemantauan akademik bertenaga machine learning untuk mendeteksi siswa yang berisiko tertinggal, mempersonalisasi alur belajar, dan meningkatkan angka kelulusan.', NULL, '2026-10-01T02:24:13.297Z', '2026-10-01T02:24:13.297Z', 16, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah transformasi pendidikan digital yang pesat, evaluasi kemajuan belajar siswa tidak lagi cukup hanya mengandalkan rekap nilai ujian berkala di akhir semester. Data aktivitas belajar yang tersebar terpisah—mulai dari sistem manajemen pembelajaran (LMS), presensi kehadiran, nilai tugas harian, hingga interaksi di kelas digital—kerap membuat pendidik terlambat menyadari penurunan motivasi belajar siswa hingga berujung pada kegagalan akademik. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Platform Analitik Performa & Pembelajaran Siswa Berbasis AI (AI-Based Student Performance Analytics)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menyatukan seluruh rekam jejak akademik ke dalam satu tampilan terpadu berbasis kecerdasan buatan dan analitik prediktif.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Deteksi Dini Risiko Akademik & Pola Belajar: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memanfaatkan algoritma machine learning untuk memetakan kebiasaan belajar dan mendeteksi siswa yang berpotensi mengalami kesulitan materi atau penurunan performa jauh sebelum masa ujian tiba.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Personalisasi Jalur Pembelajaran (Adaptive Learning): ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menganalisis tingkat pemahaman, kelebihan, dan preferensi belajar tiap individu guna membantu pendidik menyusun materi pendalaman, tugas pengayaan, serta bimbingan yang tepat sasaran.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Wawasan Akademik & Perencanaan Institusi: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyajikan tren pencapaian kelas, tingkat partisipasi, dan metrik keberhasilan kurikulum pada dasbor interaktif, memudahkan manajemen sekolah maupun universitas dalam mengoptimalkan alokasi tenaga pendidik dan program pendampingan.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan platform analitik performa berbasis AI ini, lembaga pendidikan dapat mengambil langkah intervensi akademik secara tepat waktu, mendongkrak efektivitas kegiatan belajar-mengajar, serta membangun ekosistem akademik yang adaptif demi kesuksesan setiap peserta didik.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (92, 'Keamanan Siber & Perlindungan Data Institusi Pendidikan', 'keamanan-siber-perlindungan-data-institusi-pendidikan', '2026-10-01T02:25:15.650Z', 'Solusi tata kelola keamanan siber terpadu berbasis kontrol akses, enkripsi data, dan pemantauan ancaman real-time untuk melindungi data sivitas akademika serta kelancaran pembelajaran digital.', NULL, '2026-10-01T02:25:15.650Z', '2026-10-01T02:25:15.650Z', 16, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di era pembelajaran digital yang mengandalkan komputasi awan, platform kolaborasi daring, dan sistem informasi kampus terintegrasi, institusi pendidikan kini menjadi sasaran empuk serangan siber. Keberadaan data sensitif bernilai tinggi—seperti identitas pribadi mahasiswa, catatan nilai akademik, berkas finansial, hingga hasil riset strategis institusi—sangat rentan terhadap bahaya kebocoran data, serangan ransomware, maupun upaya phishing. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Keamanan Siber & Perlindungan Data Institusi Pendidikan (Cybersecurity & Data Protection for Education)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir memberikan perlindungan menyeluruh melalui integrasi kontrol akses identitas, pencegahan kebocoran data (DLP), enkripsi, dan pemantauan ancaman secara berkesinambungan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Manajemen Identitas & Kontrol Akses Ketat (IAM): ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menerapkan autentikasi multi-faktor dan pembatasan hak akses berbasis peran (role-based access) untuk memastikan portal kampus, sistem ujian, dan repositori riset hanya dapat diakses oleh pihak yang berwenang.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perlindungan Data Sensitif (DLP) & Enkripsi Menyeluruh: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengamankan transmisi maupun penyimpanan berkas mahasiswa dan data penelitian melalui enkripsi berlapis serta sistem deteksi kebocoran otomatis guna mencegah peretasan dan distribusi data ilegal.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Ancaman Real-Time & Dasbor Kepatuhan: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyajikan visibilitas postur keamanan jaringan kampus pada dasbor komando terpusat, mempermudah tim IT mendeteksi anomali lalu lintas data, merespons insiden peretasan secara cepat, serta memenuhi standar regulasi perlindungan privasi data.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan kerangka keamanan siber dan perlindungan data yang kokoh ini, universitas maupun sekolah dapat mengeliminasi ancaman siber yang melumpuhkan sistem operasional, menjamin kerahasiaan data seluruh sivitas akademika, serta menyelenggarakan lingkungan belajar-mengajar digital yang aman, lancar, dan tepercaya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (93, 'Infrastruktur Pembelajaran Hibrida & Kelas Digital Terintegrasi', 'infrastruktur-pembelajaran-hibrida-kelas-digital-terintegrasi', '2026-10-01T02:26:16.347Z', 'Solusi ekosistem kelas hibrida terpadu berbasis LMS, konferensi video, dan komputasi awan untuk menghadirkan pengalaman belajar tatap muka dan daring yang fleksibel serta setara.', NULL, '2026-10-01T02:26:16.347Z', '2026-10-01T02:26:16.347Z', 16, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Transformasi pendidikan modern menuntut model pembelajaran yang tidak lagi terbatas pada dinding ruang kelas fisik semata. Pembelajaran jarak jauh yang terpisah dari kegiatan tatap muka konvensional kerap menimbulkan kesenjangan akses materi, kesulitan interaksi dua arah, serta kendala teknis jaringan yang mengganggu konsentrasi belajar siswa. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Infrastruktur Pembelajaran Hibrida & Kelas Digital Terintegrasi (Hybrid Learning Infrastructure)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menyatukan ruang kelas fisik dan platform digital ke dalam satu ekosistem pembelajaran yang fleksibel, stabil, dan mudah diakses dari mana saja.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Integrasi Ruang Kelas Fisik & Platform Daring: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menggabungkan perangkat audio-visual cerdas di kelas dengan sistem manajemen pembelajaran (LMS) dan konferensi video interaktif, memungkinkan siswa daring maupun luring berpartisipasi dalam diskusi secara setara dan real-time.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Konektivitas Awan Andal & Akses Materi Terpusat: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menjamin ketersediaan modul ajar, rekaman perkuliahan, dan tugas digital melalui arsitektur komputasi awan (cloud) yang skalabel dan minim gangguan latensi, bahkan saat diakses bersamaan oleh ribuan siswa.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Partisipasi & Analitik Keterlibatan Siswa: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memantau tingkat kehadiran, keaktifan diskusi, dan durasi akses materi digital melalui dasbor analitik terpusat, memudahkan pendidik mengevaluasi efektivitas metode pengajaran dan memberikan perhatian personal pada siswa yang membutuhkan.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui penerapan infrastruktur pembelajaran hibrida yang terintegrasi ini, sekolah dan universitas dapat memperluas jangkauan layanan pendidikan melampaui batas geografis, menjaga kelangsungan belajar tanpa terputus di berbagai situasi, serta membangun pengalaman akademik yang inklusif, modern, dan siap menghadapi masa depan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (108, 'Platform Tata Kelola Data & Analitik Kecerdasan Buatan', 'platform-tata-kelola-data-analitik-kecerdasan-buatan', '2026-10-01T02:58:28.282Z', 'Solusi konsolidasi data dan analitik prediktif berbasis machine learning untuk mengubah data mentah lintas sistem menjadi wawasan strategis dan rekomendasi keputusan real-time.', NULL, '2026-10-01T03:21:58.903Z', '2026-10-01T02:58:28.282Z', 18, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah pesatnya pertumbuhan ekonomi digital, tantangan terbesar bagi organisasi bukan lagi keterbatasan volume data, melainkan ketidakmampuan mengubah tumpukan data mentah menjadi wawasan bisnis yang dapat ditindaklanjuti. Informasi yang terisolasi di berbagai sistem mandiri—mulai dari ERP, CRM, sensor IoT, hingga basis data eksternal—kerap menghasilkan laporan statis yang terlambat, memicu bias interpretasi manual, dan memperlambat respons perusahaan terhadap perubahan pasar. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Platform Tata Kelola Data & Analitik Kecerdasan Buatan Terpadu (AI & Data Analytics Platform)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai fondasi kecerdasan digital yang mengintegrasikan data lake, data warehouse, dan model pembelajaran mesin (machine learning) ke dalam satu alur pemrosesan data otomatis berkecepatan tinggi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Konsolidasi Data Lintas Sistem & Alur Pemrosesan Otomatis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengintegrasikan aliran data terstruktur maupun tidak terstruktur dari sistem operasional utama melalui data pipeline otomatis, mengeliminasi pekerjaan pembersihan data manual dan memastikan integritas data tetap konsisten.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Prediktif & Pemodelan Cerdas Bertenaga AI:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan algoritma machine learning untuk memproyeksikan tren permintaan pasar, mendeteksi anomali kinerja operasional lebih awal, serta memberikan rekomendasi langkah strategis secara otomatis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dasbor Wawasan Eksekutif & Eksplorasi Data Mandiri (Self-Service BI):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan visualisasi metrik performa bisnis yang interaktif dan dinamis, memudahkan para pengambil keputusan di berbagai divisi untuk mengeksplorasi wawasan dan mengambil keputusan berbasis data secara mandiri dan percaya diri.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan platform analitik data dan AI yang komprehensif ini, organisasi dapat memangkas siklus pengambilan keputusan, mengoptimalkan efisiensi alur kerja operasional, serta membuka potensi peluang bisnis baru yang mendorong keunggulan kompetitif berkelanjutan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (95, 'Integrasi Ekosistem & Platform Manajemen Pembelajaran Digital', 'integrasi-ekosistem-platform-manajemen-pembelajaran-digital', '2026-10-01T02:30:28.652Z', 'Solusi penyelarasan LMS dengan SIS, alat kolaborasi daring, dan repositori konten untuk menyederhanakan administrasi akademik serta menghadirkan pengalaman belajar tanpa batas.', NULL, '2026-10-01T02:30:28.652Z', '2026-10-01T02:30:28.652Z', 16, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di era digitalisasi pendidikan, pemanfaatan portal pembelajaran yang berdiri sendiri (standalone) sering kali menciptakan tumpang tindih data dan inefisiensi administrasi. Pendidik dan staf kampus kerap harus memasukkan nilai, jadwal, dan presensi secara ganda antara Sistem Informasi Akademik (SIS/SIAKAD), aplikasi ruang kelas virtual, dan platform konferensi video. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Integrasi Ekosistem & Platform Manajemen Pembelajaran Digital (LMS Integration)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menghubungkan seluruh sistem akademik, manajemen konten materi, dan sarana kolaborasi interaktif ke dalam satu ekosistem terpadu yang tersinkronisasi secara otomatis dan real-time.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Sinkronisasi Data Akademik Terpusat: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menghubungkan platform LMS langsung dengan Sistem Informasi Mahasiswa/Siswa (SIS), memastikan data pendaftaran mata kuliah, presensi kehadiran, dan rekapitulasi nilai tersinkronisasi tanpa input manual berulang.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Akses Materi & Kolaborasi Multikanal Mulus: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memudahkan peserta didik mengakses repositori modul ajar, mengunggah tugas kuliah, serta bergabung ke sesi kuliah virtual interaktif melalui integrasi sekali masuk (Single Sign-On / SSO) lintas perangkat.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Pembelajaran & Otomasi Alur Kerja: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengonsolidasikan data tingkat partisipasi dan capaian belajar siswa ke dalam dasbor pemantauan terpadu, membantu dosen mengidentifikasi kebutuhan bimbingan tambahan sekaligus memangkas beban administrasi pengajaran secara signifikan.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan integrasi sistem manajemen pembelajaran yang komprehensif ini, institusi pendidikan dapat menekan beban kerja administratif tenaga pendidik, menghilangkan fragmentasi data nilai dan kehadiran, serta mewujudkan pengalaman belajar daring yang mulus, adaptif, dan berdaya guna tinggi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (96, 'Solusi Ruang Kelas Pintar & Pembelajaran Interaktif', 'solusi-ruang-kelas-pintar-pembelajaran-interaktif', '2026-10-01T02:31:37.509Z', 'Solusi digitalisasi ruang kelas berbasis papan pintar interaktif, perangkat terhubung, dan integrasi LMS untuk mendorong kolaborasi aktif serta pembelajaran partisipatif.', NULL, '2026-10-01T02:31:37.509Z', '2026-10-01T02:31:37.509Z', 16, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di era transformasi pendidikan modern, metode pengajaran satu arah menggunakan papan tulis konvensional mulai ditinggalkan karena dinilai kurang efektif dalam mempertahankan fokus dan keterlibatan generasi digital. Keterbatasan sarana interaktif di dalam kelas kerap membuat proses penyampaian materi terasa monoton, membatasi partisipasi aktif peserta didik, serta menyulitkan kolaborasi antara siswa di ruang kelas fisik dengan yang mengikuti secara daring. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Solusi Ruang Kelas Pintar & Pembelajaran Interaktif (Smart Classroom Solution)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir merevolusi ruang kelas menjadi lingkungan belajar multimedia yang dinamis, terhubung, dan kolaboratif.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Media Pembelajaran Interaktif & Perangkat Terhubung: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengintegrasikan papan tulis digital interaktif (smart board), proyektor cerdas, dan perangkat pendukung pembelajaran yang memungkinkan pengajar membagikan materi multimedia serta menjalankan kuis interaktif secara instan ke gawai masing-masing siswa.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kolaborasi Tanpa Hambatan & Pembelajaran Hibrida: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mendukung koneksi nirkabel lintas platform (screen sharing) dan terhubung langsung dengan sistem manajemen pembelajaran (LMS), memfasilitasi interaksi dua arah yang setara bagi siswa tatap muka maupun siswa jarak jauh.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Partisipasi Kelas & Pemantauan Real-Time: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menyajikan data kehadiran, tingkat keaktifan, dan respons pemahaman siswa terhadap materi kuis harian ke dalam dasbor kelas, memudahkan guru menyesuaikan tempo pengajaran dan memberikan perhatian personal secara tepat waktu.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan ekosistem ruang kelas pintar ini, institusi pendidikan dapat mendongkrak antusiasme serta capaian belajar peserta didik, menyederhanakan alur kerja pengajar dalam menyampaikan materi, serta menghadirkan suasana kelas modern yang adaptif dan siap menyongsong masa depan pendidikan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (106, 'Solusi Ketahanan Bisnis & Pemulihan Bencana Sistem', 'solusi-ketahanan-bisnis-pemulihan-bencana-sistem', '2026-10-01T02:56:56.718Z', 'Solusi kelangsungan operasional menyeluruh berbasis replikasi data real-time, pencadangan otomatis, dan failover cloud untuk memastikan sistem pulih tanpa henti saat krisis.', NULL, '2026-10-01T03:22:20.433Z', '2026-10-01T02:56:56.718Z', 18, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di era digital yang menuntut ketersediaan layanan 24 jam penuh tanpa jeda, gangguan sistem sekecil apa pun dapat mengakibatkan kerugian finansial langsung, kelumpuhan operasional, hingga pudarnya kepercayaan pelanggan dan pemangku kepentingan. Ancaman siber seperti ransomware, kegagalan perangkat keras di pusat data, hingga bencana fisik yang tak terduga kerap melumpuhkan aplikasi inti jika bisnis hanya mengandalkan prosedur pencadangan konvensional yang lambat dan rentan gagal. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Solusi Ketahanan Bisnis & Pemulihan Bencana Sistem Terpadu (Business Continuity & Disaster Recovery / BCDR)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk menjamin infrastruktur TI dan proses bisnis esensial tetap berjalan stabil, tangguh, serta siap dipulihkan seketika dengan target waktu henti (downtime) mendekati nol.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Replikasi Data Real-Time & Pencadangan Otomatis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menggandakan data operasional dan basis data secara kontinu ke lingkungan komputasi awan yang terisolasi dan terenkripsi, meminimalkan potensi kehilangan transaksi data (RPO minimum) saat insiden terjadi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengalihan Sistem Otomatis (Automated Cloud Failover):","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengalihkan beban kerja aplikasi ke sistem cadangan secara instan tanpa hambatan saat server utama mengalami kegagalan fungsi, memastikan layanan pelanggan tetap beroperasi secara normal tanpa interupsi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Kesiapsiagaan & Dasbor Orkestrasi Terpusat:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan indikator kesehatan infrastruktur, status replikasi, dan simulasi pengujian pemulihan bencana (DR drill) pada satu antarmuka dasbor analitik, mempermudah tim IT mengeksekusi langkah pemulihan secara presisi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengadopsi strategi BCDR yang komprehensif ini, perusahaan dapat memitigasi risiko kelumpuhan operasional, menekan biaya pemulihan darurat, serta memastikan ketahanan bisnis yang solid dan tepercaya di tengah dinamika disrupsi digital yang tidak terduga.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (98, 'Sistem Tanggap Darurat & Keselamatan Terpadu Kawasan Resor', 'sistem-tanggap-darurat-keselamatan-terpadu-kawasan-resor', '2026-10-01T02:49:42.611Z', 'Solusi proteksi keselamatan kawasan perhotelan berbasis IoT dan pemantauan terpusat untuk mendeteksi bahaya, merespons insiden darurat secara cepat, dan melindungi kenyamanan tamu 24/7.', NULL, '2026-10-01T02:49:42.611Z', '2026-10-01T02:49:42.611Z', 17, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri hospitality dan pariwisata premium, rasa aman dan perlindungan terhadap tamu merupakan tolok ukur fundamental yang menentukan reputasi serta citra sebuah resor. Lanskap properti yang luas dan terdistribusi—mulai dari vila privat, area pantai terbuka, kolam renang, restoran, hingga wahana rekreasi luar ruang—menghadirkan tantangan pengawasan yang sulit dijangkau patroli fisik konvensional. Kondisi darurat medis, risiko kebakaran, maupun akses ilegal di area terpencil kerap terlambat direspons tanpa adanya sistem kendali yang terhubung secara terpusat. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Sistem Tanggap Darurat & Keselamatan Terpadu Kawasan Resor (Safety & Emergency Response System for Resorts)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir mengintegrasikan sensor lingkungan IoT, jaringan kamera pengawas, dan kontrol akses ke dalam satu platform pemantauan wilayah yang aktif sepanjang waktu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pengawasan Kawasan Terintegrasi & Deteksi Bahaya Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengawasi seluruh sudut properti melalui kamera CCTV cerdas, tombol darurat (panic button), serta sensor pendeteksi bahaya (seperti asap/api dan ketinggian gelombang/air) untuk mengenali ancaman secara otomatis sebelum membahayakan tamu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pusat Komando Cepat Tanggap & Pelacakan Lokasi Insiden:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menampilkan peta interaktif seluruh kawasan resor pada dasbor kendali sentral guna memetakan titik koordinat insiden secara presisi, memudahkan tim penyelamat dan staf medis darurat mencapai lokasi dengan rute tercepat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Koordinasi Lintas Divisi & Penyelamatan Terpadu:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyediakan kanal komunikasi instan yang menyinkronkan tindakan antara petugas keamanan, tim pertolongan pertama, pemadam kebakaran lokal, dan manajemen resor tanpa memicu kepanikan berlebih pada tamu lainnya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan sistem keselamatan dan tanggap darurat cerdas ini, pengelola resor dan jaringan perhotelan dapat menekan risiko insiden fatal di area wisata, menjaga standar keselamatan bertaraf internasional, serta menghadirkan pengalaman liburan yang tenang, nyaman, dan bebas dari rasa khawatir bagi setiap tamu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (47, 'Pemantauan Energi & Lingkungan Rumah Sakit', 'pemantauan-energi-lingkungan-rumah-sakit', '2026-09-30T07:22:39.007Z', 'Solusi pemantauan berbasis IoT dan analitik cerdas untuk menjaga stabilitas suhu, kualitas udara, dan penggunaan energi di area kritis rumah sakit secara real-time.', 237, '2026-10-01T06:36:02.615Z', '2026-09-30T07:22:39.007Z', 12, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di fasilitas pelayanan kesehatan modern, menjaga kondisi lingkungan yang stabil bukan hanya soal efisiensi operasional, melainkan faktor krusial yang berdampak langsung pada keselamatan pasien dan kepatuhan regulasi medis. Rumah sakit sering kali menghadapi tantangan pemborosan konsumsi listrik serta risiko fluktuasi suhu atau kualitas udara di area sensitif. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pemantauan Energi & Lingkungan Rumah Sakit","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir untuk memberikan visibilitas menyeluruh terhadap parameter lingkungan dan penggunaan daya secara real-time di seluruh fasilitas, termasuk ruang ICU, ruang operasi, laboratorium, hingga ruang rawat inap.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Pemantauan Parameter Kritis & Notifikasi Otomatis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memanfaatkan sensor IoT dan sistem pengelolaan gedung untuk melacak suhu, kelembapan, kualitas udara, serta konsumsi listrik secara kontinu, dengan peringatan instan saat terjadi deviasi kondisi optimal.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Optimasi Energi & Keberlanjutan Lingkungan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menganalisis pola penggunaan daya pada sistem HVAC (AC/ventilasi), pencahayaan, dan perangkat medis kritis untuk menekan biaya operasional tanpa mengorbankan standar keselamatan pasien.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Perawatan Prediktif & Keandalan Fasilitas:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengidentifikasi indikasi gangguan performa peralatan lebih awal guna mencegah terjadinya kelumpuhan sistem (downtime) pada area berisiko tinggi (high-dependency areas).","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Melalui integrasi data lingkungan dan energi yang akurat ini, manajemen rumah sakit dapat menjamin keselamatan pasien, meningkatkan ketahanan operasional fasilitas kesehatan, serta mewujudkan tata kelola rumah sakit yang ramah lingkungan dan berbasis data.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (100, 'Pusat Operasional & Pengalaman Tamu Terpadu Perhotelan', 'pusat-operasional-pengalaman-tamu-terpadu-perhotelan', '2026-10-01T02:51:25.579Z', 'Platform kendali sentral terintegrasi berbasis PMS dan IoT untuk menyelaraskan operasional hotel, mempercepat pemenuhan layanan kamar, serta memaksimalkan kepuasan tamu secara real-time.', NULL, '2026-10-01T02:51:44.016Z', '2026-10-01T02:51:25.579Z', 17, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di industri perhotelan dan pariwisata yang bertumpu pada keunggulan layanan, koordinasi antar-divisi yang lambat kerap menjadi penghambat utama dalam menghadirkan pengalaman menginap yang istimewa. Tata kelola operasional yang terpisah—mulai dari resepsionis (front office), tata graha (housekeeping), pemeliharaan fasilitas (engineering), hingga restoran—sering memicu penundaan kesiapan kamar saat check-in, respons permintaan tamu yang lamban, serta inefisiensi alokasi staf di jam sibuk. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Komando Operasional & Pengalaman Tamu Terpadu Perhotelan (Hospitality Command Center)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir menyatukan sistem manajemen properti (PMS), otomatisasi kamar berbasis IoT, platform umpan balik tamu, dan sistem perawatan gedung ke dalam satu pusat kendali yang cerdas dan terpantau langsung.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Visibilitas Operasional Properti Menyeluruh:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengonsolidasikan status keterisian kamar (occupancy), kesiapan kebersihan kamar, antrean tiket perawatan teknis, dan arus pengunjung restoran ke dalam satu dasbor terpusat yang informatif dan dinamis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Orkestrasi Alur Kerja & Tanggap Permintaan Otomatis:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengubah permintaan atau keluhan tamu menjadi tiket tugas otomatis yang langsung diteruskan ke perangkat seluler staf terkait (seperti tim housekeeping atau teknisi), mempercepat waktu penyelesaian masalah sebelum berdampak pada penilaian tamu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Analitik Preferensi Tamu & Prediksi Kebutuhan Berbasis Data:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menganalisis pola riwayat kunjungan dan kebiasaan tamu guna memfasilitasi personalisasi fasilitas kamar, mengantisipasi lonjakan permintaan layanan, serta mengoptimalkan jadwal giliran kerja (shift) staf perhotelan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan pusat komando operasional perhotelan terintegrasi ini, manajemen hotel dan grup resor dapat memangkas waktu tunggu tamu secara signifikan, meningkatkan produktivitas tim operasional harian, serta memberikan standar pelayanan premium yang konsisten, responsif, dan berkesan bagi setiap pengunjung.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (94, 'Pusat Operasional Kampus Cerdas', 'pusat-operasional-kampus-cerdas', '2026-10-01T02:28:33.815Z', 'Platform kendali operasional kampus berbasis IoT dan analitik data terpusat untuk memantau keamanan, utilisasi fasilitas, serta merespons insiden secara real-time.', NULL, '2026-10-01T02:51:57.794Z', '2026-10-01T02:28:33.815Z', 16, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di lingkungan institusi pendidikan modern yang luas dan padat aktivitas, tata kelola fasilitas, keselamatan, dan sumber daya kampus kerap terhambat oleh sistem operasional yang berjalan secara terpisah (siloed systems). Pengawasan manual yang tidak terintegrasi antara divisi keamanan, manajemen gedung, dan bagian akademik sering kali memperlambat respons penanganan insiden darurat, memicu pemborosan energi listrik, serta mengakibatkan ketidakefisienan pemanfaatan ruang belajar. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Pusat Komando & Operasional Kampus Cerdas Terpadu (Campus Command Center)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir sebagai pusat kendali sentral yang mengonsolidasikan data dari jaringan kamera pengawas, kontrol akses, sensor IoT fasilitas, dan aktivitas akademik ke dalam satu tampilan pemantauan menyeluruh secara real-time.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Visibilitas Operasional & Keamanan Kampus Menyeluruh: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Mengintegrasikan umpan video CCTV, sensor lingkungan, dan detektor pergerakan massa ke dalam dasbor komando interaktif, memungkinkan pengawasan situasi kawasan kampus dari satu ruang kendali utama.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Manajemen Fasilitas & Efisiensi Sumber Daya Berbasis IoT: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Memantau tingkat keterisian ruang kelas, konsumsi daya listrik pendingin udara (AC), dan sistem penerangan secara otomatis, membantu manajemen kampus mengoptimalkan pemanfaatan ruang serta memangkas biaya utilitas.","type":"text","style":"","detail":0,"format":0,"version":1}]},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Koordinasi Lintas Divisi & Tanggap Darurat Terpadu: ","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":"Menghubungkan alur kerja otomatis antara tim keamanan internal, pengelola sarana prasarana, dan pihak administrasi saat terjadi gangguan fasilitas atau kondisi krisis guna mempercepat proses penanganan dan evakuasi.","type":"text","style":"","detail":0,"format":0,"version":1}]}],"listType":"bullet"},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengimplementasikan pusat komando kampus terpadu ini, universitas maupun sekolah berskala besar dapat meningkatkan efisiensi operasional gedung secara signifikan, meminimalkan risiko keamanan, serta menciptakan ekosistem kampus yang aman, cerdas, dan responsif bagi seluruh sivitas akademika dan tamu.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (102, 'Kolaborasi Terpadu & Ekosistem Ruang Kerja Digital Perusahaan', 'kolaborasi-terpadu-ekosistem-ruang-kerja-digital-perusahaan', '2026-10-01T02:54:02.692Z', 'Solusi lingkungan kerja digital terintegrasi berbasis komputasi awan untuk menyatukan komunikasi tim, otomasi alur dokumen, dan kolaborasi hibrida secara aman dari mana saja.', NULL, '2026-10-01T02:54:02.692Z', '2026-10-01T02:54:02.692Z', 18, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di tengah pergeseran pola kerja modern yang makin terdistribusi, koordinasi tim yang terpecah di berbagai aplikasi mandiri sering kali menghambat produktivitas dan memperlambat pengambilan keputusan strategis. Ketiadaan wadah kerja terpadu kerap memicu masalah komunikasi yang terfragmentasi, duplikasi versi dokumen kerja, hingga kebingungan pembagian peran antara karyawan yang bekerja di kantor, dari rumah, maupun di lapangan. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Kolaborasi Terpadu & Ekosistem Ruang Kerja Digital Perusahaan (Unified Collaboration & Digital Workplace)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" hadir mengintegrasikan saluran percakapan instan, konferensi video berkualitas tinggi, manajemen berkas berbasis awan, dan aplikasi bisnis harian ke dalam satu ekosistem digital yang mulus dan terpusat.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Ruang Kerja Digital Multikanal & Fleksibel:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyatukan fitur obrolan tim, panggilan suara/video interaktif, dan kalender bersama ke dalam satu platform yang dapat diakses dengan aman dari perangkat desktop, laptop, maupun gawai seluler tanpa batasan geografis.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Kolaborasi Dokumen Real-Time & Otomasi Alur Persetujuan:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memungkinkan pengerjaan dan penyuntingan dokumen secara bersamaan oleh banyak pengguna secara langsung, didukung sistem otomatisasi penugasan dan alur persetujuan (approval) dokumen untuk memangkas birokrasi operasional.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Tata Kelola Keamanan Data & Dasbor Produktivitas:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengamankan akses data perusahaan melalui autentikasi identitas terpusat serta enkripsi tingkat korporasi, sembari menyajikan metrik keterlibatan dan performa kolaborasi tim pada dasbor analitik manajemen.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan mengadopsi platform kolaborasi terpadu dan ruang kerja digital ini, organisasi dapat memangkas gesekan koordinasi internal, mempercepat siklus penyelesaian proyek lintas divisi, serta menciptakan lingkungan kerja modern yang lincah, adaptif, dan siap berkembang di era digital.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb),
  (104, 'Arsitektur Jaringan Keamanan Berbasis Zero Trust Terintegrasi', 'arsitektur-jaringan-keamanan-berbasis-zero-trust-terintegrasi', '2026-10-01T02:55:22.855Z', 'Solusi pertahanan keamanan siber adaptif tanpa celah berbasis verifikasi identitas berkelanjutan, segmentasi mikro, dan kontrol akses ketat untuk melindungi infrastruktur hibrida perusahaan.', NULL, '2026-10-01T02:55:22.855Z', '2026-10-01T02:55:22.855Z', 18, '{"root":{"type":"root","format":"","indent":0,"version":1,"children":[{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Di era digitalisasi dan adopsi komputasi awan yang kian terdistribusi, model pertahanan jaringan perimeter konvensional—yang menganggap semua lalu lintas internal aman secara otomatis—tidak lagi memadai untuk menahan laju serangan siber mutakhir. Akses kerja jarak jauh, integrasi perangkat pribadi (BYOD), dan aplikasi lintas lingkungan awan memperlebar celah peretasan yang memungkinkan penyerang bergerak bebas antarsistem (lateral movement) setelah berhasil menembus lapisan luar. Solusi ","type":"text","style":"","detail":0,"format":0,"version":1},{"mode":"normal","text":"Arsitektur Jaringan Keamanan Berbasis Zero Trust Terintegrasi (Zero Trust Network Architecture)","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" mendefinisikan ulang paradigma keamanan melalui prinsip fundamental: tidak memercayai siapa pun secara default, selalu memverifikasi setiap upaya akses, dan hanya memberikan hak akses minimum (least privilege).","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0},{"tag":"ul","type":"list","start":1,"format":"","indent":0,"version":1,"children":[{"type":"listitem","value":1,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Verifikasi Akses Berkelanjutan & Manajemen Identitas Adaptif:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Memvalidasi setiap permintaan akses secara berkesinambungan melalui kombinasi autentikasi multi-faktor (MFA), postur kesehatan perangkat (endpoint posture), dan analisis profil risiko kontekstual sebelum izin diberikan.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":2,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Mikrosegmentasi Jaringan & Pencegahan Pergerakan Lateral:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Mengisolasi beban kerja (workloads) dan aplikasi ke dalam segmen-segmen jaringan virtual tertutup, memastikan bahwa kompromi pada satu perangkat tidak dapat dimanfaatkan untuk menyusup ke aset data sensitif lainnya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null},{"type":"listitem","value":3,"format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Visibilitas Terpusat & Mitigasi Ancaman Real-Time:","type":"text","style":"","detail":0,"format":1,"version":1},{"mode":"normal","text":" Menyajikan catatan aktivitas lalu lintas pengguna dan anomali jaringan pada dasbor kendali terpadu, memungkinkan tim keamanan merespons serta mencabut izin akses secara otomatis dan seketika saat terdeteksi indikasi bahaya.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null}],"listType":"bullet","direction":null},{"type":"paragraph","format":"","indent":0,"version":1,"children":[{"mode":"normal","text":"Dengan menerapkan arsitektur jaringan berbasis Zero Trust ini, organisasi dapat meminimalkan permukaan serangan siber secara drastis, menjamin keamanan operasional kerja dari mana saja tanpa rasa waswas, serta membangun fondasi transformasi digital yang tangguh, aman, dan patuh regulasi.","type":"text","style":"","detail":0,"format":0,"version":1}],"direction":null,"textStyle":"","textFormat":0}],"direction":null}}'::jsonb);

-- Data untuk tabel: "solutions_rels" (2531 rows)
TRUNCATE TABLE "solutions_rels" CASCADE;
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (4786, 1, 16, 'solutionCategories', 14, NULL),
  (4787, 2, 16, 'solutionCategories', 27, NULL),
  (4788, 3, 16, 'solutionCategories', 28, NULL),
  (4789, 1, 16, 'partnership_solution', NULL, 20),
  (4790, 2, 16, 'partnership_solution', NULL, 88),
  (4791, 3, 16, 'partnership_solution', NULL, 86),
  (4792, 4, 16, 'partnership_solution', NULL, 27),
  (4793, 5, 16, 'partnership_solution', NULL, 11),
  (4794, 6, 16, 'partnership_solution', NULL, 87),
  (4795, 7, 16, 'partnership_solution', NULL, 25),
  (4796, 8, 16, 'partnership_solution', NULL, 22),
  (4797, 9, 16, 'partnership_solution', NULL, 89),
  (4798, 10, 16, 'partnership_solution', NULL, 83),
  (4799, 11, 16, 'partnership_solution', NULL, 16),
  (4800, 12, 16, 'partnership_solution', NULL, 36),
  (4801, 13, 16, 'partnership_solution', NULL, 50),
  (4802, 14, 16, 'partnership_solution', NULL, 14),
  (4803, 15, 16, 'partnership_solution', NULL, 39),
  (4804, 16, 16, 'partnership_solution', NULL, 92),
  (4805, 17, 16, 'partnership_solution', NULL, 54),
  (4806, 18, 16, 'partnership_solution', NULL, 37),
  (4807, 19, 16, 'partnership_solution', NULL, 17),
  (4808, 20, 16, 'partnership_solution', NULL, 31),
  (4809, 21, 16, 'partnership_solution', NULL, 48),
  (4810, 22, 16, 'partnership_solution', NULL, 51),
  (4811, 23, 16, 'partnership_solution', NULL, 38),
  (4812, 24, 16, 'partnership_solution', NULL, 84),
  (4813, 25, 16, 'partnership_solution', NULL, 52),
  (4814, 26, 16, 'partnership_solution', NULL, 33),
  (4815, 27, 16, 'partnership_solution', NULL, 91),
  (4816, 28, 16, 'partnership_solution', NULL, 9),
  (4817, 29, 16, 'partnership_solution', NULL, 29),
  (4818, 30, 16, 'partnership_solution', NULL, 85),
  (4819, 31, 16, 'partnership_solution', NULL, 90),
  (5028, 1, 84, 'solutionCategories', 14, NULL),
  (5029, 2, 84, 'solutionCategories', 16, NULL),
  (5030, 3, 84, 'solutionCategories', 27, NULL),
  (5031, 1, 84, 'partnership_solution', NULL, 9),
  (5032, 2, 84, 'partnership_solution', NULL, 11),
  (5033, 3, 84, 'partnership_solution', NULL, 14),
  (5034, 4, 84, 'partnership_solution', NULL, 16),
  (5035, 5, 84, 'partnership_solution', NULL, 17),
  (5036, 6, 84, 'partnership_solution', NULL, 20),
  (5037, 7, 84, 'partnership_solution', NULL, 22),
  (5038, 8, 84, 'partnership_solution', NULL, 25),
  (5039, 9, 84, 'partnership_solution', NULL, 27),
  (5040, 10, 84, 'partnership_solution', NULL, 28),
  (5041, 11, 84, 'partnership_solution', NULL, 29),
  (5042, 12, 84, 'partnership_solution', NULL, 31),
  (5043, 13, 84, 'partnership_solution', NULL, 33),
  (5044, 14, 84, 'partnership_solution', NULL, 36),
  (5045, 15, 84, 'partnership_solution', NULL, 37),
  (5046, 16, 84, 'partnership_solution', NULL, 38),
  (5047, 17, 84, 'partnership_solution', NULL, 39),
  (5048, 18, 84, 'partnership_solution', NULL, 48),
  (5049, 19, 84, 'partnership_solution', NULL, 50),
  (5050, 20, 84, 'partnership_solution', NULL, 51),
  (5051, 21, 84, 'partnership_solution', NULL, 52),
  (5052, 22, 84, 'partnership_solution', NULL, 54),
  (5053, 23, 84, 'partnership_solution', NULL, 83),
  (5054, 24, 84, 'partnership_solution', NULL, 84),
  (5055, 25, 84, 'partnership_solution', NULL, 85),
  (5056, 26, 84, 'partnership_solution', NULL, 86),
  (5057, 27, 84, 'partnership_solution', NULL, 87),
  (5219, 1, 89, 'solutionCategories', 15, NULL),
  (5220, 2, 89, 'solutionCategories', 18, NULL),
  (5221, 3, 89, 'solutionCategories', 30, NULL),
  (5222, 1, 89, 'partnership_solution', NULL, 10),
  (5223, 2, 89, 'partnership_solution', NULL, 11),
  (5224, 3, 89, 'partnership_solution', NULL, 20),
  (5225, 4, 89, 'partnership_solution', NULL, 22),
  (5226, 5, 89, 'partnership_solution', NULL, 24),
  (5227, 6, 89, 'partnership_solution', NULL, 27),
  (6797, 1, 45, 'solutionCategories', 12, NULL),
  (6798, 2, 45, 'solutionCategories', 30, NULL),
  (6799, 3, 45, 'solutionCategories', 13, NULL),
  (6800, 4, 45, 'solutionCategories', 14, NULL),
  (6801, 1, 45, 'partnership_solution', NULL, 20),
  (6802, 2, 45, 'partnership_solution', NULL, 26),
  (6803, 3, 45, 'partnership_solution', NULL, 39),
  (6804, 4, 45, 'partnership_solution', NULL, 40),
  (6805, 5, 45, 'partnership_solution', NULL, 28),
  (6806, 6, 45, 'partnership_solution', NULL, 51),
  (6807, 7, 45, 'partnership_solution', NULL, 48),
  (6808, 8, 45, 'partnership_solution', NULL, 27),
  (6809, 9, 45, 'partnership_solution', NULL, 102),
  (6810, 10, 45, 'partnership_solution', NULL, 22),
  (6811, 11, 45, 'partnership_solution', NULL, 103),
  (6812, 12, 45, 'partnership_solution', NULL, 104),
  (6813, 13, 45, 'partnership_solution', NULL, 54),
  (6814, 14, 45, 'partnership_solution', NULL, 105),
  (6815, 15, 45, 'partnership_solution', NULL, 106),
  (6816, 16, 45, 'partnership_solution', NULL, 107),
  (6817, 17, 45, 'partnership_solution', NULL, 56),
  (6818, 18, 45, 'partnership_solution', NULL, 108),
  (6819, 19, 45, 'partnership_solution', NULL, 109),
  (6820, 20, 45, 'partnership_solution', NULL, 110),
  (6821, 21, 45, 'partnership_solution', NULL, 23),
  (6822, 22, 45, 'partnership_solution', NULL, 12),
  (6823, 23, 45, 'partnership_solution', NULL, 11);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6824, 24, 45, 'partnership_solution', NULL, 44),
  (6825, 25, 45, 'partnership_solution', NULL, 19),
  (6826, 26, 45, 'partnership_solution', NULL, 43),
  (6827, 27, 45, 'partnership_solution', NULL, 16),
  (6828, 28, 45, 'partnership_solution', NULL, 34),
  (6829, 29, 45, 'partnership_solution', NULL, 14),
  (6830, 30, 45, 'partnership_solution', NULL, 46),
  (5058, 1, 85, 'solutionCategories', 13, NULL),
  (5059, 2, 85, 'solutionCategories', 16, NULL),
  (5060, 3, 85, 'solutionCategories', 18, NULL),
  (5061, 4, 85, 'solutionCategories', 30, NULL),
  (5062, 1, 85, 'partnership_solution', NULL, 7),
  (5063, 2, 85, 'partnership_solution', NULL, 8),
  (5064, 3, 85, 'partnership_solution', NULL, 11),
  (5065, 4, 85, 'partnership_solution', NULL, 12),
  (5066, 5, 85, 'partnership_solution', NULL, 13),
  (5067, 6, 85, 'partnership_solution', NULL, 14),
  (5068, 7, 85, 'partnership_solution', NULL, 15),
  (5069, 8, 85, 'partnership_solution', NULL, 16),
  (5070, 9, 85, 'partnership_solution', NULL, 18),
  (5071, 10, 85, 'partnership_solution', NULL, 19),
  (5072, 11, 85, 'partnership_solution', NULL, 20),
  (5073, 12, 85, 'partnership_solution', NULL, 21),
  (5074, 13, 85, 'partnership_solution', NULL, 22),
  (5075, 14, 85, 'partnership_solution', NULL, 23),
  (5076, 15, 85, 'partnership_solution', NULL, 24),
  (5077, 16, 85, 'partnership_solution', NULL, 25),
  (5078, 17, 85, 'partnership_solution', NULL, 27),
  (5079, 18, 85, 'partnership_solution', NULL, 28),
  (5080, 19, 85, 'partnership_solution', NULL, 30),
  (5081, 20, 85, 'partnership_solution', NULL, 32),
  (5082, 21, 85, 'partnership_solution', NULL, 34),
  (5083, 22, 85, 'partnership_solution', NULL, 35),
  (5084, 23, 85, 'partnership_solution', NULL, 39),
  (5085, 24, 85, 'partnership_solution', NULL, 41),
  (5086, 25, 85, 'partnership_solution', NULL, 43),
  (5087, 26, 85, 'partnership_solution', NULL, 44),
  (5088, 27, 85, 'partnership_solution', NULL, 46),
  (5089, 28, 85, 'partnership_solution', NULL, 47),
  (5090, 29, 85, 'partnership_solution', NULL, 48),
  (5091, 30, 85, 'partnership_solution', NULL, 49),
  (5092, 31, 85, 'partnership_solution', NULL, 51),
  (5093, 32, 85, 'partnership_solution', NULL, 52),
  (5094, 33, 85, 'partnership_solution', NULL, 53),
  (6831, 31, 45, 'partnership_solution', NULL, 32),
  (6832, 32, 45, 'partnership_solution', NULL, 53),
  (6833, 33, 45, 'partnership_solution', NULL, 15),
  (6834, 34, 45, 'partnership_solution', NULL, 24),
  (6835, 35, 45, 'partnership_solution', NULL, 13),
  (6836, 36, 45, 'partnership_solution', NULL, 35),
  (6837, 37, 45, 'partnership_solution', NULL, 49),
  (6838, 38, 45, 'partnership_solution', NULL, 25),
  (6839, 39, 45, 'partnership_solution', NULL, 8),
  (6840, 40, 45, 'partnership_solution', NULL, 18),
  (6841, 41, 45, 'partnership_solution', NULL, 7),
  (6842, 42, 45, 'partnership_solution', NULL, 30),
  (6843, 43, 45, 'partnership_solution', NULL, 47),
  (6844, 44, 45, 'partnership_solution', NULL, 41),
  (6845, 45, 45, 'partnership_solution', NULL, 52),
  (6846, 46, 45, 'partnership_solution', NULL, 21),
  (6847, 47, 45, 'partnership_solution', NULL, 36),
  (6848, 48, 45, 'partnership_solution', NULL, 50),
  (6849, 49, 45, 'partnership_solution', NULL, 37),
  (6850, 50, 45, 'partnership_solution', NULL, 31),
  (6851, 51, 45, 'partnership_solution', NULL, 38),
  (6852, 52, 45, 'partnership_solution', NULL, 33),
  (6853, 53, 45, 'partnership_solution', NULL, 9),
  (6854, 54, 45, 'partnership_solution', NULL, 29),
  (6855, 55, 45, 'partnership_solution', NULL, 17),
  (7276, 14, 67, 'partnership_solution', NULL, 19),
  (7277, 15, 67, 'partnership_solution', NULL, 43),
  (7278, 16, 67, 'partnership_solution', NULL, 16),
  (7279, 17, 67, 'partnership_solution', NULL, 34),
  (5095, 34, 85, 'partnership_solution', NULL, 54),
  (5096, 35, 85, 'partnership_solution', NULL, 56),
  (5097, 36, 85, 'partnership_solution', NULL, 58),
  (5098, 37, 85, 'partnership_solution', NULL, 102),
  (5099, 38, 85, 'partnership_solution', NULL, 103),
  (5100, 39, 85, 'partnership_solution', NULL, 104),
  (5101, 40, 85, 'partnership_solution', NULL, 105),
  (5102, 41, 85, 'partnership_solution', NULL, 106),
  (5103, 42, 85, 'partnership_solution', NULL, 107),
  (5104, 43, 85, 'partnership_solution', NULL, 108),
  (5105, 44, 85, 'partnership_solution', NULL, 109),
  (5106, 45, 85, 'partnership_solution', NULL, 110),
  (5228, 7, 89, 'partnership_solution', NULL, 28),
  (5229, 8, 89, 'partnership_solution', NULL, 42),
  (5230, 9, 89, 'partnership_solution', NULL, 45),
  (5231, 10, 89, 'partnership_solution', NULL, 53),
  (5232, 11, 89, 'partnership_solution', NULL, 54),
  (5233, 12, 89, 'partnership_solution', NULL, 55),
  (5234, 13, 89, 'partnership_solution', NULL, 56),
  (5235, 14, 89, 'partnership_solution', NULL, 58),
  (5236, 15, 89, 'partnership_solution', NULL, 102),
  (5237, 16, 89, 'partnership_solution', NULL, 103),
  (5238, 17, 89, 'partnership_solution', NULL, 104),
  (5239, 18, 89, 'partnership_solution', NULL, 105),
  (5240, 19, 89, 'partnership_solution', NULL, 106),
  (5241, 20, 89, 'partnership_solution', NULL, 107),
  (5242, 21, 89, 'partnership_solution', NULL, 108);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (5243, 22, 89, 'partnership_solution', NULL, 109),
  (5244, 23, 89, 'partnership_solution', NULL, 110),
  (5107, 1, 86, 'solutionCategories', 12, NULL),
  (5108, 2, 86, 'solutionCategories', 18, NULL),
  (5109, 3, 86, 'solutionCategories', 32, NULL),
  (6856, 1, 47, 'solutionCategories', 12, NULL),
  (6857, 2, 47, 'solutionCategories', 28, NULL),
  (6858, 3, 47, 'solutionCategories', 18, NULL),
  (6859, 4, 47, 'solutionCategories', 14, NULL),
  (6860, 1, 47, 'partnership_solution', NULL, 20),
  (6861, 2, 47, 'partnership_solution', NULL, 26),
  (6862, 3, 47, 'partnership_solution', NULL, 39),
  (6863, 4, 47, 'partnership_solution', NULL, 40),
  (7418, 1, 81, 'solutionCategories', 13, NULL),
  (7419, 2, 81, 'solutionCategories', 14, NULL),
  (7420, 3, 81, 'solutionCategories', 18, NULL),
  (7421, 1, 81, 'partnership_solution', NULL, 7),
  (7422, 2, 81, 'partnership_solution', NULL, 8),
  (7423, 3, 81, 'partnership_solution', NULL, 9),
  (7424, 4, 81, 'partnership_solution', NULL, 11),
  (7425, 5, 81, 'partnership_solution', NULL, 12),
  (7426, 6, 81, 'partnership_solution', NULL, 13),
  (7427, 7, 81, 'partnership_solution', NULL, 14),
  (7428, 8, 81, 'partnership_solution', NULL, 15),
  (7429, 9, 81, 'partnership_solution', NULL, 16),
  (7430, 10, 81, 'partnership_solution', NULL, 17),
  (5110, 1, 86, 'partnership_solution', NULL, 11),
  (5111, 2, 86, 'partnership_solution', NULL, 20),
  (5112, 3, 86, 'partnership_solution', NULL, 22),
  (5113, 4, 86, 'partnership_solution', NULL, 24),
  (5114, 5, 86, 'partnership_solution', NULL, 26),
  (5115, 6, 86, 'partnership_solution', NULL, 28),
  (5116, 7, 86, 'partnership_solution', NULL, 39),
  (5117, 8, 86, 'partnership_solution', NULL, 40),
  (5118, 9, 86, 'partnership_solution', NULL, 44),
  (5119, 10, 86, 'partnership_solution', NULL, 48),
  (5120, 11, 86, 'partnership_solution', NULL, 51),
  (5121, 12, 86, 'partnership_solution', NULL, 58),
  (5122, 13, 86, 'partnership_solution', NULL, 85),
  (5123, 14, 86, 'partnership_solution', NULL, 118),
  (5124, 15, 86, 'partnership_solution', NULL, 119),
  (5125, 16, 86, 'partnership_solution', NULL, 120),
  (5126, 17, 86, 'partnership_solution', NULL, 121),
  (5127, 18, 86, 'partnership_solution', NULL, 122),
  (5128, 19, 86, 'partnership_solution', NULL, 123),
  (5129, 20, 86, 'partnership_solution', NULL, 124),
  (5245, 1, 90, 'solutionCategories', 12, NULL),
  (5246, 2, 90, 'solutionCategories', 13, NULL),
  (5247, 3, 90, 'solutionCategories', 14, NULL),
  (5248, 4, 90, 'solutionCategories', 15, NULL),
  (5249, 1, 90, 'partnership_solution', NULL, 7),
  (5250, 2, 90, 'partnership_solution', NULL, 8),
  (5251, 3, 90, 'partnership_solution', NULL, 9),
  (5252, 4, 90, 'partnership_solution', NULL, 10),
  (7431, 11, 81, 'partnership_solution', NULL, 18),
  (7432, 12, 81, 'partnership_solution', NULL, 19),
  (7433, 13, 81, 'partnership_solution', NULL, 20),
  (7434, 14, 81, 'partnership_solution', NULL, 21),
  (7435, 15, 81, 'partnership_solution', NULL, 22),
  (7436, 16, 81, 'partnership_solution', NULL, 23),
  (7437, 17, 81, 'partnership_solution', NULL, 24),
  (7438, 18, 81, 'partnership_solution', NULL, 25),
  (7439, 19, 81, 'partnership_solution', NULL, 27),
  (7440, 20, 81, 'partnership_solution', NULL, 28),
  (7441, 21, 81, 'partnership_solution', NULL, 29),
  (7442, 22, 81, 'partnership_solution', NULL, 30),
  (6864, 5, 47, 'partnership_solution', NULL, 28),
  (6865, 6, 47, 'partnership_solution', NULL, 51),
  (6866, 7, 47, 'partnership_solution', NULL, 48),
  (6867, 8, 47, 'partnership_solution', NULL, 88),
  (6868, 9, 47, 'partnership_solution', NULL, 22),
  (6869, 10, 47, 'partnership_solution', NULL, 89),
  (6870, 11, 47, 'partnership_solution', NULL, 50),
  (6871, 12, 47, 'partnership_solution', NULL, 90),
  (6872, 13, 47, 'partnership_solution', NULL, 91),
  (6873, 14, 47, 'partnership_solution', NULL, 92),
  (6874, 15, 47, 'partnership_solution', NULL, 58),
  (6875, 16, 47, 'partnership_solution', NULL, 24),
  (6876, 17, 47, 'partnership_solution', NULL, 27),
  (6877, 18, 47, 'partnership_solution', NULL, 11),
  (6878, 19, 47, 'partnership_solution', NULL, 36),
  (6879, 20, 47, 'partnership_solution', NULL, 14),
  (6880, 21, 47, 'partnership_solution', NULL, 54),
  (6881, 22, 47, 'partnership_solution', NULL, 37),
  (6882, 23, 47, 'partnership_solution', NULL, 31),
  (6883, 24, 47, 'partnership_solution', NULL, 38),
  (6884, 25, 47, 'partnership_solution', NULL, 33),
  (6885, 26, 47, 'partnership_solution', NULL, 9),
  (6886, 27, 47, 'partnership_solution', NULL, 29),
  (6887, 28, 47, 'partnership_solution', NULL, 52),
  (6888, 29, 47, 'partnership_solution', NULL, 17),
  (7280, 18, 67, 'partnership_solution', NULL, 14),
  (7281, 19, 67, 'partnership_solution', NULL, 46),
  (6213, 1, 108, 'solutionCategories', 12, NULL),
  (6214, 2, 108, 'solutionCategories', 14, NULL),
  (6215, 3, 108, 'solutionCategories', 16, NULL),
  (6216, 1, 108, 'partnership_solution', NULL, 9),
  (6217, 2, 108, 'partnership_solution', NULL, 11),
  (6218, 3, 108, 'partnership_solution', NULL, 14),
  (6219, 4, 108, 'partnership_solution', NULL, 17);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6220, 5, 108, 'partnership_solution', NULL, 20),
  (6221, 6, 108, 'partnership_solution', NULL, 22),
  (6222, 7, 108, 'partnership_solution', NULL, 26),
  (6223, 8, 108, 'partnership_solution', NULL, 27),
  (6224, 9, 108, 'partnership_solution', NULL, 28),
  (6225, 10, 108, 'partnership_solution', NULL, 29),
  (6226, 11, 108, 'partnership_solution', NULL, 31),
  (6227, 12, 108, 'partnership_solution', NULL, 33),
  (6228, 13, 108, 'partnership_solution', NULL, 36),
  (6229, 14, 108, 'partnership_solution', NULL, 37),
  (6230, 15, 108, 'partnership_solution', NULL, 38),
  (6231, 16, 108, 'partnership_solution', NULL, 39),
  (6232, 17, 108, 'partnership_solution', NULL, 40),
  (6233, 18, 108, 'partnership_solution', NULL, 48),
  (6234, 19, 108, 'partnership_solution', NULL, 50),
  (6235, 20, 108, 'partnership_solution', NULL, 51),
  (6236, 21, 108, 'partnership_solution', NULL, 52),
  (6237, 22, 108, 'partnership_solution', NULL, 54),
  (6650, 1, 35, 'solutionCategories', 12, NULL),
  (6651, 2, 35, 'solutionCategories', 18, NULL),
  (6652, 3, 35, 'solutionCategories', 14, NULL),
  (6653, 1, 35, 'partnership_solution', NULL, 20),
  (6654, 2, 35, 'partnership_solution', NULL, 26),
  (6655, 3, 35, 'partnership_solution', NULL, 39),
  (6656, 4, 35, 'partnership_solution', NULL, 40),
  (6657, 5, 35, 'partnership_solution', NULL, 28),
  (6658, 6, 35, 'partnership_solution', NULL, 51),
  (6659, 7, 35, 'partnership_solution', NULL, 48),
  (6660, 8, 35, 'partnership_solution', NULL, 58),
  (6661, 9, 35, 'partnership_solution', NULL, 24),
  (6662, 10, 35, 'partnership_solution', NULL, 27),
  (6663, 11, 35, 'partnership_solution', NULL, 11),
  (6664, 12, 35, 'partnership_solution', NULL, 22),
  (6665, 13, 35, 'partnership_solution', NULL, 36),
  (6666, 14, 35, 'partnership_solution', NULL, 50),
  (6667, 15, 35, 'partnership_solution', NULL, 14),
  (6668, 16, 35, 'partnership_solution', NULL, 54),
  (6669, 17, 35, 'partnership_solution', NULL, 37),
  (6670, 18, 35, 'partnership_solution', NULL, 31),
  (6671, 19, 35, 'partnership_solution', NULL, 38),
  (5130, 1, 87, 'solutionCategories', 13, NULL),
  (5131, 2, 87, 'solutionCategories', 15, NULL),
  (5132, 3, 87, 'solutionCategories', 23, NULL),
  (5133, 1, 87, 'partnership_solution', NULL, 7),
  (5134, 2, 87, 'partnership_solution', NULL, 8),
  (5135, 3, 87, 'partnership_solution', NULL, 10),
  (5136, 4, 87, 'partnership_solution', NULL, 11),
  (5137, 5, 87, 'partnership_solution', NULL, 12),
  (5138, 6, 87, 'partnership_solution', NULL, 13),
  (5139, 7, 87, 'partnership_solution', NULL, 14),
  (5140, 8, 87, 'partnership_solution', NULL, 15),
  (5141, 9, 87, 'partnership_solution', NULL, 16),
  (5142, 10, 87, 'partnership_solution', NULL, 18),
  (5143, 11, 87, 'partnership_solution', NULL, 19),
  (5144, 12, 87, 'partnership_solution', NULL, 20),
  (5145, 13, 87, 'partnership_solution', NULL, 21),
  (5146, 14, 87, 'partnership_solution', NULL, 22),
  (5147, 15, 87, 'partnership_solution', NULL, 23),
  (5148, 16, 87, 'partnership_solution', NULL, 24),
  (5149, 17, 87, 'partnership_solution', NULL, 25),
  (5150, 18, 87, 'partnership_solution', NULL, 27),
  (5151, 19, 87, 'partnership_solution', NULL, 30),
  (5152, 20, 87, 'partnership_solution', NULL, 32),
  (5153, 21, 87, 'partnership_solution', NULL, 34),
  (5154, 22, 87, 'partnership_solution', NULL, 35),
  (5155, 23, 87, 'partnership_solution', NULL, 39),
  (5156, 24, 87, 'partnership_solution', NULL, 41),
  (5157, 25, 87, 'partnership_solution', NULL, 42),
  (5158, 26, 87, 'partnership_solution', NULL, 43),
  (5159, 27, 87, 'partnership_solution', NULL, 44),
  (5160, 28, 87, 'partnership_solution', NULL, 45),
  (5161, 29, 87, 'partnership_solution', NULL, 46),
  (5162, 30, 87, 'partnership_solution', NULL, 47),
  (6238, 1, 106, 'solutionCategories', 14, NULL),
  (6239, 2, 106, 'solutionCategories', 16, NULL),
  (6240, 3, 106, 'solutionCategories', 27, NULL),
  (6241, 1, 106, 'partnership_solution', NULL, 9),
  (6242, 2, 106, 'partnership_solution', NULL, 11),
  (6243, 3, 106, 'partnership_solution', NULL, 14),
  (6244, 4, 106, 'partnership_solution', NULL, 16),
  (6245, 5, 106, 'partnership_solution', NULL, 17),
  (6246, 6, 106, 'partnership_solution', NULL, 20),
  (6247, 7, 106, 'partnership_solution', NULL, 22),
  (6248, 8, 106, 'partnership_solution', NULL, 25),
  (6249, 9, 106, 'partnership_solution', NULL, 27),
  (6250, 10, 106, 'partnership_solution', NULL, 28),
  (6251, 11, 106, 'partnership_solution', NULL, 29),
  (6252, 12, 106, 'partnership_solution', NULL, 31),
  (6253, 13, 106, 'partnership_solution', NULL, 33),
  (6254, 14, 106, 'partnership_solution', NULL, 36),
  (6255, 15, 106, 'partnership_solution', NULL, 37),
  (6256, 16, 106, 'partnership_solution', NULL, 38),
  (6257, 17, 106, 'partnership_solution', NULL, 39),
  (6258, 18, 106, 'partnership_solution', NULL, 48),
  (6259, 19, 106, 'partnership_solution', NULL, 50),
  (6260, 20, 106, 'partnership_solution', NULL, 51),
  (6261, 21, 106, 'partnership_solution', NULL, 52),
  (6262, 22, 106, 'partnership_solution', NULL, 54),
  (6263, 23, 106, 'partnership_solution', NULL, 83),
  (6264, 24, 106, 'partnership_solution', NULL, 84);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6265, 25, 106, 'partnership_solution', NULL, 85),
  (6266, 26, 106, 'partnership_solution', NULL, 86),
  (6267, 27, 106, 'partnership_solution', NULL, 87),
  (6672, 20, 35, 'partnership_solution', NULL, 33),
  (6673, 21, 35, 'partnership_solution', NULL, 9),
  (6674, 22, 35, 'partnership_solution', NULL, 29),
  (6675, 23, 35, 'partnership_solution', NULL, 52),
  (6676, 24, 35, 'partnership_solution', NULL, 17),
  (6889, 1, 49, 'solutionCategories', 13, NULL),
  (6890, 2, 49, 'solutionCategories', 12, NULL),
  (6891, 3, 49, 'solutionCategories', 18, NULL),
  (6892, 4, 49, 'solutionCategories', 16, NULL),
  (6893, 1, 49, 'partnership_solution', NULL, 23),
  (6894, 2, 49, 'partnership_solution', NULL, 12),
  (6895, 3, 49, 'partnership_solution', NULL, 27),
  (6896, 4, 49, 'partnership_solution', NULL, 11),
  (6897, 5, 49, 'partnership_solution', NULL, 44),
  (6898, 6, 49, 'partnership_solution', NULL, 22),
  (6899, 7, 49, 'partnership_solution', NULL, 19),
  (6900, 8, 49, 'partnership_solution', NULL, 43),
  (5163, 31, 87, 'partnership_solution', NULL, 48),
  (5164, 32, 87, 'partnership_solution', NULL, 49),
  (5165, 33, 87, 'partnership_solution', NULL, 52),
  (5166, 34, 87, 'partnership_solution', NULL, 53),
  (5167, 35, 87, 'partnership_solution', NULL, 55),
  (5168, 36, 87, 'partnership_solution', NULL, 66),
  (5169, 37, 87, 'partnership_solution', NULL, 67),
  (5170, 38, 87, 'partnership_solution', NULL, 68),
  (5253, 5, 90, 'partnership_solution', NULL, 11),
  (5254, 6, 90, 'partnership_solution', NULL, 12),
  (5255, 7, 90, 'partnership_solution', NULL, 13),
  (5256, 8, 90, 'partnership_solution', NULL, 14),
  (5257, 9, 90, 'partnership_solution', NULL, 15),
  (5258, 10, 90, 'partnership_solution', NULL, 16),
  (6901, 9, 49, 'partnership_solution', NULL, 16),
  (6902, 10, 49, 'partnership_solution', NULL, 34),
  (6903, 11, 49, 'partnership_solution', NULL, 14),
  (6904, 12, 49, 'partnership_solution', NULL, 39),
  (6905, 13, 49, 'partnership_solution', NULL, 46),
  (6906, 14, 49, 'partnership_solution', NULL, 32),
  (6907, 15, 49, 'partnership_solution', NULL, 53),
  (6908, 16, 49, 'partnership_solution', NULL, 15),
  (6909, 17, 49, 'partnership_solution', NULL, 24),
  (6910, 18, 49, 'partnership_solution', NULL, 13),
  (6911, 19, 49, 'partnership_solution', NULL, 35),
  (6912, 20, 49, 'partnership_solution', NULL, 49),
  (6913, 21, 49, 'partnership_solution', NULL, 25),
  (6914, 22, 49, 'partnership_solution', NULL, 8),
  (6915, 23, 49, 'partnership_solution', NULL, 18),
  (6916, 24, 49, 'partnership_solution', NULL, 7),
  (6917, 25, 49, 'partnership_solution', NULL, 30),
  (6918, 26, 49, 'partnership_solution', NULL, 47),
  (6919, 27, 49, 'partnership_solution', NULL, 41),
  (6920, 28, 49, 'partnership_solution', NULL, 48),
  (6921, 29, 49, 'partnership_solution', NULL, 52),
  (6922, 30, 49, 'partnership_solution', NULL, 21),
  (6923, 31, 49, 'partnership_solution', NULL, 20),
  (6924, 32, 49, 'partnership_solution', NULL, 26),
  (6925, 33, 49, 'partnership_solution', NULL, 40),
  (6926, 34, 49, 'partnership_solution', NULL, 28),
  (6927, 35, 49, 'partnership_solution', NULL, 51),
  (6928, 36, 49, 'partnership_solution', NULL, 58),
  (7282, 20, 67, 'partnership_solution', NULL, 32),
  (7283, 21, 67, 'partnership_solution', NULL, 53),
  (7284, 22, 67, 'partnership_solution', NULL, 15),
  (7285, 23, 67, 'partnership_solution', NULL, 24),
  (7286, 24, 67, 'partnership_solution', NULL, 13),
  (7287, 25, 67, 'partnership_solution', NULL, 35),
  (7288, 26, 67, 'partnership_solution', NULL, 49),
  (7289, 27, 67, 'partnership_solution', NULL, 25),
  (7290, 28, 67, 'partnership_solution', NULL, 8),
  (5259, 11, 90, 'partnership_solution', NULL, 17),
  (5260, 12, 90, 'partnership_solution', NULL, 18),
  (5261, 13, 90, 'partnership_solution', NULL, 19),
  (5262, 14, 90, 'partnership_solution', NULL, 20),
  (5263, 15, 90, 'partnership_solution', NULL, 21),
  (5264, 16, 90, 'partnership_solution', NULL, 22),
  (5265, 17, 90, 'partnership_solution', NULL, 23),
  (5266, 18, 90, 'partnership_solution', NULL, 24),
  (5267, 19, 90, 'partnership_solution', NULL, 25),
  (6929, 1, 51, 'solutionCategories', 13, NULL),
  (6930, 2, 51, 'solutionCategories', 15, NULL),
  (6931, 3, 51, 'solutionCategories', 14, NULL),
  (6932, 4, 51, 'solutionCategories', 27, NULL),
  (6933, 1, 51, 'partnership_solution', NULL, 23),
  (6934, 2, 51, 'partnership_solution', NULL, 12),
  (6935, 3, 51, 'partnership_solution', NULL, 27),
  (6936, 4, 51, 'partnership_solution', NULL, 11),
  (6937, 5, 51, 'partnership_solution', NULL, 44),
  (6938, 6, 51, 'partnership_solution', NULL, 22),
  (6939, 7, 51, 'partnership_solution', NULL, 19),
  (6940, 8, 51, 'partnership_solution', NULL, 43),
  (6941, 9, 51, 'partnership_solution', NULL, 16),
  (6942, 10, 51, 'partnership_solution', NULL, 34),
  (6943, 11, 51, 'partnership_solution', NULL, 14),
  (6944, 12, 51, 'partnership_solution', NULL, 39),
  (6945, 13, 51, 'partnership_solution', NULL, 46),
  (6946, 14, 51, 'partnership_solution', NULL, 32),
  (6947, 15, 51, 'partnership_solution', NULL, 53),
  (6948, 16, 51, 'partnership_solution', NULL, 15);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6949, 17, 51, 'partnership_solution', NULL, 24),
  (6950, 18, 51, 'partnership_solution', NULL, 13),
  (6951, 19, 51, 'partnership_solution', NULL, 35),
  (6952, 20, 51, 'partnership_solution', NULL, 49),
  (6953, 21, 51, 'partnership_solution', NULL, 25),
  (6954, 22, 51, 'partnership_solution', NULL, 8),
  (6955, 23, 51, 'partnership_solution', NULL, 18),
  (6956, 24, 51, 'partnership_solution', NULL, 7),
  (6957, 25, 51, 'partnership_solution', NULL, 30),
  (6958, 26, 51, 'partnership_solution', NULL, 47),
  (6959, 27, 51, 'partnership_solution', NULL, 41),
  (6960, 28, 51, 'partnership_solution', NULL, 48),
  (6961, 29, 51, 'partnership_solution', NULL, 52),
  (6962, 30, 51, 'partnership_solution', NULL, 21),
  (6963, 31, 51, 'partnership_solution', NULL, 10),
  (6964, 32, 51, 'partnership_solution', NULL, 45),
  (6965, 33, 51, 'partnership_solution', NULL, 42),
  (6966, 34, 51, 'partnership_solution', NULL, 55),
  (6967, 35, 51, 'partnership_solution', NULL, 20),
  (6968, 36, 51, 'partnership_solution', NULL, 36),
  (6969, 37, 51, 'partnership_solution', NULL, 50),
  (6970, 38, 51, 'partnership_solution', NULL, 54),
  (6971, 39, 51, 'partnership_solution', NULL, 37),
  (6972, 40, 51, 'partnership_solution', NULL, 31),
  (6973, 41, 51, 'partnership_solution', NULL, 51),
  (6974, 42, 51, 'partnership_solution', NULL, 38),
  (6975, 43, 51, 'partnership_solution', NULL, 33),
  (6976, 44, 51, 'partnership_solution', NULL, 9),
  (6977, 45, 51, 'partnership_solution', NULL, 29),
  (6978, 46, 51, 'partnership_solution', NULL, 17),
  (6979, 47, 51, 'partnership_solution', NULL, 83),
  (6980, 48, 51, 'partnership_solution', NULL, 84),
  (6981, 49, 51, 'partnership_solution', NULL, 85),
  (6982, 50, 51, 'partnership_solution', NULL, 86),
  (6983, 51, 51, 'partnership_solution', NULL, 87),
  (7291, 29, 67, 'partnership_solution', NULL, 18),
  (7292, 30, 67, 'partnership_solution', NULL, 7),
  (7293, 31, 67, 'partnership_solution', NULL, 30),
  (7294, 32, 67, 'partnership_solution', NULL, 47),
  (7295, 33, 67, 'partnership_solution', NULL, 41),
  (7296, 34, 67, 'partnership_solution', NULL, 52),
  (7297, 35, 67, 'partnership_solution', NULL, 21),
  (7298, 36, 67, 'partnership_solution', NULL, 36),
  (7299, 37, 67, 'partnership_solution', NULL, 50),
  (7300, 38, 67, 'partnership_solution', NULL, 54),
  (7301, 39, 67, 'partnership_solution', NULL, 37),
  (7302, 40, 67, 'partnership_solution', NULL, 31),
  (7303, 41, 67, 'partnership_solution', NULL, 38),
  (7304, 42, 67, 'partnership_solution', NULL, 33),
  (7305, 43, 67, 'partnership_solution', NULL, 9),
  (7306, 44, 67, 'partnership_solution', NULL, 29),
  (7307, 45, 67, 'partnership_solution', NULL, 17),
  (7336, 1, 63, 'solutionCategories', 15, NULL),
  (7337, 2, 63, 'solutionCategories', 12, NULL),
  (7338, 3, 63, 'solutionCategories', 13, NULL),
  (7443, 23, 81, 'partnership_solution', NULL, 31),
  (7444, 24, 81, 'partnership_solution', NULL, 32),
  (7445, 25, 81, 'partnership_solution', NULL, 33),
  (7446, 26, 81, 'partnership_solution', NULL, 34),
  (7447, 27, 81, 'partnership_solution', NULL, 35),
  (7448, 28, 81, 'partnership_solution', NULL, 36),
  (7449, 29, 81, 'partnership_solution', NULL, 37),
  (7450, 30, 81, 'partnership_solution', NULL, 38),
  (7451, 31, 81, 'partnership_solution', NULL, 39),
  (7452, 32, 81, 'partnership_solution', NULL, 41),
  (7453, 33, 81, 'partnership_solution', NULL, 43),
  (7454, 34, 81, 'partnership_solution', NULL, 44),
  (7455, 35, 81, 'partnership_solution', NULL, 46),
  (7456, 36, 81, 'partnership_solution', NULL, 47),
  (7457, 37, 81, 'partnership_solution', NULL, 48),
  (7458, 38, 81, 'partnership_solution', NULL, 49),
  (7459, 39, 81, 'partnership_solution', NULL, 50),
  (7460, 40, 81, 'partnership_solution', NULL, 51),
  (6984, 1, 53, 'solutionCategories', 30, NULL),
  (6985, 2, 53, 'solutionCategories', 12, NULL),
  (6986, 3, 53, 'solutionCategories', 14, NULL),
  (6987, 1, 53, 'partnership_solution', NULL, 20),
  (6988, 2, 53, 'partnership_solution', NULL, 27),
  (6989, 3, 53, 'partnership_solution', NULL, 102),
  (6990, 4, 53, 'partnership_solution', NULL, 22),
  (6991, 5, 53, 'partnership_solution', NULL, 103),
  (6992, 6, 53, 'partnership_solution', NULL, 104),
  (6993, 7, 53, 'partnership_solution', NULL, 54),
  (6994, 8, 53, 'partnership_solution', NULL, 105),
  (6995, 9, 53, 'partnership_solution', NULL, 106),
  (6996, 10, 53, 'partnership_solution', NULL, 107),
  (6997, 11, 53, 'partnership_solution', NULL, 56),
  (6998, 12, 53, 'partnership_solution', NULL, 108),
  (6999, 13, 53, 'partnership_solution', NULL, 109),
  (7000, 14, 53, 'partnership_solution', NULL, 110),
  (7001, 15, 53, 'partnership_solution', NULL, 26),
  (7002, 16, 53, 'partnership_solution', NULL, 39),
  (7003, 17, 53, 'partnership_solution', NULL, 40),
  (7004, 18, 53, 'partnership_solution', NULL, 28),
  (7005, 19, 53, 'partnership_solution', NULL, 51),
  (7006, 20, 53, 'partnership_solution', NULL, 48),
  (7007, 21, 53, 'partnership_solution', NULL, 11),
  (7008, 22, 53, 'partnership_solution', NULL, 36),
  (7009, 23, 53, 'partnership_solution', NULL, 50),
  (7010, 24, 53, 'partnership_solution', NULL, 14);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (7011, 25, 53, 'partnership_solution', NULL, 37),
  (7012, 26, 53, 'partnership_solution', NULL, 31),
  (7013, 27, 53, 'partnership_solution', NULL, 38),
  (7014, 28, 53, 'partnership_solution', NULL, 33),
  (7015, 29, 53, 'partnership_solution', NULL, 9),
  (7016, 30, 53, 'partnership_solution', NULL, 29),
  (7017, 31, 53, 'partnership_solution', NULL, 52),
  (7018, 32, 53, 'partnership_solution', NULL, 17),
  (7019, 1, 55, 'solutionCategories', 14, NULL),
  (7020, 2, 55, 'solutionCategories', 12, NULL),
  (7021, 3, 55, 'solutionCategories', 16, NULL),
  (7022, 1, 55, 'partnership_solution', NULL, 20),
  (7023, 2, 55, 'partnership_solution', NULL, 27),
  (7024, 3, 55, 'partnership_solution', NULL, 11),
  (7025, 4, 55, 'partnership_solution', NULL, 22),
  (7026, 5, 55, 'partnership_solution', NULL, 36),
  (7027, 6, 55, 'partnership_solution', NULL, 50),
  (7028, 7, 55, 'partnership_solution', NULL, 14),
  (7029, 8, 55, 'partnership_solution', NULL, 39),
  (7030, 9, 55, 'partnership_solution', NULL, 54),
  (7031, 10, 55, 'partnership_solution', NULL, 37),
  (7032, 11, 55, 'partnership_solution', NULL, 31),
  (7033, 12, 55, 'partnership_solution', NULL, 51),
  (7034, 13, 55, 'partnership_solution', NULL, 38),
  (7035, 14, 55, 'partnership_solution', NULL, 33),
  (7036, 15, 55, 'partnership_solution', NULL, 9),
  (7037, 16, 55, 'partnership_solution', NULL, 29),
  (7038, 17, 55, 'partnership_solution', NULL, 52),
  (7039, 18, 55, 'partnership_solution', NULL, 17),
  (7461, 41, 81, 'partnership_solution', NULL, 52),
  (7462, 42, 81, 'partnership_solution', NULL, 53),
  (7463, 43, 81, 'partnership_solution', NULL, 54),
  (7464, 44, 81, 'partnership_solution', NULL, 58),
  (7040, 19, 55, 'partnership_solution', NULL, 26),
  (7041, 20, 55, 'partnership_solution', NULL, 40),
  (7042, 21, 55, 'partnership_solution', NULL, 28),
  (7043, 22, 55, 'partnership_solution', NULL, 48),
  (7308, 1, 65, 'solutionCategories', 14, NULL),
  (7309, 2, 65, 'solutionCategories', 27, NULL),
  (7310, 1, 65, 'partnership_solution', NULL, 20),
  (7311, 2, 65, 'partnership_solution', NULL, 27),
  (7312, 3, 65, 'partnership_solution', NULL, 11),
  (7313, 4, 65, 'partnership_solution', NULL, 22),
  (7314, 5, 65, 'partnership_solution', NULL, 36),
  (7315, 6, 65, 'partnership_solution', NULL, 50),
  (7316, 7, 65, 'partnership_solution', NULL, 14),
  (7317, 8, 65, 'partnership_solution', NULL, 39),
  (7318, 9, 65, 'partnership_solution', NULL, 54),
  (7319, 10, 65, 'partnership_solution', NULL, 37),
  (7320, 11, 65, 'partnership_solution', NULL, 31),
  (7321, 12, 65, 'partnership_solution', NULL, 51),
  (7322, 13, 65, 'partnership_solution', NULL, 38),
  (7323, 14, 65, 'partnership_solution', NULL, 33),
  (7324, 15, 65, 'partnership_solution', NULL, 9),
  (7325, 16, 65, 'partnership_solution', NULL, 29),
  (7326, 17, 65, 'partnership_solution', NULL, 52),
  (7327, 18, 65, 'partnership_solution', NULL, 17),
  (7328, 19, 65, 'partnership_solution', NULL, 83),
  (7329, 20, 65, 'partnership_solution', NULL, 16),
  (7330, 21, 65, 'partnership_solution', NULL, 84),
  (7331, 22, 65, 'partnership_solution', NULL, 85),
  (7332, 23, 65, 'partnership_solution', NULL, 86),
  (7333, 24, 65, 'partnership_solution', NULL, 87),
  (7334, 25, 65, 'partnership_solution', NULL, 25),
  (7335, 26, 65, 'partnership_solution', NULL, 48),
  (7465, 1, 80, 'solutionCategories', 12, NULL),
  (7466, 2, 80, 'solutionCategories', 13, NULL),
  (7467, 3, 80, 'solutionCategories', 27, NULL),
  (7468, 1, 80, 'partnership_solution', NULL, 7),
  (7469, 2, 80, 'partnership_solution', NULL, 8),
  (7470, 3, 80, 'partnership_solution', NULL, 11),
  (7471, 4, 80, 'partnership_solution', NULL, 12),
  (7472, 5, 80, 'partnership_solution', NULL, 13),
  (7473, 6, 80, 'partnership_solution', NULL, 14),
  (7474, 7, 80, 'partnership_solution', NULL, 15),
  (7475, 8, 80, 'partnership_solution', NULL, 16),
  (7476, 9, 80, 'partnership_solution', NULL, 18),
  (7477, 10, 80, 'partnership_solution', NULL, 19),
  (7478, 11, 80, 'partnership_solution', NULL, 20),
  (7479, 12, 80, 'partnership_solution', NULL, 21),
  (7480, 13, 80, 'partnership_solution', NULL, 22),
  (7481, 14, 80, 'partnership_solution', NULL, 23),
  (7482, 15, 80, 'partnership_solution', NULL, 24),
  (7483, 16, 80, 'partnership_solution', NULL, 25),
  (7484, 17, 80, 'partnership_solution', NULL, 26),
  (7485, 18, 80, 'partnership_solution', NULL, 27),
  (7486, 19, 80, 'partnership_solution', NULL, 28),
  (7487, 20, 80, 'partnership_solution', NULL, 30),
  (7488, 21, 80, 'partnership_solution', NULL, 32),
  (7489, 22, 80, 'partnership_solution', NULL, 34),
  (7490, 23, 80, 'partnership_solution', NULL, 35),
  (7491, 24, 80, 'partnership_solution', NULL, 39),
  (7492, 25, 80, 'partnership_solution', NULL, 40),
  (7493, 26, 80, 'partnership_solution', NULL, 41),
  (7494, 27, 80, 'partnership_solution', NULL, 43),
  (7495, 28, 80, 'partnership_solution', NULL, 44),
  (7496, 29, 80, 'partnership_solution', NULL, 46),
  (7497, 30, 80, 'partnership_solution', NULL, 47),
  (7498, 31, 80, 'partnership_solution', NULL, 48),
  (7499, 32, 80, 'partnership_solution', NULL, 49);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (7500, 33, 80, 'partnership_solution', NULL, 51),
  (7501, 34, 80, 'partnership_solution', NULL, 52),
  (7502, 35, 80, 'partnership_solution', NULL, 53),
  (7503, 36, 80, 'partnership_solution', NULL, 83),
  (7504, 37, 80, 'partnership_solution', NULL, 84),
  (7505, 38, 80, 'partnership_solution', NULL, 85),
  (7506, 39, 80, 'partnership_solution', NULL, 86),
  (7507, 40, 80, 'partnership_solution', NULL, 87),
  (7508, 1, 79, 'solutionCategories', 12, NULL),
  (7509, 2, 79, 'solutionCategories', 18, NULL),
  (7510, 3, 79, 'solutionCategories', 35, NULL),
  (7511, 1, 79, 'partnership_solution', NULL, 20),
  (7512, 2, 79, 'partnership_solution', NULL, 24),
  (7513, 3, 79, 'partnership_solution', NULL, 26),
  (7514, 4, 79, 'partnership_solution', NULL, 28),
  (7515, 5, 79, 'partnership_solution', NULL, 39),
  (7516, 6, 79, 'partnership_solution', NULL, 40),
  (7517, 7, 79, 'partnership_solution', NULL, 48),
  (7518, 8, 79, 'partnership_solution', NULL, 51),
  (7519, 9, 79, 'partnership_solution', NULL, 58),
  (4456, 1, 4, 'solutionCategories', 12, NULL),
  (4457, 2, 4, 'solutionCategories', 13, NULL),
  (4458, 3, 4, 'solutionCategories', 14, NULL),
  (4459, 4, 4, 'solutionCategories', 15, NULL),
  (4460, 1, 4, 'partnership_solution', NULL, 7),
  (5171, 1, 88, 'solutionCategories', 12, NULL),
  (5172, 2, 88, 'solutionCategories', 13, NULL),
  (5173, 3, 88, 'solutionCategories', 14, NULL),
  (5174, 1, 88, 'partnership_solution', NULL, 7),
  (5175, 2, 88, 'partnership_solution', NULL, 8),
  (5176, 3, 88, 'partnership_solution', NULL, 9),
  (5177, 4, 88, 'partnership_solution', NULL, 11),
  (5178, 5, 88, 'partnership_solution', NULL, 12),
  (5179, 6, 88, 'partnership_solution', NULL, 13),
  (5180, 7, 88, 'partnership_solution', NULL, 14),
  (5181, 8, 88, 'partnership_solution', NULL, 15),
  (7044, 1, 57, 'solutionCategories', 12, NULL),
  (7045, 2, 57, 'solutionCategories', 16, NULL),
  (7046, 3, 57, 'solutionCategories', 13, NULL),
  (7047, 4, 57, 'solutionCategories', 14, NULL),
  (7048, 1, 57, 'partnership_solution', NULL, 20),
  (7049, 2, 57, 'partnership_solution', NULL, 26),
  (7050, 3, 57, 'partnership_solution', NULL, 39),
  (7051, 4, 57, 'partnership_solution', NULL, 40),
  (7052, 5, 57, 'partnership_solution', NULL, 28),
  (7053, 6, 57, 'partnership_solution', NULL, 51),
  (7054, 7, 57, 'partnership_solution', NULL, 48),
  (7055, 8, 57, 'partnership_solution', NULL, 23),
  (7056, 9, 57, 'partnership_solution', NULL, 12),
  (7057, 10, 57, 'partnership_solution', NULL, 27),
  (7058, 11, 57, 'partnership_solution', NULL, 11),
  (7059, 12, 57, 'partnership_solution', NULL, 44),
  (7060, 13, 57, 'partnership_solution', NULL, 22),
  (7061, 14, 57, 'partnership_solution', NULL, 19),
  (7062, 15, 57, 'partnership_solution', NULL, 43),
  (7063, 16, 57, 'partnership_solution', NULL, 16),
  (7064, 17, 57, 'partnership_solution', NULL, 34),
  (7065, 18, 57, 'partnership_solution', NULL, 14),
  (7066, 19, 57, 'partnership_solution', NULL, 46),
  (7067, 20, 57, 'partnership_solution', NULL, 32),
  (7068, 21, 57, 'partnership_solution', NULL, 53),
  (7069, 22, 57, 'partnership_solution', NULL, 15),
  (7070, 23, 57, 'partnership_solution', NULL, 24),
  (7071, 24, 57, 'partnership_solution', NULL, 13),
  (7072, 25, 57, 'partnership_solution', NULL, 35),
  (7073, 26, 57, 'partnership_solution', NULL, 49),
  (7074, 27, 57, 'partnership_solution', NULL, 25),
  (7075, 28, 57, 'partnership_solution', NULL, 8),
  (7076, 29, 57, 'partnership_solution', NULL, 18),
  (7077, 30, 57, 'partnership_solution', NULL, 7),
  (7078, 31, 57, 'partnership_solution', NULL, 30),
  (7079, 32, 57, 'partnership_solution', NULL, 47),
  (7080, 33, 57, 'partnership_solution', NULL, 41),
  (7081, 34, 57, 'partnership_solution', NULL, 52),
  (7082, 35, 57, 'partnership_solution', NULL, 21),
  (7083, 36, 57, 'partnership_solution', NULL, 36),
  (7084, 37, 57, 'partnership_solution', NULL, 50),
  (7085, 38, 57, 'partnership_solution', NULL, 54),
  (7086, 39, 57, 'partnership_solution', NULL, 37),
  (7087, 40, 57, 'partnership_solution', NULL, 31),
  (7088, 41, 57, 'partnership_solution', NULL, 38),
  (7089, 42, 57, 'partnership_solution', NULL, 33),
  (7090, 43, 57, 'partnership_solution', NULL, 9),
  (7091, 44, 57, 'partnership_solution', NULL, 29),
  (7092, 45, 57, 'partnership_solution', NULL, 17),
  (7339, 4, 63, 'solutionCategories', 16, NULL),
  (7340, 1, 63, 'partnership_solution', NULL, 10),
  (7341, 2, 63, 'partnership_solution', NULL, 45),
  (7342, 3, 63, 'partnership_solution', NULL, 11),
  (5182, 9, 88, 'partnership_solution', NULL, 16),
  (5183, 10, 88, 'partnership_solution', NULL, 17),
  (5184, 11, 88, 'partnership_solution', NULL, 18),
  (5185, 12, 88, 'partnership_solution', NULL, 19),
  (5186, 13, 88, 'partnership_solution', NULL, 20),
  (5187, 14, 88, 'partnership_solution', NULL, 21),
  (5188, 15, 88, 'partnership_solution', NULL, 22),
  (7343, 4, 63, 'partnership_solution', NULL, 42),
  (7344, 5, 63, 'partnership_solution', NULL, 53),
  (7345, 6, 63, 'partnership_solution', NULL, 55),
  (7346, 7, 63, 'partnership_solution', NULL, 20);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (7347, 8, 63, 'partnership_solution', NULL, 26),
  (7348, 9, 63, 'partnership_solution', NULL, 39),
  (7349, 10, 63, 'partnership_solution', NULL, 40),
  (7350, 11, 63, 'partnership_solution', NULL, 28),
  (7351, 12, 63, 'partnership_solution', NULL, 51),
  (7352, 13, 63, 'partnership_solution', NULL, 48),
  (7353, 14, 63, 'partnership_solution', NULL, 23),
  (7354, 15, 63, 'partnership_solution', NULL, 12),
  (7355, 16, 63, 'partnership_solution', NULL, 27),
  (7356, 17, 63, 'partnership_solution', NULL, 44),
  (7357, 18, 63, 'partnership_solution', NULL, 22),
  (7358, 19, 63, 'partnership_solution', NULL, 19),
  (7359, 20, 63, 'partnership_solution', NULL, 43),
  (7360, 21, 63, 'partnership_solution', NULL, 16),
  (7361, 22, 63, 'partnership_solution', NULL, 34),
  (7362, 23, 63, 'partnership_solution', NULL, 14),
  (7363, 24, 63, 'partnership_solution', NULL, 46),
  (7364, 25, 63, 'partnership_solution', NULL, 32),
  (7365, 26, 63, 'partnership_solution', NULL, 15),
  (7366, 27, 63, 'partnership_solution', NULL, 24),
  (7367, 28, 63, 'partnership_solution', NULL, 13),
  (7093, 1, 59, 'solutionCategories', 18, NULL),
  (7094, 2, 59, 'solutionCategories', 12, NULL),
  (7095, 3, 59, 'solutionCategories', 14, NULL),
  (7096, 1, 59, 'partnership_solution', NULL, 58),
  (7097, 2, 59, 'partnership_solution', NULL, 28),
  (7098, 3, 59, 'partnership_solution', NULL, 24),
  (7099, 4, 59, 'partnership_solution', NULL, 20),
  (7100, 5, 59, 'partnership_solution', NULL, 26),
  (7101, 6, 59, 'partnership_solution', NULL, 39),
  (7102, 7, 59, 'partnership_solution', NULL, 40),
  (7103, 8, 59, 'partnership_solution', NULL, 51),
  (7104, 9, 59, 'partnership_solution', NULL, 48),
  (7105, 10, 59, 'partnership_solution', NULL, 27),
  (7106, 11, 59, 'partnership_solution', NULL, 11),
  (7107, 12, 59, 'partnership_solution', NULL, 22),
  (7108, 13, 59, 'partnership_solution', NULL, 36),
  (7109, 14, 59, 'partnership_solution', NULL, 50),
  (7110, 15, 59, 'partnership_solution', NULL, 14),
  (7111, 16, 59, 'partnership_solution', NULL, 54),
  (7112, 17, 59, 'partnership_solution', NULL, 37),
  (7113, 18, 59, 'partnership_solution', NULL, 31),
  (7520, 1, 78, 'solutionCategories', 12, NULL),
  (7521, 2, 78, 'solutionCategories', 13, NULL),
  (7522, 3, 78, 'solutionCategories', 23, NULL),
  (7523, 1, 78, 'partnership_solution', NULL, 7),
  (7524, 2, 78, 'partnership_solution', NULL, 8),
  (7525, 3, 78, 'partnership_solution', NULL, 11),
  (7526, 4, 78, 'partnership_solution', NULL, 12),
  (7527, 5, 78, 'partnership_solution', NULL, 13),
  (7528, 6, 78, 'partnership_solution', NULL, 14),
  (7529, 7, 78, 'partnership_solution', NULL, 15),
  (7530, 8, 78, 'partnership_solution', NULL, 16),
  (7531, 9, 78, 'partnership_solution', NULL, 18),
  (7532, 10, 78, 'partnership_solution', NULL, 19),
  (7533, 11, 78, 'partnership_solution', NULL, 20),
  (7534, 12, 78, 'partnership_solution', NULL, 21),
  (7535, 13, 78, 'partnership_solution', NULL, 22),
  (7536, 14, 78, 'partnership_solution', NULL, 23),
  (7537, 15, 78, 'partnership_solution', NULL, 24),
  (7538, 16, 78, 'partnership_solution', NULL, 25),
  (7539, 17, 78, 'partnership_solution', NULL, 26),
  (7540, 18, 78, 'partnership_solution', NULL, 27),
  (7541, 19, 78, 'partnership_solution', NULL, 28),
  (7542, 20, 78, 'partnership_solution', NULL, 30),
  (7543, 21, 78, 'partnership_solution', NULL, 32),
  (7544, 22, 78, 'partnership_solution', NULL, 34),
  (7545, 23, 78, 'partnership_solution', NULL, 35),
  (7546, 24, 78, 'partnership_solution', NULL, 39),
  (7547, 25, 78, 'partnership_solution', NULL, 40),
  (7548, 26, 78, 'partnership_solution', NULL, 41),
  (7114, 19, 59, 'partnership_solution', NULL, 38),
  (7115, 20, 59, 'partnership_solution', NULL, 33),
  (7116, 21, 59, 'partnership_solution', NULL, 9),
  (7117, 22, 59, 'partnership_solution', NULL, 29),
  (7118, 23, 59, 'partnership_solution', NULL, 52),
  (7119, 24, 59, 'partnership_solution', NULL, 17),
  (7368, 29, 63, 'partnership_solution', NULL, 35),
  (7369, 30, 63, 'partnership_solution', NULL, 49),
  (7370, 31, 63, 'partnership_solution', NULL, 25),
  (7371, 32, 63, 'partnership_solution', NULL, 8),
  (7372, 33, 63, 'partnership_solution', NULL, 18),
  (7373, 34, 63, 'partnership_solution', NULL, 7),
  (7374, 35, 63, 'partnership_solution', NULL, 30),
  (7375, 36, 63, 'partnership_solution', NULL, 47),
  (7376, 37, 63, 'partnership_solution', NULL, 41),
  (7377, 38, 63, 'partnership_solution', NULL, 52),
  (7378, 39, 63, 'partnership_solution', NULL, 21),
  (7379, 1, 61, 'solutionCategories', 12, NULL),
  (7380, 2, 61, 'solutionCategories', 13, NULL),
  (7381, 3, 61, 'solutionCategories', 18, NULL),
  (7382, 1, 61, 'partnership_solution', NULL, 20),
  (7383, 2, 61, 'partnership_solution', NULL, 26),
  (7384, 3, 61, 'partnership_solution', NULL, 39),
  (7385, 4, 61, 'partnership_solution', NULL, 40),
  (7386, 5, 61, 'partnership_solution', NULL, 28),
  (7387, 6, 61, 'partnership_solution', NULL, 51),
  (7388, 7, 61, 'partnership_solution', NULL, 48),
  (7389, 8, 61, 'partnership_solution', NULL, 23),
  (7390, 9, 61, 'partnership_solution', NULL, 12);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (7549, 27, 78, 'partnership_solution', NULL, 43),
  (7550, 28, 78, 'partnership_solution', NULL, 44),
  (7551, 29, 78, 'partnership_solution', NULL, 46),
  (7552, 30, 78, 'partnership_solution', NULL, 47),
  (7553, 31, 78, 'partnership_solution', NULL, 48),
  (7554, 32, 78, 'partnership_solution', NULL, 49),
  (7555, 33, 78, 'partnership_solution', NULL, 51),
  (7556, 34, 78, 'partnership_solution', NULL, 52),
  (7557, 35, 78, 'partnership_solution', NULL, 53),
  (7558, 36, 78, 'partnership_solution', NULL, 66),
  (7559, 37, 78, 'partnership_solution', NULL, 67),
  (7560, 38, 78, 'partnership_solution', NULL, 68),
  (7561, 1, 77, 'solutionCategories', 14, NULL),
  (7562, 2, 77, 'solutionCategories', 16, NULL),
  (7563, 3, 77, 'solutionCategories', 27, NULL),
  (7564, 1, 77, 'partnership_solution', NULL, 9),
  (7565, 2, 77, 'partnership_solution', NULL, 11),
  (7566, 3, 77, 'partnership_solution', NULL, 14),
  (7567, 4, 77, 'partnership_solution', NULL, 16),
  (7568, 5, 77, 'partnership_solution', NULL, 17),
  (7569, 6, 77, 'partnership_solution', NULL, 20),
  (7570, 7, 77, 'partnership_solution', NULL, 22),
  (7571, 8, 77, 'partnership_solution', NULL, 25),
  (7572, 9, 77, 'partnership_solution', NULL, 27),
  (4524, 13, 5, 'partnership_solution', NULL, 19),
  (4525, 14, 5, 'partnership_solution', NULL, 43),
  (4526, 15, 5, 'partnership_solution', NULL, 7),
  (4527, 16, 5, 'partnership_solution', NULL, 16),
  (4528, 17, 5, 'partnership_solution', NULL, 34),
  (4529, 18, 5, 'partnership_solution', NULL, 36),
  (4530, 19, 5, 'partnership_solution', NULL, 30),
  (4531, 20, 5, 'partnership_solution', NULL, 42),
  (4532, 21, 5, 'partnership_solution', NULL, 50),
  (4533, 22, 5, 'partnership_solution', NULL, 14),
  (4534, 23, 5, 'partnership_solution', NULL, 39),
  (4535, 24, 5, 'partnership_solution', NULL, 46),
  (4536, 25, 5, 'partnership_solution', NULL, 32),
  (4537, 26, 5, 'partnership_solution', NULL, 54),
  (4538, 27, 5, 'partnership_solution', NULL, 47),
  (4539, 28, 5, 'partnership_solution', NULL, 37),
  (4540, 29, 5, 'partnership_solution', NULL, 17),
  (4541, 30, 5, 'partnership_solution', NULL, 31),
  (4542, 31, 5, 'partnership_solution', NULL, 41),
  (7573, 10, 77, 'partnership_solution', NULL, 28),
  (7574, 11, 77, 'partnership_solution', NULL, 29),
  (7575, 12, 77, 'partnership_solution', NULL, 31),
  (7576, 13, 77, 'partnership_solution', NULL, 33),
  (7577, 14, 77, 'partnership_solution', NULL, 36),
  (7578, 15, 77, 'partnership_solution', NULL, 37),
  (7579, 16, 77, 'partnership_solution', NULL, 38),
  (7580, 17, 77, 'partnership_solution', NULL, 39),
  (7581, 18, 77, 'partnership_solution', NULL, 48),
  (7582, 19, 77, 'partnership_solution', NULL, 50),
  (7583, 20, 77, 'partnership_solution', NULL, 51),
  (7584, 21, 77, 'partnership_solution', NULL, 52),
  (7585, 22, 77, 'partnership_solution', NULL, 54),
  (7586, 23, 77, 'partnership_solution', NULL, 83),
  (7587, 24, 77, 'partnership_solution', NULL, 84),
  (7588, 25, 77, 'partnership_solution', NULL, 85),
  (7589, 26, 77, 'partnership_solution', NULL, 86),
  (7590, 27, 77, 'partnership_solution', NULL, 87),
  (4543, 32, 5, 'partnership_solution', NULL, 48),
  (4544, 33, 5, 'partnership_solution', NULL, 51),
  (4545, 34, 5, 'partnership_solution', NULL, 38),
  (4546, 35, 5, 'partnership_solution', NULL, 15),
  (4547, 36, 5, 'partnership_solution', NULL, 24),
  (4548, 37, 5, 'partnership_solution', NULL, 52),
  (4549, 38, 5, 'partnership_solution', NULL, 33),
  (4550, 39, 5, 'partnership_solution', NULL, 13),
  (4551, 40, 5, 'partnership_solution', NULL, 9),
  (4552, 41, 5, 'partnership_solution', NULL, 29),
  (4553, 42, 5, 'partnership_solution', NULL, 35),
  (4554, 43, 5, 'partnership_solution', NULL, 53),
  (4555, 44, 5, 'partnership_solution', NULL, 21),
  (4556, 45, 5, 'partnership_solution', NULL, 49),
  (4557, 46, 5, 'partnership_solution', NULL, 55),
  (4617, 7, 7, 'partnership_solution', NULL, 11),
  (4618, 8, 7, 'partnership_solution', NULL, 44),
  (4619, 9, 7, 'partnership_solution', NULL, 25),
  (4620, 10, 7, 'partnership_solution', NULL, 8),
  (4621, 11, 7, 'partnership_solution', NULL, 22),
  (4622, 12, 7, 'partnership_solution', NULL, 18),
  (4623, 13, 7, 'partnership_solution', NULL, 19),
  (4624, 14, 7, 'partnership_solution', NULL, 43),
  (4625, 15, 7, 'partnership_solution', NULL, 7),
  (4626, 16, 7, 'partnership_solution', NULL, 16),
  (4627, 17, 7, 'partnership_solution', NULL, 34),
  (4628, 18, 7, 'partnership_solution', NULL, 36),
  (4629, 19, 7, 'partnership_solution', NULL, 30),
  (7591, 1, 76, 'solutionCategories', 12, NULL),
  (7592, 2, 76, 'solutionCategories', 13, NULL),
  (7593, 3, 76, 'solutionCategories', 18, NULL),
  (7594, 4, 76, 'solutionCategories', 35, NULL),
  (7595, 1, 76, 'partnership_solution', NULL, 7),
  (7596, 2, 76, 'partnership_solution', NULL, 8),
  (7597, 3, 76, 'partnership_solution', NULL, 11),
  (7598, 4, 76, 'partnership_solution', NULL, 12),
  (7599, 5, 76, 'partnership_solution', NULL, 13),
  (7600, 6, 76, 'partnership_solution', NULL, 14),
  (7601, 7, 76, 'partnership_solution', NULL, 15);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (7602, 8, 76, 'partnership_solution', NULL, 16),
  (7603, 9, 76, 'partnership_solution', NULL, 18),
  (7604, 10, 76, 'partnership_solution', NULL, 19),
  (7605, 11, 76, 'partnership_solution', NULL, 20),
  (7606, 12, 76, 'partnership_solution', NULL, 21),
  (7607, 13, 76, 'partnership_solution', NULL, 22),
  (7608, 14, 76, 'partnership_solution', NULL, 23),
  (7609, 15, 76, 'partnership_solution', NULL, 24),
  (7610, 16, 76, 'partnership_solution', NULL, 25),
  (7611, 17, 76, 'partnership_solution', NULL, 26),
  (7612, 18, 76, 'partnership_solution', NULL, 27),
  (7613, 19, 76, 'partnership_solution', NULL, 28),
  (7614, 20, 76, 'partnership_solution', NULL, 30),
  (7615, 21, 76, 'partnership_solution', NULL, 32),
  (7616, 22, 76, 'partnership_solution', NULL, 34),
  (7617, 23, 76, 'partnership_solution', NULL, 35),
  (7618, 24, 76, 'partnership_solution', NULL, 39),
  (7619, 25, 76, 'partnership_solution', NULL, 40),
  (7620, 26, 76, 'partnership_solution', NULL, 41),
  (7621, 27, 76, 'partnership_solution', NULL, 43),
  (7622, 28, 76, 'partnership_solution', NULL, 44),
  (7623, 29, 76, 'partnership_solution', NULL, 46),
  (7624, 30, 76, 'partnership_solution', NULL, 47),
  (7625, 31, 76, 'partnership_solution', NULL, 48),
  (7626, 32, 76, 'partnership_solution', NULL, 49),
  (7627, 33, 76, 'partnership_solution', NULL, 51),
  (7628, 34, 76, 'partnership_solution', NULL, 52),
  (7629, 35, 76, 'partnership_solution', NULL, 53),
  (7630, 36, 76, 'partnership_solution', NULL, 58),
  (4558, 1, 6, 'solutionCategories', 13, NULL),
  (4559, 2, 6, 'solutionCategories', 14, NULL),
  (4560, 3, 6, 'solutionCategories', 15, NULL),
  (4561, 1, 6, 'partnership_solution', NULL, 20),
  (4562, 2, 6, 'partnership_solution', NULL, 23),
  (4563, 3, 6, 'partnership_solution', NULL, 12),
  (4564, 4, 6, 'partnership_solution', NULL, 27),
  (4565, 5, 6, 'partnership_solution', NULL, 10),
  (4566, 6, 6, 'partnership_solution', NULL, 45),
  (4567, 7, 6, 'partnership_solution', NULL, 11),
  (4568, 8, 6, 'partnership_solution', NULL, 44),
  (4569, 9, 6, 'partnership_solution', NULL, 25),
  (4570, 10, 6, 'partnership_solution', NULL, 8),
  (4571, 11, 6, 'partnership_solution', NULL, 22),
  (4572, 12, 6, 'partnership_solution', NULL, 18),
  (4573, 13, 6, 'partnership_solution', NULL, 19),
  (4574, 14, 6, 'partnership_solution', NULL, 43),
  (6268, 1, 18, 'solutionCategories', 12, NULL),
  (6269, 2, 18, 'solutionCategories', 13, NULL),
  (6270, 3, 18, 'solutionCategories', 14, NULL),
  (6271, 4, 18, 'solutionCategories', 15, NULL),
  (6272, 5, 18, 'solutionCategories', 30, NULL),
  (6273, 1, 18, 'partnership_solution', NULL, 20),
  (6274, 2, 18, 'partnership_solution', NULL, 26),
  (6275, 3, 18, 'partnership_solution', NULL, 23),
  (6276, 4, 18, 'partnership_solution', NULL, 110),
  (6277, 5, 18, 'partnership_solution', NULL, 12),
  (6278, 6, 18, 'partnership_solution', NULL, 27),
  (6279, 7, 18, 'partnership_solution', NULL, 10),
  (6280, 8, 18, 'partnership_solution', NULL, 102),
  (6281, 9, 18, 'partnership_solution', NULL, 45),
  (6282, 10, 18, 'partnership_solution', NULL, 11),
  (6283, 11, 18, 'partnership_solution', NULL, 44),
  (6284, 12, 18, 'partnership_solution', NULL, 25),
  (6285, 13, 18, 'partnership_solution', NULL, 8),
  (6286, 14, 18, 'partnership_solution', NULL, 22),
  (6287, 15, 18, 'partnership_solution', NULL, 18),
  (6288, 16, 18, 'partnership_solution', NULL, 19),
  (6289, 17, 18, 'partnership_solution', NULL, 43),
  (6290, 18, 18, 'partnership_solution', NULL, 7),
  (6291, 19, 18, 'partnership_solution', NULL, 103),
  (6292, 20, 18, 'partnership_solution', NULL, 16),
  (6293, 21, 18, 'partnership_solution', NULL, 34),
  (6294, 22, 18, 'partnership_solution', NULL, 36),
  (6295, 23, 18, 'partnership_solution', NULL, 30),
  (6296, 24, 18, 'partnership_solution', NULL, 42),
  (6297, 25, 18, 'partnership_solution', NULL, 104),
  (6298, 26, 18, 'partnership_solution', NULL, 50),
  (6299, 27, 18, 'partnership_solution', NULL, 14),
  (6300, 28, 18, 'partnership_solution', NULL, 39),
  (6301, 29, 18, 'partnership_solution', NULL, 46),
  (4575, 15, 6, 'partnership_solution', NULL, 7),
  (4576, 16, 6, 'partnership_solution', NULL, 16),
  (4577, 17, 6, 'partnership_solution', NULL, 34),
  (4578, 18, 6, 'partnership_solution', NULL, 36),
  (4579, 19, 6, 'partnership_solution', NULL, 30),
  (4580, 20, 6, 'partnership_solution', NULL, 42),
  (4581, 21, 6, 'partnership_solution', NULL, 50),
  (4582, 22, 6, 'partnership_solution', NULL, 14),
  (4583, 23, 6, 'partnership_solution', NULL, 39),
  (4584, 24, 6, 'partnership_solution', NULL, 46),
  (4585, 25, 6, 'partnership_solution', NULL, 32),
  (4586, 26, 6, 'partnership_solution', NULL, 54),
  (4587, 27, 6, 'partnership_solution', NULL, 47),
  (4588, 28, 6, 'partnership_solution', NULL, 37),
  (4589, 29, 6, 'partnership_solution', NULL, 17),
  (4590, 30, 6, 'partnership_solution', NULL, 31),
  (4591, 31, 6, 'partnership_solution', NULL, 41),
  (4592, 32, 6, 'partnership_solution', NULL, 48),
  (4593, 33, 6, 'partnership_solution', NULL, 51),
  (4594, 34, 6, 'partnership_solution', NULL, 38);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (4595, 35, 6, 'partnership_solution', NULL, 15),
  (4596, 36, 6, 'partnership_solution', NULL, 24),
  (4597, 37, 6, 'partnership_solution', NULL, 52),
  (4598, 38, 6, 'partnership_solution', NULL, 33),
  (4599, 39, 6, 'partnership_solution', NULL, 13),
  (4600, 40, 6, 'partnership_solution', NULL, 9),
  (4601, 41, 6, 'partnership_solution', NULL, 29),
  (4602, 42, 6, 'partnership_solution', NULL, 35),
  (4603, 43, 6, 'partnership_solution', NULL, 53),
  (4604, 44, 6, 'partnership_solution', NULL, 21),
  (4605, 45, 6, 'partnership_solution', NULL, 49),
  (4606, 46, 6, 'partnership_solution', NULL, 55),
  (4630, 20, 7, 'partnership_solution', NULL, 42),
  (4631, 21, 7, 'partnership_solution', NULL, 50),
  (4632, 22, 7, 'partnership_solution', NULL, 14),
  (4633, 23, 7, 'partnership_solution', NULL, 39),
  (4634, 24, 7, 'partnership_solution', NULL, 46),
  (4635, 25, 7, 'partnership_solution', NULL, 32),
  (4636, 26, 7, 'partnership_solution', NULL, 54),
  (4637, 27, 7, 'partnership_solution', NULL, 47),
  (4638, 28, 7, 'partnership_solution', NULL, 28),
  (4639, 29, 7, 'partnership_solution', NULL, 37),
  (4640, 30, 7, 'partnership_solution', NULL, 17),
  (4641, 31, 7, 'partnership_solution', NULL, 31),
  (4642, 32, 7, 'partnership_solution', NULL, 41),
  (4643, 33, 7, 'partnership_solution', NULL, 48),
  (4644, 34, 7, 'partnership_solution', NULL, 51),
  (4645, 35, 7, 'partnership_solution', NULL, 38),
  (7120, 1, 73, 'solutionCategories', 13, NULL),
  (7121, 2, 73, 'solutionCategories', 18, NULL),
  (7122, 3, 73, 'solutionCategories', 12, NULL),
  (7123, 4, 73, 'solutionCategories', 14, NULL),
  (7124, 1, 73, 'partnership_solution', NULL, 23),
  (7125, 2, 73, 'partnership_solution', NULL, 12),
  (7126, 3, 73, 'partnership_solution', NULL, 27),
  (7127, 4, 73, 'partnership_solution', NULL, 11),
  (7128, 5, 73, 'partnership_solution', NULL, 44),
  (7129, 6, 73, 'partnership_solution', NULL, 22),
  (7130, 7, 73, 'partnership_solution', NULL, 19),
  (7131, 8, 73, 'partnership_solution', NULL, 43),
  (7132, 9, 73, 'partnership_solution', NULL, 16),
  (7133, 10, 73, 'partnership_solution', NULL, 34),
  (7134, 11, 73, 'partnership_solution', NULL, 14),
  (7135, 12, 73, 'partnership_solution', NULL, 39),
  (7136, 13, 73, 'partnership_solution', NULL, 46),
  (7137, 14, 73, 'partnership_solution', NULL, 32),
  (7138, 15, 73, 'partnership_solution', NULL, 53),
  (7139, 16, 73, 'partnership_solution', NULL, 15),
  (7140, 17, 73, 'partnership_solution', NULL, 24),
  (7141, 18, 73, 'partnership_solution', NULL, 13),
  (7142, 19, 73, 'partnership_solution', NULL, 35),
  (7143, 20, 73, 'partnership_solution', NULL, 49),
  (7144, 21, 73, 'partnership_solution', NULL, 25),
  (7145, 22, 73, 'partnership_solution', NULL, 8),
  (7146, 23, 73, 'partnership_solution', NULL, 18),
  (7147, 24, 73, 'partnership_solution', NULL, 7),
  (7148, 25, 73, 'partnership_solution', NULL, 30),
  (7149, 26, 73, 'partnership_solution', NULL, 47),
  (7150, 27, 73, 'partnership_solution', NULL, 41),
  (7151, 28, 73, 'partnership_solution', NULL, 48),
  (7152, 29, 73, 'partnership_solution', NULL, 52),
  (7153, 30, 73, 'partnership_solution', NULL, 21),
  (7154, 31, 73, 'partnership_solution', NULL, 58),
  (7155, 32, 73, 'partnership_solution', NULL, 28),
  (7156, 33, 73, 'partnership_solution', NULL, 20),
  (7157, 34, 73, 'partnership_solution', NULL, 26),
  (7158, 35, 73, 'partnership_solution', NULL, 40),
  (7159, 36, 73, 'partnership_solution', NULL, 51),
  (7160, 37, 73, 'partnership_solution', NULL, 36),
  (7161, 38, 73, 'partnership_solution', NULL, 50),
  (7162, 39, 73, 'partnership_solution', NULL, 54),
  (7163, 40, 73, 'partnership_solution', NULL, 37),
  (7164, 41, 73, 'partnership_solution', NULL, 31),
  (7165, 42, 73, 'partnership_solution', NULL, 38),
  (7166, 43, 73, 'partnership_solution', NULL, 33),
  (7167, 44, 73, 'partnership_solution', NULL, 9),
  (7168, 45, 73, 'partnership_solution', NULL, 29),
  (7169, 46, 73, 'partnership_solution', NULL, 17),
  (7170, 1, 71, 'solutionCategories', 12, NULL),
  (7171, 2, 71, 'solutionCategories', 18, NULL),
  (7172, 3, 71, 'solutionCategories', 14, NULL),
  (7173, 4, 71, 'solutionCategories', 13, NULL),
  (7174, 1, 71, 'partnership_solution', NULL, 20),
  (7175, 2, 71, 'partnership_solution', NULL, 26),
  (7176, 3, 71, 'partnership_solution', NULL, 39),
  (7177, 4, 71, 'partnership_solution', NULL, 40),
  (7178, 5, 71, 'partnership_solution', NULL, 28),
  (4607, 1, 7, 'solutionCategories', 13, NULL),
  (4608, 2, 7, 'solutionCategories', 14, NULL),
  (4609, 3, 7, 'solutionCategories', 15, NULL),
  (4610, 4, 7, 'solutionCategories', 16, NULL),
  (4611, 1, 7, 'partnership_solution', NULL, 20),
  (4612, 2, 7, 'partnership_solution', NULL, 23),
  (4613, 3, 7, 'partnership_solution', NULL, 12),
  (4614, 4, 7, 'partnership_solution', NULL, 27),
  (4615, 5, 7, 'partnership_solution', NULL, 10),
  (4616, 6, 7, 'partnership_solution', NULL, 45),
  (4461, 2, 4, 'partnership_solution', NULL, 8),
  (4462, 3, 4, 'partnership_solution', NULL, 9),
  (4463, 4, 4, 'partnership_solution', NULL, 10);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (4464, 5, 4, 'partnership_solution', NULL, 11),
  (4465, 6, 4, 'partnership_solution', NULL, 12),
  (4466, 7, 4, 'partnership_solution', NULL, 13),
  (4467, 8, 4, 'partnership_solution', NULL, 14),
  (4468, 9, 4, 'partnership_solution', NULL, 15),
  (4469, 10, 4, 'partnership_solution', NULL, 16),
  (4470, 11, 4, 'partnership_solution', NULL, 17),
  (4471, 12, 4, 'partnership_solution', NULL, 18),
  (4472, 13, 4, 'partnership_solution', NULL, 19),
  (4473, 14, 4, 'partnership_solution', NULL, 20),
  (4474, 15, 4, 'partnership_solution', NULL, 21),
  (4475, 16, 4, 'partnership_solution', NULL, 22),
  (4476, 17, 4, 'partnership_solution', NULL, 23),
  (4477, 18, 4, 'partnership_solution', NULL, 24),
  (4478, 19, 4, 'partnership_solution', NULL, 25),
  (4479, 20, 4, 'partnership_solution', NULL, 26),
  (4480, 21, 4, 'partnership_solution', NULL, 27),
  (4481, 22, 4, 'partnership_solution', NULL, 28),
  (4482, 23, 4, 'partnership_solution', NULL, 29),
  (4483, 24, 4, 'partnership_solution', NULL, 30),
  (4484, 25, 4, 'partnership_solution', NULL, 31),
  (4485, 26, 4, 'partnership_solution', NULL, 32),
  (4486, 27, 4, 'partnership_solution', NULL, 33),
  (4487, 28, 4, 'partnership_solution', NULL, 34),
  (4488, 29, 4, 'partnership_solution', NULL, 35),
  (4489, 30, 4, 'partnership_solution', NULL, 36),
  (4490, 31, 4, 'partnership_solution', NULL, 37),
  (4491, 32, 4, 'partnership_solution', NULL, 38),
  (4492, 33, 4, 'partnership_solution', NULL, 39),
  (4493, 34, 4, 'partnership_solution', NULL, 40),
  (4494, 35, 4, 'partnership_solution', NULL, 41),
  (4495, 36, 4, 'partnership_solution', NULL, 42),
  (4496, 37, 4, 'partnership_solution', NULL, 43),
  (4497, 38, 4, 'partnership_solution', NULL, 44),
  (4498, 39, 4, 'partnership_solution', NULL, 45),
  (4499, 40, 4, 'partnership_solution', NULL, 46),
  (4500, 41, 4, 'partnership_solution', NULL, 47),
  (4501, 42, 4, 'partnership_solution', NULL, 48),
  (4502, 43, 4, 'partnership_solution', NULL, 49),
  (4503, 44, 4, 'partnership_solution', NULL, 50),
  (4504, 45, 4, 'partnership_solution', NULL, 51),
  (4505, 46, 4, 'partnership_solution', NULL, 52),
  (4506, 47, 4, 'partnership_solution', NULL, 53),
  (4507, 48, 4, 'partnership_solution', NULL, 54),
  (4508, 49, 4, 'partnership_solution', NULL, 55),
  (4509, 1, 5, 'solutionCategories', 13, NULL),
  (4510, 2, 5, 'solutionCategories', 14, NULL),
  (4511, 3, 5, 'solutionCategories', 15, NULL),
  (4512, 1, 5, 'partnership_solution', NULL, 20),
  (4513, 2, 5, 'partnership_solution', NULL, 23),
  (4514, 3, 5, 'partnership_solution', NULL, 12),
  (4515, 4, 5, 'partnership_solution', NULL, 27),
  (4516, 5, 5, 'partnership_solution', NULL, 10),
  (4517, 6, 5, 'partnership_solution', NULL, 45),
  (4518, 7, 5, 'partnership_solution', NULL, 11),
  (4519, 8, 5, 'partnership_solution', NULL, 44),
  (4520, 9, 5, 'partnership_solution', NULL, 25),
  (4521, 10, 5, 'partnership_solution', NULL, 8),
  (4522, 11, 5, 'partnership_solution', NULL, 22),
  (4523, 12, 5, 'partnership_solution', NULL, 18),
  (4646, 36, 7, 'partnership_solution', NULL, 15),
  (4647, 37, 7, 'partnership_solution', NULL, 24),
  (4648, 38, 7, 'partnership_solution', NULL, 52),
  (4649, 39, 7, 'partnership_solution', NULL, 33),
  (4650, 40, 7, 'partnership_solution', NULL, 13),
  (4651, 41, 7, 'partnership_solution', NULL, 9),
  (4652, 42, 7, 'partnership_solution', NULL, 29),
  (4653, 43, 7, 'partnership_solution', NULL, 35),
  (4654, 44, 7, 'partnership_solution', NULL, 53),
  (4655, 45, 7, 'partnership_solution', NULL, 21),
  (4656, 46, 7, 'partnership_solution', NULL, 49),
  (4657, 47, 7, 'partnership_solution', NULL, 55),
  (4658, 1, 9, 'solutionCategories', 14, NULL),
  (4659, 2, 9, 'solutionCategories', 15, NULL),
  (4660, 3, 9, 'solutionCategories', 17, NULL),
  (4661, 4, 9, 'solutionCategories', 18, NULL),
  (4662, 1, 9, 'partnership_solution', NULL, 20),
  (4663, 2, 9, 'partnership_solution', NULL, 27),
  (4664, 3, 9, 'partnership_solution', NULL, 10),
  (4665, 4, 9, 'partnership_solution', NULL, 45),
  (4666, 5, 9, 'partnership_solution', NULL, 11),
  (4667, 6, 9, 'partnership_solution', NULL, 57),
  (4668, 7, 9, 'partnership_solution', NULL, 22),
  (4669, 8, 9, 'partnership_solution', NULL, 36),
  (4670, 9, 9, 'partnership_solution', NULL, 42),
  (4671, 10, 9, 'partnership_solution', NULL, 50),
  (4672, 11, 9, 'partnership_solution', NULL, 14),
  (4673, 12, 9, 'partnership_solution', NULL, 39),
  (4674, 13, 9, 'partnership_solution', NULL, 54),
  (4675, 14, 9, 'partnership_solution', NULL, 58),
  (4676, 15, 9, 'partnership_solution', NULL, 28),
  (4677, 16, 9, 'partnership_solution', NULL, 37),
  (4678, 17, 9, 'partnership_solution', NULL, 17),
  (4679, 18, 9, 'partnership_solution', NULL, 31),
  (4680, 19, 9, 'partnership_solution', NULL, 51),
  (4681, 20, 9, 'partnership_solution', NULL, 56),
  (4682, 21, 9, 'partnership_solution', NULL, 38),
  (4683, 22, 9, 'partnership_solution', NULL, 24),
  (4684, 23, 9, 'partnership_solution', NULL, 52),
  (4685, 24, 9, 'partnership_solution', NULL, 33);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (4686, 25, 9, 'partnership_solution', NULL, 9),
  (4687, 26, 9, 'partnership_solution', NULL, 29),
  (4688, 27, 9, 'partnership_solution', NULL, 53),
  (4689, 28, 9, 'partnership_solution', NULL, 55),
  (4690, 1, 12, 'solutionCategories', 12, NULL),
  (4691, 2, 12, 'solutionCategories', 13, NULL),
  (4692, 3, 12, 'solutionCategories', 18, NULL),
  (4693, 1, 12, 'partnership_solution', NULL, 20),
  (4694, 2, 12, 'partnership_solution', NULL, 26),
  (4695, 3, 12, 'partnership_solution', NULL, 23),
  (4696, 4, 12, 'partnership_solution', NULL, 12),
  (4697, 5, 12, 'partnership_solution', NULL, 27),
  (4698, 6, 12, 'partnership_solution', NULL, 11),
  (4699, 7, 12, 'partnership_solution', NULL, 44),
  (4700, 8, 12, 'partnership_solution', NULL, 25),
  (4701, 9, 12, 'partnership_solution', NULL, 8),
  (4702, 10, 12, 'partnership_solution', NULL, 22),
  (4703, 11, 12, 'partnership_solution', NULL, 18),
  (4704, 12, 12, 'partnership_solution', NULL, 19),
  (4705, 13, 12, 'partnership_solution', NULL, 43),
  (4706, 14, 12, 'partnership_solution', NULL, 7),
  (4707, 15, 12, 'partnership_solution', NULL, 16),
  (4708, 16, 12, 'partnership_solution', NULL, 34),
  (4709, 17, 12, 'partnership_solution', NULL, 30),
  (4710, 18, 12, 'partnership_solution', NULL, 14),
  (4711, 19, 12, 'partnership_solution', NULL, 39),
  (4712, 20, 12, 'partnership_solution', NULL, 46),
  (4713, 21, 12, 'partnership_solution', NULL, 40),
  (4714, 22, 12, 'partnership_solution', NULL, 32),
  (4715, 23, 12, 'partnership_solution', NULL, 58),
  (4716, 24, 12, 'partnership_solution', NULL, 47),
  (4717, 25, 12, 'partnership_solution', NULL, 28),
  (4718, 26, 12, 'partnership_solution', NULL, 41),
  (4719, 27, 12, 'partnership_solution', NULL, 48),
  (4720, 28, 12, 'partnership_solution', NULL, 51),
  (4721, 29, 12, 'partnership_solution', NULL, 15),
  (4722, 30, 12, 'partnership_solution', NULL, 24),
  (4723, 31, 12, 'partnership_solution', NULL, 52),
  (4724, 32, 12, 'partnership_solution', NULL, 13),
  (4725, 33, 12, 'partnership_solution', NULL, 35),
  (4726, 34, 12, 'partnership_solution', NULL, 53),
  (4727, 35, 12, 'partnership_solution', NULL, 21),
  (4728, 36, 12, 'partnership_solution', NULL, 49),
  (4729, 1, 14, 'solutionCategories', 12, NULL),
  (4730, 2, 14, 'solutionCategories', 13, NULL),
  (4731, 3, 14, 'solutionCategories', 14, NULL),
  (4732, 4, 14, 'solutionCategories', 23, NULL),
  (4733, 5, 14, 'solutionCategories', 24, NULL),
  (4734, 1, 14, 'partnership_solution', NULL, 20),
  (4735, 2, 14, 'partnership_solution', NULL, 26),
  (4736, 3, 14, 'partnership_solution', NULL, 23),
  (4737, 4, 14, 'partnership_solution', NULL, 12),
  (4738, 5, 14, 'partnership_solution', NULL, 27),
  (4739, 6, 14, 'partnership_solution', NULL, 11),
  (4740, 7, 14, 'partnership_solution', NULL, 44),
  (4741, 8, 14, 'partnership_solution', NULL, 25),
  (4742, 9, 14, 'partnership_solution', NULL, 8),
  (4743, 10, 14, 'partnership_solution', NULL, 22),
  (4744, 11, 14, 'partnership_solution', NULL, 18),
  (4745, 12, 14, 'partnership_solution', NULL, 19),
  (4746, 13, 14, 'partnership_solution', NULL, 43),
  (4747, 14, 14, 'partnership_solution', NULL, 7),
  (4748, 15, 14, 'partnership_solution', NULL, 16),
  (4749, 16, 14, 'partnership_solution', NULL, 34),
  (4750, 17, 14, 'partnership_solution', NULL, 36),
  (4751, 18, 14, 'partnership_solution', NULL, 30),
  (4752, 19, 14, 'partnership_solution', NULL, 67),
  (4753, 20, 14, 'partnership_solution', NULL, 66),
  (4754, 21, 14, 'partnership_solution', NULL, 50),
  (4755, 22, 14, 'partnership_solution', NULL, 14),
  (4756, 23, 14, 'partnership_solution', NULL, 39),
  (4757, 24, 14, 'partnership_solution', NULL, 69),
  (4758, 25, 14, 'partnership_solution', NULL, 46),
  (4759, 26, 14, 'partnership_solution', NULL, 40),
  (4760, 27, 14, 'partnership_solution', NULL, 72),
  (4761, 28, 14, 'partnership_solution', NULL, 70),
  (4762, 29, 14, 'partnership_solution', NULL, 32),
  (4763, 30, 14, 'partnership_solution', NULL, 54),
  (4764, 31, 14, 'partnership_solution', NULL, 47),
  (4765, 32, 14, 'partnership_solution', NULL, 28),
  (4766, 33, 14, 'partnership_solution', NULL, 71),
  (4767, 34, 14, 'partnership_solution', NULL, 37),
  (4768, 35, 14, 'partnership_solution', NULL, 17),
  (4769, 36, 14, 'partnership_solution', NULL, 31),
  (4770, 37, 14, 'partnership_solution', NULL, 41),
  (4771, 38, 14, 'partnership_solution', NULL, 48),
  (4772, 39, 14, 'partnership_solution', NULL, 51),
  (4773, 40, 14, 'partnership_solution', NULL, 68),
  (4774, 41, 14, 'partnership_solution', NULL, 38),
  (4775, 42, 14, 'partnership_solution', NULL, 15),
  (4776, 43, 14, 'partnership_solution', NULL, 24),
  (4777, 44, 14, 'partnership_solution', NULL, 52),
  (4778, 45, 14, 'partnership_solution', NULL, 33),
  (4779, 46, 14, 'partnership_solution', NULL, 13),
  (4780, 47, 14, 'partnership_solution', NULL, 9),
  (4781, 48, 14, 'partnership_solution', NULL, 29),
  (4782, 49, 14, 'partnership_solution', NULL, 35),
  (4783, 50, 14, 'partnership_solution', NULL, 53),
  (4784, 51, 14, 'partnership_solution', NULL, 21),
  (4785, 52, 14, 'partnership_solution', NULL, 49);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (5016, 1, 83, 'solutionCategories', 12, NULL),
  (5017, 2, 83, 'solutionCategories', 16, NULL),
  (5018, 3, 83, 'solutionCategories', 18, NULL),
  (5019, 1, 83, 'partnership_solution', NULL, 20),
  (5020, 2, 83, 'partnership_solution', NULL, 24),
  (5021, 3, 83, 'partnership_solution', NULL, 26),
  (5022, 4, 83, 'partnership_solution', NULL, 28),
  (5023, 5, 83, 'partnership_solution', NULL, 39),
  (5024, 6, 83, 'partnership_solution', NULL, 40),
  (5025, 7, 83, 'partnership_solution', NULL, 48),
  (5026, 8, 83, 'partnership_solution', NULL, 51),
  (5027, 9, 83, 'partnership_solution', NULL, 58),
  (5189, 16, 88, 'partnership_solution', NULL, 23),
  (5190, 17, 88, 'partnership_solution', NULL, 24),
  (5191, 18, 88, 'partnership_solution', NULL, 25),
  (5192, 19, 88, 'partnership_solution', NULL, 26),
  (5193, 20, 88, 'partnership_solution', NULL, 27),
  (5194, 21, 88, 'partnership_solution', NULL, 28),
  (5195, 22, 88, 'partnership_solution', NULL, 29),
  (5196, 23, 88, 'partnership_solution', NULL, 30),
  (5197, 24, 88, 'partnership_solution', NULL, 31),
  (5198, 25, 88, 'partnership_solution', NULL, 32),
  (5199, 26, 88, 'partnership_solution', NULL, 33),
  (5200, 27, 88, 'partnership_solution', NULL, 34),
  (5201, 28, 88, 'partnership_solution', NULL, 35),
  (5202, 29, 88, 'partnership_solution', NULL, 36),
  (5203, 30, 88, 'partnership_solution', NULL, 37),
  (5204, 31, 88, 'partnership_solution', NULL, 38),
  (5205, 32, 88, 'partnership_solution', NULL, 39),
  (5206, 33, 88, 'partnership_solution', NULL, 40),
  (5207, 34, 88, 'partnership_solution', NULL, 41),
  (5208, 35, 88, 'partnership_solution', NULL, 43),
  (5209, 36, 88, 'partnership_solution', NULL, 44),
  (5210, 37, 88, 'partnership_solution', NULL, 46),
  (5211, 38, 88, 'partnership_solution', NULL, 47),
  (5212, 39, 88, 'partnership_solution', NULL, 48),
  (5213, 40, 88, 'partnership_solution', NULL, 49),
  (5214, 41, 88, 'partnership_solution', NULL, 50),
  (5215, 42, 88, 'partnership_solution', NULL, 51),
  (5216, 43, 88, 'partnership_solution', NULL, 52),
  (5217, 44, 88, 'partnership_solution', NULL, 53),
  (5218, 45, 88, 'partnership_solution', NULL, 54),
  (5268, 20, 90, 'partnership_solution', NULL, 26),
  (5269, 21, 90, 'partnership_solution', NULL, 27),
  (5270, 22, 90, 'partnership_solution', NULL, 28),
  (5271, 23, 90, 'partnership_solution', NULL, 29),
  (5272, 24, 90, 'partnership_solution', NULL, 30),
  (5273, 25, 90, 'partnership_solution', NULL, 31),
  (5274, 26, 90, 'partnership_solution', NULL, 32),
  (5275, 27, 90, 'partnership_solution', NULL, 33),
  (5276, 28, 90, 'partnership_solution', NULL, 34),
  (5277, 29, 90, 'partnership_solution', NULL, 35),
  (5278, 30, 90, 'partnership_solution', NULL, 36),
  (5279, 31, 90, 'partnership_solution', NULL, 37),
  (5280, 32, 90, 'partnership_solution', NULL, 38),
  (5281, 33, 90, 'partnership_solution', NULL, 39),
  (5282, 34, 90, 'partnership_solution', NULL, 40),
  (5283, 35, 90, 'partnership_solution', NULL, 41),
  (5284, 36, 90, 'partnership_solution', NULL, 42),
  (5285, 37, 90, 'partnership_solution', NULL, 43),
  (5286, 38, 90, 'partnership_solution', NULL, 44),
  (5287, 39, 90, 'partnership_solution', NULL, 45),
  (5288, 40, 90, 'partnership_solution', NULL, 46),
  (5289, 41, 90, 'partnership_solution', NULL, 47),
  (5290, 42, 90, 'partnership_solution', NULL, 48),
  (5291, 43, 90, 'partnership_solution', NULL, 49),
  (5292, 44, 90, 'partnership_solution', NULL, 50),
  (5293, 45, 90, 'partnership_solution', NULL, 51),
  (5294, 46, 90, 'partnership_solution', NULL, 52),
  (5295, 47, 90, 'partnership_solution', NULL, 53),
  (5296, 48, 90, 'partnership_solution', NULL, 54),
  (5297, 49, 90, 'partnership_solution', NULL, 55),
  (5298, 1, 91, 'solutionCategories', 12, NULL),
  (5299, 2, 91, 'solutionCategories', 13, NULL),
  (5300, 3, 91, 'solutionCategories', 16, NULL),
  (5301, 4, 91, 'solutionCategories', 18, NULL),
  (5302, 1, 91, 'partnership_solution', NULL, 7),
  (5303, 2, 91, 'partnership_solution', NULL, 8),
  (5304, 3, 91, 'partnership_solution', NULL, 11),
  (5305, 4, 91, 'partnership_solution', NULL, 12),
  (5306, 5, 91, 'partnership_solution', NULL, 13),
  (5307, 6, 91, 'partnership_solution', NULL, 14),
  (5308, 7, 91, 'partnership_solution', NULL, 15),
  (5309, 8, 91, 'partnership_solution', NULL, 16),
  (5310, 9, 91, 'partnership_solution', NULL, 18),
  (5311, 10, 91, 'partnership_solution', NULL, 19),
  (5312, 11, 91, 'partnership_solution', NULL, 20),
  (5313, 12, 91, 'partnership_solution', NULL, 21),
  (5314, 13, 91, 'partnership_solution', NULL, 22),
  (5315, 14, 91, 'partnership_solution', NULL, 23),
  (5316, 15, 91, 'partnership_solution', NULL, 24),
  (5317, 16, 91, 'partnership_solution', NULL, 25),
  (5318, 17, 91, 'partnership_solution', NULL, 26),
  (5319, 18, 91, 'partnership_solution', NULL, 27),
  (5320, 19, 91, 'partnership_solution', NULL, 28),
  (5321, 20, 91, 'partnership_solution', NULL, 30),
  (5322, 21, 91, 'partnership_solution', NULL, 32),
  (5323, 22, 91, 'partnership_solution', NULL, 34),
  (5324, 23, 91, 'partnership_solution', NULL, 35),
  (5325, 24, 91, 'partnership_solution', NULL, 39);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (5326, 25, 91, 'partnership_solution', NULL, 40),
  (5327, 26, 91, 'partnership_solution', NULL, 41),
  (5328, 27, 91, 'partnership_solution', NULL, 43),
  (5329, 28, 91, 'partnership_solution', NULL, 44),
  (5330, 29, 91, 'partnership_solution', NULL, 46),
  (5331, 30, 91, 'partnership_solution', NULL, 47),
  (5332, 31, 91, 'partnership_solution', NULL, 48),
  (5333, 32, 91, 'partnership_solution', NULL, 49),
  (5334, 33, 91, 'partnership_solution', NULL, 51),
  (5335, 34, 91, 'partnership_solution', NULL, 52),
  (5336, 35, 91, 'partnership_solution', NULL, 53),
  (5337, 36, 91, 'partnership_solution', NULL, 58),
  (5338, 1, 92, 'solutionCategories', 13, NULL),
  (5339, 2, 92, 'solutionCategories', 14, NULL),
  (5340, 3, 92, 'solutionCategories', 27, NULL),
  (5341, 1, 92, 'partnership_solution', NULL, 7),
  (5342, 2, 92, 'partnership_solution', NULL, 8),
  (5343, 3, 92, 'partnership_solution', NULL, 9),
  (5344, 4, 92, 'partnership_solution', NULL, 11),
  (5345, 5, 92, 'partnership_solution', NULL, 12),
  (5346, 6, 92, 'partnership_solution', NULL, 13),
  (5347, 7, 92, 'partnership_solution', NULL, 14),
  (5348, 8, 92, 'partnership_solution', NULL, 15),
  (5349, 9, 92, 'partnership_solution', NULL, 16),
  (5350, 10, 92, 'partnership_solution', NULL, 17),
  (5351, 11, 92, 'partnership_solution', NULL, 18),
  (5352, 12, 92, 'partnership_solution', NULL, 19),
  (5353, 13, 92, 'partnership_solution', NULL, 20),
  (5354, 14, 92, 'partnership_solution', NULL, 21),
  (5355, 15, 92, 'partnership_solution', NULL, 22),
  (5356, 16, 92, 'partnership_solution', NULL, 23),
  (5357, 17, 92, 'partnership_solution', NULL, 24),
  (5358, 18, 92, 'partnership_solution', NULL, 25),
  (5359, 19, 92, 'partnership_solution', NULL, 27),
  (5360, 20, 92, 'partnership_solution', NULL, 29),
  (5361, 21, 92, 'partnership_solution', NULL, 30),
  (5362, 22, 92, 'partnership_solution', NULL, 31),
  (5363, 23, 92, 'partnership_solution', NULL, 32),
  (5364, 24, 92, 'partnership_solution', NULL, 33),
  (5365, 25, 92, 'partnership_solution', NULL, 34),
  (5366, 26, 92, 'partnership_solution', NULL, 35),
  (5367, 27, 92, 'partnership_solution', NULL, 36),
  (5368, 28, 92, 'partnership_solution', NULL, 37),
  (5369, 29, 92, 'partnership_solution', NULL, 38),
  (5370, 30, 92, 'partnership_solution', NULL, 39),
  (5371, 31, 92, 'partnership_solution', NULL, 41),
  (5372, 32, 92, 'partnership_solution', NULL, 43),
  (5373, 33, 92, 'partnership_solution', NULL, 44),
  (5374, 34, 92, 'partnership_solution', NULL, 46),
  (5375, 35, 92, 'partnership_solution', NULL, 47),
  (5376, 36, 92, 'partnership_solution', NULL, 48),
  (5377, 37, 92, 'partnership_solution', NULL, 49),
  (5378, 38, 92, 'partnership_solution', NULL, 50),
  (5379, 39, 92, 'partnership_solution', NULL, 51),
  (5380, 40, 92, 'partnership_solution', NULL, 52),
  (5381, 41, 92, 'partnership_solution', NULL, 53),
  (5382, 42, 92, 'partnership_solution', NULL, 54),
  (5383, 43, 92, 'partnership_solution', NULL, 83),
  (5384, 44, 92, 'partnership_solution', NULL, 84),
  (5385, 45, 92, 'partnership_solution', NULL, 85),
  (5386, 46, 92, 'partnership_solution', NULL, 86),
  (5387, 47, 92, 'partnership_solution', NULL, 87),
  (5388, 1, 93, 'solutionCategories', 13, NULL),
  (5389, 2, 93, 'solutionCategories', 18, NULL),
  (5390, 3, 93, 'solutionCategories', 23, NULL),
  (5391, 1, 93, 'partnership_solution', NULL, 7),
  (5392, 2, 93, 'partnership_solution', NULL, 8),
  (5393, 3, 93, 'partnership_solution', NULL, 11),
  (5394, 4, 93, 'partnership_solution', NULL, 12),
  (5395, 5, 93, 'partnership_solution', NULL, 13),
  (5396, 6, 93, 'partnership_solution', NULL, 14),
  (5397, 7, 93, 'partnership_solution', NULL, 15),
  (5398, 8, 93, 'partnership_solution', NULL, 16),
  (5399, 9, 93, 'partnership_solution', NULL, 18),
  (5400, 10, 93, 'partnership_solution', NULL, 19),
  (5401, 11, 93, 'partnership_solution', NULL, 20),
  (5402, 12, 93, 'partnership_solution', NULL, 21),
  (5403, 13, 93, 'partnership_solution', NULL, 22),
  (5404, 14, 93, 'partnership_solution', NULL, 23),
  (5405, 15, 93, 'partnership_solution', NULL, 24),
  (5406, 16, 93, 'partnership_solution', NULL, 25),
  (5407, 17, 93, 'partnership_solution', NULL, 27),
  (5408, 18, 93, 'partnership_solution', NULL, 28),
  (5409, 19, 93, 'partnership_solution', NULL, 30),
  (5410, 20, 93, 'partnership_solution', NULL, 32),
  (5411, 21, 93, 'partnership_solution', NULL, 34),
  (5412, 22, 93, 'partnership_solution', NULL, 35),
  (5413, 23, 93, 'partnership_solution', NULL, 39),
  (5414, 24, 93, 'partnership_solution', NULL, 41),
  (5415, 25, 93, 'partnership_solution', NULL, 43),
  (5416, 26, 93, 'partnership_solution', NULL, 44),
  (5417, 27, 93, 'partnership_solution', NULL, 46),
  (5418, 28, 93, 'partnership_solution', NULL, 47),
  (5419, 29, 93, 'partnership_solution', NULL, 48),
  (5420, 30, 93, 'partnership_solution', NULL, 49),
  (5421, 31, 93, 'partnership_solution', NULL, 52),
  (5422, 32, 93, 'partnership_solution', NULL, 53),
  (5423, 33, 93, 'partnership_solution', NULL, 58),
  (5424, 34, 93, 'partnership_solution', NULL, 66),
  (5425, 35, 93, 'partnership_solution', NULL, 67);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (5426, 36, 93, 'partnership_solution', NULL, 68),
  (6302, 30, 18, 'partnership_solution', NULL, 40),
  (6303, 31, 18, 'partnership_solution', NULL, 32),
  (6304, 32, 18, 'partnership_solution', NULL, 54),
  (6305, 33, 18, 'partnership_solution', NULL, 105),
  (6306, 34, 18, 'partnership_solution', NULL, 106),
  (6307, 35, 18, 'partnership_solution', NULL, 47),
  (6308, 36, 18, 'partnership_solution', NULL, 28),
  (6309, 37, 18, 'partnership_solution', NULL, 107),
  (6310, 38, 18, 'partnership_solution', NULL, 37),
  (6311, 39, 18, 'partnership_solution', NULL, 17),
  (6312, 40, 18, 'partnership_solution', NULL, 31),
  (6313, 41, 18, 'partnership_solution', NULL, 41),
  (6314, 42, 18, 'partnership_solution', NULL, 48),
  (6315, 43, 18, 'partnership_solution', NULL, 51),
  (6316, 44, 18, 'partnership_solution', NULL, 56),
  (6317, 45, 18, 'partnership_solution', NULL, 38),
  (6318, 46, 18, 'partnership_solution', NULL, 15),
  (6319, 47, 18, 'partnership_solution', NULL, 24),
  (6320, 48, 18, 'partnership_solution', NULL, 52),
  (6321, 49, 18, 'partnership_solution', NULL, 33),
  (6322, 50, 18, 'partnership_solution', NULL, 13),
  (6323, 51, 18, 'partnership_solution', NULL, 9),
  (5449, 1, 95, 'solutionCategories', 13, NULL),
  (5450, 2, 95, 'solutionCategories', 16, NULL),
  (5451, 3, 95, 'solutionCategories', 18, NULL),
  (5452, 4, 95, 'solutionCategories', 23, NULL),
  (5453, 1, 95, 'partnership_solution', NULL, 7),
  (5454, 2, 95, 'partnership_solution', NULL, 8),
  (5455, 3, 95, 'partnership_solution', NULL, 11),
  (5456, 4, 95, 'partnership_solution', NULL, 12),
  (5457, 5, 95, 'partnership_solution', NULL, 13),
  (5458, 6, 95, 'partnership_solution', NULL, 14),
  (5459, 7, 95, 'partnership_solution', NULL, 15),
  (5460, 8, 95, 'partnership_solution', NULL, 16),
  (5461, 9, 95, 'partnership_solution', NULL, 18),
  (5462, 10, 95, 'partnership_solution', NULL, 19),
  (5463, 11, 95, 'partnership_solution', NULL, 20),
  (5464, 12, 95, 'partnership_solution', NULL, 21),
  (5465, 13, 95, 'partnership_solution', NULL, 22),
  (5466, 14, 95, 'partnership_solution', NULL, 23),
  (5467, 15, 95, 'partnership_solution', NULL, 24),
  (5468, 16, 95, 'partnership_solution', NULL, 25),
  (5469, 17, 95, 'partnership_solution', NULL, 27),
  (5470, 18, 95, 'partnership_solution', NULL, 28),
  (5471, 19, 95, 'partnership_solution', NULL, 30),
  (5472, 20, 95, 'partnership_solution', NULL, 32),
  (5473, 21, 95, 'partnership_solution', NULL, 34),
  (5474, 22, 95, 'partnership_solution', NULL, 35),
  (5475, 23, 95, 'partnership_solution', NULL, 39),
  (5476, 24, 95, 'partnership_solution', NULL, 41),
  (5477, 25, 95, 'partnership_solution', NULL, 43),
  (5478, 26, 95, 'partnership_solution', NULL, 44),
  (5479, 27, 95, 'partnership_solution', NULL, 46),
  (5480, 28, 95, 'partnership_solution', NULL, 47),
  (5481, 29, 95, 'partnership_solution', NULL, 48),
  (5482, 30, 95, 'partnership_solution', NULL, 49),
  (5483, 31, 95, 'partnership_solution', NULL, 51),
  (5484, 32, 95, 'partnership_solution', NULL, 52),
  (5485, 33, 95, 'partnership_solution', NULL, 53),
  (5486, 34, 95, 'partnership_solution', NULL, 58),
  (5487, 35, 95, 'partnership_solution', NULL, 66),
  (5488, 36, 95, 'partnership_solution', NULL, 67),
  (5489, 37, 95, 'partnership_solution', NULL, 68),
  (5490, 1, 96, 'solutionCategories', 12, NULL),
  (5491, 2, 96, 'solutionCategories', 15, NULL),
  (5492, 3, 96, 'solutionCategories', 18, NULL),
  (5493, 4, 96, 'solutionCategories', 23, NULL),
  (5494, 1, 96, 'partnership_solution', NULL, 10),
  (5495, 2, 96, 'partnership_solution', NULL, 11),
  (5496, 3, 96, 'partnership_solution', NULL, 20),
  (5497, 4, 96, 'partnership_solution', NULL, 24),
  (5498, 5, 96, 'partnership_solution', NULL, 26),
  (5499, 6, 96, 'partnership_solution', NULL, 28),
  (5500, 7, 96, 'partnership_solution', NULL, 39),
  (5501, 8, 96, 'partnership_solution', NULL, 40),
  (5502, 9, 96, 'partnership_solution', NULL, 42),
  (5503, 10, 96, 'partnership_solution', NULL, 45),
  (5504, 11, 96, 'partnership_solution', NULL, 48),
  (5505, 12, 96, 'partnership_solution', NULL, 51),
  (5506, 13, 96, 'partnership_solution', NULL, 53),
  (5507, 14, 96, 'partnership_solution', NULL, 55),
  (5508, 15, 96, 'partnership_solution', NULL, 58),
  (5509, 16, 96, 'partnership_solution', NULL, 66),
  (5510, 17, 96, 'partnership_solution', NULL, 67),
  (5511, 18, 96, 'partnership_solution', NULL, 68),
  (6324, 52, 18, 'partnership_solution', NULL, 29),
  (6325, 53, 18, 'partnership_solution', NULL, 35),
  (6326, 54, 18, 'partnership_solution', NULL, 53),
  (6327, 55, 18, 'partnership_solution', NULL, 21),
  (6328, 56, 18, 'partnership_solution', NULL, 49),
  (6329, 57, 18, 'partnership_solution', NULL, 108),
  (6330, 58, 18, 'partnership_solution', NULL, 55),
  (6331, 59, 18, 'partnership_solution', NULL, 109),
  (6332, 1, 20, 'solutionCategories', 12, NULL),
  (6333, 2, 20, 'solutionCategories', 13, NULL),
  (6334, 3, 20, 'solutionCategories', 16, NULL),
  (6335, 4, 20, 'solutionCategories', 18, NULL),
  (6336, 1, 20, 'partnership_solution', NULL, 20),
  (6337, 2, 20, 'partnership_solution', NULL, 26);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6338, 3, 20, 'partnership_solution', NULL, 23),
  (6339, 4, 20, 'partnership_solution', NULL, 12),
  (6340, 5, 20, 'partnership_solution', NULL, 27),
  (6341, 6, 20, 'partnership_solution', NULL, 11),
  (6342, 7, 20, 'partnership_solution', NULL, 44),
  (6343, 8, 20, 'partnership_solution', NULL, 25),
  (5532, 1, 98, 'solutionCategories', 12, NULL),
  (5533, 2, 98, 'solutionCategories', 15, NULL),
  (5534, 3, 98, 'solutionCategories', 23, NULL),
  (5535, 1, 98, 'partnership_solution', NULL, 10),
  (5536, 2, 98, 'partnership_solution', NULL, 11),
  (5537, 3, 98, 'partnership_solution', NULL, 20),
  (5538, 4, 98, 'partnership_solution', NULL, 24),
  (5539, 5, 98, 'partnership_solution', NULL, 26),
  (5540, 6, 98, 'partnership_solution', NULL, 28),
  (5541, 7, 98, 'partnership_solution', NULL, 39),
  (5542, 8, 98, 'partnership_solution', NULL, 40),
  (5543, 9, 98, 'partnership_solution', NULL, 42),
  (5544, 10, 98, 'partnership_solution', NULL, 45),
  (5545, 11, 98, 'partnership_solution', NULL, 48),
  (5546, 12, 98, 'partnership_solution', NULL, 51),
  (5547, 13, 98, 'partnership_solution', NULL, 53),
  (5548, 14, 98, 'partnership_solution', NULL, 55),
  (5549, 15, 98, 'partnership_solution', NULL, 66),
  (5550, 16, 98, 'partnership_solution', NULL, 67),
  (5551, 17, 98, 'partnership_solution', NULL, 68),
  (6344, 9, 20, 'partnership_solution', NULL, 8),
  (6345, 10, 20, 'partnership_solution', NULL, 22),
  (6346, 11, 20, 'partnership_solution', NULL, 18),
  (6347, 12, 20, 'partnership_solution', NULL, 19),
  (6348, 13, 20, 'partnership_solution', NULL, 43),
  (6349, 14, 20, 'partnership_solution', NULL, 7),
  (6350, 15, 20, 'partnership_solution', NULL, 16),
  (6351, 16, 20, 'partnership_solution', NULL, 34),
  (6352, 17, 20, 'partnership_solution', NULL, 30),
  (6353, 18, 20, 'partnership_solution', NULL, 14),
  (6354, 19, 20, 'partnership_solution', NULL, 39),
  (6355, 20, 20, 'partnership_solution', NULL, 46),
  (6356, 21, 20, 'partnership_solution', NULL, 40),
  (6357, 22, 20, 'partnership_solution', NULL, 32),
  (6358, 23, 20, 'partnership_solution', NULL, 58),
  (6359, 24, 20, 'partnership_solution', NULL, 47),
  (6360, 25, 20, 'partnership_solution', NULL, 28),
  (6361, 26, 20, 'partnership_solution', NULL, 41),
  (6362, 27, 20, 'partnership_solution', NULL, 48),
  (6363, 28, 20, 'partnership_solution', NULL, 51),
  (6364, 29, 20, 'partnership_solution', NULL, 15),
  (5582, 1, 100, 'solutionCategories', 12, NULL),
  (5583, 2, 100, 'solutionCategories', 18, NULL),
  (5584, 3, 100, 'solutionCategories', 23, NULL),
  (5585, 1, 100, 'partnership_solution', NULL, 20),
  (5586, 2, 100, 'partnership_solution', NULL, 24),
  (5587, 3, 100, 'partnership_solution', NULL, 26),
  (5588, 4, 100, 'partnership_solution', NULL, 28),
  (5589, 5, 100, 'partnership_solution', NULL, 39),
  (5590, 6, 100, 'partnership_solution', NULL, 40),
  (5591, 7, 100, 'partnership_solution', NULL, 48),
  (5592, 8, 100, 'partnership_solution', NULL, 51),
  (5593, 9, 100, 'partnership_solution', NULL, 58),
  (5594, 10, 100, 'partnership_solution', NULL, 66),
  (5595, 11, 100, 'partnership_solution', NULL, 67),
  (5596, 12, 100, 'partnership_solution', NULL, 68),
  (5597, 1, 94, 'solutionCategories', 12, NULL),
  (5598, 2, 94, 'solutionCategories', 15, NULL),
  (5599, 3, 94, 'solutionCategories', 18, NULL),
  (5600, 4, 94, 'solutionCategories', 23, NULL),
  (5601, 1, 94, 'partnership_solution', NULL, 10),
  (5602, 2, 94, 'partnership_solution', NULL, 11),
  (5603, 3, 94, 'partnership_solution', NULL, 20),
  (5604, 4, 94, 'partnership_solution', NULL, 24),
  (5605, 5, 94, 'partnership_solution', NULL, 26),
  (5606, 6, 94, 'partnership_solution', NULL, 28),
  (5607, 7, 94, 'partnership_solution', NULL, 39),
  (5608, 8, 94, 'partnership_solution', NULL, 40),
  (5609, 9, 94, 'partnership_solution', NULL, 42),
  (5610, 10, 94, 'partnership_solution', NULL, 45),
  (5611, 11, 94, 'partnership_solution', NULL, 48),
  (5612, 12, 94, 'partnership_solution', NULL, 51),
  (5613, 13, 94, 'partnership_solution', NULL, 53),
  (5614, 14, 94, 'partnership_solution', NULL, 55),
  (5615, 15, 94, 'partnership_solution', NULL, 58),
  (5616, 16, 94, 'partnership_solution', NULL, 66),
  (5617, 17, 94, 'partnership_solution', NULL, 67),
  (5618, 18, 94, 'partnership_solution', NULL, 68),
  (5658, 1, 102, 'solutionCategories', 13, NULL),
  (5659, 2, 102, 'solutionCategories', 16, NULL),
  (5660, 3, 102, 'solutionCategories', 23, NULL),
  (5661, 1, 102, 'partnership_solution', NULL, 7),
  (5662, 2, 102, 'partnership_solution', NULL, 8),
  (5663, 3, 102, 'partnership_solution', NULL, 11),
  (5664, 4, 102, 'partnership_solution', NULL, 12),
  (5665, 5, 102, 'partnership_solution', NULL, 13),
  (5666, 6, 102, 'partnership_solution', NULL, 14),
  (5667, 7, 102, 'partnership_solution', NULL, 15),
  (5668, 8, 102, 'partnership_solution', NULL, 16),
  (5669, 9, 102, 'partnership_solution', NULL, 18),
  (5670, 10, 102, 'partnership_solution', NULL, 19),
  (5671, 11, 102, 'partnership_solution', NULL, 20),
  (5672, 12, 102, 'partnership_solution', NULL, 21),
  (5673, 13, 102, 'partnership_solution', NULL, 22);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (5674, 14, 102, 'partnership_solution', NULL, 23),
  (5675, 15, 102, 'partnership_solution', NULL, 24),
  (5676, 16, 102, 'partnership_solution', NULL, 25),
  (5677, 17, 102, 'partnership_solution', NULL, 27),
  (5678, 18, 102, 'partnership_solution', NULL, 28),
  (5679, 19, 102, 'partnership_solution', NULL, 30),
  (5680, 20, 102, 'partnership_solution', NULL, 32),
  (5681, 21, 102, 'partnership_solution', NULL, 34),
  (5682, 22, 102, 'partnership_solution', NULL, 35),
  (5683, 23, 102, 'partnership_solution', NULL, 39),
  (5684, 24, 102, 'partnership_solution', NULL, 41),
  (5685, 25, 102, 'partnership_solution', NULL, 43),
  (5686, 26, 102, 'partnership_solution', NULL, 44),
  (5687, 27, 102, 'partnership_solution', NULL, 46),
  (5688, 28, 102, 'partnership_solution', NULL, 47),
  (5689, 29, 102, 'partnership_solution', NULL, 48),
  (5690, 30, 102, 'partnership_solution', NULL, 49),
  (5691, 31, 102, 'partnership_solution', NULL, 51),
  (5692, 32, 102, 'partnership_solution', NULL, 52),
  (5693, 33, 102, 'partnership_solution', NULL, 53),
  (5694, 34, 102, 'partnership_solution', NULL, 66),
  (5695, 35, 102, 'partnership_solution', NULL, 67),
  (5696, 36, 102, 'partnership_solution', NULL, 68),
  (6365, 30, 20, 'partnership_solution', NULL, 24),
  (6366, 31, 20, 'partnership_solution', NULL, 52),
  (6367, 32, 20, 'partnership_solution', NULL, 13),
  (6368, 33, 20, 'partnership_solution', NULL, 35),
  (6369, 34, 20, 'partnership_solution', NULL, 53),
  (6370, 35, 20, 'partnership_solution', NULL, 21),
  (6371, 36, 20, 'partnership_solution', NULL, 49),
  (6372, 1, 22, 'solutionCategories', 13, NULL),
  (6373, 2, 22, 'solutionCategories', 14, NULL),
  (6374, 3, 22, 'solutionCategories', 15, NULL),
  (6375, 1, 22, 'partnership_solution', NULL, 20),
  (6376, 2, 22, 'partnership_solution', NULL, 23),
  (6377, 3, 22, 'partnership_solution', NULL, 12),
  (6378, 4, 22, 'partnership_solution', NULL, 27),
  (6379, 5, 22, 'partnership_solution', NULL, 10),
  (6380, 6, 22, 'partnership_solution', NULL, 45),
  (6381, 7, 22, 'partnership_solution', NULL, 11),
  (6382, 8, 22, 'partnership_solution', NULL, 44),
  (6383, 9, 22, 'partnership_solution', NULL, 25),
  (6384, 10, 22, 'partnership_solution', NULL, 8),
  (6385, 11, 22, 'partnership_solution', NULL, 22),
  (6386, 12, 22, 'partnership_solution', NULL, 18),
  (6387, 13, 22, 'partnership_solution', NULL, 19),
  (6388, 14, 22, 'partnership_solution', NULL, 43),
  (6389, 15, 22, 'partnership_solution', NULL, 7),
  (6390, 16, 22, 'partnership_solution', NULL, 16),
  (6391, 17, 22, 'partnership_solution', NULL, 34),
  (6392, 18, 22, 'partnership_solution', NULL, 36),
  (6393, 19, 22, 'partnership_solution', NULL, 30),
  (6394, 20, 22, 'partnership_solution', NULL, 42),
  (6395, 21, 22, 'partnership_solution', NULL, 50),
  (6396, 22, 22, 'partnership_solution', NULL, 14),
  (6397, 23, 22, 'partnership_solution', NULL, 39),
  (6398, 24, 22, 'partnership_solution', NULL, 46),
  (6399, 25, 22, 'partnership_solution', NULL, 32),
  (6400, 26, 22, 'partnership_solution', NULL, 54),
  (6401, 27, 22, 'partnership_solution', NULL, 47),
  (6402, 28, 22, 'partnership_solution', NULL, 37),
  (6403, 29, 22, 'partnership_solution', NULL, 17),
  (6404, 30, 22, 'partnership_solution', NULL, 31),
  (6405, 31, 22, 'partnership_solution', NULL, 41),
  (6406, 32, 22, 'partnership_solution', NULL, 48),
  (6407, 33, 22, 'partnership_solution', NULL, 51),
  (6408, 34, 22, 'partnership_solution', NULL, 38),
  (6409, 35, 22, 'partnership_solution', NULL, 15),
  (6410, 36, 22, 'partnership_solution', NULL, 24),
  (6411, 37, 22, 'partnership_solution', NULL, 52),
  (6412, 38, 22, 'partnership_solution', NULL, 33),
  (6413, 39, 22, 'partnership_solution', NULL, 13),
  (6414, 40, 22, 'partnership_solution', NULL, 9),
  (6415, 41, 22, 'partnership_solution', NULL, 29),
  (6416, 42, 22, 'partnership_solution', NULL, 35),
  (6417, 43, 22, 'partnership_solution', NULL, 53),
  (6418, 44, 22, 'partnership_solution', NULL, 21),
  (6419, 45, 22, 'partnership_solution', NULL, 49),
  (6420, 46, 22, 'partnership_solution', NULL, 55),
  (6677, 1, 37, 'solutionCategories', 12, NULL),
  (6678, 2, 37, 'solutionCategories', 18, NULL),
  (6679, 1, 37, 'partnership_solution', NULL, 20),
  (6680, 2, 37, 'partnership_solution', NULL, 26),
  (6681, 3, 37, 'partnership_solution', NULL, 39),
  (6682, 4, 37, 'partnership_solution', NULL, 40),
  (6683, 5, 37, 'partnership_solution', NULL, 28),
  (6684, 6, 37, 'partnership_solution', NULL, 51),
  (6685, 7, 37, 'partnership_solution', NULL, 48),
  (6686, 8, 37, 'partnership_solution', NULL, 58),
  (6687, 9, 37, 'partnership_solution', NULL, 24),
  (6688, 1, 39, 'solutionCategories', 14, NULL),
  (6689, 2, 39, 'solutionCategories', 12, NULL),
  (6690, 3, 39, 'solutionCategories', 15, NULL),
  (6691, 4, 39, 'solutionCategories', 13, NULL),
  (6692, 1, 39, 'partnership_solution', NULL, 20),
  (6693, 2, 39, 'partnership_solution', NULL, 27),
  (6694, 3, 39, 'partnership_solution', NULL, 11),
  (6695, 4, 39, 'partnership_solution', NULL, 22),
  (6696, 5, 39, 'partnership_solution', NULL, 36),
  (6421, 1, 24, 'solutionCategories', 12, NULL);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6422, 2, 24, 'solutionCategories', 14, NULL),
  (6423, 3, 24, 'solutionCategories', 18, NULL),
  (6424, 1, 24, 'partnership_solution', NULL, 20),
  (6425, 2, 24, 'partnership_solution', NULL, 26),
  (6426, 3, 24, 'partnership_solution', NULL, 27),
  (6427, 4, 24, 'partnership_solution', NULL, 11),
  (6428, 5, 24, 'partnership_solution', NULL, 22),
  (6429, 6, 24, 'partnership_solution', NULL, 36),
  (6430, 7, 24, 'partnership_solution', NULL, 50),
  (6431, 8, 24, 'partnership_solution', NULL, 14),
  (6432, 9, 24, 'partnership_solution', NULL, 39),
  (6433, 10, 24, 'partnership_solution', NULL, 40),
  (6434, 11, 24, 'partnership_solution', NULL, 54),
  (6435, 12, 24, 'partnership_solution', NULL, 58),
  (6436, 13, 24, 'partnership_solution', NULL, 28),
  (6437, 14, 24, 'partnership_solution', NULL, 37),
  (6438, 15, 24, 'partnership_solution', NULL, 17),
  (6439, 16, 24, 'partnership_solution', NULL, 31),
  (6440, 17, 24, 'partnership_solution', NULL, 48),
  (6441, 18, 24, 'partnership_solution', NULL, 51),
  (6442, 19, 24, 'partnership_solution', NULL, 38),
  (6443, 20, 24, 'partnership_solution', NULL, 24),
  (6444, 21, 24, 'partnership_solution', NULL, 52),
  (6445, 22, 24, 'partnership_solution', NULL, 33),
  (6446, 23, 24, 'partnership_solution', NULL, 9),
  (6447, 24, 24, 'partnership_solution', NULL, 29),
  (6697, 6, 39, 'partnership_solution', NULL, 50),
  (6698, 7, 39, 'partnership_solution', NULL, 14),
  (6699, 8, 39, 'partnership_solution', NULL, 39),
  (6700, 9, 39, 'partnership_solution', NULL, 54),
  (6701, 10, 39, 'partnership_solution', NULL, 37),
  (6702, 11, 39, 'partnership_solution', NULL, 31),
  (6703, 12, 39, 'partnership_solution', NULL, 51),
  (6704, 13, 39, 'partnership_solution', NULL, 38),
  (6705, 14, 39, 'partnership_solution', NULL, 33),
  (6706, 15, 39, 'partnership_solution', NULL, 9),
  (6707, 16, 39, 'partnership_solution', NULL, 29),
  (6708, 17, 39, 'partnership_solution', NULL, 52),
  (6709, 18, 39, 'partnership_solution', NULL, 17),
  (6710, 19, 39, 'partnership_solution', NULL, 26),
  (6711, 20, 39, 'partnership_solution', NULL, 40),
  (6712, 21, 39, 'partnership_solution', NULL, 28),
  (6713, 22, 39, 'partnership_solution', NULL, 48),
  (6714, 23, 39, 'partnership_solution', NULL, 10),
  (6715, 24, 39, 'partnership_solution', NULL, 45),
  (5743, 1, 104, 'solutionCategories', 13, NULL),
  (5744, 2, 104, 'solutionCategories', 14, NULL),
  (5745, 3, 104, 'solutionCategories', 16, NULL),
  (5746, 1, 104, 'partnership_solution', NULL, 7),
  (5747, 2, 104, 'partnership_solution', NULL, 8),
  (5748, 3, 104, 'partnership_solution', NULL, 9),
  (5749, 4, 104, 'partnership_solution', NULL, 11),
  (5750, 5, 104, 'partnership_solution', NULL, 12),
  (5751, 6, 104, 'partnership_solution', NULL, 13),
  (5752, 7, 104, 'partnership_solution', NULL, 14),
  (5753, 8, 104, 'partnership_solution', NULL, 15),
  (5754, 9, 104, 'partnership_solution', NULL, 16),
  (5755, 10, 104, 'partnership_solution', NULL, 17),
  (5756, 11, 104, 'partnership_solution', NULL, 18),
  (5757, 12, 104, 'partnership_solution', NULL, 19),
  (5758, 13, 104, 'partnership_solution', NULL, 20),
  (5759, 14, 104, 'partnership_solution', NULL, 21),
  (5760, 15, 104, 'partnership_solution', NULL, 22),
  (5761, 16, 104, 'partnership_solution', NULL, 23),
  (5762, 17, 104, 'partnership_solution', NULL, 24),
  (5763, 18, 104, 'partnership_solution', NULL, 25),
  (5764, 19, 104, 'partnership_solution', NULL, 27),
  (5765, 20, 104, 'partnership_solution', NULL, 28),
  (5766, 21, 104, 'partnership_solution', NULL, 29),
  (5767, 22, 104, 'partnership_solution', NULL, 30),
  (5768, 23, 104, 'partnership_solution', NULL, 31),
  (5769, 24, 104, 'partnership_solution', NULL, 32),
  (5770, 25, 104, 'partnership_solution', NULL, 33),
  (5771, 26, 104, 'partnership_solution', NULL, 34),
  (5772, 27, 104, 'partnership_solution', NULL, 35),
  (5773, 28, 104, 'partnership_solution', NULL, 36),
  (5774, 29, 104, 'partnership_solution', NULL, 37),
  (5775, 30, 104, 'partnership_solution', NULL, 38),
  (5776, 31, 104, 'partnership_solution', NULL, 39),
  (5777, 32, 104, 'partnership_solution', NULL, 41),
  (5778, 33, 104, 'partnership_solution', NULL, 43),
  (5779, 34, 104, 'partnership_solution', NULL, 44),
  (5780, 35, 104, 'partnership_solution', NULL, 46),
  (5781, 36, 104, 'partnership_solution', NULL, 47),
  (5782, 37, 104, 'partnership_solution', NULL, 48),
  (5783, 38, 104, 'partnership_solution', NULL, 49),
  (5784, 39, 104, 'partnership_solution', NULL, 50),
  (5785, 40, 104, 'partnership_solution', NULL, 51),
  (5786, 41, 104, 'partnership_solution', NULL, 52),
  (5787, 42, 104, 'partnership_solution', NULL, 53),
  (5788, 43, 104, 'partnership_solution', NULL, 54),
  (6716, 25, 39, 'partnership_solution', NULL, 42),
  (6717, 26, 39, 'partnership_solution', NULL, 53),
  (6718, 27, 39, 'partnership_solution', NULL, 55),
  (6719, 28, 39, 'partnership_solution', NULL, 23),
  (6720, 29, 39, 'partnership_solution', NULL, 12),
  (6721, 30, 39, 'partnership_solution', NULL, 44),
  (6722, 31, 39, 'partnership_solution', NULL, 19),
  (6723, 32, 39, 'partnership_solution', NULL, 43),
  (6724, 33, 39, 'partnership_solution', NULL, 16);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6725, 34, 39, 'partnership_solution', NULL, 34),
  (6726, 35, 39, 'partnership_solution', NULL, 46),
  (6727, 36, 39, 'partnership_solution', NULL, 32),
  (6728, 37, 39, 'partnership_solution', NULL, 15),
  (6729, 38, 39, 'partnership_solution', NULL, 24),
  (6730, 39, 39, 'partnership_solution', NULL, 13),
  (6448, 1, 27, 'solutionCategories', 30, NULL),
  (6449, 2, 27, 'solutionCategories', 14, NULL),
  (6450, 3, 27, 'solutionCategories', 13, NULL),
  (6451, 4, 27, 'solutionCategories', 12, NULL),
  (6452, 1, 27, 'partnership_solution', NULL, 20),
  (6453, 2, 27, 'partnership_solution', NULL, 27),
  (6454, 3, 27, 'partnership_solution', NULL, 102),
  (6455, 4, 27, 'partnership_solution', NULL, 22),
  (6456, 5, 27, 'partnership_solution', NULL, 103),
  (6457, 6, 27, 'partnership_solution', NULL, 104),
  (6458, 7, 27, 'partnership_solution', NULL, 54),
  (6459, 8, 27, 'partnership_solution', NULL, 105),
  (6460, 9, 27, 'partnership_solution', NULL, 106),
  (6461, 10, 27, 'partnership_solution', NULL, 107),
  (6462, 11, 27, 'partnership_solution', NULL, 56),
  (7179, 6, 71, 'partnership_solution', NULL, 51),
  (7180, 7, 71, 'partnership_solution', NULL, 48),
  (7181, 8, 71, 'partnership_solution', NULL, 58),
  (7182, 9, 71, 'partnership_solution', NULL, 24),
  (7183, 10, 71, 'partnership_solution', NULL, 27),
  (7184, 11, 71, 'partnership_solution', NULL, 11),
  (7185, 12, 71, 'partnership_solution', NULL, 22),
  (7186, 13, 71, 'partnership_solution', NULL, 36),
  (7187, 14, 71, 'partnership_solution', NULL, 50),
  (7188, 15, 71, 'partnership_solution', NULL, 14),
  (7189, 16, 71, 'partnership_solution', NULL, 54),
  (7190, 17, 71, 'partnership_solution', NULL, 37),
  (7191, 18, 71, 'partnership_solution', NULL, 31),
  (7192, 19, 71, 'partnership_solution', NULL, 38),
  (7193, 20, 71, 'partnership_solution', NULL, 33),
  (7194, 21, 71, 'partnership_solution', NULL, 9),
  (7195, 22, 71, 'partnership_solution', NULL, 29),
  (7196, 23, 71, 'partnership_solution', NULL, 52),
  (7197, 24, 71, 'partnership_solution', NULL, 17),
  (7198, 25, 71, 'partnership_solution', NULL, 23),
  (7199, 26, 71, 'partnership_solution', NULL, 12),
  (7200, 27, 71, 'partnership_solution', NULL, 44),
  (7201, 28, 71, 'partnership_solution', NULL, 19),
  (7202, 29, 71, 'partnership_solution', NULL, 43),
  (7203, 30, 71, 'partnership_solution', NULL, 16),
  (7204, 31, 71, 'partnership_solution', NULL, 34),
  (7205, 32, 71, 'partnership_solution', NULL, 46),
  (7206, 33, 71, 'partnership_solution', NULL, 32),
  (7207, 34, 71, 'partnership_solution', NULL, 53),
  (7208, 35, 71, 'partnership_solution', NULL, 15),
  (6463, 12, 27, 'partnership_solution', NULL, 108),
  (6464, 13, 27, 'partnership_solution', NULL, 109),
  (6465, 14, 27, 'partnership_solution', NULL, 110),
  (6466, 15, 27, 'partnership_solution', NULL, 11),
  (6467, 16, 27, 'partnership_solution', NULL, 36),
  (6468, 17, 27, 'partnership_solution', NULL, 50),
  (6469, 18, 27, 'partnership_solution', NULL, 14),
  (6470, 19, 27, 'partnership_solution', NULL, 39),
  (6471, 20, 27, 'partnership_solution', NULL, 37),
  (6472, 21, 27, 'partnership_solution', NULL, 31),
  (6473, 22, 27, 'partnership_solution', NULL, 51),
  (6474, 23, 27, 'partnership_solution', NULL, 38),
  (6475, 24, 27, 'partnership_solution', NULL, 33),
  (6476, 25, 27, 'partnership_solution', NULL, 9),
  (6477, 26, 27, 'partnership_solution', NULL, 29),
  (6478, 27, 27, 'partnership_solution', NULL, 52),
  (6479, 28, 27, 'partnership_solution', NULL, 17),
  (6480, 29, 27, 'partnership_solution', NULL, 23),
  (6481, 30, 27, 'partnership_solution', NULL, 12),
  (6482, 31, 27, 'partnership_solution', NULL, 44),
  (6483, 32, 27, 'partnership_solution', NULL, 19),
  (6484, 33, 27, 'partnership_solution', NULL, 43),
  (6485, 34, 27, 'partnership_solution', NULL, 16),
  (6486, 35, 27, 'partnership_solution', NULL, 34),
  (6487, 36, 27, 'partnership_solution', NULL, 46),
  (7209, 36, 71, 'partnership_solution', NULL, 13),
  (7210, 37, 71, 'partnership_solution', NULL, 35),
  (7211, 38, 71, 'partnership_solution', NULL, 49),
  (7212, 39, 71, 'partnership_solution', NULL, 25),
  (7213, 40, 71, 'partnership_solution', NULL, 8),
  (7214, 41, 71, 'partnership_solution', NULL, 18),
  (7215, 42, 71, 'partnership_solution', NULL, 7),
  (7216, 43, 71, 'partnership_solution', NULL, 30),
  (7217, 44, 71, 'partnership_solution', NULL, 47),
  (7218, 45, 71, 'partnership_solution', NULL, 41),
  (7219, 46, 71, 'partnership_solution', NULL, 21),
  (7391, 10, 61, 'partnership_solution', NULL, 27),
  (7392, 11, 61, 'partnership_solution', NULL, 11),
  (7393, 12, 61, 'partnership_solution', NULL, 44),
  (7394, 13, 61, 'partnership_solution', NULL, 22),
  (7395, 14, 61, 'partnership_solution', NULL, 19),
  (7396, 15, 61, 'partnership_solution', NULL, 43),
  (7397, 16, 61, 'partnership_solution', NULL, 16),
  (7398, 17, 61, 'partnership_solution', NULL, 34),
  (7399, 18, 61, 'partnership_solution', NULL, 14),
  (7400, 19, 61, 'partnership_solution', NULL, 46),
  (7401, 20, 61, 'partnership_solution', NULL, 32),
  (7402, 21, 61, 'partnership_solution', NULL, 53),
  (7403, 22, 61, 'partnership_solution', NULL, 15);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (7404, 23, 61, 'partnership_solution', NULL, 24),
  (6488, 37, 27, 'partnership_solution', NULL, 32),
  (6489, 38, 27, 'partnership_solution', NULL, 53),
  (6490, 39, 27, 'partnership_solution', NULL, 15),
  (6491, 40, 27, 'partnership_solution', NULL, 24),
  (6492, 41, 27, 'partnership_solution', NULL, 13),
  (6493, 42, 27, 'partnership_solution', NULL, 35),
  (6494, 43, 27, 'partnership_solution', NULL, 49),
  (6495, 44, 27, 'partnership_solution', NULL, 25),
  (6496, 45, 27, 'partnership_solution', NULL, 8),
  (6497, 46, 27, 'partnership_solution', NULL, 18),
  (6498, 47, 27, 'partnership_solution', NULL, 7),
  (6499, 48, 27, 'partnership_solution', NULL, 30),
  (6500, 49, 27, 'partnership_solution', NULL, 47),
  (6501, 50, 27, 'partnership_solution', NULL, 41),
  (6502, 51, 27, 'partnership_solution', NULL, 48),
  (6503, 52, 27, 'partnership_solution', NULL, 21),
  (6504, 53, 27, 'partnership_solution', NULL, 26),
  (6505, 54, 27, 'partnership_solution', NULL, 40),
  (6506, 55, 27, 'partnership_solution', NULL, 28),
  (6731, 40, 39, 'partnership_solution', NULL, 35),
  (6732, 41, 39, 'partnership_solution', NULL, 49),
  (6733, 42, 39, 'partnership_solution', NULL, 25),
  (6734, 43, 39, 'partnership_solution', NULL, 8),
  (6735, 44, 39, 'partnership_solution', NULL, 18),
  (6736, 45, 39, 'partnership_solution', NULL, 7),
  (6737, 46, 39, 'partnership_solution', NULL, 30),
  (6738, 47, 39, 'partnership_solution', NULL, 47),
  (6739, 48, 39, 'partnership_solution', NULL, 41),
  (6740, 49, 39, 'partnership_solution', NULL, 21),
  (6741, 1, 41, 'solutionCategories', 30, NULL),
  (6742, 2, 41, 'solutionCategories', 15, NULL),
  (6743, 3, 41, 'solutionCategories', 23, NULL),
  (6744, 1, 41, 'partnership_solution', NULL, 20),
  (6745, 2, 41, 'partnership_solution', NULL, 27),
  (6746, 3, 41, 'partnership_solution', NULL, 102),
  (6747, 4, 41, 'partnership_solution', NULL, 22),
  (6748, 5, 41, 'partnership_solution', NULL, 103),
  (6749, 6, 41, 'partnership_solution', NULL, 104),
  (6750, 7, 41, 'partnership_solution', NULL, 54),
  (6751, 8, 41, 'partnership_solution', NULL, 105),
  (6752, 9, 41, 'partnership_solution', NULL, 106),
  (6753, 10, 41, 'partnership_solution', NULL, 107),
  (6754, 11, 41, 'partnership_solution', NULL, 56),
  (6755, 12, 41, 'partnership_solution', NULL, 108),
  (6756, 13, 41, 'partnership_solution', NULL, 109),
  (6757, 14, 41, 'partnership_solution', NULL, 110),
  (6758, 15, 41, 'partnership_solution', NULL, 10),
  (6759, 16, 41, 'partnership_solution', NULL, 45),
  (6760, 17, 41, 'partnership_solution', NULL, 11),
  (6761, 18, 41, 'partnership_solution', NULL, 42),
  (6762, 19, 41, 'partnership_solution', NULL, 53),
  (6763, 20, 41, 'partnership_solution', NULL, 55),
  (6764, 21, 41, 'partnership_solution', NULL, 24),
  (6765, 22, 41, 'partnership_solution', NULL, 66),
  (6766, 23, 41, 'partnership_solution', NULL, 67),
  (6767, 24, 41, 'partnership_solution', NULL, 68),
  (7220, 1, 69, 'solutionCategories', 18, NULL),
  (7221, 2, 69, 'solutionCategories', 13, NULL),
  (7222, 3, 69, 'solutionCategories', 16, NULL),
  (7223, 4, 69, 'solutionCategories', 12, NULL),
  (7224, 1, 69, 'partnership_solution', NULL, 58),
  (7225, 2, 69, 'partnership_solution', NULL, 28),
  (7226, 3, 69, 'partnership_solution', NULL, 24),
  (7227, 4, 69, 'partnership_solution', NULL, 23),
  (7228, 5, 69, 'partnership_solution', NULL, 12),
  (7229, 6, 69, 'partnership_solution', NULL, 27),
  (7230, 7, 69, 'partnership_solution', NULL, 11),
  (7231, 8, 69, 'partnership_solution', NULL, 44),
  (7232, 9, 69, 'partnership_solution', NULL, 22),
  (7233, 10, 69, 'partnership_solution', NULL, 19),
  (7234, 11, 69, 'partnership_solution', NULL, 43),
  (7235, 12, 69, 'partnership_solution', NULL, 16),
  (7236, 13, 69, 'partnership_solution', NULL, 34),
  (7237, 14, 69, 'partnership_solution', NULL, 14),
  (7238, 15, 69, 'partnership_solution', NULL, 39),
  (7239, 16, 69, 'partnership_solution', NULL, 46),
  (7240, 17, 69, 'partnership_solution', NULL, 32),
  (7241, 18, 69, 'partnership_solution', NULL, 53),
  (7242, 19, 69, 'partnership_solution', NULL, 15),
  (7243, 20, 69, 'partnership_solution', NULL, 13),
  (7244, 21, 69, 'partnership_solution', NULL, 35),
  (7245, 22, 69, 'partnership_solution', NULL, 49),
  (7246, 23, 69, 'partnership_solution', NULL, 25),
  (7247, 24, 69, 'partnership_solution', NULL, 8),
  (7248, 25, 69, 'partnership_solution', NULL, 18),
  (7249, 26, 69, 'partnership_solution', NULL, 7),
  (7250, 27, 69, 'partnership_solution', NULL, 30),
  (7251, 28, 69, 'partnership_solution', NULL, 47),
  (7252, 29, 69, 'partnership_solution', NULL, 41),
  (7253, 30, 69, 'partnership_solution', NULL, 48),
  (7254, 31, 69, 'partnership_solution', NULL, 52),
  (7255, 32, 69, 'partnership_solution', NULL, 21),
  (7256, 33, 69, 'partnership_solution', NULL, 51),
  (7257, 34, 69, 'partnership_solution', NULL, 20),
  (7258, 35, 69, 'partnership_solution', NULL, 26),
  (7259, 36, 69, 'partnership_solution', NULL, 40),
  (7405, 24, 61, 'partnership_solution', NULL, 13),
  (7406, 25, 61, 'partnership_solution', NULL, 35),
  (7407, 26, 61, 'partnership_solution', NULL, 49);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (7408, 27, 61, 'partnership_solution', NULL, 25),
  (7409, 28, 61, 'partnership_solution', NULL, 8),
  (7410, 29, 61, 'partnership_solution', NULL, 18),
  (7411, 30, 61, 'partnership_solution', NULL, 7),
  (7412, 31, 61, 'partnership_solution', NULL, 30),
  (7413, 32, 61, 'partnership_solution', NULL, 47),
  (7414, 33, 61, 'partnership_solution', NULL, 41),
  (7415, 34, 61, 'partnership_solution', NULL, 52),
  (7416, 35, 61, 'partnership_solution', NULL, 21),
  (7417, 36, 61, 'partnership_solution', NULL, 58),
  (6507, 1, 29, 'solutionCategories', 23, NULL),
  (6508, 2, 29, 'solutionCategories', 24, NULL),
  (6509, 3, 29, 'solutionCategories', 14, NULL),
  (6510, 1, 29, 'partnership_solution', NULL, 20),
  (6511, 2, 29, 'partnership_solution', NULL, 24),
  (6512, 3, 29, 'partnership_solution', NULL, 66),
  (6513, 4, 29, 'partnership_solution', NULL, 67),
  (6514, 5, 29, 'partnership_solution', NULL, 68),
  (6515, 6, 29, 'partnership_solution', NULL, 27),
  (6516, 7, 29, 'partnership_solution', NULL, 69),
  (6517, 8, 29, 'partnership_solution', NULL, 70),
  (6518, 9, 29, 'partnership_solution', NULL, 71),
  (6519, 10, 29, 'partnership_solution', NULL, 72),
  (6520, 11, 29, 'partnership_solution', NULL, 54),
  (6521, 12, 29, 'partnership_solution', NULL, 11),
  (6522, 13, 29, 'partnership_solution', NULL, 22),
  (6523, 14, 29, 'partnership_solution', NULL, 36),
  (6524, 15, 29, 'partnership_solution', NULL, 50),
  (6525, 16, 29, 'partnership_solution', NULL, 14),
  (6526, 17, 29, 'partnership_solution', NULL, 39),
  (6527, 18, 29, 'partnership_solution', NULL, 37),
  (6528, 19, 29, 'partnership_solution', NULL, 31),
  (6529, 20, 29, 'partnership_solution', NULL, 51),
  (6530, 21, 29, 'partnership_solution', NULL, 38),
  (6042, 1, 112, 'solutionCategories', 12, NULL),
  (6043, 2, 112, 'solutionCategories', 13, NULL),
  (6044, 3, 112, 'solutionCategories', 16, NULL),
  (6045, 4, 112, 'solutionCategories', 32, NULL),
  (6046, 1, 112, 'partnership_solution', NULL, 7),
  (6047, 2, 112, 'partnership_solution', NULL, 8),
  (6048, 3, 112, 'partnership_solution', NULL, 11),
  (6049, 4, 112, 'partnership_solution', NULL, 12),
  (6050, 5, 112, 'partnership_solution', NULL, 13),
  (6051, 6, 112, 'partnership_solution', NULL, 14),
  (6052, 7, 112, 'partnership_solution', NULL, 15),
  (6053, 8, 112, 'partnership_solution', NULL, 16),
  (6054, 9, 112, 'partnership_solution', NULL, 18),
  (6055, 10, 112, 'partnership_solution', NULL, 19),
  (6056, 11, 112, 'partnership_solution', NULL, 20),
  (6057, 12, 112, 'partnership_solution', NULL, 21),
  (6058, 13, 112, 'partnership_solution', NULL, 22),
  (6059, 14, 112, 'partnership_solution', NULL, 23),
  (6060, 15, 112, 'partnership_solution', NULL, 24),
  (6061, 16, 112, 'partnership_solution', NULL, 25),
  (6062, 17, 112, 'partnership_solution', NULL, 26),
  (6063, 18, 112, 'partnership_solution', NULL, 27),
  (6064, 19, 112, 'partnership_solution', NULL, 28),
  (6065, 20, 112, 'partnership_solution', NULL, 30),
  (6066, 21, 112, 'partnership_solution', NULL, 32),
  (6067, 22, 112, 'partnership_solution', NULL, 34),
  (6068, 23, 112, 'partnership_solution', NULL, 35),
  (6069, 24, 112, 'partnership_solution', NULL, 39),
  (6070, 25, 112, 'partnership_solution', NULL, 40),
  (6071, 26, 112, 'partnership_solution', NULL, 41),
  (6072, 27, 112, 'partnership_solution', NULL, 43),
  (6073, 28, 112, 'partnership_solution', NULL, 44),
  (6074, 29, 112, 'partnership_solution', NULL, 46),
  (6075, 30, 112, 'partnership_solution', NULL, 47),
  (6076, 31, 112, 'partnership_solution', NULL, 48),
  (6077, 32, 112, 'partnership_solution', NULL, 49),
  (6078, 33, 112, 'partnership_solution', NULL, 51),
  (6079, 34, 112, 'partnership_solution', NULL, 52),
  (6080, 35, 112, 'partnership_solution', NULL, 53),
  (6081, 36, 112, 'partnership_solution', NULL, 85),
  (6082, 37, 112, 'partnership_solution', NULL, 118),
  (6083, 38, 112, 'partnership_solution', NULL, 119),
  (6084, 39, 112, 'partnership_solution', NULL, 120),
  (6085, 40, 112, 'partnership_solution', NULL, 121),
  (6086, 41, 112, 'partnership_solution', NULL, 122),
  (6087, 42, 112, 'partnership_solution', NULL, 123),
  (6088, 43, 112, 'partnership_solution', NULL, 124),
  (6531, 22, 29, 'partnership_solution', NULL, 33),
  (6532, 23, 29, 'partnership_solution', NULL, 9),
  (6533, 24, 29, 'partnership_solution', NULL, 29),
  (6534, 25, 29, 'partnership_solution', NULL, 52),
  (6535, 26, 29, 'partnership_solution', NULL, 17),
  (6768, 1, 43, 'solutionCategories', 15, NULL),
  (6769, 2, 43, 'solutionCategories', 14, NULL),
  (6770, 3, 43, 'solutionCategories', 18, NULL),
  (6771, 1, 43, 'partnership_solution', NULL, 10),
  (6772, 2, 43, 'partnership_solution', NULL, 45),
  (6773, 3, 43, 'partnership_solution', NULL, 11),
  (6774, 4, 43, 'partnership_solution', NULL, 42),
  (6775, 5, 43, 'partnership_solution', NULL, 53),
  (6776, 6, 43, 'partnership_solution', NULL, 55),
  (6777, 7, 43, 'partnership_solution', NULL, 20),
  (6778, 8, 43, 'partnership_solution', NULL, 27),
  (6779, 9, 43, 'partnership_solution', NULL, 22),
  (6780, 10, 43, 'partnership_solution', NULL, 36),
  (6781, 11, 43, 'partnership_solution', NULL, 50);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6782, 12, 43, 'partnership_solution', NULL, 14),
  (6783, 13, 43, 'partnership_solution', NULL, 39),
  (6784, 14, 43, 'partnership_solution', NULL, 54),
  (6785, 15, 43, 'partnership_solution', NULL, 37),
  (6786, 16, 43, 'partnership_solution', NULL, 31),
  (6787, 17, 43, 'partnership_solution', NULL, 51),
  (6788, 18, 43, 'partnership_solution', NULL, 38),
  (6789, 19, 43, 'partnership_solution', NULL, 33),
  (6790, 20, 43, 'partnership_solution', NULL, 9),
  (6791, 21, 43, 'partnership_solution', NULL, 29),
  (6792, 22, 43, 'partnership_solution', NULL, 52),
  (6793, 23, 43, 'partnership_solution', NULL, 17),
  (6794, 24, 43, 'partnership_solution', NULL, 58),
  (6795, 25, 43, 'partnership_solution', NULL, 28),
  (6796, 26, 43, 'partnership_solution', NULL, 24),
  (7260, 1, 67, 'solutionCategories', 12, NULL),
  (7261, 2, 67, 'solutionCategories', 13, NULL),
  (6536, 1, 31, 'solutionCategories', 23, NULL),
  (6537, 2, 31, 'solutionCategories', 12, NULL),
  (6127, 1, 114, 'solutionCategories', 14, NULL),
  (6128, 2, 114, 'solutionCategories', 27, NULL),
  (6129, 3, 114, 'solutionCategories', 32, NULL),
  (6130, 1, 114, 'partnership_solution', NULL, 9),
  (6131, 2, 114, 'partnership_solution', NULL, 11),
  (6132, 3, 114, 'partnership_solution', NULL, 14),
  (6133, 4, 114, 'partnership_solution', NULL, 16),
  (6134, 5, 114, 'partnership_solution', NULL, 17),
  (6135, 6, 114, 'partnership_solution', NULL, 20),
  (6136, 7, 114, 'partnership_solution', NULL, 22),
  (6137, 8, 114, 'partnership_solution', NULL, 25),
  (6138, 9, 114, 'partnership_solution', NULL, 27),
  (6139, 10, 114, 'partnership_solution', NULL, 28),
  (6140, 11, 114, 'partnership_solution', NULL, 29),
  (6141, 12, 114, 'partnership_solution', NULL, 31),
  (6142, 13, 114, 'partnership_solution', NULL, 33),
  (6143, 14, 114, 'partnership_solution', NULL, 36),
  (6144, 15, 114, 'partnership_solution', NULL, 37),
  (6145, 16, 114, 'partnership_solution', NULL, 38),
  (6146, 17, 114, 'partnership_solution', NULL, 39),
  (6147, 18, 114, 'partnership_solution', NULL, 44),
  (6148, 19, 114, 'partnership_solution', NULL, 48),
  (6149, 20, 114, 'partnership_solution', NULL, 50),
  (6150, 21, 114, 'partnership_solution', NULL, 51),
  (6151, 22, 114, 'partnership_solution', NULL, 52),
  (6152, 23, 114, 'partnership_solution', NULL, 54),
  (6153, 24, 114, 'partnership_solution', NULL, 83),
  (6154, 25, 114, 'partnership_solution', NULL, 84),
  (6155, 26, 114, 'partnership_solution', NULL, 85),
  (6156, 27, 114, 'partnership_solution', NULL, 86),
  (6157, 28, 114, 'partnership_solution', NULL, 87),
  (6158, 29, 114, 'partnership_solution', NULL, 118),
  (6159, 30, 114, 'partnership_solution', NULL, 119),
  (6160, 31, 114, 'partnership_solution', NULL, 120),
  (6161, 32, 114, 'partnership_solution', NULL, 121),
  (6162, 33, 114, 'partnership_solution', NULL, 122),
  (6163, 34, 114, 'partnership_solution', NULL, 123),
  (6164, 35, 114, 'partnership_solution', NULL, 124),
  (6538, 3, 31, 'solutionCategories', 13, NULL),
  (6539, 4, 31, 'solutionCategories', 14, NULL),
  (6540, 5, 31, 'solutionCategories', 15, NULL),
  (6541, 1, 31, 'partnership_solution', NULL, 20),
  (6542, 2, 31, 'partnership_solution', NULL, 24),
  (6543, 3, 31, 'partnership_solution', NULL, 66),
  (6544, 4, 31, 'partnership_solution', NULL, 67),
  (6545, 5, 31, 'partnership_solution', NULL, 68),
  (6546, 6, 31, 'partnership_solution', NULL, 26),
  (6547, 7, 31, 'partnership_solution', NULL, 39),
  (6548, 8, 31, 'partnership_solution', NULL, 40),
  (6549, 9, 31, 'partnership_solution', NULL, 28),
  (6550, 10, 31, 'partnership_solution', NULL, 51),
  (6551, 11, 31, 'partnership_solution', NULL, 48),
  (6552, 12, 31, 'partnership_solution', NULL, 23),
  (6553, 13, 31, 'partnership_solution', NULL, 12),
  (6554, 14, 31, 'partnership_solution', NULL, 27),
  (6555, 15, 31, 'partnership_solution', NULL, 11),
  (6556, 16, 31, 'partnership_solution', NULL, 44),
  (6557, 17, 31, 'partnership_solution', NULL, 22),
  (6558, 18, 31, 'partnership_solution', NULL, 19),
  (6559, 19, 31, 'partnership_solution', NULL, 43),
  (6560, 20, 31, 'partnership_solution', NULL, 16),
  (6561, 21, 31, 'partnership_solution', NULL, 34),
  (6562, 22, 31, 'partnership_solution', NULL, 14),
  (6563, 23, 31, 'partnership_solution', NULL, 46),
  (6564, 24, 31, 'partnership_solution', NULL, 32),
  (6565, 25, 31, 'partnership_solution', NULL, 53),
  (6566, 26, 31, 'partnership_solution', NULL, 15),
  (6567, 27, 31, 'partnership_solution', NULL, 13),
  (6568, 28, 31, 'partnership_solution', NULL, 35),
  (6569, 29, 31, 'partnership_solution', NULL, 49),
  (6570, 30, 31, 'partnership_solution', NULL, 25),
  (6571, 31, 31, 'partnership_solution', NULL, 8),
  (6572, 32, 31, 'partnership_solution', NULL, 18),
  (6573, 33, 31, 'partnership_solution', NULL, 7),
  (6574, 34, 31, 'partnership_solution', NULL, 30),
  (6575, 35, 31, 'partnership_solution', NULL, 47),
  (6576, 36, 31, 'partnership_solution', NULL, 41),
  (6577, 37, 31, 'partnership_solution', NULL, 52),
  (6578, 38, 31, 'partnership_solution', NULL, 21),
  (6579, 39, 31, 'partnership_solution', NULL, 36),
  (6580, 40, 31, 'partnership_solution', NULL, 50);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6581, 41, 31, 'partnership_solution', NULL, 54),
  (6582, 42, 31, 'partnership_solution', NULL, 37),
  (6583, 43, 31, 'partnership_solution', NULL, 31),
  (6584, 44, 31, 'partnership_solution', NULL, 38),
  (6585, 45, 31, 'partnership_solution', NULL, 33),
  (6586, 46, 31, 'partnership_solution', NULL, 9),
  (6587, 47, 31, 'partnership_solution', NULL, 29),
  (6588, 48, 31, 'partnership_solution', NULL, 17),
  (6589, 49, 31, 'partnership_solution', NULL, 10),
  (6590, 50, 31, 'partnership_solution', NULL, 45),
  (6591, 51, 31, 'partnership_solution', NULL, 42),
  (6592, 52, 31, 'partnership_solution', NULL, 55),
  (7262, 3, 67, 'solutionCategories', 14, NULL),
  (7263, 1, 67, 'partnership_solution', NULL, 20),
  (7264, 2, 67, 'partnership_solution', NULL, 26),
  (7265, 3, 67, 'partnership_solution', NULL, 39),
  (7266, 4, 67, 'partnership_solution', NULL, 40),
  (7267, 5, 67, 'partnership_solution', NULL, 28),
  (7268, 6, 67, 'partnership_solution', NULL, 51),
  (7269, 7, 67, 'partnership_solution', NULL, 48),
  (7270, 8, 67, 'partnership_solution', NULL, 23),
  (7271, 9, 67, 'partnership_solution', NULL, 12),
  (7272, 10, 67, 'partnership_solution', NULL, 27),
  (7273, 11, 67, 'partnership_solution', NULL, 11),
  (6165, 1, 110, 'solutionCategories', 12, NULL),
  (6166, 2, 110, 'solutionCategories', 13, NULL),
  (6167, 3, 110, 'solutionCategories', 14, NULL),
  (6168, 1, 110, 'partnership_solution', NULL, 7),
  (6169, 2, 110, 'partnership_solution', NULL, 8),
  (6170, 3, 110, 'partnership_solution', NULL, 9),
  (6171, 4, 110, 'partnership_solution', NULL, 11),
  (6172, 5, 110, 'partnership_solution', NULL, 12),
  (6173, 6, 110, 'partnership_solution', NULL, 13),
  (6174, 7, 110, 'partnership_solution', NULL, 14),
  (6175, 8, 110, 'partnership_solution', NULL, 15),
  (6176, 9, 110, 'partnership_solution', NULL, 16),
  (6177, 10, 110, 'partnership_solution', NULL, 17),
  (6178, 11, 110, 'partnership_solution', NULL, 18),
  (6179, 12, 110, 'partnership_solution', NULL, 19),
  (6180, 13, 110, 'partnership_solution', NULL, 20),
  (6181, 14, 110, 'partnership_solution', NULL, 21),
  (6182, 15, 110, 'partnership_solution', NULL, 22),
  (6183, 16, 110, 'partnership_solution', NULL, 23),
  (6184, 17, 110, 'partnership_solution', NULL, 24),
  (6185, 18, 110, 'partnership_solution', NULL, 25),
  (6186, 19, 110, 'partnership_solution', NULL, 26),
  (6187, 20, 110, 'partnership_solution', NULL, 27),
  (6188, 21, 110, 'partnership_solution', NULL, 28),
  (6189, 22, 110, 'partnership_solution', NULL, 29),
  (6190, 23, 110, 'partnership_solution', NULL, 30),
  (6191, 24, 110, 'partnership_solution', NULL, 31),
  (6192, 25, 110, 'partnership_solution', NULL, 32),
  (6193, 26, 110, 'partnership_solution', NULL, 33),
  (6194, 27, 110, 'partnership_solution', NULL, 34),
  (6195, 28, 110, 'partnership_solution', NULL, 35),
  (6196, 29, 110, 'partnership_solution', NULL, 36),
  (6197, 30, 110, 'partnership_solution', NULL, 37),
  (6198, 31, 110, 'partnership_solution', NULL, 38),
  (6199, 32, 110, 'partnership_solution', NULL, 39),
  (6200, 33, 110, 'partnership_solution', NULL, 40),
  (6201, 34, 110, 'partnership_solution', NULL, 41),
  (6202, 35, 110, 'partnership_solution', NULL, 43),
  (6203, 36, 110, 'partnership_solution', NULL, 44),
  (6204, 37, 110, 'partnership_solution', NULL, 46),
  (6205, 38, 110, 'partnership_solution', NULL, 47),
  (6206, 39, 110, 'partnership_solution', NULL, 48),
  (6207, 40, 110, 'partnership_solution', NULL, 49),
  (6208, 41, 110, 'partnership_solution', NULL, 50),
  (6209, 42, 110, 'partnership_solution', NULL, 51),
  (6210, 43, 110, 'partnership_solution', NULL, 52),
  (6211, 44, 110, 'partnership_solution', NULL, 53),
  (6212, 45, 110, 'partnership_solution', NULL, 54),
  (6593, 1, 33, 'solutionCategories', 32, NULL),
  (6594, 2, 33, 'solutionCategories', 12, NULL),
  (6595, 3, 33, 'solutionCategories', 14, NULL),
  (6596, 4, 33, 'solutionCategories', 13, NULL),
  (6597, 1, 33, 'partnership_solution', NULL, 118),
  (6598, 2, 33, 'partnership_solution', NULL, 119),
  (6599, 3, 33, 'partnership_solution', NULL, 11),
  (6600, 4, 33, 'partnership_solution', NULL, 44),
  (6601, 5, 33, 'partnership_solution', NULL, 22),
  (6602, 6, 33, 'partnership_solution', NULL, 120),
  (6603, 7, 33, 'partnership_solution', NULL, 121),
  (6604, 8, 33, 'partnership_solution', NULL, 28),
  (6605, 9, 33, 'partnership_solution', NULL, 122),
  (6606, 10, 33, 'partnership_solution', NULL, 123),
  (6607, 11, 33, 'partnership_solution', NULL, 85),
  (6608, 12, 33, 'partnership_solution', NULL, 124),
  (6609, 13, 33, 'partnership_solution', NULL, 20),
  (6610, 14, 33, 'partnership_solution', NULL, 26),
  (6611, 15, 33, 'partnership_solution', NULL, 39),
  (6612, 16, 33, 'partnership_solution', NULL, 40),
  (6613, 17, 33, 'partnership_solution', NULL, 51),
  (6614, 18, 33, 'partnership_solution', NULL, 48),
  (6615, 19, 33, 'partnership_solution', NULL, 27),
  (6616, 20, 33, 'partnership_solution', NULL, 36),
  (6617, 21, 33, 'partnership_solution', NULL, 50),
  (6618, 22, 33, 'partnership_solution', NULL, 14),
  (6619, 23, 33, 'partnership_solution', NULL, 54),
  (6620, 24, 33, 'partnership_solution', NULL, 37);
INSERT INTO "solutions_rels" ("id", "order", "parent_id", "path", "solution_categories_id", "partnership_solutions_id") VALUES
  (6621, 25, 33, 'partnership_solution', NULL, 31),
  (6622, 26, 33, 'partnership_solution', NULL, 38),
  (6623, 27, 33, 'partnership_solution', NULL, 33),
  (6624, 28, 33, 'partnership_solution', NULL, 9),
  (6625, 29, 33, 'partnership_solution', NULL, 29),
  (6626, 30, 33, 'partnership_solution', NULL, 52),
  (6627, 31, 33, 'partnership_solution', NULL, 17),
  (6628, 32, 33, 'partnership_solution', NULL, 23),
  (6629, 33, 33, 'partnership_solution', NULL, 12),
  (6630, 34, 33, 'partnership_solution', NULL, 19),
  (6631, 35, 33, 'partnership_solution', NULL, 43),
  (6632, 36, 33, 'partnership_solution', NULL, 16),
  (6633, 37, 33, 'partnership_solution', NULL, 34),
  (6634, 38, 33, 'partnership_solution', NULL, 46),
  (6635, 39, 33, 'partnership_solution', NULL, 32),
  (6636, 40, 33, 'partnership_solution', NULL, 53),
  (6637, 41, 33, 'partnership_solution', NULL, 15),
  (6638, 42, 33, 'partnership_solution', NULL, 24),
  (6639, 43, 33, 'partnership_solution', NULL, 13),
  (6640, 44, 33, 'partnership_solution', NULL, 35),
  (6641, 45, 33, 'partnership_solution', NULL, 49),
  (6642, 46, 33, 'partnership_solution', NULL, 25),
  (6643, 47, 33, 'partnership_solution', NULL, 8),
  (6644, 48, 33, 'partnership_solution', NULL, 18),
  (6645, 49, 33, 'partnership_solution', NULL, 7),
  (6646, 50, 33, 'partnership_solution', NULL, 30),
  (6647, 51, 33, 'partnership_solution', NULL, 47),
  (6648, 52, 33, 'partnership_solution', NULL, 41),
  (6649, 53, 33, 'partnership_solution', NULL, 21),
  (7274, 12, 67, 'partnership_solution', NULL, 44),
  (7275, 13, 67, 'partnership_solution', NULL, 22);

-- Data untuk tabel: "users" (1 rows)
TRUNCATE TABLE "users" CASCADE;
INSERT INTO "users" ("id", "updated_at", "created_at", "email", "reset_password_token", "reset_password_expiration", "salt", "hash", "login_attempts", "lock_until") VALUES
  (1, '2026-09-29T02:01:47.256Z', '2026-05-16T04:45:29.227Z', 'miraisoftnet@gmail.com', NULL, NULL, '2242ef3cdd3e72e2c3f392e080f5f32e7c38eb1a25416dfd47cec8a83d80c7d6', 'e5bad8b30fe1cdbcbab0bbdba1a69f6835ef1f3e59506a706f3299470658f95004f5ffcf9b366b5142add1ce82a8c7a1d81d2d2ac7fb5680620406c2e2bb2bc9af5fc992bef94380633c786e97cde1be6f391f61a1b8a876752d4fc89186b95c603649a64c4d70cc040a6a6856358874736d388e6458ca6d26a7d9512f6adbe7a80ecd1cb3de07cff5fb499445b7a041e934de67dfe98f7d7033e7666799d042598b3c71dde82135c7ab5d68ef42f563b87801a281cb2cc7eeb7c54710d845de6f707b2a69300c9a3f0855701e88ba2d16a00797f315bd3ffcabc3888ee59d7c66d98bd863b37da4166b733f483cf683efc250d2c70f843af89f2a9a413c0ee93976d36199ad4b7ff51403501ef324a888cb9aa65eae748e5a391db9ad7f3200a9290537c24c0345fd1844b612a876e37b8f6ce411be16b5d894d4856ead9bb8051a88e13a41279fb1f02a801c1b6c9eb863f70866b6ea7449c4bf478300585d530a90cddeb2dce05182da15ae28f879a64a3656a407c7bc65fbad3cb37e25370abc28f4c0d4f81776284500486e6f479d42be4de1a0572ed49a30faf625c42033738f6546053f051abad140ba091e97dde062f1345081d0f34055377f886057e9aea6fa7f9c3ce906cbdd3bdf23d2d57309c9f09ae64e0d68e68becdc03027db4f7b5cb85a95a6557ad9d9d54463e847b54850cf8d79003dcc8f98707ef54e4', '0', NULL);

-- Data untuk tabel: "users_sessions" (1 rows)
TRUNCATE TABLE "users_sessions" CASCADE;
INSERT INTO "users_sessions" ("_order", "_parent_id", "id", "created_at", "expires_at") VALUES
  (1, 1, 'e38a1676-0393-4c18-b748-7c1fdb844ccf', '2026-10-02T00:57:52.615Z', '2026-10-02T02:57:52.615Z');

-- Sinkronisasi Sequence ID

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'about_us' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"about_us"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "about_us"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'about_us_core_values' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"about_us_core_values"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "about_us_core_values"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'about_us_industries' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"about_us_industries"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "about_us_industries"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'about_us_milestones' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"about_us_milestones"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "about_us_milestones"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'about_us_mission_list' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"about_us_mission_list"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "about_us_mission_list"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'about_us_strengths' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"about_us_strengths"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "about_us_strengths"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'about_us_team_members' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"about_us_team_members"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "about_us_team_members"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'careers' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"careers"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "careers"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'customers' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"customers"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "customers"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'faqs' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"faqs"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "faqs"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'faqs_qna_list' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"faqs_qna_list"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "faqs_qna_list"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'industries' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"industries"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "industries"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'media' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"media"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "media"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'news' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"news"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "news"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'partnership_solutions' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"partnership_solutions"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "partnership_solutions"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'partnerships' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"partnerships"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "partnerships"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'payload_kv' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"payload_kv"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "payload_kv"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'payload_locked_documents' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"payload_locked_documents"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "payload_locked_documents"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'payload_locked_documents_rels' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"payload_locked_documents_rels"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "payload_locked_documents_rels"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'payload_migrations' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"payload_migrations"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "payload_migrations"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'payload_preferences' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"payload_preferences"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "payload_preferences"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'payload_preferences_rels' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"payload_preferences_rels"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "payload_preferences_rels"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'portfolios' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"portfolios"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "portfolios"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'portfolios_achievements' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"portfolios_achievements"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "portfolios_achievements"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'portfolios_rels' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"portfolios_rels"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "portfolios_rels"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'portfolios_tags' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"portfolios_tags"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "portfolios_tags"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'pricing_faqs' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"pricing_faqs"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "pricing_faqs"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'problems' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"problems"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "problems"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'products' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"products"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "products"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'products_benefits' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"products_benefits"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "products_benefits"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'products_clients' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"products_clients"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "products_clients"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'products_features' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"products_features"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "products_features"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'products_gallery' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"products_gallery"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "products_gallery"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'products_integrations' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"products_integrations"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "products_integrations"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'products_use_cases' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"products_use_cases"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "products_use_cases"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'services' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"services"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "services"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'services_benefit_cards' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"services_benefit_cards"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "services_benefit_cards"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'services_framework_logos' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"services_framework_logos"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "services_framework_logos"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'services_pricing_tiers' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"services_pricing_tiers"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "services_pricing_tiers"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'services_pricing_tiers_features' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"services_pricing_tiers_features"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "services_pricing_tiers_features"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'services_problem_cards' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"services_problem_cards"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "services_problem_cards"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'services_process_steps' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"services_process_steps"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "services_process_steps"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'services_solution_list' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"services_solution_list"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "services_solution_list"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'solution_categories' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"solution_categories"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "solution_categories"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'solutions' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"solutions"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "solutions"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'solutions_rels' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"solutions_rels"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "solutions_rels"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'users' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"users"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "users"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'users_sessions' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"users_sessions"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "users_sessions"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = 'visitors' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"visitors"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "visitors"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    

SET session_replication_role = 'origin';


-- ============================================================================

-- 5. INDEXES

-- ============================================================================

CREATE INDEX IF NOT EXISTS about_us_hero_image_idx ON public.about_us USING btree (hero_image_id);

CREATE INDEX IF NOT EXISTS about_us_core_values_icon_idx ON public.about_us_core_values USING btree (icon_id);

CREATE INDEX IF NOT EXISTS about_us_core_values_order_idx ON public.about_us_core_values USING btree (_order);

CREATE INDEX IF NOT EXISTS about_us_core_values_parent_id_idx ON public.about_us_core_values USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS about_us_industries_icon_idx ON public.about_us_industries USING btree (icon_id);

CREATE INDEX IF NOT EXISTS about_us_industries_order_idx ON public.about_us_industries USING btree (_order);

CREATE INDEX IF NOT EXISTS about_us_industries_parent_id_idx ON public.about_us_industries USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS about_us_milestones_order_idx ON public.about_us_milestones USING btree (_order);

CREATE INDEX IF NOT EXISTS about_us_milestones_parent_id_idx ON public.about_us_milestones USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS about_us_mission_list_order_idx ON public.about_us_mission_list USING btree (_order);

CREATE INDEX IF NOT EXISTS about_us_mission_list_parent_id_idx ON public.about_us_mission_list USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS about_us_strengths_order_idx ON public.about_us_strengths USING btree (_order);

CREATE INDEX IF NOT EXISTS about_us_strengths_parent_id_idx ON public.about_us_strengths USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS about_us_team_members_order_idx ON public.about_us_team_members USING btree (_order);

CREATE INDEX IF NOT EXISTS about_us_team_members_parent_id_idx ON public.about_us_team_members USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS about_us_team_members_photo_idx ON public.about_us_team_members USING btree (photo_id);

CREATE INDEX IF NOT EXISTS careers_created_at_idx ON public.careers USING btree (created_at);

CREATE INDEX IF NOT EXISTS careers_image_idx ON public.careers USING btree (image_id);

CREATE UNIQUE INDEX IF NOT EXISTS careers_slug_idx ON public.careers USING btree (slug);

CREATE INDEX IF NOT EXISTS careers_updated_at_idx ON public.careers USING btree (updated_at);

CREATE INDEX IF NOT EXISTS customers_created_at_idx ON public.customers USING btree (created_at);

CREATE INDEX IF NOT EXISTS customers_logo_idx ON public.customers USING btree (logo_id);

CREATE INDEX IF NOT EXISTS customers_updated_at_idx ON public.customers USING btree (updated_at);

CREATE INDEX IF NOT EXISTS faqs_created_at_idx ON public.faqs USING btree (created_at);

CREATE INDEX IF NOT EXISTS faqs_icon_idx ON public.faqs USING btree (icon_id);

CREATE INDEX IF NOT EXISTS faqs_updated_at_idx ON public.faqs USING btree (updated_at);

CREATE INDEX IF NOT EXISTS faqs_qna_list_order_idx ON public.faqs_qna_list USING btree (_order);

CREATE INDEX IF NOT EXISTS faqs_qna_list_parent_id_idx ON public.faqs_qna_list USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS industries_created_at_idx ON public.industries USING btree (created_at);

CREATE UNIQUE INDEX IF NOT EXISTS industries_slug_idx ON public.industries USING btree (slug);

CREATE INDEX IF NOT EXISTS industries_updated_at_idx ON public.industries USING btree (updated_at);

CREATE INDEX IF NOT EXISTS media_created_at_idx ON public.media USING btree (created_at);

CREATE UNIQUE INDEX IF NOT EXISTS media_filename_idx ON public.media USING btree (filename);

CREATE INDEX IF NOT EXISTS media_sizes_card_sizes_card_filename_idx ON public.media USING btree (sizes_card_filename);

CREATE INDEX IF NOT EXISTS media_sizes_hero_sizes_hero_filename_idx ON public.media USING btree (sizes_hero_filename);

CREATE INDEX IF NOT EXISTS media_sizes_thumbnail_sizes_thumbnail_filename_idx ON public.media USING btree (sizes_thumbnail_filename);

CREATE INDEX IF NOT EXISTS media_updated_at_idx ON public.media USING btree (updated_at);

CREATE INDEX IF NOT EXISTS news_created_at_idx ON public.news USING btree (created_at);

CREATE INDEX IF NOT EXISTS news_image_idx ON public.news USING btree (image_id);

CREATE UNIQUE INDEX IF NOT EXISTS news_slug_idx ON public.news USING btree (slug);

CREATE INDEX IF NOT EXISTS news_thumbnail_idx ON public.news USING btree (thumbnail_id);

CREATE INDEX IF NOT EXISTS news_updated_at_idx ON public.news USING btree (updated_at);

CREATE INDEX IF NOT EXISTS partnership_solutions_created_at_idx ON public.partnership_solutions USING btree (created_at);

CREATE INDEX IF NOT EXISTS partnership_solutions_updated_at_idx ON public.partnership_solutions USING btree (updated_at);

CREATE INDEX IF NOT EXISTS partnerships_created_at_idx ON public.partnerships USING btree (created_at);

CREATE INDEX IF NOT EXISTS partnerships_logo_idx ON public.partnerships USING btree (logo_id);

CREATE INDEX IF NOT EXISTS partnerships_updated_at_idx ON public.partnerships USING btree (updated_at);

CREATE UNIQUE INDEX IF NOT EXISTS payload_kv_key_idx ON public.payload_kv USING btree (key);

CREATE INDEX IF NOT EXISTS payload_locked_documents_created_at_idx ON public.payload_locked_documents USING btree (created_at);

CREATE INDEX IF NOT EXISTS payload_locked_documents_global_slug_idx ON public.payload_locked_documents USING btree (global_slug);

CREATE INDEX IF NOT EXISTS payload_locked_documents_updated_at_idx ON public.payload_locked_documents USING btree (updated_at);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_careers_id_idx ON public.payload_locked_documents_rels USING btree (careers_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_customers_id_idx ON public.payload_locked_documents_rels USING btree (customers_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_faqs_id_idx ON public.payload_locked_documents_rels USING btree (faqs_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_industries_id_idx ON public.payload_locked_documents_rels USING btree (industries_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_media_id_idx ON public.payload_locked_documents_rels USING btree (media_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_news_id_idx ON public.payload_locked_documents_rels USING btree (news_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_order_idx ON public.payload_locked_documents_rels USING btree ("order");

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_parent_idx ON public.payload_locked_documents_rels USING btree (parent_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_partnership_solutions_id_idx ON public.payload_locked_documents_rels USING btree (partnership_solutions_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_partnerships_id_idx ON public.payload_locked_documents_rels USING btree (partnerships_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_path_idx ON public.payload_locked_documents_rels USING btree (path);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_portfolios_id_idx ON public.payload_locked_documents_rels USING btree (portfolios_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_pricing_faqs_id_idx ON public.payload_locked_documents_rels USING btree (pricing_faqs_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_problems_id_idx ON public.payload_locked_documents_rels USING btree (problems_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_products_id_idx ON public.payload_locked_documents_rels USING btree (products_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_services_id_idx ON public.payload_locked_documents_rels USING btree (services_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_solution_categories_id_idx ON public.payload_locked_documents_rels USING btree (solution_categories_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_solutions_id_idx ON public.payload_locked_documents_rels USING btree (solutions_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_users_id_idx ON public.payload_locked_documents_rels USING btree (users_id);

CREATE INDEX IF NOT EXISTS payload_locked_documents_rels_visitors_id_idx ON public.payload_locked_documents_rels USING btree (visitors_id);

CREATE INDEX IF NOT EXISTS payload_migrations_created_at_idx ON public.payload_migrations USING btree (created_at);

CREATE INDEX IF NOT EXISTS payload_migrations_updated_at_idx ON public.payload_migrations USING btree (updated_at);

CREATE INDEX IF NOT EXISTS payload_preferences_created_at_idx ON public.payload_preferences USING btree (created_at);

CREATE INDEX IF NOT EXISTS payload_preferences_key_idx ON public.payload_preferences USING btree (key);

CREATE INDEX IF NOT EXISTS payload_preferences_updated_at_idx ON public.payload_preferences USING btree (updated_at);

CREATE INDEX IF NOT EXISTS payload_preferences_rels_order_idx ON public.payload_preferences_rels USING btree ("order");

CREATE INDEX IF NOT EXISTS payload_preferences_rels_parent_idx ON public.payload_preferences_rels USING btree (parent_id);

CREATE INDEX IF NOT EXISTS payload_preferences_rels_path_idx ON public.payload_preferences_rels USING btree (path);

CREATE INDEX IF NOT EXISTS payload_preferences_rels_users_id_idx ON public.payload_preferences_rels USING btree (users_id);

CREATE INDEX IF NOT EXISTS portfolios_created_at_idx ON public.portfolios USING btree (created_at);

CREATE INDEX IF NOT EXISTS portfolios_customer_idx ON public.portfolios USING btree (customer_id);

CREATE INDEX IF NOT EXISTS portfolios_image_idx ON public.portfolios USING btree (image_id);

CREATE INDEX IF NOT EXISTS portfolios_updated_at_idx ON public.portfolios USING btree (updated_at);

CREATE INDEX IF NOT EXISTS portfolios_achievements_order_idx ON public.portfolios_achievements USING btree (_order);

CREATE INDEX IF NOT EXISTS portfolios_achievements_parent_id_idx ON public.portfolios_achievements USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS portfolios_rels_order_idx ON public.portfolios_rels USING btree ("order");

CREATE INDEX IF NOT EXISTS portfolios_rels_parent_idx ON public.portfolios_rels USING btree (parent_id);

CREATE INDEX IF NOT EXISTS portfolios_rels_path_idx ON public.portfolios_rels USING btree (path);

CREATE INDEX IF NOT EXISTS portfolios_rels_services_id_idx ON public.portfolios_rels USING btree (services_id);

CREATE INDEX IF NOT EXISTS portfolios_tags_order_idx ON public.portfolios_tags USING btree (_order);

CREATE INDEX IF NOT EXISTS portfolios_tags_parent_id_idx ON public.portfolios_tags USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS pricing_faqs_created_at_idx ON public.pricing_faqs USING btree (created_at);

CREATE INDEX IF NOT EXISTS pricing_faqs_updated_at_idx ON public.pricing_faqs USING btree (updated_at);

CREATE INDEX IF NOT EXISTS problems_created_at_idx ON public.problems USING btree (created_at);

CREATE INDEX IF NOT EXISTS problems_icon_idx ON public.problems USING btree (icon_id);

CREATE INDEX IF NOT EXISTS problems_updated_at_idx ON public.problems USING btree (updated_at);

CREATE INDEX IF NOT EXISTS products_created_at_idx ON public.products USING btree (created_at);

CREATE INDEX IF NOT EXISTS products_icon_title_idx ON public.products USING btree (icon_title_id);

CREATE INDEX IF NOT EXISTS products_image_idx ON public.products USING btree (image_id);

CREATE UNIQUE INDEX IF NOT EXISTS products_slug_idx ON public.products USING btree (slug);

CREATE INDEX IF NOT EXISTS products_updated_at_idx ON public.products USING btree (updated_at);

CREATE INDEX IF NOT EXISTS products_benefits_order_idx ON public.products_benefits USING btree (_order);

CREATE INDEX IF NOT EXISTS products_benefits_parent_id_idx ON public.products_benefits USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS products_clients_client_logo_idx ON public.products_clients USING btree (client_logo_id);

CREATE INDEX IF NOT EXISTS products_clients_order_idx ON public.products_clients USING btree (_order);

CREATE INDEX IF NOT EXISTS products_clients_parent_id_idx ON public.products_clients USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS products_features_icon_idx ON public.products_features USING btree (icon_id);

CREATE INDEX IF NOT EXISTS products_features_order_idx ON public.products_features USING btree (_order);

CREATE INDEX IF NOT EXISTS products_features_parent_id_idx ON public.products_features USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS products_features_picture_idx ON public.products_features USING btree (picture_id);

CREATE INDEX IF NOT EXISTS products_gallery_gallery_image_idx ON public.products_gallery USING btree (gallery_image_id);

CREATE INDEX IF NOT EXISTS products_gallery_order_idx ON public.products_gallery USING btree (_order);

CREATE INDEX IF NOT EXISTS products_gallery_parent_id_idx ON public.products_gallery USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS products_integrations_logo_idx ON public.products_integrations USING btree (logo_id);

CREATE INDEX IF NOT EXISTS products_integrations_order_idx ON public.products_integrations USING btree (_order);

CREATE INDEX IF NOT EXISTS products_integrations_parent_id_idx ON public.products_integrations USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS products_use_cases_order_idx ON public.products_use_cases USING btree (_order);

CREATE INDEX IF NOT EXISTS products_use_cases_parent_id_idx ON public.products_use_cases USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS services_created_at_idx ON public.services USING btree (created_at);

CREATE INDEX IF NOT EXISTS services_hero_image_idx ON public.services USING btree (hero_image_id);

CREATE INDEX IF NOT EXISTS services_icon_title_idx ON public.services USING btree (icon_title_id);

CREATE UNIQUE INDEX IF NOT EXISTS services_slug_idx ON public.services USING btree (slug);

CREATE INDEX IF NOT EXISTS services_updated_at_idx ON public.services USING btree (updated_at);

CREATE INDEX IF NOT EXISTS services_benefit_cards_icon_idx ON public.services_benefit_cards USING btree (icon_id);

CREATE INDEX IF NOT EXISTS services_benefit_cards_order_idx ON public.services_benefit_cards USING btree (_order);

CREATE INDEX IF NOT EXISTS services_benefit_cards_parent_id_idx ON public.services_benefit_cards USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS services_framework_logos_logo_idx ON public.services_framework_logos USING btree (logo_id);

CREATE INDEX IF NOT EXISTS services_framework_logos_order_idx ON public.services_framework_logos USING btree (_order);

CREATE INDEX IF NOT EXISTS services_framework_logos_parent_id_idx ON public.services_framework_logos USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS services_pricing_tiers_order_idx ON public.services_pricing_tiers USING btree (_order);

CREATE INDEX IF NOT EXISTS services_pricing_tiers_parent_id_idx ON public.services_pricing_tiers USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS services_pricing_tiers_features_order_idx ON public.services_pricing_tiers_features USING btree (_order);

CREATE INDEX IF NOT EXISTS services_pricing_tiers_features_parent_id_idx ON public.services_pricing_tiers_features USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS services_problem_cards_icon_idx ON public.services_problem_cards USING btree (icon_id);

CREATE INDEX IF NOT EXISTS services_problem_cards_order_idx ON public.services_problem_cards USING btree (_order);

CREATE INDEX IF NOT EXISTS services_problem_cards_parent_id_idx ON public.services_problem_cards USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS services_process_steps_icon_idx ON public.services_process_steps USING btree (icon_id);

CREATE INDEX IF NOT EXISTS services_process_steps_order_idx ON public.services_process_steps USING btree (_order);

CREATE INDEX IF NOT EXISTS services_process_steps_parent_id_idx ON public.services_process_steps USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS services_solution_list_image_idx ON public.services_solution_list USING btree (image_id);

CREATE INDEX IF NOT EXISTS services_solution_list_order_idx ON public.services_solution_list USING btree (_order);

CREATE INDEX IF NOT EXISTS services_solution_list_parent_id_idx ON public.services_solution_list USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS solution_categories_created_at_idx ON public.solution_categories USING btree (created_at);

CREATE UNIQUE INDEX IF NOT EXISTS solution_categories_slug_idx ON public.solution_categories USING btree (slug);

CREATE INDEX IF NOT EXISTS solution_categories_updated_at_idx ON public.solution_categories USING btree (updated_at);

CREATE INDEX IF NOT EXISTS solutions_cover_image_idx ON public.solutions USING btree (cover_image_id);

CREATE INDEX IF NOT EXISTS solutions_created_at_idx ON public.solutions USING btree (created_at);

CREATE INDEX IF NOT EXISTS solutions_industry_idx ON public.solutions USING btree (industry_id);

CREATE UNIQUE INDEX IF NOT EXISTS solutions_slug_idx ON public.solutions USING btree (slug);

CREATE INDEX IF NOT EXISTS solutions_updated_at_idx ON public.solutions USING btree (updated_at);

CREATE INDEX IF NOT EXISTS solutions_rels_order_idx ON public.solutions_rels USING btree ("order");

CREATE INDEX IF NOT EXISTS solutions_rels_parent_idx ON public.solutions_rels USING btree (parent_id);

CREATE INDEX IF NOT EXISTS solutions_rels_partnership_solutions_id_idx ON public.solutions_rels USING btree (partnership_solutions_id);

CREATE INDEX IF NOT EXISTS solutions_rels_path_idx ON public.solutions_rels USING btree (path);

CREATE INDEX IF NOT EXISTS solutions_rels_solution_categories_id_idx ON public.solutions_rels USING btree (solution_categories_id);

CREATE INDEX IF NOT EXISTS users_created_at_idx ON public.users USING btree (created_at);

CREATE UNIQUE INDEX IF NOT EXISTS users_email_idx ON public.users USING btree (email);

CREATE INDEX IF NOT EXISTS users_updated_at_idx ON public.users USING btree (updated_at);

CREATE INDEX IF NOT EXISTS users_sessions_order_idx ON public.users_sessions USING btree (_order);

CREATE INDEX IF NOT EXISTS users_sessions_parent_id_idx ON public.users_sessions USING btree (_parent_id);

CREATE INDEX IF NOT EXISTS visitors_created_at_idx ON public.visitors USING btree (created_at);

CREATE INDEX IF NOT EXISTS visitors_updated_at_idx ON public.visitors USING btree (updated_at);

SET session_replication_role = 'origin';
