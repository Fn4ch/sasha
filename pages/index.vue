<template>
    <div>
        <ProductInfo />
        <ProductList />
        <Contacts />
    </div>
</template>

<script setup lang="ts">
import { ProductList, ProductInfo } from '~/src/features/Product'
import Contacts from '~/src/widgets/Contacts.vue'
import products from '~/src/shared/constants/products.json'

const SITE_URL = 'https://kaomodul.ru'
const title = 'КАО Модуль — модульные дома в Казани'
const description = 'Модульные дома КАО Модуль: модели PX, Q, O и V площадью от 16 до 38 м². Фотографии, размеры и консультация в Казани.'
const image = `${SITE_URL}/images/mainpage.png`
const catalogOffers = products.map(product => ({
    '@type': 'Offer',
    itemOffered: { '@type': 'Product', name: product.title },
}))

useSeoMeta({
    title,
    description,
    keywords: 'модульные дома Казань, купить модульный дом, дома PX, дома Q, дома O, дома V, КАО Модуль',
    robots: 'index, follow',
    author: 'КАО Модуль',
    themeColor: '#f57c00',
    msapplicationTileColor: '#f57c00',
    ogTitle: title,
    ogDescription: description,
    ogImage: image,
    ogUrl: `${SITE_URL}/`,
    ogType: 'website',
    twitterCard: 'summary_large_image',
    twitterTitle: title,
    twitterDescription: description,
    twitterImage: image,
})

useHead({
    link: [{ rel: 'canonical', href: SITE_URL }],
    meta: [
        { name: 'geo.region', content: 'RU-TA' },
        { name: 'geo.placename', content: 'Казань' },
    ],
    script: [{
        type: 'application/ld+json',
        children: JSON.stringify({
            '@context': 'https://schema.org',
            '@graph': [
                {
                    '@type': 'LocalBusiness',
                    '@id': `${SITE_URL}/#organization`,
                    name: 'КАО Модуль',
                    description,
                    url: SITE_URL,
                    telephone: ['+7 963 123 0396'],
                    email: 'kuznetsov358881@yandex.ru',
                    image,
                    logo: {
                        '@type': 'ImageObject',
                        url: `${SITE_URL}/images/logo.webp`,
                    },
                    address: {
                        '@type': 'PostalAddress',
                        streetAddress: 'ул. Маршала Чуйкова, д. 15',
                        addressLocality: 'Казань',
                        addressRegion: 'Республика Татарстан',
                        postalCode: '420000',
                        addressCountry: 'RU',
                    },
                    contactPoint: [
                        {
                            '@type': 'ContactPoint',
                            telephone: '+7 963 123 0396',
                            contactType: 'sales',
                            areaServed: 'RU',
                            availableLanguage: 'Russian',
                        },
                        {
                            '@type': 'ContactPoint',
                            telephone: '+79600310187',
                            contactType: 'customer support',
                            areaServed: 'RU',
                            availableLanguage: 'Russian',
                        },
                    ],
                    areaServed: {
                        '@type': 'Country',
                        name: 'Россия',
                    },
                    hasOfferCatalog: {
                        '@type': 'OfferCatalog',
                        name: 'Модульные дома',
                        itemListElement: catalogOffers,
                    },
                },
                {
                    '@type': 'WebSite',
                    '@id': `${SITE_URL}/#website`,
                    url: SITE_URL,
                    name: 'КАО Модуль',
                    publisher: { '@id': `${SITE_URL}/#organization` },
                    inLanguage: 'ru-RU',
                },
                {
                    '@type': 'WebPage',
                    '@id': `${SITE_URL}/#webpage`,
                    url: SITE_URL,
                    name: title,
                    description,
                    isPartOf: { '@id': `${SITE_URL}/#website` },
                    about: { '@id': `${SITE_URL}/#organization` },
                    inLanguage: 'ru-RU',
                },
            ],
        }),
    }],
})
</script>
