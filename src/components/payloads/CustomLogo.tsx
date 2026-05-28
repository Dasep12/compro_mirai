import Image from "next/image";

export const CustomLogo = () => {
  return (
    <div
      style={{ padding: "10px 0", display: "flex", justifyContent: "center" }}
    >
      <Image
        src="/api/media/file/mirai-white.png"
        alt="mirai-white-logo"
        width={402}
        height={140}
        style={{
          width: "100%",
          maxWidth: "180px",
          height: "auto",
          objectFit: "contain",
        }}
        priority
      />
    </div>
  );
};
