// Плагин для валидации переменных окружения на сервере
export default defineNuxtPlugin(() => {
  // Проверяем только на сервере
  if (import.meta.server) {
    const requiredEnvVars = [
      'TELEGRAM_BOT_TOKEN',
      'TELEGRAM_CHAT_ID'
    ]

    const missingVars = requiredEnvVars.filter(varName => !process.env[varName])

    if (missingVars.length > 0) {
      console.warn('⚠️  ВНИМАНИЕ: Отсутствуют переменные окружения для Telegram:')
      missingVars.forEach(varName => {
        console.warn(`   - ${varName}`)
      })
      console.warn('📖 Инструкции по настройке: см. TELEGRAM_SETUP.md')
      console.warn('🔧 Форма обратной связи будет работать, но уведомления не будут отправляться')
    } else {
      console.log('✅ Все переменные окружения для Telegram настроены')
    }
  }
})
