import { getProductBySlug } from "@/lib/data/collections";
import { notFound } from "next/navigation";
import ProductHero from "@/components/views/products/ProductHero";
import ProductFeatures from "@/components/views/products/ProductFeatures";
import ProductBenefits from "@/components/views/products/ProductBenefits";
import ProductGallery from "@/components/views/products/ProductGallery";
import ProductEcosystem from "@/components/views/products/ProductEcosystem";
import FadeInUp from "@/components/ui/FadeInUp";
import ProductCTA from "@/components/views/products/ProductCTA";

interface PageProps {
    params: Promise<{slug: string}> 
}

export default async function ProductPage({params}: PageProps){
    const {slug} = await params;
    const product = await getProductBySlug(slug);

    if(!product){
        return notFound();
    }
    
    return (
        <main className="overflow-hidden">
            <ProductHero product={product} />

            <FadeInUp delay={0.2}>
                <ProductFeatures product={product} />
            </FadeInUp>

            <FadeInUp>
                <ProductBenefits product={product} />
            </FadeInUp>
            
            <FadeInUp>
                <ProductGallery product={product} />
            </FadeInUp>

            <FadeInUp>
                <ProductCTA product={product} />
            </FadeInUp>

            <FadeInUp>
                <ProductEcosystem product={product} />
            </FadeInUp>
        </main>
    );
    
}