// Generated by CoffeeScript 1.4.0
(function() {
  var makeSideNav, refreshScrollSpy;

  makeSideNav = function() {
    var content, newRow, sideNav, sideNavContent;
    content = $('#content').html();
    sideNavContent = '';
    $('#content h1').each(function(i, elem) {
      var $elem, href, li;
      $elem = $(elem);
      href = "#" + ($elem.attr('id'));
      li = $('<li>');
      if ($elem.hasClass('title')) {
        li.hide();
      }
      li.append($('<a>').attr('href', href).text($elem.text()));
      return sideNavContent += li[0].outerHTML;
    });
    sideNav = $('<div id="sideNav">');
    $('<ul class="nav">').html(sideNavContent).appendTo(sideNav);
    newRow = $('<div class="row">');
    newRow.append($('<div class="col-md-3">').append(sideNav));
    newRow.append($('<div class="col-md-9 navedContent">').append(content));
    return $('#content').html(newRow);
  };

  refreshScrollSpy = function() {
    return $('[data-spy="scroll"]').each(function() {
      return $(this).scrollspy('refresh');
    });
  };

  $(function() {
    var $sideNav;
    if ($('#makesidenav').length) {
      $('#makesidenav').remove();
      makeSideNav();
      $sideNav = $('#sideNav');
      $('#sideNav').affix({
        offset: {
          top: 56
        }
      });
      refreshScrollSpy();
      return $(window).resize(refreshScrollSpy);
    }
  });

}).call(this);
