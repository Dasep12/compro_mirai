# ==============================================================================
# Dockerfile untuk Mirai Softnet Company Profile (Next.js 16 + Payload CMS 3)
# Multi-stage build dengan mode Standalone untuk ukuran image yang minimal dan cepat
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Base Stage
# ------------------------------------------------------------------------------
FROM node:20-slim AS base
WORKDIR /app
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------------------------
# 2. Dependencies Stage
# ------------------------------------------------------------------------------
FROM base AS deps
WORKDIR /app
COPY package.json package-lock.json ./
# Menggunakan npm ci terlebih dahulu, fallback ke npm install jika ada perbedaan platform
RUN npm ci || npm install

# ------------------------------------------------------------------------------
# 3. Builder Stage
# ------------------------------------------------------------------------------
FROM base AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build Arguments untuk Next.js SSG / SSR pre-rendering
ARG DATABASE_URI
ARG PAYLOAD_SECRET
ARG NEXT_PUBLIC_SUPABASE_URL
ARG SUPABASE_PROJECT_ID
ARG SUPABASE_STORAGE_BUCKET
ARG SUPABASE_S3_ACCESS_KEY_ID
ARG SUPABASE_S3_SECRET_ACCESS_KEY
ARG SUPABASE_S3_REGION
ARG SUPABASE_S3_ENDPOINT

ENV NEXT_TELEMETRY_DISABLED=1 \
    NODE_ENV=production \
    DATABASE_URI=$DATABASE_URI \
    PAYLOAD_SECRET=$PAYLOAD_SECRET \
    NEXT_PUBLIC_SUPABASE_URL=$NEXT_PUBLIC_SUPABASE_URL \
    SUPABASE_PROJECT_ID=$SUPABASE_PROJECT_ID \
    SUPABASE_STORAGE_BUCKET=$SUPABASE_STORAGE_BUCKET \
    SUPABASE_S3_ACCESS_KEY_ID=$SUPABASE_S3_ACCESS_KEY_ID \
    SUPABASE_S3_SECRET_ACCESS_KEY=$SUPABASE_S3_SECRET_ACCESS_KEY \
    SUPABASE_S3_REGION=$SUPABASE_S3_REGION \
    SUPABASE_S3_ENDPOINT=$SUPABASE_S3_ENDPOINT

# Regenerate import map untuk komponen client S3 Payload sebelum build
RUN npm run generate:importmap

# Build Next.js ke direktori .next/standalone
RUN npm run build

# ------------------------------------------------------------------------------
# 4. Production Runner Stage
# ------------------------------------------------------------------------------
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production \
    NEXT_TELEMETRY_DISABLED=1 \
    PORT=3000 \
    HOSTNAME="0.0.0.0"

# Gunakan non-root user untuk keamanan container
RUN groupadd --system --gid 1001 nodejs && \
    useradd --system --uid 1001 nextjs

# Salin public assets
COPY --from=builder /app/public ./public

# Buat direktori .next dengan permission yang sesuai
RUN mkdir .next && chown nextjs:nodejs .next

# Salin output standalone Next.js dan file statis yang dioptimasi
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

# Health check untuk memverifikasi container berjalan normal
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:3000/api/graphql || curl -f http://localhost:3000 || exit 1

CMD ["node", "server.js"]
