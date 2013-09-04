# TODO: refactor
makeSideNav = ->
  content = $('#content').html()
  sideNavContent = ''
  $('#content h1').each (i, elem) ->
    $elem = $(elem)
    href = "##{$elem.attr 'id'}"
    li = $('<li>')
    li.append $('<a>').attr('href', href).text $elem.text()
    sideNavContent += li[0].outerHTML
  sideNav = $('<div id="sideNav">')
  $('<ul class="nav">').html(sideNavContent).appendTo sideNav
  newRow = $ '<div class="row">'
  newRow.append $('<div class="col-md-3">') .append sideNav
  newRow.append $('<div class="col-md-9 navedContent">') .append content
  $('#content').html newRow

$ ->
  if $('#makesidenav').length
    $('#makesidenav').remove()
    makeSideNav()
    $('#sideNav').affix
      offset:
        top: 60
    $('[data-spy="scroll"]').each ->
      $spy = $(@).scrollspy 'refresh'
