<template>
  <Transition name="dialog-fade">
    <div v-if="isOpen" class="dialog-overlay" @click="handleBackdrop">
      <div class="dialog" role="dialog" aria-modal="true" @click.stop>
        <header class="dialog__header">
          <h3 class="dialog__title">Связаться с нами</h3>
          <button class="icon-button" aria-label="Закрыть" @click="close">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M18 6L6 18M6 6l12 12" />
            </svg>
          </button>
        </header>

        <form @submit.prevent="submit" target="_blank" action="https://formsubmit.co/your@email.com" method="POST">
          <section class="dialog__content">
            <div class="md-field">
              <textarea
                id="contact-message"
                v-model.trim="message"
                class="md-field__input md-field__textarea"
                rows="5"
                placeholder=" "
                :aria-invalid="messageError ? 'true' : 'false'"
              ></textarea>
              <label for="contact-message" class="md-field__label">Сообщение</label>
              <p v-if="messageError" class="md-field__error">
                Введите сообщение (минимум 5 символов)
              </p>
            </div>

            <div class="md-field">
              <input
                id="contact-phone"
                v-model.trim="phone"
                class="md-field__input"
                type="tel"
                inputmode="tel"
                pattern="^\+?[0-9\s\-()]{7,}$"
                placeholder=" "
                :aria-invalid="phoneError ? 'true' : 'false'"
              />
              <label for="contact-phone" class="md-field__label">Телефон для связи</label>
              <p v-if="phoneError" class="md-field__error">Укажите корректный номер телефона</p>
            </div>
          </section>

          <footer class="dialog__footer">
            <button class="cta-button secondary" @click="close">Отмена</button>
            <button class="cta-button primary" :disabled="!isValid" @click="submit">
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

const messageError = computed(
  () => props.isOpen && message.value.trim().length > 0 && message.value.trim().length < 5,
);
const phoneRegex = /^\+?[0-9\s\-()]{7,}$/;
const phoneError = computed(
  () => props.isOpen && phone.value.trim().length > 0 && !phoneRegex.test(phone.value.trim()),
);
const isValid = computed(
  () => message.value.trim().length >= 5 && phoneRegex.test(phone.value.trim()),
);

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
  // close on overlay click
  if (e.target && (e.target as HTMLElement).classList.contains("dialog-overlay")) {
    close();
  }
}

function submit() {
  if (!isValid.value) return;
  const payload = { message: message.value.trim(), phone: phone.value.trim() };
  emit("submit", payload);

  // Fallback action: open mail client
  const subject = encodeURIComponent("Запрос с сайта: контактная форма");
  const body = encodeURIComponent(`Сообщение:\n${payload.message}\n\nТелефон: ${payload.phone}`);
  window.location.href = `mailto:rusbar2008@rambler.ru?subject=${subject}&body=${body}`;

  close();
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
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: transparent;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #333;
  transition: background 0.2s ease-in-out;

  svg {
    width: 20px;
    height: 20px;
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
