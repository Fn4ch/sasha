<template>
    <div>
        <Head>
            <meta name="keywords" content="весы Казань, продажа весов, установка весов, промышленные весы, торговые весы, лабораторные весы, весы оборудование, весы для машин">
            <meta name="robots" content="index, follow">
            <meta name="description" content="ООО «Весы» — надежный партнер в весовом оборудовании с 2006 года. Полный цикл услуг: продажа, монтаж, модернизация, сервисное и гарантийное обслуживание автомобильных, вагонных, платформенных, крановых весов в Казани.">
            <link rel="canonical" href="https://vesi-kazan.ru">
            <meta name="language" content="ru">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Весы Казань - Профессиональное весовое оборудование с 2006 года</title>
            <meta property="og:title" content="Весы Казань - Профессиональное весовое оборудование с 2006 года">
            <meta property="og:description" content="ООО «Весы» — надежный партнер в весовом оборудовании с 2006 года. Полный цикл услуг: продажа, монтаж, модернизация, сервисное и гарантийное обслуживание.">
            <meta property="og:image" content="https://vesi-kazan.ru/images/mainpage.png">
            <meta property="og:url" content="https://vesi-kazan.ru/">
            <meta property="og:type" content="website">
            <meta name="twitter:card" content="summary_large_image">
            <meta name="twitter:title" content="Весы Казань - Профессиональное весовое оборудование">
            <meta name="twitter:description" content="ООО «Весы» — надежный партнер в весовом оборудовании с 2006 года">
            <meta name="twitter:image" content="https://vesi-kazan.ru/images/mainpage.png">
            <meta name="theme-color" content="#f57c00">
            <meta name="msapplication-TileColor" content="#f57c00">
            <meta name="apple-mobile-web-app-capable" content="yes">
            <meta name="apple-mobile-web-app-status-bar-style" content="default">
            <meta name="apple-mobile-web-app-title" content="Весы Казань">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
            <link rel="dns-prefetch" href="https://fonts.googleapis.com">
            <link rel="dns-prefetch" href="https://fonts.gstatic.com">
        </Head>
        <ProductInfo />
        <ProductList />
        <Contacts />
    </div>
</template>

<script setup lang="ts">
import { ProductList, ProductInfo } from '~/src/features/Product'
import Contacts from '~/src/widgets/Contacts.vue'
</script>
