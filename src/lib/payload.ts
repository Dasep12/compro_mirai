/* eslint-disable @typescript-eslint/no-explicit-any */
import { getPayload } from "payload";
import config from "../../payload.config";

const globalForPayload = globalThis as unknown as { _payloadClient: any };

export async function getPayloadClient() {
  if (!globalForPayload._payloadClient) {
    globalForPayload._payloadClient = await getPayload({ config });
  }

  return globalForPayload._payloadClient;
}
