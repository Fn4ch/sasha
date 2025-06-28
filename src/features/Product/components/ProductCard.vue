<template>    
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
            <NuxtLink :to="`/product/${id}`" class="product-card-link">
                <button>Подробнее</button>
            </NuxtLink>
        </div>
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
    width: 100%;
    max-width: 23rem;
    height: 34rem;
    padding: 1.5rem;
    @extend %boxShadow;
    border-radius: $borderRadiusLarge;
    align-items: center;
    background-color: $colorWhite;
    @extend %materialTransition;
    row-gap: 1rem;
    
    &:hover {
        @extend %boxShadowHover;
        transform: translateY(-2px);
    }
    
    @media (min-width: 1921px) {
        border-radius: 0.8vw;
        padding: 1vw;
        margin-top: 2.4vw;
        height: 30vw;
        max-width: 25vw;
    }
    
    @media (max-width: 1440px) {
        max-width: 20rem;
        height: 32rem;
        padding: 1.2rem;
        margin: 0.8rem;
    }
    
    @media (max-width: 1024px) {
        padding: 1rem;
        margin: 0.6rem;
        height: 28rem;
        max-width: 18rem;
    }
    
    @media (max-width: 768px) {
        height: 24rem;
        max-width: 16rem;
        padding: 0.8rem;
        margin: 0.4rem;
        row-gap: 0.8rem;
    }
    
    @media (max-width: 480px) {
        height: 20rem;
        max-width: 16rem;
        padding: 0.8rem;
        margin: 0.4rem;
        row-gap: 0.6rem;
    }
    
    @media (max-width: 375px) {
        height: 18rem;
        max-width: 14rem;
        padding: 0.6rem;
        margin: 0.3rem;
        row-gap: 0.5rem;
    }
    
    @media (max-width: 320px) {
        height: 16rem;
        max-width: 12rem;
        padding: 0.5rem;
        margin: 0.2rem;
        row-gap: 0.4rem;
    }
    
    &__title{
        font-size: 1.5rem;
        font-weight: 500;
        flex-shrink: 0;
        height: 3.2em;
        line-height: 1.4;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        margin-top: 0.5rem;
        color: rgba(0, 0, 0, 0.87);
        
        @media (min-width: 1921px) {
            padding: 0.8vw 0;
            font-size: 1.2vw;
            height: 3.2em;
        }
        
        @media (max-width: 1440px) {
            font-size: 1.3rem;
            padding: 0.8rem 0;
        }
        
        @media (max-width: 1024px) {
            font-size: 1.2rem;
            padding: 0.6rem 0;
        }
        
        @media (max-width: 768px) {
            font-size: 1rem;
            padding: 0.5rem 0;
            height: 2.8em;
        }
        
        @media (max-width: 480px) {
            font-size: 1rem;
            padding: 0.5rem 0;
            height: 2.8em;
        }
        
        @media (max-width: 375px) {
            font-size: 0.9rem;
            padding: 0.4rem 0;
            height: 2.6em;
        }
        
        @media (max-width: 320px) {
            font-size: 0.85rem;
            padding: 0.3rem 0;
            height: 2.4em;
        }
    }
    
    &__description{
        font-size: 1rem;
        color: rgba(0, 0, 0, 0.6);
        flex: 1;
        display: -webkit-box;
        line-clamp: 3;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        line-height: 1.4;
        max-height: 4rem;
        position: relative;
        word-wrap: break-word;
        
        @media (min-width: 1921px) {
            font-size: .8vw;
            max-height: 4rem;
        }
        
        @media (max-width: 1440px) {
            max-height: 3.6rem;
            font-size: 0.9rem;
        }
        
        @media (max-width: 1024px) {
            font-size: 0.9rem;
            max-height: 2.8rem;
            line-clamp: 2;
            -webkit-line-clamp: 2;
        }
        
        @media (max-width: 768px) {
            font-size: 0.8rem;
            max-height: 3.2rem;
            line-height: 1.3;
        }
        
        @media (max-width: 480px) {
            display: none;
        }
    
    }

    button{
        font-size: 1rem;
        margin-top: auto;
        cursor: pointer;
        flex-shrink: 0;
        border-radius: $borderRadius;
        background-color: #f57c00;
        color: $colorWhite;
        padding: 0.75rem 1.5rem;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        @extend %materialTransition;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border: none;
        min-height: 2.5rem;
        
        &:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            background-color: #e65100;
        }
        
        &:active {
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            transform: translateY(0);
        }
        
        @media (max-width: 1024px) {
            font-size: 0.9rem;
            padding: 0.8rem 1.2rem;
            min-height: 2.4rem;
        }
        
        @media (max-width: 768px) {
            font-size: 0.8rem;
            padding: 0.6rem 1rem;
            min-height: 2.2rem;
        }
        
        @media (max-width: 480px) {
            margin-top: 0.5rem;
            font-size: 0.8rem;
            padding: 0.6rem 1rem;
            min-height: 2.2rem;
        }
        
        @media (max-width: 375px) {
            font-size: 0.75rem;
            padding: 0.5rem 0.8rem;
            min-height: 2rem;
        }
        
        @media (max-width: 320px) {
            font-size: 0.7rem;
            padding: 0.4rem 0.6rem;
            min-height: 1.8rem;
        }
    }
    
    .nuxt-img {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 100%;
        height: auto;
        max-width: 100%;
        flex-shrink: 0;
        border-radius: $borderRadius;
        object-fit: cover;
        
        @media (max-width: 768px) {
            max-height: 120px;
        }
        
        @media (max-width: 480px) {
            max-height: 110px;
        }
        
        @media (max-width: 375px) {
            max-height: 100px;
        }
        
        @media (max-width: 320px) {
            max-height: 90px;
        }
    }
}    
</style>