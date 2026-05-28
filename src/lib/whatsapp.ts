interface WhatsAppParams {
  phoneNumber?: string;
  message?: string;
}

export const generateWhatsAppUrl = ({
  phoneNumber = "6285218026895",
  message = "Halo Tim Mirai Softnet,\n\nSaya tertarik untuk berdiskusi mengenai Layanan atau Produk Anda di Mirai Softnet & Technology.\n",
}: WhatsAppParams = {}): string => {
  const encodedMessage = encodeURIComponent(message);

  return `https://wa.me/${phoneNumber}?text=${encodedMessage}`;
};
