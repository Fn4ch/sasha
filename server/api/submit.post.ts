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
    return { error: 'Ошибка сервера' }
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
      console.error('Telegram error:', err)
      return { error: 'Не удалось отправить в Telegram' }
    }

    return { success: true }
  } catch (error) {
    console.error('Ошибка:', error)
    return { error: 'Внутренняя ошибка' }
  }
})