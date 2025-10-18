// Плагин для корректного расчета viewport height на мобильных устройствах
export default defineNuxtPlugin(() => {
  // Функция для установки CSS-переменной --vh
  const setViewportHeight = () => {
    const vh = window.innerHeight * 0.01
    document.documentElement.style.setProperty('--vh', `${vh}px`)
  }

  // Устанавливаем начальное значение
  setViewportHeight()

  // Обновляем при изменении размера окна
  window.addEventListener('resize', setViewportHeight)
  window.addEventListener('orientationchange', () => {
    // Небольшая задержка для корректного расчета после поворота
    setTimeout(setViewportHeight, 100)
  })

  // Дополнительная проверка для iOS Safari
  if (/iPad|iPhone|iPod/.test(navigator.userAgent)) {
    // Дополнительное обновление после загрузки
    window.addEventListener('load', setViewportHeight)
    
    // Обновление при изменении видимости (для случаев когда Safari скрывает/показывает UI)
    document.addEventListener('visibilitychange', () => {
      if (!document.hidden) {
        setTimeout(setViewportHeight, 100)
      }
    })
  }
})
