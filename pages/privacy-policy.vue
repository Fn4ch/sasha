<template>
  <div class="privacy">

    <div class="privacy__container">

      <h1 class="privacy__title">Политика обработки персональных данных</h1>
      <p class="privacy__date">Дата последнего обновления: 22 июня 2026 г.</p>

      <section class="privacy__section">
        <h2>1. Общие положения</h2>
        <p>
          Настоящая Политика обработки персональных данных (далее — Политика) разработана в соответствии с требованиями
          Федерального закона от 27.07.2006 № 152-ФЗ «О персональных данных» и определяет порядок обработки персональных
          данных пользователей сайта <strong>vesi-kazan.ru</strong>.
        </p>
        <p>
          Оператором персональных данных является:
        </p>
        <ul>
          <li><strong>Наименование:</strong> ООО «Весы»</li>
          <li><strong>Юридический адрес:</strong> г. Казань, ул. Маршала Чуйкова, д. 15</li>
          <li><strong>Телефон:</strong> +7 (960) 031-01-85</li>
          <li><strong>Email:</strong> rusbar2008@rambler.ru</li>
        </ul>
      </section>

      <section class="privacy__section">
        <h2>2. Какие персональные данные мы обрабатываем</h2>
        <p>При заполнении формы обратной связи на сайте мы обрабатываем следующие данные:</p>
        <ul>
          <li>Номер телефона</li>
          <li>Текст сообщения (запроса)</li>
        </ul>
        <p>
          При посещении сайта серверное программное обеспечение автоматически фиксирует технические данные:
          IP-адрес, тип браузера, операционная система. Указанные данные обрабатываются в обезличенном виде
          исключительно в целях обеспечения работоспособности сайта.
        </p>
      </section>

      <section class="privacy__section">
        <h2>3. Цели обработки персональных данных</h2>
        <p>Персональные данные обрабатываются в следующих целях:</p>
        <ul>
          <li>Обработка входящих заявок и обращений от пользователей</li>
          <li>Обратная связь: ответ на вопросы, консультации по продукции и услугам</li>
        </ul>
        <p>
          Правовым основанием обработки является согласие субъекта персональных данных
          (ст. 6, ч. 1, п. 1 ФЗ-152).
        </p>
      </section>

      <section class="privacy__section">
        <h2>4. Передача данных третьим лицам</h2>
        <p>
          В целях оперативной обработки заявок данные (номер телефона и текст сообщения) направляются
          через сервис <strong>Telegram</strong> (Telegram FZ-LLC / Telegram Messenger Inc.) на защищённый корпоративный
          канал уведомлений оператора. Передача осуществляется посредством Telegram Bot API.
        </p>
        <p>
          Серверы Telegram могут располагаться за пределами Российской Федерации.
          Оператор принимает необходимые меры для обеспечения конфиденциальности передаваемых данных.
        </p>
        <p>Данные не продаются, не передаются и не раскрываются иным третьим лицам.</p>
      </section>

      <section class="privacy__section">
        <h2>5. Сроки хранения данных</h2>
        <p>
          Персональные данные хранятся в течение срока, необходимого для достижения целей их обработки,
          но не более <strong>1 года</strong> с момента получения согласия, либо до момента отзыва согласия
          субъектом персональных данных.
        </p>
      </section>

      <section class="privacy__section">
        <h2>6. Защита персональных данных</h2>
        <p>
          Оператор принимает необходимые организационные и технические меры для защиты персональных данных
          от неправомерного доступа, изменения, раскрытия или уничтожения. Передача данных между браузером
          пользователя и сервером осуществляется по протоколу HTTPS.
        </p>
      </section>

      <section class="privacy__section">
        <h2>7. Права субъекта персональных данных</h2>
        <p>Вы имеете право:</p>
        <ul>
          <li>Получить информацию об обработке ваших персональных данных</li>
          <li>Потребовать уточнения, блокирования или уничтожения данных</li>
          <li>Отозвать согласие на обработку персональных данных в любой момент</li>
          <li>Обратиться с жалобой в Роскомнадзор (rkn.gov.ru), если считаете, что ваши права нарушены</li>
        </ul>
        <p>
          Для реализации ваших прав направьте запрос по адресу:
          <a href="mailto:rusbar2008@rambler.ru">rusbar2008@rambler.ru</a>
          или по телефону <a href="tel:+79600310185">+7 (960) 031-01-85</a>.
        </p>
      </section>

      <section class="privacy__section">
        <h2>8. Файлы Cookie</h2>
        <p>
          Сайт не использует аналитические или рекламные файлы cookie. Технические cookie,
          необходимые для работы сайта, не содержат персональных данных.
        </p>
      </section>

      <section class="privacy__section">
        <h2>9. Изменения в Политике</h2>
        <p>
          Оператор оставляет за собой право вносить изменения в настоящую Политику.
          Актуальная версия всегда доступна на данной странице. Продолжение использования сайта
          после внесения изменений означает согласие с обновлённой Политикой.
        </p>
      </section>

      <div class="privacy__back">
        <NuxtLink to="/" class="back-btn">← На главную</NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
