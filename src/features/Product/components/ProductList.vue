<template>
    <article id="catalog" class="products">
        <div class="title">
            <h2>Каталог</h2>
        </div>
        <section class="products-list">
            <ProductCard 
                v-for="p in PRODUCTS_DATA" 
                :id="p.id"
                :key="p.title"
                :images="p.images" 
                :title="p.title" 
                :short-description="p.shortDescription" 
            />
        </section>
    </article>
</template>
<script setup lang="ts">
import type { IVesi } from '~/src/entities/Product/model';
import products from  '~/src/shared/constants/products.json'
import ProductCard from './ProductCard.vue';

const PRODUCTS_DATA: IVesi[] = products
</script>
<style lang="scss" scoped>
.products{
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    row-gap: 2rem;
    padding: 2rem;
    margin: 2rem auto 0 auto;
    scroll-margin-top: 80px;
    max-width: 100%;
    
    @media (max-width: 1440px) {
        row-gap: 1.8rem;
        padding: 1.8rem;
    }
    
    @media (max-width: 1024px) {
        row-gap: 1.5rem;
        padding: 1.5rem;
    }
    
    @media (max-width: 768px) {
        row-gap: 1rem;
        padding: 1rem;
    }
    
    @media (max-width: 480px) {
        margin-top: 5vh;
        row-gap: 0.8rem;
        padding: 0.8rem;
    }
    
    @media (max-width: 375px) {
        padding: 0.5rem;
        row-gap: 0.6rem;
    }
}

.title{
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: center;
    text-align: center;
    max-width: 800px;
    width: 100%;
    margin: 0 auto;
    
    @media (max-width: 1440px) {
        max-width: 700px;
    }
    
    @media (max-width: 1024px) {
        max-width: 600px;
    }
    
    @media (max-width: 768px) {
        max-width: 500px;
    }
    
    @media (max-width: 480px) {
        max-width: 100%;
        padding: 0 0.5rem;
    }
    
    @media (max-width: 375px) {
        padding: 0 0.3rem;
    }
}

.title-badge {
    display: inline-block;
    background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
    border-radius: 50px;
    padding: 0.5rem 1.5rem;
    margin-bottom: 1.5rem;
    font-size: 0.9rem;
    font-weight: 600;
    color: white;
    text-transform: uppercase;
    letter-spacing: 1px;
    box-shadow: 0 4px 15px rgba(245, 124, 0, 0.3);
    
    @media (min-width: 1921px) {
        padding: 0.4vw 1.2vw;
        font-size: 0.7vw;
        margin-bottom: 1.2vw;
    }
    
    @media (max-width: 768px) {
        padding: 0.4rem 1rem;
        font-size: 0.8rem;
        margin-bottom: 1rem;
    }
    
    @media (max-width: 480px) {
        padding: 0.3rem 0.8rem;
        font-size: 0.75rem;
        margin-bottom: 0.8rem;
    }
}

.products h2{
    font-size: 3rem;
    font-weight: 700;
    letter-spacing: -1px;
    color: rgba(0, 0, 0, 0.87);
    margin: 0 0 1rem 0;
    background: linear-gradient(135deg, #333 0%, #666 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    
    @media (min-width: 1921px) {
        font-size: 2.4vw;
        margin: 0 0 0.8vw 0;
    }
    
    @media (max-width: 1024px) {
        font-size: 2.5rem;
        margin: 0 0 0.8rem 0;
    }
    
    @media (max-width: 768px) {
        font-size: 2rem;
        margin: 0 0 0.6rem 0;
    }
    
    @media (max-width: 480px) {
        font-size: 1.5rem;
        margin: 0 0 0.5rem 0;
    }
}

.products h4{
    font-weight: 400;
    font-size: 1.3rem;
    color: rgba(0, 0, 0, 0.6);
    margin: 0;
    line-height: 1.4;
    
    @media (min-width: 1921px) {
        font-size: 1.04vw;
    }
    
    @media (max-width: 1024px) {
        font-size: 1.1rem;
    }
    
    @media (max-width: 768px) {
        font-size: 1rem;
    }
    
    @media (max-width: 480px) {
        font-size: 0.9rem;
    }
}

.products-list{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;
    padding: 2rem;
    max-width: 1400px;
    width: 100%;
    box-sizing: border-box;
    align-items: start;
    justify-items: center;
    margin: 0 auto;

    @media (min-width: 1921px) {
        max-width: 1800px;
        gap: 2.5rem;
        padding: 2.5rem;
    }

    @media (max-width: 1440px) {
        gap: 1.5rem;
        padding: 1.5rem;
        max-width: 1200px;
    }

    @media (max-width: 1024px) {
        grid-template-columns: repeat(2, 1fr);
        padding: 1rem;
        gap: 1.2rem;
        max-width: 1000px;
    }

    @media (max-width: 768px) {
        grid-template-columns: repeat(2, 1fr);
        padding: 0.8rem;
        gap: 1rem;
        max-width: 100%;
    }

    @media (max-width: 480px) {
        grid-template-columns: 1fr;
        padding: 0.5rem;
        gap: 0.8rem;
    }

    @media (max-width: 375px) {
        padding: 0.3rem;
        gap: 0.6rem;
    }
}
</style>