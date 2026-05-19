import configPromise from '@payload-config'
import { RootPage } from '@payloadcms/next/views'

import { importMap } from '../importMap'

type Args = {
  params: Promise<{ segments: string[] }>
  searchParams: Promise<{ [key: string]: string | string[] }>
}

export default function Page({ params, searchParams }: Args) {
  return (
    <RootPage
      config={configPromise}
      params={params}
      searchParams={searchParams}
      importMap={importMap}
    />
  )
}