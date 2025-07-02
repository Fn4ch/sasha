<template>
    <article class="products">
        <div class="title">
            <h2>Найдите то что вам нужно</h2>
            <h4>Широкий выбор для всех случаев</h4>
        </div>
        <section class="products-list">
            <ProductCard 
                v-for="(p, index) in PRODUCTS_DATA" 
                :key="p.title"
                :id="p.id"
                :images="p.images" 
                :title="p.title" 
                :shortDescription="p.shortDescription" 
            />
        </section>
    </article>
</template>
<script setup lang="ts">
import type { IVesi } from '~/src/entities/Product/model';
import vesi from  '~/src/shared/constants/vesi.json'
import ProductCard from './ProductCard.vue';

const PRODUCTS_DATA: IVesi[] = vesi
</script>
<style lang="scss" scoped>
.products{
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    align-items: center;
    row-gap: 1rem;
    align-self: flex-start;
    margin-top: -50vh;
    
    h2{
        font-size: 2.2rem;
        font-weight: 300;
        letter-spacing: -0.5px;
        color: rgba(0, 0, 0, 0.87);
        @media (max-width: 1024px) {
            font-size: 1.7rem;
        }
        @media (max-width: 768px) {
            font-size: 1.2rem;
        }
        @media (max-width: 480px) {
            font-size: 1rem;
        }
    }

    h4{
        font-weight: 400;
        font-size: 1.5rem;
        color: rgba(0, 0, 0, 0.6);
        @media (max-width: 1024px) {
            font-size: 1.1rem;
        }
        @media (max-width: 768px) {
            font-size: 0.95rem;
        }
        @media (max-width: 480px) {
            font-size: 0.85rem;
        }
    }
    
    @media (max-width: 1024px) {
        margin-top: -20vh;
    }
    @media (max-width: 768px) {
        margin-top: -5vh;
        row-gap: 0.5rem;
    }
    @media (max-width: 480px) {
        margin-top: 5vh;
        row-gap: 0.3rem;
    }
}

.title{
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: center;
    padding: 0 1rem;
    @media (max-width: 480px) {
        padding: 0 0.3rem;
    }
}

.products-list{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
    padding: 1.4rem;
    max-width: 100%;
    box-sizing: border-box;
    align-items: start;
    
    @media (max-width: 1440px) {
        grid-template-columns: repeat(2, 1fr);
        gap: 0.8rem;
    }
    @media (max-width: 1024px) {
        grid-template-columns: repeat(2, 1fr);
        padding: 1rem;
        gap: 0.6rem;
    }
    @media (max-width: 819px) {
        grid-template-columns: 1fr;
        padding: 0.5rem;
        gap: 0.5rem;
    }
    @media (max-width: 480px) {
        grid-template-columns: 1fr;
        padding: 0.2rem;
        gap: 0.4rem;
    }
}
</style>