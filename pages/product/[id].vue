<template>
  <div class="product-page">
    <template v-if="product && product.images && product.images.length">
      <NuxtLink to="/#catalog" class="back-link">
        <ArrowLeft />
        <span>Каталог домов</span>
      </NuxtLink>

      <div class="product-container">
        <div class="product-gallery">
          <div
            ref="mainTrackRef"
            class="main-image-track"
            role="group"
            :aria-label="`${product.title}: фотогалерея`"
            @scroll.passive="handleMainScroll"
          >
            <button
              v-for="(image, index) in product.images"
              :key="image"
              type="button"
              class="main-image-slide"
              :aria-label="`Увеличить фотографию ${index + 1}`"
              @click="openFullscreen(index)"
            >
              <NuxtImg
                :src="getImageFromS3(image)"
                fit="cover"
                width="800"
                height="600"
                :alt="`${product.title} — фотография ${index + 1}`"
                class="main-image"
                :loading="index === 0 ? 'eager' : 'lazy'"
                format="webp"
                quality="85"
                :priority="index === 0"
                :fetchpriority="index === 0 ? 'high' : 'low'"
              />
              <span class="image-counter" aria-hidden="true">
                {{ index + 1 }} / {{ product.images.length }}
              </span>
              <span class="zoom-indicator" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                  <circle cx="11" cy="11" r="7" />
                  <path d="m20 20-4-4M11 8v6M8 11h6" />
                </svg>
                <span>Увеличить</span>
              </span>
            </button>
          </div>

          <div v-if="product.images.length > 1" class="thumbnail-container">
            <button
              type="button"
              class="thumbnail-arrow"
              :disabled="isFirstImage"
              aria-label="Предыдущая фотография"
              @click="prevImage"
            >
              <ArrowLeft />
            </button>

            <div class="thumbnails-wrapper">
              <div ref="thumbnailsRef" class="thumbnails">
                <button
                  v-for="(image, index) in product.images"
                  :key="image"
                  type="button"
                  class="thumbnail"
                  :class="{ active: index === currentIndex }"
                  :aria-label="`Показать фотографию ${index + 1}`"
                  :aria-pressed="index === currentIndex"
                  @click="selectImage(index)"
                >
                  <NuxtImg
                    :src="getImageFromS3(image)"
                    fit="cover"
                    width="80"
                    height="80"
                    alt=""
                    loading="lazy"
                    format="webp"
                    quality="60"
                    fetchpriority="low"
                  />
                </button>
              </div>
            </div>

            <button
              type="button"
              class="thumbnail-arrow"
              :disabled="isLastImage"
              aria-label="Следующая фотография"
              @click="nextImage"
            >
              <ArrowRight />
            </button>
          </div>
        </div>

        <div class="product-info">
          <h1 class="product-title">
            <span>Модульный дом</span>
            {{ model }}
          </h1>

          <dl v-if="dimensions || area" class="product-specs">
            <div v-if="dimensions">
              <dt>Длина × ширина × высота</dt>
              <dd>{{ dimensions }}</dd>
            </div>
            <div v-if="area">
              <dt>Площадь</dt>
              <dd>{{ area }}</dd>
            </div>
          </dl>
          <p v-else-if="product.shortDescription" class="product-description">
            {{ product.shortDescription }}
          </p>

          <ul class="product-services">
            <li>Официальная гарантия производителя</li>
            <li>Доставка по России и Казахстану</li>
          </ul>

          <div class="product-contact">
            <p>Расскажите, что важно для вашего участка и отдыха. Обсудим эту модель и ответим на вопросы.</p>
            <button type="button" class="contact-btn" @click="openContactModal">
              Связаться с нами
            </button>
          </div>
        </div>
      </div>

      <FullscreenView
        v-model:is-open="isFullscreenOpen"
        :images="fullscreenImages"
        :initial-index="currentIndex"
        @close="closeFullscreen"
      />
    </template>

    <div v-else class="not-found">
      <h1>Такой модели нет в каталоге</h1>
      <p>Вернитесь к списку модульных домов и выберите другой проект.</p>
      <NuxtLink to="/#catalog" class="back-btn">
        <ArrowLeft />
        <span>Вернуться в каталог</span>
      </NuxtLink>
    </div>

    <ContactModal v-model:is-open="isContactOpen" />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, nextTick } from 'vue'
