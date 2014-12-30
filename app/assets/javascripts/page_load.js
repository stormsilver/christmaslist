$.fn.selectpicker.defaults = {
    iconBase: 'fa',
    tickIcon: 'fa-check'
};

$(document).on('ready pjax:success page:load', function() {
    $(".modal-trigger").each(function() {
        new Modal($(this)).initialize();
    });
    $('a[rel~=tooltip], .has-tooltip, [data-toggle="tooltip"]').tooltip();
    $('select').selectpicker();
});
