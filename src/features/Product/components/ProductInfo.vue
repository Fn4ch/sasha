<template>
    <div ref="preview" class="preview" :class="{ 'slide-up': isHidden }">
        <NuxtImg 
            src="/images/mainpage.png" 
            sizes="xs:100vw sm:100vw md:100vw lg:100vw xl:100vw"
            class="image"
        />
        <div class="title">
            <h1>Весы</h1>
            <h5>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quos.
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quos. 
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quos. 
            </h5>
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
    width: 100% !important;
    min-width: 100% !important;
    max-width: 100% !important;
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
    transition: transform 1s cubic-bezier(0.4, 0, 0.2, 1), opacity 1s cubic-bezier(0.4, 0, 0.2, 1), filter 1s;
    filter: blur(0); 
    opacity: 1;
    will-change: transform, opacity;
    pointer-events: auto;
    margin-top: 64px;
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
    transform: translate(-50%, -50%);
    text-align: flex-start;
    margin-left: 6rem;
    width: 100%;
    h1 {
        font-size: 4rem;
        font-weight: 300;
        letter-spacing: -1px;
        color: white;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        margin: 0 0 1rem 0;
        @media (max-width: 1024px) {
            font-size: 2.5rem;
            margin: 0 0 0.8rem 0;
        }
        @media (max-width: 768px) {
            font-size: 1.5rem;
            margin: 0 0 0.6rem 0;
        }
        @media (max-width: 480px) {
            font-size: 1.1rem;
            margin: 0 0 0.4rem 0;
        }
    }
    h3{
        font-size: 2rem;
        letter-spacing: -1px;
        color: white;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        margin: 0 0 1rem 0;
        @media (max-width: 1024px) {
            font-size: 1.5rem;
            margin: 0 0 0.8rem 0;
        }
        @media (max-width: 768px) {
            font-size: 1.2rem;
            margin: 0 0 0.6rem 0;
        }
        @media (max-width: 480px) {
            font-size: 1rem;
            margin: 0 0 0.4rem 0;
        }
    }
    h5{
        max-width: 50%;
        font-size: 1.5rem;
        letter-spacing: -1px;
        color: white;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        margin: 0;
        line-height: 1.4;
        @media (max-width: 1024px) {
            max-width: 65%;
            font-size: 1.2rem;
            line-height: 1.3;
        }
        @media (max-width: 768px) {
            max-width: 75%;
            font-size: 1rem;
            margin-top: 0.5rem;
            line-height: 1.3;
        }
        @media (max-width: 480px) {
            max-width: 95%;
            font-size: 0.9rem;
            margin-top: 0.3rem;
            line-height: 1.2;
        }
    }
    @media (max-width: 1024px) {
        margin: 0 3rem;
    }
    @media (max-width: 768px) {
        margin: 0 2rem;
    }
    @media (max-width: 480px) {
        margin: 0 1rem;
    }
}
</style>