import { useRoute } from 'vue-router'
import { useProduct } from '~/src/features/Product/lib'
import { FullscreenView } from '~/src/shared/ui'
import ArrowLeft from '~/src/shared/lib/icons/ArrowLeft.vue'
import ArrowRight from '~/src/shared/lib/icons/ArrowRight.vue'
import { getImageFromS3 } from '~/src/shared/lib/utils/getImageUrl'
import { useSeoMeta, useHead, useRequestURL } from '#imports'
import ContactModal from '~/src/widgets/ContactModal.vue'

const route = useRoute()
const productId = computed(() => route.params.id as string)
const product = useProduct(productId.value)
const currentIndex = ref(0)
const mainTrackRef = ref<HTMLElement>()
const thumbnailsRef = ref<HTMLElement>()
const isFullscreenOpen = ref(false)
const isContactOpen = ref(false)

const isFirstImage = computed(() => currentIndex.value <= 0)
const isLastImage = computed(() => {
  if (!product.value?.images?.length) return true
  return currentIndex.value >= product.value.images.length - 1
})

const model = computed(() => product.value?.title.replace(/^Модульный дом\s*/i, '') || '')
const dimensions = computed(() => {
  const match = product.value?.shortDescription.match(/Д\s*(\d+)\s*[хx×]\s*Ш\s*(\d+)\s*[хx×]\s*В\s*(\d+)/i)
  return match ? `${match[1]} × ${match[2]} × ${match[3]} мм` : ''
})
const area = computed(() => {
  const match = product.value?.shortDescription.match(/Площадь\s*:?\s*(\d+(?:[.,]\d+)?)\s*м\s*2/i)
  return match ? `${match[1]} м²` : ''
})

const fullscreenImages = computed(() => {
  if (!product.value?.images) return []
  return product.value.images.map(image => getImageFromS3(image))
})

const url = useRequestURL()
const canonical = computed(() => new URL(`/product/${productId.value}`, url.origin).toString())
const seoTitle = computed(() => product.value
  ? `${product.value.title} | КАО Модуль`
  : 'Модель не найдена | КАО Модуль'
)
const seoDescription = computed(() => product.value
  ? `${product.value.title}. ${product.value.shortDescription}. Фотографии и консультация КАО Модуль.`
  : 'Каталог модульных домов КАО Модуль.'
)
const seoKeywords = computed(() => product.value
  ? `${product.value.title}, модульные дома, купить модульный дом, КАО Модуль`
  : 'модульные дома, КАО Модуль'
)
const seoImage = computed(() => {
  const first = product.value?.images?.[0]
  return first ? getImageFromS3(first) : '/images/logo.webp'
})

useSeoMeta({
  title: () => seoTitle.value,
  ogTitle: () => seoTitle.value,
  description: () => seoDescription.value,
  ogDescription: () => seoDescription.value,
  ogImage: () => seoImage.value,
  ogUrl: () => canonical.value,
  ogType: 'product',
  keywords: () => seoKeywords.value,
  twitterCard: 'summary_large_image',
  twitterTitle: () => seoTitle.value,
  twitterDescription: () => seoDescription.value,
  twitterImage: () => seoImage.value,
  robots: () => product.value ? 'index, follow' : 'noindex, nofollow',
})

