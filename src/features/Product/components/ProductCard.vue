<template>    
        <div class="product-card">
            <div class="product-card__image-wrapper">
                <NuxtImg
                    :src="getImageUrl(images)"
                    :alt="`${title} - изображение товара`"
                    loading="lazy"
                    format="webp"
                    quality="75"
                    sizes="xs:192px sm:256px md:288px lg:320px xl:368px 2xl:576px"
                    placeholder
                    fetchpriority="low"
                />
                <div class="image-overlay">
                    <div class="overlay-content">
                        <span class="view-details">Подробнее</span>
                    </div>
                </div>
            </div>
            <div class="product-card__content">
                <div class="product-card__title">{{ title }}</div>
                <div class="product-card__description">{{ shortDescription }}</div>
                <NuxtLink :to="`/product/${id}`" class="product-card-link">
                    <button class="modern-button">
                        <span>Подробнее</span>
                        <svg class="button-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M5 12h14M12 5l7 7-7 7"/>
                        </svg>
                    </button>
                </NuxtLink>
            </div>
        </div>
</template>

<script setup lang="ts">
import { getImageFromS3 } from '~/src/shared/lib/utils/getImageUrl'
withDefaults(defineProps<{
    id?: string,
    title?: string,
    images?: string[],
    shortDescription?: string
}>(), {
    title: 'Не удалось загрузить',
    images: () => ['/images/pallete.png'],
    shortDescription: ''
})

const getImageUrl = (images: string[]) => {
    return getImageFromS3(images[0])
}
</script>

<style lang="scss" scoped>
.product-card-link {
    text-decoration: none;
    color: inherit;
    display: block;
    width: 100%;
}

.product-card{
    margin: 1rem;
    display: flex;
    flex-direction: column;
    width: 100%;
    max-width: 23rem;
    height: 38rem;
    padding: 0;
    border-radius: 20px;
    align-items: stretch;
    justify-content: space-between;
    background-color: $colorWhite;
    @extend %materialTransition;
    overflow: hidden;
    position: relative;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    
    &:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        
        .image-overlay {
            opacity: 1;
        }
        
        .modern-button {
            background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
            transform: translateY(0);
            color: $colorWhite;
        }
        
        .button-icon {
            transform: translateX(3px);
        }
    }
    
    @media (min-width: 1921px) {
        border-radius: 1.6vw;
        height: clamp(38rem, 34vw, 52rem);
        max-width: 25vw;
    }
    
    @media (max-width: 1440px) {
        max-width: 20rem;
        height: 34rem;
        margin: 0.8rem;
    }
    
    @media (max-width: 1024px) {
        margin: 0.6rem;
        height: 30rem;
        max-width: 18rem;
    }
    
    @media (max-width: 768px) {
        height: 28rem;
        max-width: 100%;
        width: 100%;
        margin: 0.4rem 0;
    }
    
    @media (max-width: 480px) {
        height: 26rem;
        max-width: 100%;
        width: 100%;
        margin: 0.4rem 0;
    }
    
    @media (max-width: 375px) {
        max-width: 100%;
        width: 100%;
        margin: 0.3rem 0;
    }
    
    @media (max-width: 320px) {
        max-width: 100%;
        width: 100%;
        margin: 0.2rem 0;
    }
    
    &__content {
        padding: 1.5rem;
        display: flex;
        flex-direction: column;
        gap: 1rem;
        flex: 1;
        justify-content: space-between;
        min-height: 0;
        
        @media (min-width: 1921px) {
            padding: 1.2vw;
            gap: 0.8vw;
        }
        
        @media (max-width: 1440px) {
            padding: 1.3rem;
            gap: 0.9rem;
        }
        
        @media (max-width: 1024px) {
            padding: 1.2rem;
            gap: 0.8rem;
        }
        
        @media (max-width: 768px) {
            padding: 1rem;
            gap: 0.8rem;
        }
        
        @media (max-width: 480px) {
            padding: 0.8rem;
            gap: 0.6rem;
        }
        
        @media (max-width: 375px) {
            padding: 0.7rem;
            gap: 0.5rem;
        }
        
        @media (max-width: 320px) {
            padding: 0.6rem;
            gap: 0.4rem;
        }
    }
    
    &__title{
        font-size: 1.4rem;
        font-weight: 600;
        flex-shrink: 0;
        line-height: 1.3;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        color: rgba(0, 0, 0, 0.87);
        margin: 0;
        height: 2.6em;
        min-height: 2.6em;
        max-height: 2.6em;
        
        @media (min-width: 1921px) {
            font-size: 1.12vw;
            height: 2.6em;
            min-height: 2.6em;
            max-height: 2.6em;
        }
        
        @media (max-width: 1440px) {
            font-size: 1.3rem;
            height: 2.6em;
            min-height: 2.6em;
            max-height: 2.6em;
        }
        
        @media (max-width: 1024px) {
            font-size: 1.2rem;
            height: 2.6em;
            min-height: 2.6em;
            max-height: 2.6em;
        }
        
        @media (max-width: 768px) {
            font-size: 1.1rem;
            height: 2.6em;
            min-height: 2.6em;
            max-height: 2.6em;
        }
        
        @media (max-width: 480px) {
            font-size: 1rem;
            height: 2.6em;
            min-height: 2.6em;
            max-height: 2.6em;
        }
        
        @media (max-width: 375px) {
            font-size: 0.95rem;
            height: 2.6em;
            min-height: 2.6em;
            max-height: 2.6em;
        }
        
        @media (max-width: 320px) {
            font-size: 0.9rem;
            height: 2.6em;
            min-height: 2.6em;
            max-height: 2.6em;
        }
    }
    
    &__description{
        font-size: 0.95rem;
        color: rgba(0, 0, 0, 0.6);
        flex: 1;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        line-height: 1.5;
        margin: 0;
        position: relative;
        word-wrap: break-word;
        height: 3em;
        min-height: 3em;
        max-height: 3em;
        
        @media (min-width: 1921px) {
            font-size: 0.76vw;
            height: 3em;
            min-height: 3em;
            max-height: 3em;
        }
        
        @media (max-width: 1440px) {
            font-size: 0.9rem;
            height: 3em;
            min-height: 3em;
            max-height: 3em;
        }
        
        @media (max-width: 1024px) {
            font-size: 0.85rem;
            height: 3em;
            min-height: 3em;
            max-height: 3em;
            display: none;
        }
    }

    .product-card__image-wrapper {
        width: 100%;
        height: 60%;
        overflow: hidden;
        border-radius: 20px 20px 0 0;
        margin-bottom: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 280px;
        position: relative;
        
        @media (min-width: 1921px) {
            border-radius: 1.6vw 1.6vw 0 0;
            height: 65%;
            min-height: clamp(20rem, 20vw, 34rem);
        }
        
        @media (max-width: 1440px) {
            height: 60%;
            min-height: 280px;
        }
        
        @media (max-width: 1024px) {
            height: 65%;
            min-height: 260px;
        }
        
        @media (max-width: 768px) {
            height: 70%;
            min-height: 240px;
        }
        
        @media (max-width: 480px) {
            min-height: 220px;
        }
        
        @media (max-width: 375px) {
            min-height: 200px;
        }
        
        @media (max-width: 320px) {
            min-height: 180px;
        }
    }
    
    .product-card__image-wrapper img {
        width: 100% !important;
        height: 100% !important;
        object-fit: cover;
        display: block;
        transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        background-color: #f5f5f5;
        object-position: center;
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        min-width: 100%;
        min-height: 100%;

        @media (min-width: 1921px) {
            border-radius: 1.6vw 1.6vw 0 0;
        }
    }

    .product-card:hover .product-card__image-wrapper img {
        transform: scale(1.05);
    }
}

