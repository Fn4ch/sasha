<template>
    <section id="catalog" class="products" aria-labelledby="catalog-title">
        <header class="products__header">
            <h2 id="catalog-title">Модульные дома</h2>
            <p>
                Модели площадью от 16 до 38 м². Откройте проект, чтобы посмотреть
                фотографии и обсудить детали.
            </p>
        </header>

        <div class="products__list">
            <ProductCard
                v-for="product in PRODUCTS_DATA"
                :id="product.id"
                :key="product.id"
                :images="product.images"
                :title="product.title"
                :short-description="product.shortDescription"
            />
        </div>
    </section>
</template>

<script setup lang="ts">
import type { IVesi } from '~/src/entities/Product/model'
import products from '~/src/shared/constants/products.json'
import ProductCard from './ProductCard.vue'

const PRODUCTS_DATA: IVesi[] = products
</script>

<style lang="scss" scoped>
.products {
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
    padding: clamp(3rem, 6vw, 6rem) 2rem;
    scroll-margin-top: var(--header-height);

    &__header {
        max-width: 48rem;
        text-align: left;

        h2 {
            margin: 0;
            color: #242522;
            font-size: clamp(2.25rem, 4vw, 4rem);
            font-weight: 650;
            line-height: 1.05;
            letter-spacing: -0.045em;
        }

        p {
            max-width: 42rem;
            margin: 1.25rem 0 0;
            color: #6b6d66;
            font-size: 1.05rem;
            line-height: 1.6;
        }
    }

    &__list {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 2rem;
        align-items: stretch;
        margin-top: 3.5rem;
    }

    @media (max-width: 1100px) {
        &__list {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }
    }

    @media (max-width: 640px) {
        padding: 3rem 1rem;

        &__header p {
            margin-top: 1rem;
            font-size: 1rem;
        }

        &__list {
            grid-template-columns: minmax(0, 1fr);
            gap: 1.25rem;
            margin-top: 2rem;
        }
    }

    @media (max-width: 375px) {
        padding-right: 0.75rem;
        padding-left: 0.75rem;
    }
}
</style>