useHead(() => {
  const found = !!product.value
  const ldProduct = found ? {
    '@context': 'https://schema.org',
    '@type': 'Product',
    name: product.value?.title,
    description: seoDescription.value,
    image: product.value?.images?.map(img => getImageFromS3(img)) || [],
    url: canonical.value,
    brand: {
      '@type': 'Brand',
      name: 'КАО Модуль',
    },
    seller: {
      '@type': 'LocalBusiness',
      name: 'КАО Модуль',
      url: 'https://kaomodul.ru',
      telephone: '+79600310185',
    },
  } : null

  return {
    link: [
      { rel: 'canonical', href: canonical.value }
    ],
    meta: found ? [] : [
      { name: 'robots', content: 'noindex, nofollow' }
    ],
    script: found && ldProduct ? [
      { type: 'application/ld+json', children: JSON.stringify(ldProduct) }
    ] : []
  }
})

function getScrollBehavior(): ScrollBehavior {
  return window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth'
}

function selectImage(index: number) {
  currentIndex.value = index
  const behavior = getScrollBehavior()
  if (mainTrackRef.value) {
    mainTrackRef.value.scrollTo({
      left: index * mainTrackRef.value.clientWidth,
      behavior
    })
  }
  thumbnailsRef.value
    ?.querySelectorAll('.thumbnail')[index]
    ?.scrollIntoView({ behavior, block: 'nearest', inline: 'nearest' })
}

function prevImage() {
  if (currentIndex.value > 0) {
    selectImage(currentIndex.value - 1)
  }
}

function nextImage() {
  if (product.value?.images && currentIndex.value < product.value.images.length - 1) {
    selectImage(currentIndex.value + 1)
  }
}

function handleMainScroll() {
  const track = mainTrackRef.value
  if (!track || !product.value?.images?.length) return

  const slideWidth = track.clientWidth
  if (!slideWidth) return

  const index = Math.round(track.scrollLeft / slideWidth)
  const clampedIndex = Math.min(Math.max(index, 0), product.value.images.length - 1)
  if (clampedIndex !== currentIndex.value) {
    currentIndex.value = clampedIndex
  }
}

function openFullscreen(index: number) {
  currentIndex.value = index
  isFullscreenOpen.value = true
}

function closeFullscreen() {
  isFullscreenOpen.value = false
}

function openContactModal() {
  isContactOpen.value = true
}

watch(() => product.value, () => {
  currentIndex.value = 0
  nextTick(() => {
    mainTrackRef.value?.scrollTo({ left: 0 })
  })
})
</script>

<style lang="scss" scoped>
.product-page {
  width: 100%;
  max-width: 1440px;
  min-height: calc(100vh - var(--header-height));
  margin: var(--header-height) auto 0;
  padding: 2.5rem 2rem 5rem;
  color: #242522;
}

.back-link {
  display: inline-flex;
  align-items: center;
  gap: 0.55rem;
  margin-bottom: 2rem;
  color: #6b6d66;
  font-size: 0.9rem;
  font-weight: 550;
  text-decoration: none;
  transition: color 0.2s ease;

  :deep(svg) {
    width: 1rem;
    height: 1rem;
  }

  &:hover {
    color: #242522;
  }

  &:focus-visible {
    outline: 3px solid rgba(245, 124, 0, 0.55);
    outline-offset: 5px;
  }
}

.product-container {
  display: grid;
  grid-template-columns: minmax(0, 1.45fr) minmax(20rem, 1fr);
  gap: clamp(2rem, 4vw, 4.5rem);
  align-items: start;
}

.product-gallery {
  min-width: 0;
}

.main-image-track {
  display: flex;
  width: 100%;
  aspect-ratio: 4 / 3;
  overflow-x: auto;
  background: #f4f5f1;
  border-radius: 6px;
  scroll-behavior: smooth;
  scroll-snap-type: x mandatory;
  scrollbar-width: none;
  -ms-overflow-style: none;

  &::-webkit-scrollbar {
    display: none;
  }
}

