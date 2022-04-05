// https://github.com/almasaeed2010/AdminLTE/issues/1240
$.AdminLTESidebarTweak = {};

$.AdminLTESidebarTweak.options = {
  EnableRemember: true,
  NoTransitionAfterReload: false
  //Removes the transition after page reload.
};

$(function () {
  "use strict";

  $('body').on('collapsed.lte.pushmenu shown.lte.pushmenu', function () {
    if ($.AdminLTESidebarTweak.options.EnableRemember) {
      var toggleState = 'opened';
      if ($('body').hasClass('sidebar-collapse')) {
        toggleState = 'closed';
      }
      document.cookie = 'sidebar_collapse_state=' + toggleState + ';path=/';
      setTimeout(function () {
        window.dispatchEvent(new Event('resize'))
      }, 500)
    }
  });

  if ($.AdminLTESidebarTweak.options.EnableRemember) {
    var re = new RegExp('sidebar_collapse_state' + "=([^;]+)");
    var value = re.exec(document.cookie);
    var toggleState = (value != null) ? unescape(value[1]) : null;
    if (toggleState == 'closed') {
      if ($.AdminLTESidebarTweak.options.NoTransitionAfterReload) {
        $('body').addClass('sidebar-collapse hold-transition').delay(100).queue(function () {
          $(this).removeClass('hold-transition');
        });
      } else {
        $('body').addClass('sidebar-collapse');
      }
    }
  }
});
