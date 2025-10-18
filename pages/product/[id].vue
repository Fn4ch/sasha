<template>
  <div class="product-page">
    <template v-if="product && product.images && product.images.length">
      <div class="product-container">
        <!-- Left side - Image gallery -->
        <div class="product-gallery">
          <div class="main-image-container" @click="openFullscreen">
            <NuxtImg
              :src="getImageFromS3(product.images[currentIndex])"
              fit="cover"
              width="600"
              height="500"
              :alt="`${product.title} - основное изображение`"
              class="main-image"
              loading="eager"
              format="webp"
              quality="85"
              priority
              fetchpriority="high"
            />
            <div class="image-overlay">
              <div class="zoom-indicator">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <circle cx="11" cy="11" r="8"/>
                  <path d="m21 21-4.35-4.35"/>
                  <path d="M11 8v6"/>
                  <path d="M8 11h6"/>
                </svg>
                <span>Нажмите для увеличения</span>
              </div>
            </div>
          </div>
          
          <!-- Thumbnail navigation -->
          <div class="thumbnail-container">
            <button 
              class="thumbnail-arrow left" 
              @click="scrollThumbnails('left')"
              :disabled="canScrollLeft"
            >
              <ArrowLeft />
            </button>
            
            <div class="thumbnails-wrapper">
              <div class="thumbnails" ref="thumbnailsRef">
                <div
                  v-for="(image, index) in product.images"
                  :key="index"
                  class="thumbnail"
                  :class="{ active: index === currentIndex }"
                  @click="currentIndex = index"
                >
                  <NuxtImg
                    :src="getImageFromS3(image)"
                    fit="cover"
                    width="80"
                    height="80"
                    :alt="`${product.title} - миниатюра ${index + 1}`"
                    loading="lazy"
                    format="webp"
                    quality="60"
                    fetchpriority="low"
                  />
                  <div class="thumbnail-overlay">
                    <div class="thumbnail-check">
                      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">
                        <polyline points="20,6 9,17 4,12"/>
                      </svg>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <button 
              class="thumbnail-arrow right" 
              @click="scrollThumbnails('right')"
              :disabled="canScrollRight"
            >
              <ArrowRight />
            </button>
          </div>
        </div>

        <!-- Right side - Product info -->
        <div class="product-info">
          <div class="product-header">
            <h1 class="product-title">{{ product.title }}</h1>
          </div>
          
          <div class="product-description">
            <p>{{ product.shortDescription }}</p>
          </div>
          
          <div class="product-features">
            <div class="feature-item">
              <div class="feature-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M9 12l2 2 4-4"/>
                  <path d="M21 12c0 4.97-4.03 9-9 9s-9-4.03-9-9 4.03-9 9-9 9 4.03 9 9z"/>
                </svg>
              </div>
              <div class="feature-content">
                <h4>Гарантия качества</h4>
                <p>Официальная гарантия производителя</p>
              </div>
            </div>
            
            <div class="feature-item">
              <div class="feature-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                </svg>
              </div>
              <div class="feature-content">
                <h4>Высокое качество</h4>
                <p>Проверенные материалы и технологии</p>
              </div>
            </div>
            
            <div class="feature-item">
              <div class="feature-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M20 7h-9m9 10h-9m9-5h-9"/>
                  <path d="M3 7h2m2 0h2m-6 5h2m2 0h2m-6 5h2m2 0h2"/>
                </svg>
              </div>
              <div class="feature-content">
                <h4>Быстрая доставка</h4>
                <p>Доставка по всей России</p>
              </div>
            </div>
          </div>
          
          <div class="product-contact">
            <p>Есть вопросы по товару?</p>
            <button class="contact-btn" @click="openContactModal">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
              </svg>
                  <span>Связаться с нами</span>
            </button>
          </div>
        </div>
      </div>
      
      <FullscreenView
        v-model:isOpen="isFullscreenOpen"
        :images="fullscreenImages"
        :initialIndex="currentIndex"
        @close="closeFullscreen"
      />
    </template>
    
    <template v-else>
      <div class="not-found">
        <div class="not-found-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="11" cy="11" r="8"/>
            <path d="m21 21-4.35-4.35"/>
            <path d="M11 8v6"/>
            <path d="M8 11h6"/>
          </svg>
        </div>
        <h2>Товар не найден</h2>
        <p>К сожалению, запрашиваемый товар не найден или был удален</p>
        <button class="back-btn" @click="$router.push('/')">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M19 12H5M12 19l-7-7 7-7"/>
          </svg>
          <span>Вернуться на главную</span>
        </button>
      </div>
    </template>
    <ContactModal v-model:isOpen="isContactOpen" />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue'
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
const thumbnailsRef = ref<HTMLElement>()
const isFullscreenOpen = ref(false)
const isContactOpen = ref(false)

