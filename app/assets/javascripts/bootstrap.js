jQuery(function() {
  // $("a[rel~=popover], .has-popover").popover();
  $('a[rel~=tooltip], .has-tooltip, [data-toggle="tooltip"]').tooltip();
});

$.fn.selectpicker.defaults = {
    iconBase: 'fa',
    tickIcon: 'fa-check'
};
