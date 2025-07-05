<template>
  <section id="contacts" class="contacts-section">
    <div class="contacts-container">
      <div class="contacts-header">
        <h2 class="contacts-title">Связаться с нами</h2>
        <p class="contacts-subtitle">Мы всегда готовы помочь вам с выбором и ответить на любые вопросы</p>
      </div>
      
      <div class="contacts-grid">
        <div class="contact-card">
          <div class="contact-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
            </svg>
          </div>
          <div class="contact-content">
            <h3 class="contact-label">Телефон</h3>
            <a :href="`tel:${number}`" class="contact-link">{{ number }}</a>
          </div>
        </div>
        
        <div class="contact-card">
          <div class="contact-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
            </svg>
          </div>
          <div class="contact-content">
            <h3 class="contact-label">Телефон</h3>
            <a :href="`tel:${number2}`" class="contact-link">{{ number2 }}</a>
          </div>
        </div>
        
        <div class="contact-card">
          <div class="contact-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
              <polyline points="22,6 12,13 2,6"/>
            </svg>
          </div>
          <div class="contact-content">
            <h3 class="contact-label">Email</h3>
            <a :href="`mailto:${mail}`" class="contact-link">{{ mail }}</a>
          </div>
        </div>
        
        <div class="contact-card">
          <div class="contact-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
              <circle cx="12" cy="10" r="3"/>
            </svg>
          </div>
          <div class="contact-content">
            <h3 class="contact-label">Адрес</h3>
            <span class="contact-text">{{ address }}</span>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const number = '+79600310185'
const number2 = '+79600310187'
const mail = 'rusbar2008@rambler.ru'
const address = 'г. Казань, ул. Маршала Чуйкова 15'
</script>

<style lang="scss" scoped>
.contacts-section {
  width: 100%;
  display: flex;
  justify-content: center;
  padding: 2rem 0;
  background: linear-gradient(135deg, #fafafa 0%, #f5f5f5 100%);
  scroll-margin-top: 80px;
  position: relative;
  
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent 0%, rgba(0, 0, 0, 0.1) 50%, transparent 100%);
  }
  
  @media (max-width: 768px) {
    padding: 3rem 0;
  }
  
  @media (min-width: 1921px) {
    padding: 3.2vw 0;
  }
}

.contacts-container {
  max-width: 1200px;
  width: 100%;
  margin: 0 auto;
  padding: 0 2rem;
  
  @media (max-width: 768px) {
    padding: 0 1rem;
  }
  
  @media (min-width: 1921px) {
    max-width: 96vw;
    padding: 0 1.6vw;
  }
}

.contacts-header {
  text-align: center;
  margin-bottom: 3rem;
  
  @media (max-width: 768px) {
    margin-bottom: 2rem;
  }
  
  @media (min-width: 1921px) {
    margin-bottom: 2.4vw;
  }
}

.header-badge {
  display: inline-block;
  background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
  border-radius: 50px;
  padding: 0.5rem 1.5rem;
  margin-bottom: 1.5rem;
  font-size: 0.9rem;
  font-weight: 600;
  color: white;
  text-transform: uppercase;
  letter-spacing: 1px;
  box-shadow: 0 4px 15px rgba(245, 124, 0, 0.3);
  
  @media (min-width: 1921px) {
    padding: 0.4vw 1.2vw;
    font-size: 0.7vw;
    margin-bottom: 1.2vw;
  }
  
  @media (max-width: 768px) {
    padding: 0.4rem 1rem;
    font-size: 0.8rem;
    margin-bottom: 1rem;
  }
}

.contacts-title {
  font-size: 2.5rem;
  font-weight: 700;
  color: rgba(0, 0, 0, 0.87);
  margin: 0 0 1rem 0;
  letter-spacing: -1px;
  background: linear-gradient(135deg, #333 0%, #666 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  
  @media (max-width: 768px) {
    font-size: 2rem;
    margin-bottom: 0.8rem;
  }
  
  @media (max-width: 480px) {
    font-size: 1.8rem;
  }
  
  @media (min-width: 1921px) {
    font-size: 2vw;
    margin-bottom: 0.8vw;
  }
}

.contacts-subtitle {
  font-size: 1.1rem;
  color: rgba(0, 0, 0, 0.6);
  margin: 0;
  line-height: 1.5;
  max-width: 600px;
  margin: 0 auto;
  
  @media (max-width: 768px) {
    font-size: 1rem;
  }
  
  @media (min-width: 1921px) {
    font-size: 0.88vw;
  }
}

.contacts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
  
  @media (max-width: 768px) {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  @media (min-width: 1921px) {
    gap: 1.2vw;
    grid-template-columns: repeat(auto-fit, minmax(22.4vw, 1fr));
  }
}

.contact-card {
  background: white;
  border-radius: 16px;
  padding: 2rem;
  display: flex;
  align-items: flex-start;
  gap: 1.5rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  border: 1px solid rgba(0, 0, 0, 0.05);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
  
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 3px;
    background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
    transform: scaleX(0);
    transition: transform 0.3s ease;
  }
  
  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
    border-color: rgba(245, 124, 0, 0.2);
    
    &::before {
      transform: scaleX(1);
    }
    
    .contact-icon {
      transform: scale(1.1);
      background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
      color: white;
    }
  }
  
  @media (max-width: 768px) {
    padding: 1.5rem;
    gap: 1rem;
  }
  
  @media (min-width: 1921px) {
    padding: 1.6vw;
    gap: 1.2vw;
    border-radius: 1.28vw;
  }
}

.contact-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 60px;
  height: 60px;
  border-radius: 16px;
  background: rgba(245, 124, 0, 0.1);
  color: #f57c00;
  flex-shrink: 0;
  transition: all 0.3s ease;
  
  svg {
    width: 24px;
    height: 24px;
  }
  
  @media (max-width: 768px) {
    width: 50px;
    height: 50px;
    
    svg {
      width: 20px;
      height: 20px;
    }
  }
  
  @media (min-width: 1921px) {
    width: 4.8vw;
    height: 4.8vw;
    border-radius: 1.28vw;
    
    svg {
      width: 1.92vw;
      height: 1.92vw;
    }
  }
}

.contact-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  
  @media (min-width: 1921px) {
    gap: 0.4vw;
  }
}

.contact-label {
  font-size: 0.9rem;
  font-weight: 600;
  color: rgba(0, 0, 0, 0.6);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin: 0;
  
  @media (max-width: 768px) {
    font-size: 0.8rem;
  }
  
  @media (min-width: 1921px) {
    font-size: 0.72vw;
  }
}

.contact-link {
  color: #1976d2;
  text-decoration: none;
  font-weight: 600;
  font-size: 1.1rem;
  transition: all 0.3s ease;
  
  &:hover {
    color: #1565c0;
    text-decoration: none;
  }
  
  @media (max-width: 768px) {
    font-size: 1rem;
  }
  
  @media (min-width: 1921px) {
    font-size: 0.88vw;
  }
}

.contact-text {
  color: rgba(0, 0, 0, 0.87);
  font-weight: 600;
  font-size: 1.1rem;
  line-height: 1.4;
  
  @media (max-width: 768px) {
    font-size: 1rem;
  }
  
  @media (min-width: 1921px) {
    font-size: 0.88vw;
  }
}
</style>