const canScrollLeft = computed(() => {
  if (!thumbnailsRef.value) return true
  return thumbnailsRef.value.scrollLeft <= 0
})

const canScrollRight = computed(() => {
  if (!thumbnailsRef.value) return true
  const { scrollLeft, scrollWidth, clientWidth } = thumbnailsRef.value
  return scrollLeft >= scrollWidth - clientWidth - 10
})

const fullscreenImages = computed(() => {
  if (!product.value?.images) return []
  return product.value.images.map(image => getImageFromS3(image))
})

// SEO meta based on product data
const url = useRequestURL()
const canonical = computed(() => new URL(`/product/${productId.value}`, url.origin).toString())
const seoTitle = computed(() => product.value?.title ? `${product.value.title} | Весы Казань` : 'Товар | Весы Казань')
const seoDescription = computed(() => product.value?.shortDescription || product.value?.description || 'Профессиональные весы: продажа, монтаж, сервис.')
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
  twitterCard: 'summary_large_image',
  ogType: 'website'
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
      name: 'Весы Казань'
    }
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

function scrollThumbnails(direction: 'left' | 'right') {
  if (!thumbnailsRef.value) return
  
  const scrollAmount = 200
  const currentScroll = thumbnailsRef.value.scrollLeft
  
  if (direction === 'left') {
    thumbnailsRef.value.scrollTo({
      left: currentScroll - scrollAmount,
      behavior: 'smooth'
    })
  } else {
    thumbnailsRef.value.scrollTo({
      left: currentScroll + scrollAmount,
      behavior: 'smooth'
    })
  }
}

function openFullscreen() {
  isFullscreenOpen.value = true
}

function closeFullscreen() {
  isFullscreenOpen.value = false
}

function openContactModal() {
  isContactOpen.value = true
}

function scrollToContacts() {
  const contactsElement = document.getElementById('contacts')
  if (contactsElement) {
    contactsElement.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    })
  }
}

// Reset current index when product changes
watch(() => product.value, () => {
  currentIndex.value = 0
})
</script>

<style lang="scss" scoped>
.product-page {
  width: 100%;
  max-width: 1400px;
  margin: 96px auto 0 auto;
  padding: 3rem 1rem;
  min-height: calc(100vh - 124px);
  
  @media (max-width: 768px) {
    padding: 1.5rem 1rem;
  }
  
  @media (min-width: 1921px) {
    max-width: 112vw;
    padding: 1.6vw;
  }
}

.product-container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: start;
  
  @media (max-width: 1024px) {
    gap: 3rem;
  }
  
  @media (max-width: 768px) {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  @media (min-width: 1921px) {
    gap: 3.2vw;
  }
}

.product-gallery {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  
  @media (min-width: 1921px) {
    gap: 1.2vw;
  }
}

.main-image-container {
  width: 100%;
  aspect-ratio: 4/3;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  position: relative;
  cursor: pointer;
  
  @media (max-width: 768px) {
    aspect-ratio: 3/2;
    border-radius: 16px;
  }
  
  @media (min-width: 1921px) {
    border-radius: 1.6vw;
  }
}

.main-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
  
  &:hover {
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
    rgba(245, 124, 0, 0.8) 0%,
    rgba(255, 152, 0, 0.6) 100%
  );
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
  border-radius: 20px;
  
  @media (max-width: 768px) {
    border-radius: 16px;
  }
  
  @media (min-width: 1921px) {
    border-radius: 1.6vw;
  }
}

.main-image-container:hover .image-overlay {
  opacity: 1;
}

.zoom-indicator {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  color: white;
  text-align: center;
  
  svg {
    width: 32px;
    height: 32px;
  }
  
  span {
    font-size: 0.9rem;
    font-weight: 500;
  }
  
  @media (min-width: 1921px) {
    gap: 0.4vw;
    
    svg {
      width: 2.56vw;
      height: 2.56vw;
    }
    
    span {
      font-size: 0.72vw;
    }
  }
}

.thumbnail-container {
  display: flex;
  align-items: center;
  gap: 0.8rem;
  
  @media (min-width: 1921px) {
    gap: 0.64vw;
  }
}

.thumbnails-wrapper {
  flex: 1;
  overflow: hidden;
}

