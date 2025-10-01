<template>
    <header class="hero-section">
        <div class="hero-background">
            <NuxtImg 
                :src="getImageFromS3('mainpage')" 
                sizes="100vw"
                class="hero-image"
                alt="Весы Казань - профессиональное весовое оборудование"
                format="webp"
                quality="85"
                placeholder
                priority
                fetchpriority="high"
            />
            <div class="hero-overlay"></div>
            <div class="hero-gradient"></div>
        </div>
        
        <section class="hero-content">
            <div class="hero-text">
                <!--<div class="hero-badge">
                    <span>С 2006 года</span>
                </div>-->
                
                <h1 class="hero-title">
                    <span class="title-line">Весы</span>
                </h1>
                
                <p class="hero-subtitle">
                    ООО «Весы» — надежный партнер в весовом оборудовании
                </p>
                
                <div class="hero-stats">
                    <div class="stat-item">
                        <span class="stat-number">17+</span>
                        <span class="stat-label">лет опыта</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">1000+</span>
                        <span class="stat-label">установок</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">24/7</span>
                        <span class="stat-label">поддержка</span>
                    </div>
                </div>
                
                <article class="hero-services">
                    <p class="services-text">
                        Предоставляем полный цикл услуг: продажа, монтаж, модернизация, сервисное и гарантийное обслуживание, подготовка к поверке — автомобильных, вагонных, платформенных, крановых и других весов.
                    </p>
                </article>
                
                <div class="hero-cta">
                    <button @click="scrollToCatalog" class="cta-button primary">
                        <span>Смотреть каталог</span>
                        <svg class="arrow-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M5 12h14M12 5l7 7-7 7"/>
                        </svg>
                    </button>
                    <button class="cta-button secondary" @click="openContactModal">
                        <span>Связаться с нами</span>
                    </button>
                </div>
            </div>
        </section>
        <ContactModal v-model:isOpen="isContactOpen" @submit="onContactSubmit" />
    </header>
</template>

<script setup lang="ts">
import { getImageFromS3 } from '~/src/shared/lib/utils/getImageUrl'
import { ref } from 'vue'
import ContactModal from '~/src/widgets/ContactModal.vue'

const scrollToCatalog = () => {
  const catalogElement = document.getElementById('catalog')
  if (catalogElement) {
    catalogElement.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    })
  }
}

const isContactOpen = ref(false)
const openContactModal = () => { isContactOpen.value = true }
const onContactSubmit = (payload: { message: string; phone: string }) => {
  // noop here; submit is handled inside modal via mailto fallback
  // you can hook analytics or API call here later
  console.log('Contact request:', payload)
}

</script>

<style lang="scss" scoped>
.hero-section {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: calc(100vh - 96px); 
    overflow: hidden;
    margin-top: 96px;
    padding: 1.5rem 0;
    
    @media (max-width: 1440px) {
        height: 90vh;
        margin-top: 85px;
    }
    
    @media (max-width: 1024px) {
        height: 85vh;
        margin-top: 80px;
    }
    
    @media (max-width: 480px) {
        height: 80vh;
        margin-top: 70px;
    }
    
    @media (max-width: 375px) {
        height: 75vh;
        margin-top: 65px;
        padding: 0 0.3rem;
    }
    
    @media (max-width: 320px) {
        height: 70vh;
        margin-top: 60px;
        padding: 0 0.2rem;
    }
}

.hero-background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: calc(100vh);
    z-index: 0;
    
    @media (max-width: 1440px) {
        height: calc(100% - 85px);
    }
    
    @media (max-width: 1024px) {
        height: calc(100% - 80px);
    }
    
    @media (max-width: 768px) {
        height: calc(100% - 84px);
    }
    
    @media (max-width: 480px) {
        height: calc(100% - 70px);
    }
    
    @media (max-width: 375px) {
        height: calc(100% - 65px);
    }
    
    @media (max-width: 320px) {
        height: calc(100% - 60px);
    }
}

