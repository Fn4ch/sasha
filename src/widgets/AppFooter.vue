<template>
  <footer class="footer">
    <div class="footer__container">
      <div class="footer__main">
        <div class="footer__brand">
          <div class="brand-logo">
            <img src="@/assets/logo.svg" class="logo">
            <div class="brand-info">
              <span class="company-name">ООО "Весы"</span>
              <p class="company-tagline">Профессиональные весы для любых задач</p>
            </div>
          </div>
        </div>
        
        <div class="footer__contacts">
          <h4 class="contacts__title">Контакты</h4>
          <div class="contacts-grid">
            <div class="contact-item">
              <div class="contact-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                </svg>
              </div>
              <a :href="`tel:${number}`" class="contact-link">{{ number }}</a>
            </div>
            
            <div class="contact-item">
              <div class="contact-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                </svg>
              </div>
              <a :href="`tel:${number2}`" class="contact-link">{{ number2 }}</a>
            </div>
            
            <div class="contact-item">
              <div class="contact-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                  <polyline points="22,6 12,13 2,6"/>
                </svg>
              </div>
              <a :href="`mailto:${mail}`" class="contact-link">{{ mail }}</a>
            </div>
            
            <div class="contact-item">
              <div class="contact-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                  <circle cx="12" cy="10" r="3"/>
                </svg>
              </div>
              <span class="contact-text">{{ address }}</span>
            </div>
          </div>
        </div>
      </div>

      <div class="footer__dev dev">
        <div class="dev__info">
          <p class="dev__copyright">&copy; {{ currentYear }} Весы Казань</p>
          <p class="dev__rights">Все права защищены</p>
        </div>
        <div class="dev__site">
          <a href="https://faotech.dev/ru" target="_blank" class="dev-link">
            <span>Разработано</span>
            <img src="@/public/images/logo.webp" class="dev-logo">
          </a>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">

const number = '+79600310185'
const number2 = '+79600310187'
const mail = 'rusbar2008@rambler.ru'
const address = 'Юр. Адрес г. Казань, ул. Маршала Чуйкова 15'

const currentYear = new Date().getFullYear()
</script>

<style lang="scss" scoped>
.logo{
  background-color: transparent;
  max-width: 156px;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
  transition: transform 0.3s ease;
  
  @media (max-width: 768px) {
    width: 80px;
  }
  @media (min-width: 1921px) {
    max-width: 12.48vw;
  }
}

