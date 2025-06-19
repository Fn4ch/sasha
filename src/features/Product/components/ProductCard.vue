<template>
    <NuxtLink :to="`/product/${id}`" class="product-card-link">
        <div class="product-card">
            <NuxtImg
                v-if="images && images.length > 0"
                :src="`/images/${images[0]}.png`"
                fit="cover"
                width="320"
                height="240"
                alt="product image"
            />
            <NuxtImg
                v-else
                src="/images/pallete.png"
                fit="cover"
                width="320"
                height="240"
                alt="product image"
            />
            <div class="product-card__title">{{ title }}</div>
            <div class="product-card__description">{{ description }}</div>
            <button>Запросить цену</button>
        </div>
    </NuxtLink>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
    id?: string,
    title?: string,
    images?: string[],
    description?: string
}>(), {
    title: 'Не удалось загрузить',
    images: () => ['/images/pallete.png'],
    description: ''
})
</script>

<style lang="scss" scoped>
.product-card-link {
    text-decoration: none;
    color: inherit;
    display: block;
}
.product-card{
    margin: 1rem;
    display: flex;
    flex-direction: column;
    width: min-content;
    padding: 1.5rem;
    width: 23rem;
    @extend %boxShadow;
    border-radius: 0.1rem;
    align-items: center;
    @media (min-width: 1921px) {
        border-radius: 0.8vw;
        padding: 1vw;
        margin-top: 2.4vw;
    }
    @media (max-width: 1024px) {
        padding: 1rem;
        margin-top: 1rem;
    }
    &__title{
        padding: 1rem 0;
        font-size: 1.5rem;
        font-weight: 500;
        @media (min-width: 1921px) {
            padding: 0.8vw 0;
            font-size: 1.2vw;
        }
    }
    &__description{
        font-size: 1rem;
        color: $colorGreyDark;
        word-wrap: normal;
        padding-bottom: 1.5rem;
        @media (min-width: 1921px) {
            font-size: .8vw;
        }
    }

    button{
        font-size: 1rem;
        margin-top: auto;
        cursor: pointer;
    }
    .nuxt-img {
        display: block;
        margin-left: auto;
        margin-right: auto;
    }
}    
</style>