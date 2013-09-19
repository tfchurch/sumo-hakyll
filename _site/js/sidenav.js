(function() {
  var refreshScrollSpy;

  refreshScrollSpy = function() {
    return $('[data-spy="scroll"]').each(function() {
      return $(this).scrollspy('refresh');
    });
  };

  $(function() {
    var $sideNav;
    $sideNav = $('#sideNav');
    if ($sideNav.length) {
      $sideNav.find('ul').addClass('nav');
      $sideNav.affix({
        offset: {
          top: 56
        }
      });
      refreshScrollSpy();
      $(window).resize(refreshScrollSpy);
      return $('.sidenavTitle').click(function() {
        $('.active').removeClass('active');
        return $(window).trigger('resize');
      });
    }
  });

}).call(this);
