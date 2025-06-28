<template>
    <header id="header" class="header">
        <nav class="navigation">
            <div class="navigation__logo" @click="$router.push('/')">
                <img src="@/assets/logo.svg" class="logo">
                <span>ООО "Весы"</span>
            </div>
            <div class="navigation__links">
                <NuxtLink class="link" @click="$router.push('/')">Каталог</NuxtLink>
                <NuxtLink class="link">Контакты</NuxtLink>
            </div>
        </nav>
    </header>
</template>
<script setup lang="ts">

</script>

<style lang="scss" scoped>
.logo{
    width: 3rem;
    color: white;
    background-color: transparent;
}

.header{
    align-items: center;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    backdrop-filter: blur(8px);
    background-color: rgba(33, 33, 33, 0.95);
    font-size: 1rem;
    z-index: 10;
    @extend %materialTransition;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    
    @media (max-width: 1024px) {
        font-size: 0.9rem;
    }
    
    @media (max-width: 768px) {
        font-size: 0.85rem;
    }
    
    @media (max-width: 480px) {
        font-size: 0.8rem;
    }
}

.navigation{
    display: flex;
    justify-content: space-between;
    padding: 0.5rem 5rem;
    color: $colorBlack;
    align-items: center;
    background-color: transparent;
    max-width: 100%;
    box-sizing: border-box;

    @media (max-width: 1440px) {
        padding: 0.5rem 3rem;
    }
    
    @media (max-width: 1024px) {
        padding: 0.5rem 2rem;
    }
    
    @media (max-width: 768px) {
        padding: 0.5rem 1rem;
    }
    
    @media (max-width: 480px) {
        padding: 0.5rem 0.5rem;
    }
    
    &__links{
        display: flex;
        column-gap: 2rem;
        row-gap: 2rem;
        background-color: transparent;
        
        @media (max-width: 1024px) {
            column-gap: 1.5rem;
            row-gap: 1.5rem;
        }
        
        @media (max-width: 768px) {
            column-gap: 1rem;
            row-gap: 1rem;
        }
        
        @media (max-width: 480px) {
            column-gap: 0.5rem;
            row-gap: 0.5rem;
        }
    }

    &__logo{
        display: flex;
        align-items: center;
        gap: 1rem;
        background-color: transparent;
        color: $colorOrange;
        font-size: 1.5rem;
        cursor: pointer;
        @extend %materialTransition;
        
        &:hover {
            transform: scale(1.05);
        }
        
        span{
            background-color: transparent;
        }
        
        @media (max-width: 1024px) {
            font-size: 1.3rem;
            gap: 0.8rem;
        }
        
        @media (max-width: 768px) {
            font-size: 1.1rem;
            gap: 0.6rem;
        }
        
        @media (max-width: 480px) {
            font-size: 1rem;
            gap: 0.4rem;
        }
    }
}

.link{
    font-size: 1rem;
    background-color: transparent;
    color: white;
    cursor: pointer;
    @extend %materialTransition;
    padding: 0.5rem 1rem;
    border-radius: $borderRadius;
    
    &:hover {
        background-color: rgba(255, 255, 255, 0.1);
        color: $colorOrange;
    }
    
    @media (max-width: 1024px) {
        font-size: 0.9rem;
        padding: 0.4rem 0.8rem;
    }
    
    @media (max-width: 768px) {
        font-size: 0.85rem;
        padding: 0.3rem 0.6rem;
    }
    
    @media (max-width: 480px) {
        font-size: 0.8rem;
        padding: 0.25rem 0.5rem;
    }
}
</style>