.image-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(
        135deg,
        rgba(245, 124, 0, 0.4) 0%,
        rgba(255, 152, 0, 0.3) 100%
    );
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.3s ease;
    border-radius: 20px 20px 0 0;
    
    @media (min-width: 1921px) {
        border-radius: 1.6vw 1.6vw 0 0;
    }
}

.overlay-content {
    text-align: center;
    color: white;
}

.view-details {
    font-size: 1.1rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    
    @media (min-width: 1921px) {
        font-size: 0.88vw;
    }
    
    @media (max-width: 768px) {
        font-size: 1rem;
    }
}

.modern-button {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    padding: 1rem 1.5rem;
    border-radius: 12px;
    font-size: 1rem;
    font-weight: 600;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    background: rgba(245, 124, 0, 0.1);
    color: #f57c00;
    border: 2px solid rgba(245, 124, 0, 0.2);
    position: relative;
    overflow: hidden;
    height: 3.5rem;
    min-height: 3.5rem;
    max-height: 3.5rem;
    flex-shrink: 0;
    
    @media (min-width: 1921px) {
        padding: 0.8vw 1.2vw;
        font-size: 0.8vw;
        gap: 0.4vw;
        border-radius: 0.96vw;
        height: 3.5rem;
        min-height: 3.5rem;
        max-height: 3.5rem;
    }
    
    @media (max-width: 1440px) {
        height: 3.2rem;
        min-height: 3.2rem;
        max-height: 3.2rem;
    }
    
    @media (max-width: 1024px) {
        font-size: 0.9rem;
        padding: 0.8rem 1.2rem;
        height: 3rem;
        min-height: 3rem;
        max-height: 3rem;
    }
    
    @media (max-width: 768px) {
        font-size: 0.85rem;
        padding: 0.7rem 1rem;
        height: 2.8rem;
        min-height: 2.8rem;
        max-height: 2.8rem;
    }
    
    @media (max-width: 480px) {
        font-size: 0.8rem;
        padding: 0.6rem 0.8rem;
        height: 2.6rem;
        min-height: 2.6rem;
        max-height: 2.6rem;
    }
    
    @media (max-width: 375px) {
        font-size: 0.75rem;
        padding: 0.5rem 0.7rem;
        height: 2.4rem;
        min-height: 2.4rem;
        max-height: 2.4rem;
    }
    
    @media (max-width: 320px) {
        font-size: 0.7rem;
        padding: 0.4rem 0.6rem;
        height: 2.2rem;
        min-height: 2.2rem;
        max-height: 2.2rem;
    }
}

.button-icon {
    width: 18px;
    height: 18px;
    transition: transform 0.3s ease;
    
    @media (min-width: 1921px) {
        width: 1.44vw;
        height: 1.44vw;
    }
    
    @media (max-width: 768px) {
        width: 16px;
        height: 16px;
    }
}
</style>