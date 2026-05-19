import configPromise from '@payload-config'
import '@payloadcms/next/css' // Wajib untuk styling Dashboard Admin
import { handleServerFunctions, RootLayout } from '@payloadcms/next/layouts'
import React from 'react'
import type { ServerFunctionClient } from 'payload'
import { importMap } from '../importMap'

const serverFunction: ServerFunctionClient = async function (args) {
  'use server'
  return handleServerFunctions({
    ...args,
    config: configPromise,
    importMap,
  })
}

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <RootLayout 
      config={configPromise} 
      importMap={importMap} 
      serverFunction={serverFunction}
    >
      {children}
    </RootLayout>
  )
}