.main-image-slide {
  position: relative;
  flex: 0 0 100%;
  min-width: 0;
  height: 100%;
  padding: 0;
  overflow: hidden;
  color: #242522;
  background: #f4f5f1;
  border: 0;
  border-radius: 0;
  box-shadow: none;
  scroll-snap-align: start;
  text-transform: none;

  &:hover {
    box-shadow: none;
    transform: none;
  }

  &:focus-visible {
    z-index: 1;
    outline: 3px solid #f57c00;
    outline-offset: -3px;
  }
}

.main-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.image-counter {
  position: absolute;
  top: 1rem;
  right: 1rem;
  padding: 0.35rem 0.55rem;
  color: #242522;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 4px;
  font-size: 0.75rem;
  font-variant-numeric: tabular-nums;
  line-height: 1;
}

.zoom-indicator {
  position: absolute;
  right: 1rem;
  bottom: 1rem;
  display: inline-flex;
  align-items: center;
  gap: 0.45rem;
  padding: 0.6rem 0.75rem;
  background: rgba(255, 255, 255, 0.92);
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
  line-height: 1;

  svg {
    width: 1rem;
    height: 1rem;
  }
}

.thumbnail-container {
  display: grid;
  grid-template-columns: 2.75rem minmax(0, 1fr) 2.75rem;
  gap: 0.75rem;
  align-items: center;
  margin-top: 1rem;
}

.thumbnails-wrapper {
  min-width: 0;
  overflow: hidden;
}

.thumbnails {
  display: flex;
  gap: 0.65rem;
  padding: 3px;
  overflow-x: auto;
  scrollbar-width: none;
  -ms-overflow-style: none;

  &::-webkit-scrollbar {
    display: none;
  }
}

.thumbnail {
  position: relative;
  flex: 0 0 4.5rem;
  width: 4.5rem;
  height: 4.5rem;
  padding: 0;
  overflow: hidden;
  background: #f4f5f1;
  border: 1px solid #ddded8;
  border-radius: 4px;
  box-shadow: none;
  opacity: 0.65;
  transition: border-color 0.2s ease, opacity 0.2s ease;

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  &:hover {
    box-shadow: none;
    opacity: 1;
    transform: none;
  }

  &.active {
    border-color: #f57c00;
    box-shadow: inset 0 0 0 1px #f57c00;
    opacity: 1;
  }

  &:focus-visible {
    outline: 3px solid rgba(245, 124, 0, 0.55);
    outline-offset: 2px;
  }
}

.thumbnail-arrow {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 2.75rem;
  height: 2.75rem;
  padding: 0;
  color: #242522;
  background: #ffffff;
  border: 1px solid #ddded8;
  border-radius: 4px;
  box-shadow: none;
  transition: border-color 0.2s ease, background-color 0.2s ease;

  :deep(svg) {
    width: 1.1rem;
    height: 1.1rem;
  }

  &:hover:not(:disabled) {
    background: #f4f5f1;
    border-color: #b7b9b0;
    box-shadow: none;
    transform: none;
  }

  &:disabled {
    cursor: not-allowed;
    opacity: 0.35;
  }

  &:focus-visible {
    outline: 3px solid rgba(245, 124, 0, 0.55);
    outline-offset: 3px;
  }
}

.product-info {
  position: sticky;
  top: calc(var(--header-height) + 2rem);
  min-width: 0;
  padding-top: 0.75rem;
}

.product-title {
  margin: 0;
  overflow-wrap: anywhere;
  color: #242522;
  font-size: clamp(3.25rem, 5vw, 5.5rem);
  font-weight: 700;
  line-height: 0.95;
  letter-spacing: -0.06em;

  span {
    display: block;
    margin-bottom: 0.85rem;
    color: #6b6d66;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1.4;
    letter-spacing: normal;
  }
}

.product-specs {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(min(100%, 12rem), 1fr));
  gap: 1.25rem;
  margin: 2.25rem 0 0;
  padding: 1.25rem 0;
  border-top: 1px solid #ddded8;
  border-bottom: 1px solid #ddded8;

  dt {
    margin-bottom: 0.45rem;
    color: #6b6d66;
    font-size: 0.8rem;
    line-height: 1.4;
  }

  dd {
    margin: 0;
    font-size: 1.05rem;
    font-variant-numeric: tabular-nums;
    line-height: 1.4;
  }
}