.thumbnails {
  display: flex;
  gap: 0.8rem;
  overflow-x: auto;
  scrollbar-width: none;
  -ms-overflow-style: none;
  padding: 0.2rem;
  
  &::-webkit-scrollbar {
    display: none;
  }
  
  @media (min-width: 1921px) {
    gap: 0.64vw;
    padding: 0.16vw;
  }
}

.thumbnail {
  flex-shrink: 0;
  width: 80px;
  height: 80px;
  border-radius: 12px;
  overflow: hidden;
  cursor: pointer;
  border: 2px solid transparent;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  
  &:hover {
    border-color: rgba(245, 124, 0, 0.3);
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  }
  
  &.active {
    border-color: #f57c00;
    box-shadow: 0 4px 15px rgba(245, 124, 0, 0.3);
  }
  
  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  @media (min-width: 1921px) {
    width: 6.4vw;
    height: 6.4vw;
    border-radius: 0.96vw;
  }
}

.thumbnail-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(245, 124, 0, 0.8);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.thumbnail.active .thumbnail-overlay {
  opacity: 1;
}

.thumbnail-check {
  color: white;
  
  svg {
    width: 20px;
    height: 20px;
  }
  
  @media (min-width: 1921px) {
    svg {
      width: 1.6vw;
      height: 1.6vw;
    }
  }
}

.thumbnail-arrow {
  border-radius: 0.75rem;
  background-color: transparent;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  flex-shrink: 0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  
  &:disabled {
    opacity: 0.4;
    cursor: not-allowed;
  }
  
  &:hover:not(:disabled) {
    background: white;
    transform: scale(1.1);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
  }
  
  @media (min-width: 1921px) {
    width: 3.2vw;
    height: 3.2vw;
  }
}

.product-info {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  
  @media (min-width: 1921px) {
    gap: 1.6vw;
  }
}

.product-header {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  
  @media (min-width: 1921px) {
    gap: 0.8vw;
  }
}

.product-badge {
  display: inline-block;
  background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
  border-radius: 50px;
  padding: 0.5rem 1.5rem;
  font-size: 0.9rem;
  font-weight: 600;
  color: white;
  text-transform: uppercase;
  letter-spacing: 1px;
  box-shadow: 0 4px 15px rgba(245, 124, 0, 0.3);
  align-self: flex-start;
  
  @media (min-width: 1921px) {
    padding: 0.4vw 1.2vw;
    font-size: 0.7vw;
  }
  
  @media (max-width: 768px) {
    padding: 0.4rem 1rem;
    font-size: 0.8rem;
  }
}

.product-title {
  font-size: 2.8rem;
  font-weight: 700;
  color: rgba(0, 0, 0, 0.87);
  margin: 0;
  line-height: 1.2;
  background: linear-gradient(135deg, #333 0%, #666 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  
  @media (max-width: 768px) {
    font-size: 2.2rem;
  }
  
  @media (max-width: 480px) {
    font-size: 1.8rem;
  }
  
  @media (min-width: 1921px) {
    font-size: 2.24vw;
  }
}

.product-description {
  font-size: 1.2rem;
  line-height: 1.6;
  color: rgba(0, 0, 0, 0.6);
  
  p {
    margin: 0;
  }
  
  @media (max-width: 768px) {
    font-size: 1.1rem;
  }
  
  @media (min-width: 1921px) {
    font-size: 0.96vw;
  }
}

.product-features {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  
  @media (min-width: 1921px) {
    gap: 0.8vw;
  }
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  border-radius: 12px;
  background: rgba(245, 124, 0, 0.05);
  border: 1px solid rgba(245, 124, 0, 0.1);
  transition: all 0.3s ease;
  
  &:hover {
    background: rgba(245, 124, 0, 0.1);
    transform: translateX(4px);
  }
  
  @media (min-width: 1921px) {
    padding: 0.8vw;
    gap: 0.8vw;
    border-radius: 0.96vw;
  }
}

.feature-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  border-radius: 12px;
  background: rgba(245, 124, 0, 0.1);
  color: #f57c00;
  flex-shrink: 0;
  
  svg {
    width: 24px;
    height: 24px;
  }
  
  @media (min-width: 1921px) {
    width: 3.84vw;
    height: 3.84vw;
    border-radius: 0.96vw;
    
    svg {
      width: 1.92vw;
      height: 1.92vw;
    }
  }
}

.feature-content {
  flex: 1;
  
  h4 {
    font-size: 1rem;
    font-weight: 600;
    color: rgba(0, 0, 0, 0.87);
    margin: 0 0 0.25rem 0;
  }
  
  p {
    font-size: 0.9rem;
    color: rgba(0, 0, 0, 0.6);
    margin: 0;
  }
  
  @media (min-width: 1921px) {
    h4 {
      font-size: 0.8vw;
      margin: 0 0 0.2vw 0;
    }
    
    p {
      font-size: 0.72vw;
    }
  }
}

