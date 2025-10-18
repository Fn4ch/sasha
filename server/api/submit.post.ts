import { defineEventHandler, readBody } from 'h3'

export default defineEventHandler(async (event) => {
  // Только POST (проверяется по имени файла `.post.ts`)
  const body = await readBody(event)

  const { phone, text } = body || {}

  if (!phone) {
    return { error: 'Телефон обязательный' }
  }

  const TELEGRAM_TOKEN = process.env.TELEGRAM_BOT_TOKEN
  const TELEGRAM_CHAT_ID = process.env.TELEGRAM_CHAT_ID

  if (!TELEGRAM_TOKEN || !TELEGRAM_CHAT_ID) {
    console.error('❌ TELEGRAM_TOKEN или TELEGRAM_CHAT_ID не заданы')
    console.error('TELEGRAM_TOKEN:', TELEGRAM_TOKEN ? 'установлен' : 'НЕ УСТАНОВЛЕН')
    console.error('TELEGRAM_CHAT_ID:', TELEGRAM_CHAT_ID ? 'установлен' : 'НЕ УСТАНОВЛЕН')
    return { 
      error: 'Сервис временно недоступен. Пожалуйста, попробуйте позже или свяжитесь с нами по телефону.',
      details: 'Отсутствуют настройки уведомлений'
    }
  }

  const message = `
📩 Новая заявка:
Телефон: ${phone || '—'}
Текст: ${text || '—'}
  `.trim()

  try {
    const res = await fetch(`https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        chat_id: TELEGRAM_CHAT_ID,
        text: message
      })
    })

    if (!res.ok) {
      const err = await res.json()
      console.error('Telegram API error:', err)
      console.error('Response status:', res.status)
      console.error('Response headers:', Object.fromEntries(res.headers.entries()))
      
      return { 
        error: 'Не удалось отправить уведомление. Пожалуйста, попробуйте позже.',
        details: `Telegram API error: ${err.description || 'Unknown error'}`
      }
    }

    const result = await res.json()
    console.log('✅ Сообщение успешно отправлено в Telegram:', result.message_id)
    return { success: true, messageId: result.message_id }
  } catch (error) {
    console.error('❌ Ошибка при отправке в Telegram:', error)
    return { 
      error: 'Ошибка сети. Пожалуйста, проверьте подключение и попробуйте снова.',
      details: error instanceof Error ? error.message : 'Unknown error'
    }
  }
})