.hero-image {
    filter: brightness(70%);
    z-index: 0;
    width: 100% !important;
    min-width: 100% !important;
    max-width: 100% !important;
    height: 100%;
    object-fit: cover;
    display: block;
    position: absolute;
    top: 0;
    
    @media (max-width: 1920px) {
        max-height: calc(100vh - 90px);
    }
    
    @media (max-width: 1440px) {
        max-height: calc(90vh - 85px);
    }
    
    @media (max-width: 1024px) {
        max-height: calc(85vh - 80px);
    }

    
    @media (max-width: 480px) {
        max-height: calc(85vh - 70px);
    }
    
    @media (max-width: 375px) {
        max-height: calc(75vh - 65px);
    }
    
    @media (max-width: 320px) {
        max-height: calc(70vh - 60px);
    }
}

.hero-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4);
    z-index: 1;
}

.hero-gradient {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        135deg,
        rgba(245, 124, 0, 0.1) 0%,
        rgba(0, 0, 0, 0.3) 50%,
        rgba(0, 0, 0, 0.6) 100%
    );
    z-index: 2;
}

.hero-content {
    position: relative;
    z-index: 2;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0 2rem;
    
    @media (max-width: 1920px) {
        padding: 0 1.8rem;
    }
    
    @media (max-width: 1440px) {
        padding: 0 1.5rem;
    }
    
    @media (max-width: 1024px) {
        padding: 0 1.2rem;
    }
    
    @media (max-width: 768px) {
        padding: 0 1rem;
    }
    
    @media (max-width: 480px) {
        padding: 0 0.8rem;
    }
    
    @media (max-width: 375px) {
        padding: 0 0.5rem;
    }
    
    @media (max-width: 320px) {
        padding: 0 0.3rem;
    }
}

.hero-text {
    background-color: transparent;
    position: relative;
    max-width: 1200px;
    width: 100%;
    text-align: center;
    letter-spacing: 0.05rem;
    
    @media (min-width: 1921px) {
        letter-spacing: 0.04vw;
        max-width: 1400px;
    }
    
    @media (max-width: 1920px) {
        max-width: 1300px;
        letter-spacing: 0.045rem;
    }
    
    @media (max-width: 1440px) {
        max-width: 1100px;
        letter-spacing: 0.04rem;
    }
    
    @media (max-width: 1024px) {
        max-width: 900px;
        margin: 0 1.5rem;
        letter-spacing: 0.035rem;
    }
    
    @media (max-width: 768px) {
        max-width: 700px;
        margin: 0 1rem;
        letter-spacing: 0.03rem;
    }
    
    @media (max-width: 480px) {
        max-width: 100%;
        margin: 0 0.8rem;
        letter-spacing: 0.025rem;
    }
    
    @media (max-width: 375px) {
        margin: 0 0.5rem;
        letter-spacing: 0.02rem;
    }
    
    @media (max-width: 320px) {
        margin: 0 0.3rem;
        letter-spacing: 0.015rem;
    }
}

.hero-badge {
    display: inline-block;
    background: rgba(245, 124, 0, 0.9);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 50px;
    padding: 0.4rem 1.2rem;
    margin-bottom: 1.5rem;
    font-size: 0.85rem;
    font-weight: 500;
    color: white;
    text-transform: uppercase;
    letter-spacing: 1px;
    
    @media (min-width: 1921px) {
        padding: 0.3vw 1vw;
        font-size: 0.6vw;
        margin-bottom: 1.2vw;
    }
    
    @media (max-width: 1440px) {
        padding: 0.35rem 1rem;
        font-size: 0.8rem;
        margin-bottom: 1.3rem;
    }
    
    @media (max-width: 1024px) {
        padding: 0.3rem 0.9rem;
        font-size: 0.8rem;
        margin-bottom: 1.2rem;
    }
    
    @media (max-width: 768px) {
        padding: 0.3rem 0.8rem;
        font-size: 0.75rem;
        margin-bottom: 1rem;
    }
    
    @media (max-width: 480px) {
        padding: 0.25rem 0.7rem;
        font-size: 0.7rem;
        margin-bottom: 0.8rem;
    }
    
    @media (max-width: 375px) {
        padding: 0.2rem 0.6rem;
        font-size: 0.65rem;
        margin-bottom: 0.7rem;
    }
    
    @media (max-width: 320px) {
        padding: 0.15rem 0.5rem;
        font-size: 0.6rem;
        margin-bottom: 0.6rem;
    }
}

