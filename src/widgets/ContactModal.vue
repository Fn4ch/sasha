<template>
  <Teleport to="body">
  <Transition name="dialog-fade">
    <div v-if="isOpen" class="dialog-overlay" @click="handleBackdrop">
      <div class="dialog" role="dialog" aria-modal="true" @click.stop>
        <header class="dialog__header">
          <h3 class="dialog__title">Связаться с нами</h3>
          <button class="icon-button" aria-label="Закрыть" @click="close">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" color="#cccccc" stroke-width="2">
              <path d="M18 6L6 18M6 6l12 12" />
            </svg>
          </button>
        </header>

        <form @submit.prevent="handleSubmit">
          <section class="dialog__content">
            <div class="md-field">
              <textarea
                id="contact-message"
                v-model.trim="message"
                class="md-field__input md-field__textarea"
                rows="5"
                placeholder=" "
                :aria-invalid="messageError ? 'true' : 'false'"
              />
              <label for="contact-message" class="md-field__label">Сообщение</label>
              <p v-if="messageError" class="md-field__error">
                Введите сообщение (минимум 5 символов)
              </p>
            </div>

            <div class="md-field">
              <input
                id="contact-phone"
                name="phone"
                :value="phone"
                class="md-field__input"
                type="tel"
                inputmode="tel"
                autocomplete="tel"
                placeholder="+7 (___) ___-__-__"
                maxlength="19"
                :aria-invalid="phoneError ? 'true' : 'false'"
                @input="onPhoneInput"
                @focus="onPhoneFocus"
                @paste.prevent="onPhonePaste"
              >
              <label for="contact-phone" class="md-field__label">Телефон для связи</label>
              <p v-if="phoneError" class="md-field__error">Укажите корректный номер телефона</p>
            </div>
            <!-- Hidden normalized E.164 phone for backend convenience -->
            <input type="hidden" name="phone_e164" :value="normalizedPhone" >
          </section>

          <footer class="dialog__footer">
            <button class="cta-button secondary" @click="close">Отмена</button>
            <button class="cta-button primary" :disabled="!isValid" type="submit">
              <span>Отправить</span>
              <svg
                class="arrow-icon"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M5 12h14M12 5l7 7-7 7" />
              </svg>
            </button>
          </footer>
        </form>
      </div>
    </div>
  </Transition>
  </Teleport>
</template>

<script setup lang="ts">
import { computed, ref, watch } from "vue";

interface Props {
  isOpen: boolean;
}

interface Emits {
  (e: "update:isOpen", value: boolean): void;
  (e: "close"): void;
  (e: "submit", payload: { message: string; phone: string }): void;
}

const props = defineProps<Props>();
const emit = defineEmits<Emits>();

const message = ref("");
const phone = ref("");

// --- Валидация и форматирование (остаётся без изменений) ---
function normalizeDigits(value: string): string {
  return value.replace(/\D+/g, '');
}

function formatRuPhone(digits: string): string {
  if (!digits) return '';
  if (digits[0] === '8') digits = '7' + digits.slice(1);
  if (digits[0] !== '7') digits = '7' + digits;

  const p1 = digits.slice(1, 4);
  const p2 = digits.slice(4, 7);
  const p3 = digits.slice(7, 9);
  const p4 = digits.slice(9, 11);

  let formatted = '+7';
  if (p1) formatted += ` (${p1}`;
  if (p1 && p1.length === 3) formatted += ')';
  if (p2) formatted += ` ${p2}`;
  if (p3) formatted += `-${p3}`;
  if (p4) formatted += `-${p4}`;
  return formatted;
}

const phoneError = computed(() => {
  if (!props.isOpen) return false;
  const digits = normalizeDigits(phone.value);
  if (digits.length === 0) return false;
  const coerced = digits[0] === '8' ? '7' + digits.slice(1) : (digits[0] === '7' ? digits : '7' + digits);
  return coerced.length !== 11;
});

const messageError = computed(
  () => props.isOpen && message.value.trim().length > 0 && message.value.trim().length < 5,
);

const isValid = computed(() => {
  const msgOk = message.value.trim().length >= 5;
  const digits = normalizeDigits(phone.value);
  const coerced = digits[0] === '8' ? '7' + digits.slice(1) : (digits[0] === '7' ? digits : '7' + digits);
  return msgOk && coerced.length === 11;
});

const normalizedPhone = computed(() => {
  const digits = normalizeDigits(phone.value);
  const coerced = digits[0] === '8' ? '7' + digits.slice(1) : (digits[0] === '7' ? digits : '7' + digits);
  return coerced.length === 11 ? `+${coerced}` : '';
});

function onPhoneInput(e: Event) {
  const target = e.target as HTMLInputElement;
  const digits = normalizeDigits(target.value);
  phone.value = formatRuPhone(digits);
}

function onPhoneFocus() {
  if (!phone.value) {
    phone.value = '+7 ';
  }
}

function onPhonePaste(e: ClipboardEvent) {
  const text = e.clipboardData?.getData('text') || '';
  const digits = normalizeDigits(text);
  phone.value = formatRuPhone(digits);
}

// Типы для ответа API
interface ApiSuccessResponse {
  success: true;
  messageId?: number;
}

interface ApiErrorResponse {
  error: string;
  details?: string;
}

