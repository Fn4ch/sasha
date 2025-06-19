<template>
  <div class="product-page">
    <template v-if="product && product.images && product.images.length">
      <div class="slider">
        <button class="slider__arrow left" @click="prevImage" :disabled="currentIndex === 0">&#8592;</button>
        <NuxtImg
          :src="`/images/${product.images[currentIndex]}.png`"
          fit="cover"
          width="480"
          height="360"
          alt="product image"
          class="slider__image"
        />
        <button class="slider__arrow right" @click="nextImage" :disabled="currentIndex === product.images.length - 1">&#8594;</button>
      </div>
      <div class="product-page__info">
        <h2 class="product-page__title">{{ product.title }}</h2>
        <p class="product-page__description">{{ product.description }}</p>
      </div>
    </template>
    <template v-else>
      <div class="not-found">Товар не найден</div>
    </template>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { PRODUCTS_DATA } from '~/src/shared/constants/PRODUCTS'

const route = useRoute()
const productId = computed(() => route.params.id)
const product = computed(() => PRODUCTS_DATA.find(p => p.id === productId.value))
const currentIndex = ref(0)

function prevImage() {
  if (currentIndex.value > 0) currentIndex.value--
}
function nextImage() {
  if (product.value && product.value.images && currentIndex.value < product.value.images.length - 1) currentIndex.value++
}
</script>

<style lang="scss" scoped>
.product-page {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 2rem 1rem;
  width: 100%;
  max-width: 700px;
  margin: 124px auto 0 auto;
}
.slider {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  margin-bottom: 2rem;
  position: relative;
  &__image {
    width: 100%;
    max-width: 480px;
    height: auto;
    border-radius: 0.5rem;
    box-shadow: 0 2px 16px rgba(0,0,0,0.08);
    object-fit: cover;
    background: #f8f9fa;
  }
  &__arrow {
    background: #fff;
    border: 1px solid #e0e0e0;
    border-radius: 50%;
    width: 2.5rem;
    height: 2.5rem;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 1rem;
    cursor: pointer;
    transition: background 0.2s;
    &:disabled {
      opacity: 0.4;
      cursor: not-allowed;
    }
    &:hover:not(:disabled) {
      background: #f0f0f0;
    }
  }
}
.product-page__info {
  text-align: center;
}
.product-page__title {
  font-size: 2rem;
  margin-bottom: 1rem;
}
.product-page__description {
  font-size: 1.1rem;
  color: #666;
}
</style>
