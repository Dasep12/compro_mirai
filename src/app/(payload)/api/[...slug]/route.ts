import configPromise from '../../../../../payload.config'
import { REST_GET, REST_POST, REST_DELETE, REST_OPTIONS, REST_PATCH, REST_PUT } from '@payloadcms/next/routes'
import fs from 'fs'
import path from 'path'

const baseGET = REST_GET(configPromise)

export const GET = async (
  request: Request,
  args: { params: Promise<{ slug?: string[] }> }
) => {
  const response = await baseGET(request, args)

  // Jika file media tidak ditemukan di lokal (status 404 atau 500 karena file missing di disk)
  if (response.status === 404 || response.status === 500) {
    const url = new URL(request.url)
    const remoteUrl = process.env.NEXT_PUBLIC_REMOTE_MEDIA_URL

    if (url.pathname.startsWith('/api/media/file/') && remoteUrl) {
      try {
        const remoteHost = new URL(remoteUrl).host
        const isSelf = url.host === remoteHost

        // Hanya fetch dari remote jika tidak memanggil server sendiri (mencegah infinite loop di produksi)
        if (!isSelf) {
          const remoteTarget = `${remoteUrl}${url.pathname}${url.search}`
          const remoteRes = await fetch(remoteTarget)

          if (remoteRes.ok) {
            const contentType = remoteRes.headers.get('content-type') || 'application/octet-stream'
            const buffer = await remoteRes.arrayBuffer()

            // Simpan file ke folder media lokal secara otomatis untuk caching lokal
            try {
              const filename = decodeURIComponent(url.pathname.replace('/api/media/file/', ''))
              const localPath = path.join(process.cwd(), 'media', filename)
              fs.mkdirSync(path.dirname(localPath), { recursive: true })
              fs.writeFileSync(localPath, Buffer.from(buffer))
            } catch {
              // Abaikan jika gagal menulis ke disk lokal
            }

            return new Response(buffer, {
              status: 200,
              headers: {
                'Content-Type': contentType,
                'Cache-Control': 'public, max-age=31536000, immutable',
              },
            })
          }
        }
      } catch (err) {
        console.error('Failed to proxy media from remote VPS:', err)
      }
    }
  }

  return response
}

export const POST = REST_POST(configPromise)
export const DELETE = REST_DELETE(configPromise)
export const OPTIONS = REST_OPTIONS(configPromise)
export const PATCH = REST_PATCH(configPromise)
export const PUT = REST_PUT(configPromise)