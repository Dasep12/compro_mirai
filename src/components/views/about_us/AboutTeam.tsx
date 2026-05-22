import Image from "next/image";
import Link from "next/link";
import { AboutUs } from "../../../../payload-types";

interface AboutTeamProps {
  data: AboutUs;
}

export default function AboutTeam({ data }: AboutTeamProps) {
  if (!data?.teamMembers || (data.teamMembers ?? []).length === 0) {
    return null;
  }

  return (
    <section className="w-full relative overflow-hidden bg-[#7eb2fc]/5 px-4 lg:px-[120px] 2xl:px-[240px] py-[80px] lg:py-[100px] flex flex-col items-center gap-[60px] font-sans">
      <div className="absolute top-0 left-0 w-full h-[400px] bg-linear-to-b from-[#7eb2fc]/10 to-transparent -z-10" />

      <div className="flex flex-col items-center text-center gap-4 relative z-10 w-full">
        <div className="bg-primary text-white rounded-full px-[16px] py-[6px] text-[14px] font-bold leading-[120%] tracking-wide uppercase">
          Tim Kami
        </div>

        <h2 className="text-[32px] md:text-[42px] font-bold leading-[125%] text-[#010101] tracking-tight">
          {data.teamHeadline || "Tim Pakar di Balik Mirai Softnet"}
        </h2>

        {data.teamDescription && (
          <p className="text-[16px] md:text-[17px] leading-[180%] font-medium text-[#010101]/70 mt-1">
            {data.teamDescription}
          </p>
        )}
      </div>

      <div className="w-full flex flex-wrap justify-center gap-[24px] md:gap-[32px] relative z-10">
        {(data.teamMembers ?? []).map((member, index) => {
          const photoUrl =
            member.photo &&
            typeof member.photo === "object" &&
            "url" in member.photo
              ? (member.photo.url as string)
              : null;

          return (
            <div
              key={member.id || index}
              className="group flex flex-col bg-[#fdfdfd] border border-gray-100 rounded-[32px] p-3 shadow-[0px_8px_24px_-8px_rgba(0,0,0,0.04)] hover:shadow-[0px_16px_40px_-8px_rgba(4,81,191,0.12)] hover:border-[#7eb2fc]/40 transition-all duration-300 w-[280px] sm:w-[300px] shrink-0"
            >
              <div className="w-full aspect-4/5 relative rounded-[24px] overflow-hidden bg-[#7eb2fc]/10 mb-4">
                {photoUrl ? (
                  <Image
                    src={photoUrl}
                    alt={`Foto ${member.name}`}
                    fill
                    sizes="(max-width: 768px) 280px, 300px"
                    className="object-cover transition-transform duration-700 ease-in-out group-hover:scale-105"
                  />
                ) : (
                  <div className="w-full h-full flex items-center justify-center text-[#7eb2fc]/40">
                    <svg
                      className="w-24 h-24"
                      fill="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
                    </svg>
                  </div>
                )}

                {member.linkedin && (
                  <div className="absolute top-4 right-4 z-20">
                    <Link
                      href={member.linkedin}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="w-10 h-10 rounded-full bg-[#fdfdfd]/70 backdrop-blur-md border border-white/50 flex items-center justify-center text-[#0077B5] hover:bg-[#0077B5] hover:text-[#fdfdfd] hover:border-[#0077B5] transition-all duration-300 shadow-sm"
                      aria-label={`LinkedIn ${member.name}`}
                    >
                      <svg className="w-4 h-4 fill-current" viewBox="0 0 24 24">
                        <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" />
                      </svg>
                    </Link>
                  </div>
                )}

                <div className="absolute bottom-0 left-0 w-full h-1/3 bg-linear-to-t from-black/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none" />
              </div>

              <div className="px-3 pb-4 pt-1 flex flex-col items-center text-center gap-1">
                <h3 className="text-[20px] font-bold leading-[130%] text-[#010101] group-hover:text-primary transition-colors duration-300 line-clamp-1 w-full">
                  {member.name}
                </h3>
                <p className="text-[15px] font-bold text-primary opacity-80 line-clamp-1 w-full">
                  {member.position}
                </p>
              </div>
            </div>
          );
        })}
      </div>
    </section>
  );
}
