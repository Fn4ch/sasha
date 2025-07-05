<template>
  <Transition name="fullscreen">
    <div v-if="isOpen" class="fullscreen-overlay" @click="closeModal">
      <div class="fullscreen-container" @click.stop>
        <!-- Close button -->
        <button class="close-btn" @click="closeModal">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M18 6L6 18M6 6l12 12"/>
          </svg>
        </button>

        <!-- Navigation arrows -->
        <button 
          v-if="images.length > 1"
          class="nav-arrow left" 
          @click="previousImage"
          :disabled="currentIndex === 0"
        >
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M15 18l-6-6 6-6"/>
          </svg>
        </button>

        <button 
          v-if="images.length > 1"
          class="nav-arrow right" 
          @click="nextImage"
          :disabled="currentIndex === images.length - 1"
        >
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M9 18l6-6-6-6"/>
          </svg>
        </button>

        <!-- Main image -->
        <div class="image-container">
          <NuxtImg
            :src="currentImage"
            alt="полноэкранное изображение"
            class="fullscreen-image"
            loading="eager"
            format="webp"
            quality="90"
            priority
            @load="imageLoaded = true"
          />
          <div v-if="!imageLoaded" class="loading-spinner">
            <div class="spinner"></div>
          </div>
        </div>

        <!-- Image counter -->
        <div v-if="images.length > 1" class="image-counter">
          {{ currentIndex + 1 }} / {{ images.length }}
        </div>

        <!-- Thumbnail navigation -->
        <div v-if="images.length > 1" class="thumbnail-nav">
          <div class="thumbnails-container">
            <div
              v-for="(image, index) in images"
              :key="index"
              class="thumbnail-item"
              :class="{ active: index === currentIndex }"
              @click="goToImage(index)"
            >
              <NuxtImg
                :src="image"
                :alt="`миниатюра ${index + 1}`"
                class="thumbnail-image"
                loading="lazy"
                format="webp"
                quality="60"
                fetchpriority="low"
              />
            </div>
          </div>
        </div>

        <!-- Zoom controls -->
        <div class="zoom-controls">
          <button class="zoom-btn" @click="zoomIn" :disabled="scale >= 3">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="11" cy="11" r="8"/>
              <path d="m21 21-4.35-4.35"/>
              <path d="M11 8v6"/>
              <path d="M8 11h6"/>
            </svg>
          </button>
          <button class="zoom-btn" @click="zoomOut" :disabled="scale <= 0.5">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="11" cy="11" r="8"/>
              <path d="m21 21-4.35-4.35"/>
              <path d="M8 11h6"/>
            </svg>
          </button>
          <button class="zoom-btn" @click="resetZoom">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M3 12a9 9 0 0 1 9-9 9.75 9.75 0 0 1 6.74 2.74L21 8"/>
              <path d="M21 3v5h-5"/>
              <path d="M21 12a9 9 0 0 1-9 9 9.75 9.75 0 0 1-6.74-2.74L3 16"/>
              <path d="M3 21v-5h5"/>
            </svg>
          </button>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import { ref, computed, watch, onMounted, onBeforeUnmount } from 'vue'

interface Props {
  isOpen: boolean
  images: string[]
  initialIndex?: number
}

interface Emits {
  (e: 'close'): void
  (e: 'update:isOpen', value: boolean): void
}

const props = withDefaults(defineProps<Props>(), {
  initialIndex: 0
})

const emit = defineEmits<Emits>()

const currentIndex = ref(props.initialIndex)
const scale = ref(1)
const imageLoaded = ref(false)

const currentImage = computed(() => {
  return props.images[currentIndex.value] || ''
})

function closeModal() {
  emit('close')
  emit('update:isOpen', false)
}

function nextImage() {
  if (currentIndex.value < props.images.length - 1) {
    currentIndex.value++
    resetZoom()
  }
}

function previousImage() {
  if (currentIndex.value > 0) {
    currentIndex.value--
    resetZoom()
  }
}

function goToImage(index: number) {
  currentIndex.value = index
  resetZoom()
}

function zoomIn() {
  if (scale.value < 3) {
    scale.value = Math.min(3, scale.value + 0.5)
  }
}

function zoomOut() {
  if (scale.value > 0.5) {
    scale.value = Math.max(0.5, scale.value - 0.5)
  }
}

function resetZoom() {
  scale.value = 1
}

function handleKeydown(event: KeyboardEvent) {
  if (!props.isOpen) return

  switch (event.key) {
    case 'Escape':
      closeModal()
      break
    case 'ArrowRight':
      nextImage()
      break
    case 'ArrowLeft':
      previousImage()
      break
    case '+':
    case '=':
      zoomIn()
      break
    case '-':
      zoomOut()
      break
    case '0':
      resetZoom()
      break
  }
}

