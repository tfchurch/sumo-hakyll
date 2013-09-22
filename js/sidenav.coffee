refreshScrollSpy = ->
  $('[data-spy="scroll"]').each ->
    $spy = $(@).scrollspy 'refresh'

$ ->
  $sideNavC = $('#sideNavContainer')
  if $sideNavC.length
    $sideNavC.find('ul').addClass('nav').attr 'id', 'sideNavUl'
    $sideNavC.affix
      offset:
        top: 56
    refreshScrollSpy()

    $window = $(window)
    $window.resize refreshScrollSpy
    #$('.sidenavTitle').click ->
      #$('.active').removeClass 'active'
      #refreshScrollSpy()