useSeoMeta({
  title: 'Политика конфиденциальности — Весы Казань',
  description: 'Политика обработки персональных данных ООО «Весы». Информация о сборе, хранении и защите данных пользователей сайта vesi-kazan.ru.',
  robots: 'noindex, follow',
  ogTitle: 'Политика конфиденциальности — Весы Казань',
  ogDescription: 'Политика обработки персональных данных ООО «Весы».',
  ogUrl: 'https://vesi-kazan.ru/privacy-policy',
  ogType: 'website',
})

useHead({
  link: [{ rel: 'canonical', href: 'https://vesi-kazan.ru/privacy-policy' }],
})
</script>

<style lang="scss" scoped>
.privacy {
  min-height: 100vh;
  padding: calc(var(--header-height) + 2rem) 2rem 4rem;
  background: #fafafa;

  @media (max-width: 768px) {
    padding: calc(var(--header-height) + 1.5rem) 1rem 3rem;
  }
}

.privacy__container {
  max-width: 800px;
  margin: 0 auto;
}

.privacy__logo {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 2rem;
  text-decoration: none;
  color: #f57c00;
  font-size: 1.3rem;
  font-weight: 600;
  transition: opacity 0.2s ease;

  &:hover {
    opacity: 0.8;
  }
}

.privacy__logo-img {
  width: 2.5rem;
  height: auto;
}

.privacy__title {
  font-size: 2rem;
  font-weight: 700;
  color: rgba(0, 0, 0, 0.87);
  margin-bottom: 0.5rem;
  letter-spacing: -0.5px;

  @media (max-width: 768px) {
    font-size: 1.6rem;
  }
}

.privacy__date {
  font-size: 0.9rem;
  color: rgba(0, 0, 0, 0.5);
  margin-bottom: 2.5rem;
}

.privacy__section {
  margin-bottom: 2rem;
  padding-bottom: 2rem;
  border-bottom: 1px solid rgba(0, 0, 0, 0.08);

  &:last-of-type {
    border-bottom: none;
  }

  h2 {
    font-size: 1.2rem;
    font-weight: 600;
    color: rgba(0, 0, 0, 0.87);
    margin-bottom: 0.8rem;
  }

  p {
    font-size: 1rem;
    line-height: 1.7;
    color: rgba(0, 0, 0, 0.7);
    margin-bottom: 0.6rem;

    &:last-child {
      margin-bottom: 0;
    }
  }

  ul {
    margin: 0.5rem 0 0.6rem 1.4rem;
    display: flex;
    flex-direction: column;
    gap: 0.3rem;

    li {
      font-size: 1rem;
      line-height: 1.6;
      color: rgba(0, 0, 0, 0.7);
    }
  }

  a {
    color: #f57c00;
    text-decoration: underline;

    &:hover {
      color: #e65100;
    }
  }
}

.privacy__back {
  margin-top: 2rem;
}

.back-btn {
  display: inline-flex;
  align-items: center;
  padding: 0.7rem 1.5rem;
  background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
  color: #fff;
  border-radius: 50px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(245, 124, 0, 0.35);
  }
}
</style>
