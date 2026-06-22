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

const SITE_URL = 'https://vesi-kazan.ru'
const title = 'Весы Казань — Продажа и обслуживание весового оборудования с 2006 года'
const description = 'ООО «Весы» — продажа, монтаж и сервис весового оборудования в Казани с 2006 года. 17 лет опыта, более 1000 установок. Автомобильные, вагонные, платформенные, крановые весы. Тел.: +7 (960) 031-01-85.'
const image = `${SITE_URL}/images/mainpage.png`

useSeoMeta({
  title,
  description,
  keywords: 'весы Казань, продажа весов Казань, автомобильные весы Казань, платформенные весы, вагонные весы, крановые весы, монтаж весов, обслуживание весов, весовое оборудование Казань, поверка весов Казань, ремонт весов Казань',
  robots: 'index, follow',
  author: 'ООО «Весы»',
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
          name: 'ООО «Весы»',
          alternateName: 'Весы Казань',
          description,
          url: SITE_URL,
          telephone: ['+79600310185', '+79600310187'],
          email: 'rusbar2008@rambler.ru',
          foundingDate: '2006',
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
              telephone: '+79600310185',
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
            name: 'Весовое оборудование и услуги',
            itemListElement: [
              { '@type': 'Offer', itemOffered: { '@type': 'Service', name: 'Продажа весового оборудования' } },
              { '@type': 'Offer', itemOffered: { '@type': 'Service', name: 'Монтаж весов' } },
              { '@type': 'Offer', itemOffered: { '@type': 'Service', name: 'Сервисное и гарантийное обслуживание весов' } },
              { '@type': 'Offer', itemOffered: { '@type': 'Service', name: 'Модернизация весов' } },
              { '@type': 'Offer', itemOffered: { '@type': 'Service', name: 'Подготовка весов к поверке' } },
            ],
          },
        },
        {
          '@type': 'WebSite',
          '@id': `${SITE_URL}/#website`,
          url: SITE_URL,
          name: 'Весы Казань',
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
