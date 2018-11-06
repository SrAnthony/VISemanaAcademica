$(document).on 'turbolinks:load', ->
  # Menu responsivo
  $('a[data-js="main-nav-toggler"]').click ->
    $('ul[data-js="main-nav"]').toggleClass 'hidden-tablet'

  # Ativa as tabs do #sobre
  $('.about .menu .item').tab()

  # Ativa nicescroll no scroll do body (fica elegante)
  $("body").niceScroll();

  # Máscara de CPF
  $('.cpf-mask').mask('000.000.000-00', { reverse: true });
  # Máscada de matrícula (apenas numeros)
  $('.matricula-mask').mask('0000000000000000');

  # Abre o modal de cadastro ao clicar nos botões de 'inscrever-se'
  $('.price-button, .signup-modal').click ->
    $('#modal-signup')
      .modal('setting', 'transition', 'fade up')
      .modal('show');

  # Permite abertura de múltiplos modais, sendo que o primeiro fecha antes de abrir o segundo
  $('.coupled.modal').modal({
    allowMultiple: false
  });
  $('.second.modal').modal('attach events', '.first.modal .to-login');
