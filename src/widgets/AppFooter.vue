<template>
  <footer class="footer">
    <div class="footer__container">
      <div class="footer__contacts">
        <div class="footer__contacts_logo">
          <img src="@/assets/logo.svg" class="logo">
          <span>ООО "Весы"</span>
        </div>
        <div class="contacts">
          <h4 class="contacts__title">Контакты</h4>
          <ul class="contacts__list">
            <li class="contacts__item">
              <a :href="`tel:${number}`">{{ number }}</a>
            </li>
            <li class="contacts__item">
              <a :href="`tel:${number2}`">{{ number2 }}</a>
            </li>
            <li class="contacts__item">
              <a :href="`mailto:${mail}`">{{ mail }}</a>
            </li>
            <li class="contacts__item">
              {{ address }}
            </li>
          </ul>
        </div>
      </div>

      <div class="footer__dev dev">
        <p class="dev__copyright">&copy; {{ currentYear }} Весы Казань</p>
        <p class="dev__site">
          <a href="https://faotech.dev/ru " target="_blank"><img src="@/public/images/logo.webp" class="logo"></a>
        </p>
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
  background-color: #212121; // Material Design dark theme
  color: rgba(255, 255, 255, 0.87); // Material Design text on dark
  padding: 2rem 3rem;
  @extend %materialTransition;
  @media (min-width: 1921px) {
    padding: 1.6vw 2.4vw;
    font-size: 1vw;
  }

  span{
    background-color: transparent;
  }

  p{
    background-color: transparent;
  }

  &__container {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    
    background-color: transparent;
    color: rgba(255, 255, 255, 0.87);
    min-height: 96px;
    max-width: 100%;
    box-sizing: border-box;
    @media (min-width: 1921px) {
      min-height: 7.68vw;
    }

    @media (min-width: 768px) {
      justify-content: space-between;
    }
  }

  &__logo {
    background-color: transparent;
    img {
      height: 40px;
      width: auto;
      background-color: transparent;
      color: rgba(255, 255, 255, 0.87);
    }
  }

  &__contacts{
    display: flex;
    align-items: center;
    background-color: transparent;
    column-gap: 2rem;
    @media (min-width: 1921px) {
      column-gap: 1.6vw;
    }

    &_logo{
      background-color: transparent;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      span{
        color: $colorOrange;
        font-size: 1.5rem;
        font-weight: 500;
        @media (min-width: 1921px) {
          font-size: 1.2vw;
        }
      }
      @media (max-width: 768px) {
        display: none;
      }
    }
  }

  .contacts {
    background-color: transparent;
    color: rgba(255, 255, 255, 0.87);
    
    &__title {
      background-color: transparent;
      font-size: 1.1rem;
      margin-bottom: 0.5rem;
      color: $colorGreen;
      font-weight: 500;
      @media (min-width: 1921px) {
        font-size: 0.88vw;
        margin-bottom: 0.4vw;
      }
    }

    &__item{
      background-color: transparent;

      a{ 
        background-color: transparent;
        text-decoration: none;
        color: rgba(255, 255, 255, 0.87);
        @extend %materialTransition;
        
        &:hover {
          color: $colorGreen;
        }
      }
    }

    &__list {
      background-color: transparent;
      list-style: none;
      padding: 0;
      margin: 0;
      display: flex;
      flex-direction: column;
      gap: 0.4rem;
      font-size: 1rem;
      @media (min-width: 1921px) {
        gap: 0.32vw;
        font-size: 0.8vw;
      }

      a {
        text-decoration: none;
        @extend %materialTransition;
        padding: 0.25rem 0;
        border-radius: $borderRadius;

        &:hover {
          color: $colorGreen;
          background-color: rgba(255, 255, 255, 0.05);
        }
      }
    }
  }

  .dev {
    display: flex;
    flex-direction: column;
    row-gap: 0.5rem;
    column-gap: 0.5rem;
    margin-top: auto;
    opacity: 0.7;
    background-color: transparent;
    @media (min-width: 1921px) {
      font-size: 0.8vw;
      row-gap: 0.4vw;
      column-gap: 0.4vw;
    }

    @media (max-width: 768px) {
      font-size: small;
    }

    &__site{
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    p{
      background-color: transparent;
    }

    a {
      background-color: transparent;
      color: $colorGreen;
      text-decoration: none;
      font-weight: 500;
      @extend %materialTransition;
      padding: 0.25rem 0;
      border-radius: $borderRadius;

      &:hover {
        text-decoration: underline;
        background-color: rgba(76, 175, 80, 0.1);
      }
    }
  }
}
</style>