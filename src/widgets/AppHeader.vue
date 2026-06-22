<template>
    <header id="header" class="header">
        <nav class="navigation">
            <div class="navigation__logo" @click="$router.push('/')">
                <img src="@/assets/logo.svg" alt="Логотип ООО Весы" class="logo" loading="eager" fetchpriority="high">
                <span>ООО "Весы"</span>
            </div>
            <div class="navigation__links">
                <button class="nav-link" @click="scrollToCatalog">
                    <span>Каталог</span>
                </button>
                <button class="nav-link" @click="scrollToContacts">
                    <span>Контакты</span>
                </button>
            </div>
        </nav>
    </header>
</template>
<script setup lang="ts">
import { onMounted } from 'vue'

const scrollToContacts = () => {
  const contactsElement = document.getElementById('contacts')
  if (contactsElement) {
    contactsElement.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    })
  }
}

const scrollToCatalog = () => {
  // Если мы не на главной странице, сначала переходим на неё
  if (window.location.pathname !== '/') {
    window.location.href = '/#catalog'
    return
  }
  
  const catalogElement = document.getElementById('catalog')
  if (catalogElement) {
    catalogElement.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    })
  }
}

// Обработка хэша в URL при загрузке страницы
onMounted(() => {
  if (window.location.hash === '#catalog') {
    setTimeout(() => {
      const catalogElement = document.getElementById('catalog')
      if (catalogElement) {
        catalogElement.scrollIntoView({ 
          behavior: 'smooth',
          block: 'start'
        })
      }
    }, 100)
  }
})
</script>

<style lang="scss" scoped>
.logo{
    width: 3rem;
    color: white;
    background-color: transparent;
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
    transition: transform 0.3s ease;
    
    @media (min-width: 1921px) {
        width: 2.4vw;
    }
}

.header{
    align-items: center;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    -webkit-backdrop-filter: blur(20px);
    backdrop-filter: blur(20px);
    background: linear-gradient(
        135deg,
        rgba(33, 33, 33, 0.95) 0%,
        rgba(33, 33, 33, 0.85) 100%
    );
    font-size: 1rem;
    z-index: 10;
    @extend %materialTransition;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    
    @media (max-width: 1024px) {
        font-size: 0.9rem;
    }
    
    @media (max-width: 768px) {
        font-size: 0.85rem;
    }
    
    @media (max-width: 480px) {
        font-size: 0.8rem;
    }

    @media (min-width: 1921px) {
        font-size: 0.8vw;
    }
}

.navigation{
    display: flex;
    justify-content: space-between;
    padding: 1rem 5rem;
    color: $colorBlack;
    align-items: center;
    background-color: transparent;
    max-width: 100%;
    box-sizing: border-box;

    @media (max-width: 1440px) {
        padding: 0.8rem 3rem;
    }
    
    @media (max-width: 1024px) {
        padding: 0.8rem 2rem;
    }
    
    @media (max-width: 768px) {
        padding: 0.8rem 1rem;
    }
    
    @media (max-width: 480px) {
        padding: 0.8rem 0.5rem;
    }

    @media (min-width: 1921px) {
        padding: 0.8vw 4vw;
    }

    &__links{
        display: flex;
        column-gap: 1rem;
        row-gap: 1rem;
        background-color: transparent;
        
        @media (max-width: 1024px) {
            column-gap: 0.8rem;
            row-gap: 0.8rem;
        }
        
        @media (max-width: 768px) {
            column-gap: 0.6rem;
            row-gap: 0.6rem;
        }
        
        @media (max-width: 480px) {
            column-gap: 0.4rem;
            row-gap: 0.4rem;
        }

        @media (min-width: 1921px) {
            column-gap: 0.8vw;
            row-gap: 0.8vw;
        }
    }

    &__logo{
        display: flex;
        align-items: center;
        gap: 1rem;
        background-color: transparent;
        color: $colorOrange;
        font-size: 1.5rem;
        cursor: pointer;
        @extend %materialTransition;
        padding: 0.5rem 1rem;
        border-radius: 12px;
        transition: all 0.3s ease;
        
        &:hover {
            transform: scale(1.05);
            background: rgba(245, 124, 0, 0.1);
            box-shadow: 0 4px 15px rgba(245, 124, 0, 0.2);
            
            .logo {
                transform: scale(1.1);
            }
        }
        
        span{
            background-color: transparent;
            font-weight: 600;
            letter-spacing: -0.5px;
        }
        
        @media (max-width: 1024px) {
            font-size: 1.3rem;
            gap: 0.8rem;
            padding: 0.4rem 0.8rem;
        }
        
        @media (max-width: 768px) {
            font-size: 1.1rem;
            gap: 0.6rem;
            padding: 0.3rem 0.6rem;
        }
        
        @media (max-width: 480px) {
            font-size: 1rem;
            gap: 0.4rem;
            padding: 0.2rem 0.4rem;
        }

        @media (min-width: 1921px) {
            font-size: 1.2vw;
            gap: 0.8vw;
            padding: 0.4vw 0.8vw;
            border-radius: 0.96vw;
        }
    }
}

.company-name {
    background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    @media (max-width: 480px) {
        display: none;
    }
}

.nav-link {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 12px;
    padding: 0.8rem 1.5rem;
    font-size: 1rem;
    font-weight: 500;
    color: white;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    text-decoration: none;
    position: relative;
    overflow: hidden;
    
    &:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        border-color: rgba(255, 255, 255, 0.3);
    }
    
    &:active {
        transform: translateY(0);
    }
    
    span {
        position: relative;
        z-index: 1;
    }
    
    @media (max-width: 1024px) {
        font-size: 0.9rem;
        padding: 0.6rem 1.2rem;
    }
    
    @media (max-width: 768px) {
        font-size: 0.85rem;
        padding: 0.5rem 1rem;
    }
    
    @media (max-width: 480px) {
        font-size: 0.8rem;
        padding: 0.4rem 0.8rem;
    }

    @media (min-width: 1921px) {
        font-size: 0.8vw;
        padding: 0.64vw 1.2vw;
        border-radius: 0.96vw;
    }
}
</style>