.hero-title {
    font-size: 4rem;
    font-weight: 700;
    letter-spacing: -2px;
    color: white;
    text-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
    margin: 0 0 1.2rem 0;
    line-height: 1.1;
    
    .title-line {
        display: block;
        background: linear-gradient(135deg, #ffffff 0%, #f0f0f0 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }
    
    .title-accent {
        display: block;
        background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }
    
    @media (min-width: 1921px) {
        font-size: 3.2vw;
        margin: 0 0 1vw 0;
        letter-spacing: -0.15vw;
    }
    
    @media (max-width: 1920px) {
        font-size: 3.8rem;
        margin: 0 0 1.15rem 0;
        letter-spacing: -1.8px;
    }
    
    @media (max-width: 1440px) {
        font-size: 3.5rem;
        margin: 0 0 1.1rem 0;
        letter-spacing: -1.5px;
    }
    
    @media (max-width: 1024px) {
        font-size: 3rem;
        margin: 0 0 1rem 0;
        letter-spacing: -1.2px;
    }
    
    @media (max-width: 768px) {
        font-size: 2.5rem;
        margin: 0 0 0.8rem 0;
        letter-spacing: -0.8px;
    }
    
    @media (max-width: 480px) {
        font-size: 2rem;
        margin: 0 0 0.6rem 0;
        letter-spacing: -0.5px;
    }
    
    @media (max-width: 375px) {
        font-size: 1.8rem;
        margin: 0 0 0.5rem 0;
        letter-spacing: -0.3px;
    }
    
    @media (max-width: 320px) {
        font-size: 1.6rem;
        margin: 0 0 0.4rem 0;
        letter-spacing: -0.2px;
    }
}

.hero-subtitle {
    max-width: 600px;
    margin: 0 auto 2rem auto;
    font-size: 1.3rem;
    font-weight: 400;
    letter-spacing: -0.5px;
    color: rgba(255, 255, 255, 0.9);
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    line-height: 1.4;
    
    @media (min-width: 1921px) {
        font-size: 1vw;
        margin: 0 auto 1.6vw auto;
        max-width: 48vw;
        letter-spacing: -0.04vw;
    }
    
    @media (max-width: 1920px) {
        font-size: 1.25rem;
        margin: 0 auto 1.9rem auto;
        max-width: 580px;
        letter-spacing: -0.45px;
    }
    
    @media (max-width: 1440px) {
        font-size: 1.2rem;
        margin: 0 auto 1.8rem auto;
        max-width: 550px;
        letter-spacing: -0.4px;
    }
    
    @media (max-width: 1024px) {
        font-size: 1.15rem;
        margin: 0 auto 1.6rem auto;
        max-width: 520px;
        letter-spacing: -0.35px;
    }
    
    @media (max-width: 768px) {
        font-size: 1.05rem;
        margin: 0 auto 1.3rem auto;
        max-width: 480px;
        letter-spacing: -0.25px;
    }
    
    @media (max-width: 480px) {
        font-size: 1rem;
        margin: 0 auto 1rem auto;
        max-width: 100%;
        letter-spacing: -0.15px;
    }
    
    @media (max-width: 375px) {
        font-size: 0.95rem;
        margin: 0 auto 0.8rem auto;
        letter-spacing: -0.1px;
    }
    
    @media (max-width: 320px) {
        font-size: 0.9rem;
        margin: 0 auto 0.7rem auto;
        letter-spacing: -0.05px;
    }
}

.hero-stats {
    display: flex;
    justify-content: center;
    gap: 2.5rem;
    margin-bottom: 2rem;
    
    @media (min-width: 1921px) {
        gap: 2vw;
        margin-bottom: 1.6vw;
    }
    
    @media (max-width: 1440px) {
        gap: 2.2rem;
        margin-bottom: 1.8rem;
    }
    
    @media (max-width: 1024px) {
        gap: 2rem;
        margin-bottom: 1.7rem;
    }
    
    @media (max-width: 768px) {
        gap: 1.5rem;
        margin-bottom: 1.5rem;
    }
    
    @media (max-width: 480px) {
        font-size: 0.75rem;
        gap: 1rem;
        margin-bottom: 1.2rem;
        align-items: center;
    }
    
    @media (max-width: 375px) {
        gap: 0.8rem;
        margin-bottom: 1rem;
    }
    
    @media (max-width: 320px) {
        gap: 0.6rem;
        margin-bottom: 0.8rem;
    }
}

.stat-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    
    @media (min-width: 1921px) {
        gap: 0.4vw;
    }
    
    @media (max-width: 1440px) {
        gap: 0.4rem;
    }
    
    @media (max-width: 1024px) {
        gap: 0.35rem;
    }
    
    @media (max-width: 768px) {
        gap: 0.3rem;
    }
    
    @media (max-width: 480px) {
        gap: 0.25rem;
    }
    
    @media (max-width: 375px) {
        gap: 0.2rem;
    }
    
    @media (max-width: 320px) {
        gap: 0.15rem;
    }
}

.stat-number {
    font-size: 2.2rem;
    font-weight: 700;
    color: #f57c00;
    text-shadow: 0 2px 10px rgba(245, 124, 0, 0.3);
    
    @media (min-width: 1921px) {
        font-size: 1.8vw;
    }
    
    @media (max-width: 1440px) {
        font-size: 2rem;
    }
    
    @media (max-width: 1024px) {
        font-size: 1.9rem;
    }
    
    @media (max-width: 768px) {
        font-size: 1.8rem;
    }
    
    @media (max-width: 480px) {
        font-size: 1.5rem;
    }
    
    @media (max-width: 375px) {
        font-size: 1.3rem;
    }
    
    @media (max-width: 320px) {
        font-size: 1.1rem;
    }
}

.stat-label {
    font-size: 0.9rem;
    font-weight: 500;
    color: rgba(255, 255, 255, 0.8);
    text-transform: uppercase;
    letter-spacing: 1px;
    
    @media (min-width: 1921px) {
        font-size: 0.7vw;
    }
    
    @media (max-width: 1440px) {
        font-size: 0.85rem;
    }
    
    @media (max-width: 1024px) {
        font-size: 0.8rem;
    }
    
    @media (max-width: 768px) {
        font-size: 0.8rem;
    }
    
    @media (max-width: 480px) {
        font-size: 0.75rem;
        letter-spacing: 0.8px;
    }
    
    @media (max-width: 375px) {
        font-size: 0.7rem;
        letter-spacing: 0.6px;
    }
    
    @media (max-width: 320px) {
        font-size: 0.65rem;
        letter-spacing: 0.5px;
    }
}

.hero-services {
    max-width: 800px;
    margin: 0 auto 2rem auto;
    
    @media (min-width: 1921px) {
        max-width: 64vw;
        margin: 0 auto 1.6vw auto;
    }
    
    @media (max-width: 1440px) {
        max-width: 750px;
        margin: 0 auto 1.8rem auto;
    }
    
    @media (max-width: 1024px) {
        max-width: 700px;
        margin: 0 auto 1.7rem auto;
    }
    
    @media (max-width: 768px) {
        max-width: 95%;
        margin: 0 auto 1.5rem auto;
    }
    
    @media (max-width: 480px) {
        max-width: 100%;
        margin: 0 auto 1.2rem auto;
    }
    
    @media (max-width: 375px) {
        margin: 0 auto 1rem auto;
    }
    
    @media (max-width: 320px) {
        margin: 0 auto 0.8rem auto;
    }
}

.services-text {
    font-size: 1rem;
    font-weight: 400;
    letter-spacing: -0.3px;
    color: rgba(255, 255, 255, 0.85);
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
    margin: 0;
    line-height: 1.5;
    
    @media (min-width: 1921px) {
        font-size: 0.8vw;
        letter-spacing: -0.025vw;
    }
    
    @media (max-width: 1440px) {
        font-size: 0.95rem;
        letter-spacing: -0.25px;
    }
    
    @media (max-width: 1024px) {
        font-size: 0.9rem;
        line-height: 1.4;
        letter-spacing: -0.2px;
    }
    
    @media (max-width: 768px) {
        font-size: 0.85rem;
        line-height: 1.3;
        letter-spacing: -0.15px;
    }
    
    @media (max-width: 480px) {
        font-size: 0.8rem;
        line-height: 1.2;
        letter-spacing: -0.1px;
    }
    
    @media (max-width: 375px) {
        font-size: 0.75rem;
        line-height: 1.15;
        letter-spacing: -0.05px;
    }
    
    @media (max-width: 320px) {
        font-size: 0.7rem;
        line-height: 1.1;
        letter-spacing: 0px;
    }
}

.hero-cta {
    display: flex;
    justify-content: center;
    gap: 1.2rem;
    flex-wrap: wrap;
    
    @media (min-width: 1921px) {
        gap: 1vw;
    }
    
    @media (max-width: 1440px) {
        gap: 1.1rem;
    }
    
    @media (max-width: 1024px) {
        gap: 1rem;
    }
    
    @media (max-width: 768px) {
        gap: 0.8rem;
        align-items: center;
    }

    
    @media (max-width: 320px) {
        gap: 0.75rem;
    }
}

.cta-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.8rem 1.8rem;
    border-radius: 50px;
    font-size: 0.95rem;
    font-weight: 600;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
    
    @media (min-width: 1921px) {
        padding: 0.6vw 1.4vw;
        font-size: 0.7vw;
        gap: 0.3vw;
    }
    
    @media (max-width: 1440px) {
        padding: 0.75rem 1.6rem;
        font-size: 0.9rem;
        gap: 0.4rem;
    }
    
    @media (max-width: 1024px) {
        padding: 0.7rem 1.5rem;
        font-size: 0.85rem;
        gap: 0.35rem;
    }
    
    @media (max-width: 768px) {
        padding: 0.7rem 1.3rem;
        font-size: 0.85rem;
        gap: 0.3rem;
    }
    
    @media (max-width: 480px) {
        padding: 0.6rem 1.2rem;
        font-size: 0.8rem;
        gap: 0.25rem;
    }
    
    @media (max-width: 375px) {
        padding: 0.5rem 1rem;
        font-size: 0.75rem;
        gap: 0.2rem;
    }
    
    @media (max-width: 320px) {
        padding: 0.4rem 0.8rem;
        font-size: 0.7rem;
        gap: 0.15rem;
    }
    
    &.primary {
        background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
        color: white;
        box-shadow: 0 8px 25px rgba(245, 124, 0, 0.3);
        
        &:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(245, 124, 0, 0.4);
        }
    }
    
    &.secondary {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        color: white;
        
        &:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }
    }
}