.product-actions {
  display: flex;
  gap: 1rem;
  margin-top: 1rem;
  
  @media (max-width: 480px) {
    flex-direction: column;
  }
  
  @media (min-width: 1921px) {
    gap: 0.8vw;
  }
}

.btn-primary {
  flex: 1;
  background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
  color: white;
  border: none;
  padding: 1.2rem 2rem;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  box-shadow: 0 4px 15px rgba(245, 124, 0, 0.3);
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(245, 124, 0, 0.4);
  }
  
  svg {
    width: 20px;
    height: 20px;
  }
  
  @media (min-width: 1921px) {
    padding: 0.96vw 1.6vw;
    font-size: 0.8vw;
    gap: 0.4vw;
    border-radius: 0.96vw;
    
    svg {
      width: 1.6vw;
      height: 1.6vw;
    }
  }
}

.btn-secondary {
  flex: 1;
  background: transparent;
  color: #f57c00;
  border: 2px solid #f57c00;
  padding: 1.2rem 2rem;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  
  &:hover {
    background: #f57c00;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(245, 124, 0, 0.3);
  }
  
  svg {
    width: 20px;
    height: 20px;
  }
  
  @media (min-width: 1921px) {
    padding: 0.96vw 1.6vw;
    font-size: 0.8vw;
    gap: 0.4vw;
    border-radius: 0.96vw;
    
    svg {
      width: 1.6vw;
      height: 1.6vw;
    }
  }
}

.product-contact {
  margin-top: 1rem;
  padding: 1.5rem;
  border-radius: 16px;
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  border: 1px solid rgba(0, 0, 0, 0.05);
  text-align: center;
  
  p {
    font-size: 1rem;
    color: rgba(0, 0, 0, 0.6);
    margin: 0 0 1rem 0;
  }
  
  @media (min-width: 1921px) {
    margin-top: 0.8vw;
    padding: 1.2vw;
    border-radius: 1.28vw;
    
    p {
      font-size: 0.8vw;
      margin: 0 0 0.8vw 0;
    }
  }
}

.contact-btn {
  background: rgba(76, 175, 80, 0.1);
  color: #4caf50;
  border: 2px solid rgba(76, 175, 80, 0.2);
  padding: 0.8rem 1.5rem;
  border-radius: 8px;
  font-size: 0.9rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  
  &:hover {
    background: #4caf50;
    color: white;
    transform: translateY(-1px);
  }
  
  svg {
    width: 18px;
    height: 18px;
  }
  
  @media (min-width: 1921px) {
    padding: 0.64vw 1.2vw;
    font-size: 0.72vw;
    gap: 0.4vw;
    border-radius: 0.64vw;
    
    svg {
      width: 1.44vw;
      height: 1.44vw;
    }
  }
}

.not-found {
  text-align: center;
  padding: 4rem 1rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1.5rem;
  
  @media (min-width: 1921px) {
    padding: 3.2vw 0.8vw;
    gap: 1.2vw;
  }
}

.not-found-icon {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  justify-content: center;
  color: rgba(0, 0, 0, 0.4);
  
  svg {
    width: 40px;
    height: 40px;
  }
  
  @media (min-width: 1921px) {
    width: 6.4vw;
    height: 6.4vw;
    
    svg {
      width: 3.2vw;
      height: 3.2vw;
    }
  }
}

.not-found h2 {
  font-size: 2rem;
  font-weight: 600;
  color: rgba(0, 0, 0, 0.87);
  margin: 0;
  
  @media (min-width: 1921px) {
    font-size: 1.6vw;
  }
}

.not-found p {
  font-size: 1.1rem;
  color: rgba(0, 0, 0, 0.6);
  margin: 0;
  max-width: 400px;
  
  @media (min-width: 1921px) {
    font-size: 0.88vw;
    max-width: 32vw;
  }
}

.back-btn {
  background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
  color: white;
  border: none;
  padding: 1rem 2rem;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  box-shadow: 0 4px 15px rgba(245, 124, 0, 0.3);
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(245, 124, 0, 0.4);
  }
  
  svg {
    width: 20px;
    height: 20px;
  }
  
  @media (min-width: 1921px) {
    padding: 0.8vw 1.6vw;
    font-size: 0.8vw;
    gap: 0.4vw;
    border-radius: 0.96vw;
    
    svg {
      width: 1.6vw;
      height: 1.6vw;
    }
  }
}
</style>