.footer {
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
  color: rgba(255, 255, 255, 0.87);
  padding: 3rem 3rem 2rem;
  @extend %materialTransition;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  
  @media (min-width: 1921px) {
    padding: 2.4vw 2.4vw 1.6vw;
    font-size: 1vw;
  }
  
  @media (max-width: 768px) {
    padding: 2rem 1.5rem 1.5rem;
  }
  
  @media (max-width: 480px) {
    padding: 1.5rem 1rem 1rem;
  }

  span{
    background-color: transparent;
  }

  p{
    background-color: transparent;
  }

  &__container {
    display: flex;
    flex-direction: column;
    gap: 2rem;
    background-color: transparent;
    color: rgba(255, 255, 255, 0.87);
    max-width: 1400px;
    margin: 0 auto;
    box-sizing: border-box;
    
    @media (min-width: 1921px) {
      gap: 1.6vw;
    }
    
    @media (max-width: 768px) {
      gap: 1.5rem;
    }
  }

  &__main {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 3rem;
    align-items: start;
    
    @media (min-width: 1921px) {
      gap: 2.4vw;
    }
    
    @media (max-width: 1024px) {
      grid-template-columns: 1fr;
      gap: 2rem;
    }
    
    @media (max-width: 768px) {
      gap: 1.5rem;
    }
  }

  &__brand {
    background-color: transparent;
  }

  .brand-logo {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    margin-bottom: 1.5rem;
    
    @media (min-width: 1921px) {
      gap: 1.2vw;
      margin-bottom: 1.2vw;
    }
    
    @media (max-width: 768px) {
      gap: 1rem;
      margin-bottom: 1rem;
    }
  }

  .brand-info {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    
    @media (min-width: 1921px) {
      gap: 0.4vw;
    }
  }

  .company-name {
    color: $colorOrange;
    font-size: 1.8rem;
    font-weight: 700;
    letter-spacing: -0.5px;
    background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    
    @media (min-width: 1921px) {
      font-size: 1.44vw;
    }
    
    @media (max-width: 768px) {
      font-size: 1.5rem;
    }
  }

  .company-tagline {
    color: rgba(255, 255, 255, 0.6);
    font-size: 1rem;
    margin: 0;
    font-weight: 400;
    
    @media (min-width: 1921px) {
      font-size: 0.8vw;
    }
    
    @media (max-width: 768px) {
      font-size: 0.9rem;
    }
  }

  &__contacts{
    background-color: transparent;
    color: rgba(255, 255, 255, 0.87);
  }

  .contacts {
    background-color: transparent;
    color: rgba(255, 255, 255, 0.87);
    
    &__title {
      background-color: transparent;
      font-size: 1.3rem;
      margin-bottom: 1.5rem;
      color: $colorGreen;
      font-weight: 600;
      letter-spacing: -0.5px;
      
      @media (min-width: 1921px) {
        font-size: 1.04vw;
        margin-bottom: 1.2vw;
      }
      
      @media (max-width: 768px) {
        font-size: 1.2rem;
        margin-bottom: 1rem;
      }
    }
  }

  .contacts-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1rem;
    
    @media (min-width: 1921px) {
      gap: 0.8vw;
      grid-template-columns: repeat(auto-fit, minmax(20vw, 1fr));
    }
    
    @media (max-width: 768px) {
      grid-template-columns: 1fr;
      gap: 0.8rem;
    }
  }

  .contact-item {
    display: flex;
    align-items: center;
    gap: 0.8rem;
    padding: 1rem;
    border-radius: 12px;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    transition: all 0.3s ease;
    
    &:hover {
      background: rgba(255, 255, 255, 0.1);
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
    }
    
    @media (min-width: 1921px) {
      padding: 0.8vw;
      border-radius: 0.96vw;
      gap: 0.64vw;
    }
    
    @media (max-width: 768px) {
      padding: 0.8rem;
      gap: 0.6rem;
    }
  }

  .contact-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: rgba(76, 175, 80, 0.2);
    color: $colorGreen;
    flex-shrink: 0;
    
    svg {
      width: 20px;
      height: 20px;
    }
    
    @media (min-width: 1921px) {
      width: 3.2vw;
      height: 3.2vw;
      
      svg {
        width: 1.6vw;
        height: 1.6vw;
      }
    }
    
    @media (max-width: 768px) {
      width: 35px;
      height: 35px;
      
      svg {
        width: 18px;
        height: 18px;
      }
    }
  }

  .contact-link {
    color: rgba(255, 255, 255, 0.87);
    text-decoration: none;
    font-weight: 500;
    font-size: 1rem;
    transition: all 0.3s ease;
    
    &:hover {
      color: $colorGreen;
      text-decoration: none;
    }
    
    @media (min-width: 1921px) {
      font-size: 0.8vw;
    }
    
    @media (max-width: 768px) {
      font-size: 0.9rem;
    }
  }

  .contact-text {
    color: rgba(255, 255, 255, 0.87);
    font-weight: 500;
    font-size: 1rem;
    
    @media (min-width: 1921px) {
      font-size: 0.8vw;
    }
    
    @media (max-width: 768px) {
      font-size: 0.9rem;
    }
  }

  .dev {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 2rem;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    opacity: 0.8;
    background-color: transparent;
    
    @media (min-width: 1921px) {
      padding-top: 1.6vw;
      font-size: 0.8vw;
    }
    
    @media (max-width: 768px) {
      flex-direction: column;
      gap: 1rem;
      text-align: center;
      padding-top: 1.5rem;
    }

    &__info {
      display: flex;
      flex-direction: column;
      gap: 0.3rem;
      
      @media (min-width: 1921px) {
        gap: 0.24vw;
      }
    }

    &__copyright {
      font-weight: 500;
      margin: 0;
    }

    &__rights {
      font-size: 0.9rem;
      color: rgba(255, 255, 255, 0.6);
      margin: 0;
      
      @media (min-width: 1921px) {
        font-size: 0.72vw;
      }
      
      @media (max-width: 768px) {
        font-size: 0.8rem;
      }
    }

    &__site {
      display: flex;
      align-items: center;
    }

    .dev-link {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      color: $colorGreen;
      text-decoration: none;
      font-weight: 500;
      padding: 0.5rem 1rem;
      border-radius: 8px;
      transition: all 0.3s ease;
      
      &:hover {
        background: rgba(76, 175, 80, 0.1);
        transform: translateY(-1px);
      }
      
      span {
        font-size: 0.9rem;
        
        @media (min-width: 1921px) {
          font-size: 0.72vw;
        }
        
        @media (max-width: 768px) {
          font-size: 0.8rem;
        }
      }
      
      @media (min-width: 1921px) {
        gap: 0.4vw;
        padding: 0.4vw 0.8vw;
        border-radius: 0.64vw;
      }
    }

    .dev-logo {
      width: 80px;
      height: auto;
      filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
      
      @media (min-width: 1921px) {
        width: 6.4vw;
      }
      
      @media (max-width: 768px) {
        width: 60px;
      }
    }
  }
}
</style>