.product-description {
  margin: 2rem 0 0;
  color: #6b6d66;
  font-size: 1rem;
  line-height: 1.65;
}

.product-services {
  margin: 1.5rem 0 0;
  padding: 0;
  color: #4e504a;
  font-size: 0.9rem;
  line-height: 1.5;
  list-style: none;

  li {
    padding: 0.75rem 0;
    border-top: 1px solid #ddded8;
  }

  li:last-child {
    border-bottom: 1px solid #ddded8;
  }
}

.product-contact {
  margin-top: 2rem;
  padding: 1.5rem;
  color: #ffffff;
  background: #242522;
  border-radius: 6px;

  p {
    margin: 0 0 1.25rem;
    color: #d7d8d2;
    font-size: 0.9rem;
    line-height: 1.55;
  }
}

.contact-btn,
.back-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-height: 3rem;
  padding: 0.8rem 1.15rem;
  color: #242522;
  background: #f57c00;
  border: 0;
  border-radius: 4px;
  box-shadow: none;
  font-size: 0.9rem;
  font-weight: 650;
  letter-spacing: normal;
  text-transform: none;
  transition: background-color 0.2s ease;

  &:hover {
    background: #ff9d2e;
    box-shadow: none;
    transform: none;
  }

  &:focus-visible {
    outline: 3px solid rgba(245, 124, 0, 0.55);
    outline-offset: 4px;
  }
}

.not-found {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: center;
  max-width: 42rem;
  min-height: calc(100vh - var(--header-height) - 7.5rem);
  margin: 0 auto;

  h1 {
    margin: 0;
    font-size: clamp(2.25rem, 5vw, 4.5rem);
    line-height: 1.05;
    letter-spacing: -0.045em;
  }

  p {
    max-width: 34rem;
    margin: 1.25rem 0 2rem;
    color: #6b6d66;
    font-size: 1.05rem;
    line-height: 1.6;
  }
}

.back-btn {
  gap: 0.55rem;
  text-decoration: none;

  :deep(svg) {
    width: 1rem;
    height: 1rem;
  }
}

@media (max-width: 1000px) {
  .product-container {
    grid-template-columns: minmax(0, 1fr);
  }

  .product-info {
    position: static;
    max-width: 44rem;
    padding-top: 0;
  }
}

@media (max-width: 640px) {
  .product-page {
    padding: 1.5rem 1rem 3rem;
  }

  .back-link {
    margin-bottom: 1.25rem;
  }

  .product-container {
    gap: 2rem;
  }

  .product-title {
    font-size: clamp(3rem, 16vw, 4.5rem);
  }

  .image-counter {
    top: 0.75rem;
    right: 0.75rem;
  }

  .zoom-indicator {
    right: 0.75rem;
    bottom: 0.75rem;
  }

  .thumbnail-container {
    grid-template-columns: 2.5rem minmax(0, 1fr) 2.5rem;
    gap: 0.5rem;
  }

  .thumbnail-arrow {
    width: 2.5rem;
    height: 2.5rem;
  }

  .thumbnail {
    flex-basis: 4rem;
    width: 4rem;
    height: 4rem;
  }

  .product-specs {
    margin-top: 1.75rem;
  }

  .product-contact {
    padding: 1.25rem;
  }
}

@media (max-width: 375px) {
  .product-page {
    padding-right: 0.75rem;
    padding-left: 0.75rem;
  }

  .zoom-indicator span {
    display: none;
  }
}

@media (prefers-reduced-motion: reduce) {
  .main-image-track {
    scroll-behavior: auto;
  }

  .back-link,
  .thumbnail,
  .thumbnail-arrow,
  .contact-btn {
    transition: none;
  }
}
</style>
