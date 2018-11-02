# Animação ao clicar em uma âncora
$(document).on 'click', 'a[href^="#"]', ->
  event.preventDefault()
  href = $.attr(this, 'href')

  # Cancela animação se for link da agenda
  if href.includes 'schedule'
    return

  $('html, body').animate({
    scrollTop: $(href).offset().top - 30
  }, 500)
