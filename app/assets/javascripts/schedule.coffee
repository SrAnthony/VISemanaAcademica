$(document).on 'turbolinks:load', ->
  # Ao clicar em uma aba da agenda
  $('.nav-schedule a').on 'click', ->
    event.preventDefault()
    href = $(this).attr('href')

    $('.schedule .tab-pane.active').removeClass 'active'
    $('.nav-schedule a').parent().removeClass 'active'
    $(this).parent().addClass 'active'
    $("#{href}, #{href} .tab-pane").addClass 'active'