function handleWheel(event: WheelEvent) {
  if (!props.isOpen) return
  
  event.preventDefault()
  
  if (event.ctrlKey || event.metaKey) {
    // Zoom with Ctrl/Cmd + wheel
    if (event.deltaY < 0) {
      zoomIn()
    } else {
      zoomOut()
    }
  } else {
    // Navigate with wheel
    if (event.deltaY > 0) {
      nextImage()
    } else {
      previousImage()
    }
  }
}

onMounted(() => {
  document.addEventListener('keydown', handleKeydown)
  document.addEventListener('wheel', handleWheel, { passive: false })
})

onBeforeUnmount(() => {
  document.removeEventListener('keydown', handleKeydown)
  document.removeEventListener('wheel', handleWheel)
})

watch(() => props.isOpen, (newValue) => {
  if (newValue) {
    document.body.style.overflow = 'hidden'
    imageLoaded.value = false
  } else {
    document.body.style.overflow = ''
    resetZoom()
  }
})

watch(() => props.initialIndex, (newValue) => {
  currentIndex.value = newValue
})
</script>

<style lang="scss" scoped>
.fullscreen-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.95);
  backdrop-filter: blur(10px);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.fullscreen-container {
  position: relative;
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.close-btn {
  position: absolute;
  top: 2rem;
  right: 2rem;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  color: white;
  z-index: 10;
  
  &:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: scale(1.1);
  }
  
  svg {
    width: 24px;
    height: 24px;
  }
  
  @media (max-width: 768px) {
    top: 1rem;
    right: 1rem;
    width: 40px;
    height: 40px;
    
    svg {
      width: 20px;
      height: 20px;
    }
  }
}

.nav-arrow {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  width: 56px;
  height: 56px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  color: white;
  z-index: 10;
  
  &:hover:not(:disabled) {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-50%) scale(1.1);
  }
  
  &:disabled {
    opacity: 0.3;
    cursor: not-allowed;
  }
  
  &.left {
    left: 2rem;
  }
  
  &.right {
    right: 2rem;
  }
  
  svg {
    width: 24px;
    height: 24px;
  }
  
  @media (max-width: 768px) {
    width: 48px;
    height: 48px;
    
    &.left {
      left: 1rem;
    }
    
    &.right {
      right: 1rem;
    }
    
    svg {
      width: 20px;
      height: 20px;
    }
  }
}

.image-container {
  position: relative;
  max-width: 90%;
  max-height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.fullscreen-image {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  border-radius: 8px;
  transition: transform 0.3s ease;
  transform: scale(v-bind(scale));
}

.loading-spinner {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.spinner {
  width: 40px;
  height: 40px;
  border: 3px solid rgba(255, 255, 255, 0.3);
  border-top: 3px solid white;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.image-counter {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 500;
  
  @media (max-width: 768px) {
    bottom: 1rem;
    font-size: 0.8rem;
    padding: 0.4rem 0.8rem;
  }
}

.thumbnail-nav {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0, 0, 0, 0.7);
  border-radius: 12px;
  padding: 1rem;
  
  @media (max-width: 768px) {
    bottom: 1rem;
    padding: 0.5rem;
  }
}

.thumbnails-container {
  display: flex;
  gap: 0.5rem;
  max-width: 300px;
  overflow-x: auto;
  scrollbar-width: none;
  -ms-overflow-style: none;
  
  &::-webkit-scrollbar {
    display: none;
  }
  
  @media (max-width: 768px) {
    max-width: 250px;
    gap: 0.3rem;
  }
}

.thumbnail-item {
  flex-shrink: 0;
  width: 60px;
  height: 60px;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
  border: 2px solid transparent;
  transition: all 0.3s ease;
  
  &:hover {
    border-color: rgba(255, 255, 255, 0.5);
  }
  
  &.active {
    border-color: #f57c00;
  }
  
  @media (max-width: 768px) {
    width: 50px;
    height: 50px;
  }
}

.thumbnail-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.zoom-controls {
  position: absolute;
  top: 2rem;
  left: 2rem;
  display: flex;
  gap: 0.5rem;
  z-index: 10;
  
  @media (max-width: 768px) {
    top: 1rem;
    left: 1rem;
    gap: 0.3rem;
  }
}

.zoom-btn {
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 8px;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  color: white;
  
  &:hover:not(:disabled) {
    background: rgba(255, 255, 255, 0.2);
    transform: scale(1.1);
  }
  
  &:disabled {
    opacity: 0.3;
    cursor: not-allowed;
  }
  
  svg {
    width: 18px;
    height: 18px;
  }
  
  @media (max-width: 768px) {
    width: 36px;
    height: 36px;
    
    svg {
      width: 16px;
      height: 16px;
    }
  }
}

// Transitions
.fullscreen-enter-active,
.fullscreen-leave-active {
  transition: opacity 0.3s ease;
}

.fullscreen-enter-from,
.fullscreen-leave-to {
  opacity: 0;
}
</style> 