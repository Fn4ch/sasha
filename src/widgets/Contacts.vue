<template>
  <section class="contacts-section">
    <div class="contacts-card">
      <div class="contacts-content">
        <h2 class="contacts-title">Связаться с нами</h2>
        <ul class="contacts-list">
          <li class="contacts-item">
            <span class="contact-label">Телефон:</span>
            <a :href="`tel:${number}`" class="contact-link">{{ number }}</a>
          </li>
          <li class="contacts-item">
            <span class="contact-label">Телефон:</span>
            <a :href="`tel:${number2}`" class="contact-link">{{ number2 }}</a>
          </li>
          <li class="contacts-item">
            <span class="contact-label">Email:</span>
            <a :href="`mailto:${mail}`" class="contact-link">{{ mail }}</a>
          </li>
          <li class="contacts-item">
            <span class="contact-label">Адрес:</span>
            <span class="contact-text">{{ address }}</span>
          </li>
        </ul>
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
  padding: 3rem 0;
  background-color: #fafafa;
  
  @media (max-width: 768px) {
    padding: 2rem 0;
  }
  
  @media (min-width: 1921px) {
    padding: 2.4vw 0;
  }
}

.contacts-card {
  background-color: white;
  border-radius: $borderRadiusLarge;
  padding: 1.4rem;
  max-width: 80%;
  width: 100%;
  box-sizing: border-box;
  @extend %boxShadow;
  @extend %materialTransition;
  
  &:hover {
    @extend %boxShadowHover;
  }
  
  @media (max-width: 1024px) {
    padding: 1rem;
    max-width: 85%;
  }
  
  @media (max-width: 819px) {
    padding: 0.5rem;
    max-width: 90%;
  }
  
  @media (max-width: 480px) {
    padding: 0.2rem;
    max-width: 95%;
  }
  
  @media (min-width: 1921px) {
    padding: 1.12vw;
    max-width: 64vw;
    border-radius: 0.64vw;
  }
}

.contacts-content {
  .divider {
    width: 100%;
    height: 1px;
    background-color: rgba(0, 0, 0, 0.12);
    margin-bottom: 2rem;
    
    @media (max-width: 768px) {
      margin-bottom: 1.5rem;
    }
    
    @media (max-width: 480px) {
      margin-bottom: 1rem;
    }
  }
  
  .contacts-title {
    font-size: 2rem;
    font-weight: 300;
    color: rgba(0, 0, 0, 0.87);
    margin: 0 0 2rem 0;
    letter-spacing: -0.5px;
    
    @media (max-width: 768px) {
      font-size: 1.6rem;
      margin-bottom: 1.5rem;
    }
    
    @media (max-width: 480px) {
      font-size: 1.4rem;
      margin-bottom: 1rem;
    }
    
    @media (min-width: 1921px) {
      font-size: 1.6vw;
      margin-bottom: 1.6vw;
    }
  }
}

.contacts-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 1.5rem;
  
  @media (max-width: 768px) {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  @media (min-width: 1921px) {
    gap: 1.2vw;
    grid-template-columns: repeat(auto-fit, minmax(28vw, 1fr));
  }
}

.contacts-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  border-radius: $borderRadius;
  background-color: #f5f5f5;
  @extend %materialTransition;
  
  &:hover {
    background-color: #eeeeee;
    transform: translateY(-1px);
    @extend %boxShadow;
  }
  
  @media (max-width: 768px) {
    padding: 0.8rem;
    gap: 0.8rem;
  }
  
  @media (min-width: 1921px) {
    padding: 0.8vw;
    border-radius: 0.32vw;
    gap: 0.4vw;
  }
}

.contact-label {
  font-weight: 500;
  color: rgba(0, 0, 0, 0.87);
  min-width: 100px;
  font-size: 1.1rem;
  
  @media (max-width: 768px) {
    min-width: 80px;
    font-size: 1rem;
  }
  
  @media (min-width: 1921px) {
    min-width: 8vw;
    font-size: 0.88vw;
  }
}

.contact-link {
  color: $colorBlue;
  text-decoration: none;
  font-weight: 500;
  font-size: 1.1rem;
  @extend %materialTransition;
  
  &:hover {
    color: #1976d2;
    text-decoration: underline;
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
  font-weight: 500;
  font-size: 1.1rem;
  
  @media (max-width: 768px) {
    font-size: 1rem;
  }
  
  @media (min-width: 1921px) {
    font-size: 0.88vw;
  }
}
</style>