type ApiResponse = ApiSuccessResponse | ApiErrorResponse;

// --- ОСНОВНОЕ ИЗМЕНЕНИЕ: handleSubmit через $fetch ---
async function handleSubmit() {
  if (!isValid.value) return;

  const submitButton = document.querySelector('.cta-button.primary') as HTMLButtonElement;
  const originalText = submitButton?.innerHTML;
  
  // Показываем состояние загрузки
  if (submitButton) {
    submitButton.disabled = true;
    submitButton.innerHTML = '<span>Отправка...</span>';
  }

  try {
    // Отправляем на твой Nuxt API-роут
    const response = await $fetch<ApiResponse>('/api/submit', {
      method: 'POST',
      body: {
        phone: normalizedPhone.value,
        text: message.value.trim()
      }
    });

    if ('success' in response && response.success) {
      emit('submit', { message: message.value.trim(), phone: normalizedPhone.value });
      alert('✅ Спасибо! Мы получили вашу заявку и скоро свяжемся с вами.');
      close();
    } else {
      const errorMessage = 'error' in response ? response.error : 'Неизвестная ошибка';
      const details = 'details' in response && response.details ? `\n\nДетали: ${response.details}` : '';
      alert(`❌ Ошибка: ${errorMessage}${details}`);
    }
  } catch (err: any) {
    console.error('Ошибка отправки:', err);
    
    let errorMessage = 'Не удалось отправить заявку. Попробуйте позже.';
    
    if (err.status === 500) {
      errorMessage = 'Сервер временно недоступен. Пожалуйста, попробуйте позже или свяжитесь с нами по телефону.';
    } else if (err.status === 400) {
      errorMessage = 'Проверьте правильность заполнения формы.';
    } else if (err.status === 0 || !navigator.onLine) {
      errorMessage = 'Проверьте подключение к интернету и попробуйте снова.';
    }
    
    alert(`❌ ${errorMessage}`);
  } finally {
    // Восстанавливаем кнопку
    if (submitButton) {
      submitButton.disabled = false;
      submitButton.innerHTML = originalText || '<span>Отправить</span><svg class="arrow-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7" /></svg>';
    }
  }
}

// --- Остальное без изменений ---
watch(
  () => props.isOpen,
  (open) => {
    if (open) {
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "";
      message.value = "";
      phone.value = "";
    }
  },
);

function close() {
  emit("update:isOpen", false);
  emit("close");
}

function handleBackdrop(e: MouseEvent) {
  if (e.target && (e.target as HTMLElement).classList.contains("dialog-overlay")) {
    close();
  }
}
</script>

<style lang="scss" scoped>
.dialog-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(4px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1rem;
  z-index: 1000;
}

.dialog {
  width: 100%;
  max-width: 560px;
  background: #ffffff;
  border-radius: 16px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  overflow: hidden;
}

.dialog__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem 1.25rem;
  border-bottom: 1px solid rgba(0, 0, 0, 0.06);
}

.dialog__title {
  font-size: 1.1rem;
  font-weight: 700;
}

.icon-button {
  background: transparent;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #333;
  transition: background 0.2s ease-in-out;
  box-shadow: none;
  border-radius: 12px;
  padding: 8px 8px;

  svg {
    width: 24px;
    height: 24px;
  }

  &:hover {
    background: rgba(0, 0, 0, 0.06);
  }
}

.dialog__content {
  padding: 1rem 1.25rem 0.25rem 1.25rem;
}

.dialog__footer {
  display: flex;
  gap: 0.5rem;
  justify-content: flex-end;
  padding: 0.75rem 1.25rem 1.25rem 1.25rem;
}

/* Material-like outlined fields with floating labels */
.md-field {
  position: relative;
  margin-bottom: 1rem;
}

.md-field__input {
  width: 100%;
  padding: 1rem 0.9rem 1rem 0.9rem;
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 12px;
  background: #ffffff;
  outline: none;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.md-field__textarea {
  resize: vertical;
  min-height: 120px;
}

.md-field__input:focus {
  border-color: #ff9800;
  box-shadow: 0 0 0 3px rgba(255, 152, 0, 0.15);
}

.md-field__label {
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  background: #ffffff;
  padding: 0 6px;
  color: rgba(0, 0, 0, 0.6);
  pointer-events: none;
  transition: all 0.15s ease;
}

/* Floating behavior */
.md-field__input:not(:placeholder-shown) + .md-field__label,
.md-field__input:focus + .md-field__label {
  top: 0;
  transform: translateY(-50%) scale(0.92);
  color: #ff9800;
}

.md-field__error {
  margin-top: 0.35rem;
  font-size: 0.85rem;
  color: #d32f2f;
}

/* Reuse CTA button styling from existing project */
.cta-button {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.7rem 1.3rem;
  border-radius: 50px;
  font-weight: 600;
  border: none;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);

  &.primary {
    background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
    color: #fff;
  }

  &.secondary {
    background: #eeeeee;
    color: #333;
  }
}

.arrow-icon {
  width: 18px;
  height: 18px;
}

.dialog-fade-enter-active,
.dialog-fade-leave-active {
  transition: opacity 0.2s ease;
}
.dialog-fade-enter-from,
.dialog-fade-leave-to {
  opacity: 0;
}
</style>
