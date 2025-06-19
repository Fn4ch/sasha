<template>
    <div ref="preview" class="preview" :class="{ 'slide-up': isHidden }">
        <NuxtImg 
            src="/images/mainpage.png" 
            sizes="xs:100vw sm:100vw md:100vw lg:100vw xl:100vw"
            class="image"
        />
        <div class="title">
            <h1>Весы для ваших нужд</h1>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'

const preview = ref<HTMLElement | null>(null)
const isHidden = ref(false)
const SCROLL_THRESHOLD = 100
let ticking = false

function handleScroll() {
    if (!ticking) {
        window.requestAnimationFrame(() => {
            isHidden.value = window.scrollY > SCROLL_THRESHOLD
            ticking = false
        })
        ticking = true
    }
}

onMounted(() => {
    window.addEventListener('scroll', handleScroll)
})
onBeforeUnmount(() => {
    window.removeEventListener('scroll', handleScroll)
})
</script>

<style lang="scss" scoped>
.image{
    filter: brightness(80%);
    z-index: 0;
    width: 100vw !important;
    min-width: 100vw !important;
    max-width: 100vw !important;
    height: 100%;
    object-fit: cover;
    display: block;
    position: absolute;
    left: 50%;
    top: 0;
    transform: translateX(-50%);
    max-height: 100vh;
    @media (max-width: 1024px) {
        max-height: 60vh;
    }
    @media (max-width: 768px) {
        max-height: 40vh;
    }
    @media (max-width: 480px) {
        max-height: 30vh;
    }
}
.preview{
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100vh; 
    overflow: hidden;
    transition: transform 1s cubic-bezier(0.77, 0, 0.175, 1), opacity 1s cubic-bezier(0.77, 0, 0.175, 1), filter 1s;
    filter: blur(0); 
    opacity: 1;
    will-change: transform, opacity;
    pointer-events: auto;
    @media (max-width: 1024px) {
        height: 60vh;
    }
    @media (max-width: 768px) {
        height: 40vh;
        padding: 0 1rem;
    }
    @media (max-width: 480px) {
        height: 30vh;
        padding: 0 0.5rem;
    }
}

.slide-up {
    transform: translateY(-100%);
    opacity: 0;
    filter: blur(6px);
    pointer-events: none;
}

.title{
    background-color: transparent;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    width: 100%;
    h1 {
        font-size: 4rem;
        @media (max-width: 1024px) {
            font-size: 2.5rem;
        }
        @media (max-width: 768px) {
            font-size: 1.5rem;
        }
        @media (max-width: 480px) {
            font-size: 1.1rem;
        }
    }
}
</style>