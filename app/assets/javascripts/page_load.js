$.fn.selectpicker.defaults = {
    iconBase: 'fa',
    tickIcon: 'fa-check'
};

// $(document).on('ready turbolinks:load page:load', function() {
$(document).on('turbolinks:load', function() {
    $(".modal-trigger").each(function() {
        // console.log("modal trigger", $(this))
        new Modal($(this)).initialize();
    });
    $('a[rel~=tooltip], .has-tooltip, [data-toggle="tooltip"]').tooltip();
    $('select').selectpicker();
});
