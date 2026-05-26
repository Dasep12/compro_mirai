# MiraiSoftNet Company Profile

Company profile website built with Next.js 16 and PayloadCMS 3, featuring a headless CMS architecture for managing business content.

## Tech Stack

### Frontend

- Next.js 15.1.0 (Stable) with App Router
- React 19.0.0
- TypeScript 5
- Tailwind CSS 4
- Framer Motion 12.38.0 for animations
- Lucide React for icons

### Backend & CMS

- PayloadCMS 3.84.1 (Headless CMS)
- PostgreSQL database via @payloadcms/db-postgres
- Lexical Rich Text Editor
- GraphQL API
- Supabase for authentication and database

### Development Tools

- ESLint with Next.js config
- Cross-env for environment variables
- Sharp for image optimization

## Project Structure

```
miraisoftnet-compro/
├── src/
│   ├── app/
│   │   ├── (payload)/
│   │   │   └── admin/              # PayloadCMS admin panel
│   │   ├── api/
│   │   │   └── [...slug]/          # API routes
│   │   └── (public)/               # Public-facing pages
│   ├── collections/                # PayloadCMS collections
│   ├── components/                 # React components
│   │   ├── ui/
│   │   ├── views/
│   │   └── screen/
│   └── lib/
│       └── utils.ts                # Utility functions
├── payload.config.ts               # PayloadCMS configuration
├── postcss.config.mjs
├── tsconfig.json
└── package.json
```

## Collections

The CMS manages the following content types:

- **Users** - Admin users and authentication
- **Media** - Image and file uploads
- **Services** - Company services offerings
- **Customers** - Client testimonials and case studies
- **Partnership** - Partner companies and collaborations
- **Career** - Job openings and career opportunities
- **Products** - Product catalog and descriptions
- **Faqs** - Frequently asked questions

## Prerequisites

- Node.js 20 or higher
- PostgreSQL database
- Supabase account (for authentication)

## Environment Variables

Create a `.env.local` file in the root directory:

```env
# PayloadCMS
PAYLOAD_SECRET=your-payload-secret-key

# Database
DATABASE_URI=postgresql://user:password@host:port/database

# Supabase (optional, if using Supabase features)
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
```

## Installation

1. Clone the repository:

```bash
git clone <repository-url>
cd miraisoftnet-compro
```

2. Install dependencies:

```bash
npm install
```

3. Set up environment variables (see Environment Variables section)

4. Generate TypeScript types for PayloadCMS:

```bash
npm run generate:types
```

5. Run the development server:

```bash
npm run dev
```

6. Open [http://localhost:3000](http://localhost:3000) in your browser

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm run lint` - Run ESLint
- `npm run generate:types` - Generate TypeScript types from Payload collections

## PayloadCMS Admin Panel

Access the admin panel at [http://localhost:3000/admin](http://localhost:3000/admin)

Default admin user must be created on first run through the setup wizard.

## API Endpoints

PayloadCMS automatically generates REST and GraphQL APIs for all collections:

- REST API: `/api/[collection-name]`
- GraphQL: `/api/graphql`

Example endpoints:

- GET `/api/services` - Fetch all services
- GET `/api/products` - Fetch all products
- GET `/api/customers` - Fetch all customers
- POST `/api/media` - Upload media files

## Deployment

### Build for Production

```bash
npm run build
```

### Environment Setup

Ensure all environment variables are properly configured in your production environment:

- `PAYLOAD_SECRET` - Strong secret key for PayloadCMS
- `DATABASE_URI` - Production PostgreSQL connection string

### Recommended Platforms

- Vercel (optimized for Next.js)
- Railway
- DigitalOcean App Platform
- AWS / Google Cloud / Azure

## Features

- Server-side rendering with Next.js App Router
- Headless CMS with PayloadCMS
- Type-safe development with TypeScript
- Responsive design with Tailwind CSS
- Smooth animations with Framer Motion
- Image optimization with Sharp
- PostgreSQL database integration
- GraphQL and REST APIs
- Rich text editing with Lexical

## Development Notes

- This project uses Next.js 16 with the App Router paradigm
- PayloadCMS runs as an integrated admin panel at `/admin`
- All collections are defined in `src/collections/`
- TypeScript types are auto-generated from Payload collections
- The project uses Tailwind CSS 4 with PostCSS

## License

Private project for MiraiSoftNet

## Support

For questions or issues, contact the development team at MiraiSoftNet.
