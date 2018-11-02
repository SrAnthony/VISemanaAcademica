$(document).on 'turbolinks:load', ->
  # Menu responsivo
  $('a[data-js="main-nav-toggler"]').click ->
    $('ul[data-js="main-nav"]').toggleClass 'hidden-tablet'

  # Ativa as tabs do #sobre
  $('.about .menu .item').tab()
