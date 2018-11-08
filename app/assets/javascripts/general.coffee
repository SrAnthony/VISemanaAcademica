# Animação ao clicar em uma âncora
$(document).on 'click', 'a[href^="#"]', (event) ->
  event.preventDefault()
  href = $.attr(this, 'href')

  # Cancela animação se for link da agenda ou for link vazio
  if href.includes 'schedule' || href == '#'
    return

  $('html, body').animate({
    scrollTop: $(href).offset().top - 30
  }, 500)