.arrow-icon {
    width: 20px;
    height: 20px;
    transition: transform 0.3s ease;
    
    @media (min-width: 1921px) {
        width: 1.6vw;
        height: 1.6vw;
    }
    
    @media (max-width: 1440px) {
        width: 19px;
        height: 19px;
    }
    
    @media (max-width: 1024px) {
        width: 18px;
        height: 18px;
    }
    
    @media (max-width: 768px) {
        width: 18px;
        height: 18px;
    }
    
    @media (max-width: 480px) {
        width: 16px;
        height: 16px;
    }
    
    @media (max-width: 375px) {
        width: 15px;
        height: 15px;
    }
    
    @media (max-width: 320px) {
        width: 14px;
        height: 14px;
    }
}

.cta-button:hover .arrow-icon {
    transform: translateX(3px);
}

.scroll-indicator {
    position: absolute;
    bottom: 2rem;
    left: 50%;
    transform: translateX(-50%);
    z-index: 2;
    
    @media (max-width: 1440px) {
        bottom: 1.8rem;
    }
    
    @media (max-width: 1024px) {
        bottom: 1.5rem;
    }
    
    @media (max-width: 768px) {
        bottom: 1rem;
    }
    
    @media (max-width: 480px) {
        bottom: 0.8rem;
    }
    
    @media (max-width: 375px) {
        bottom: 0.6rem;
    }
    
    @media (max-width: 320px) {
        bottom: 0.5rem;
    }
}

.scroll-dot {
    width: 8px;
    height: 8px;
    background: rgba(255, 255, 255, 0.6);
    border-radius: 50%;
    animation: scroll-bounce 2s infinite;
    
    @media (min-width: 1921px) {
        width: 0.6vw;
        height: 0.6vw;
    }
    
    @media (max-width: 1440px) {
        width: 7px;
        height: 7px;
    }
    
    @media (max-width: 1024px) {
        width: 6px;
        height: 6px;
    }
    
    @media (max-width: 768px) {
        width: 5px;
        height: 5px;
    }
    
    @media (max-width: 480px) {
        width: 4px;
        height: 4px;
    }
    
    @media (max-width: 375px) {
        width: 3px;
        height: 3px;
    }
    
    @media (max-width: 320px) {
        width: 2px;
        height: 2px;
    }
}

@keyframes scroll-bounce {
    0%, 20%, 50%, 80%, 100% {
        transform: translateY(0);
    }
    40% {
        transform: translateY(-10px);
    }
    60% {
        transform: translateY(-5px);
    }
}
</style>