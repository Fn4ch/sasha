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
    width: 64px;
    color: white;
    background-color: transparent;
}

.header{
    align-items: center;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    backdrop-filter: blur(0.1rem);
    background-color: $colorBlack;
    font-size: 20px;
    z-index: 10;
    @media (max-width:1921px) {
        font-size: 1vw;
    }
    @media (max-width: 1024px) {
        font-size: 16px;
    }
    @media (max-width: 768px) {
        font-size: 14px;
    }
    @media (max-width: 480px) {
        font-size: 12px;
    }
}

.navigation{
    display: flex;
    justify-content: space-between;
    padding: 4px 120px;
    color: $colorBlack;
    align-items: center;
    background-color: transparent;

    @media (min-width: 1921px) {
        padding: 0.6vw 6vw;
    }
    @media (max-width: 1024px) {
        padding: 4px 32px;
    }
    @media (max-width: 768px) {
        padding: 4px 12px;
    }
    @media (max-width: 480px) {
        padding: 4px 4px;
        row-gap: 8px;
        span{
            display: none;
        }
    }
    &__links{
        display: flex;
        column-gap: 48px;
        row-gap: 48px;
        background-color: transparent;
        @media (min-width: 1921px) {
            row-gap: 2.4vw;
        }
        @media (max-width: 768px) {
            column-gap: 16px;
        }
        @media (max-width: 480px) {
            column-gap: 8px;
            row-gap: 8px;
        }
    }

    &__logo{
        display: flex;
        align-items: center;
        gap: 1rem;
        background-color: transparent;
        color: $colorOrange;
        font-size: 2rem;
        cursor: pointer;
        span{
            background-color: transparent;
        }
        @media (max-width: 768px) {
            font-size: 1.2rem;
            gap: 0.5rem;
        }
        @media (max-width: 480px) {
            font-size: 1rem;
            gap: 0.3rem;
        }
    }
}

.link{
    font-size: 1.25rem;
    background-color: transparent;
    color: white;
    cursor: pointer;
    @media (max-width: 768px) {
        font-size: 1rem;
    }
    @media (max-width: 480px) {
        font-size: 0.95rem;
    }
}
</style>