function Modal(element) {
    var self = this;
    self.element = element;
    self.parent_document_title = null;

    self.modal = function() {
        return $('#modal');
    };

    self.initialize = function() {
        self.element.on('click', self.open_modal);
    };

    self.open_modal = function(event) {
        event.stopPropagation();

        var url = self.element.attr('href');

        self.modal().modal({
            show: false
        });
        self.modal().on('show.bs.modal', function() {
            $.get(url).done(function(data, textStatus, jqXHR) {
                self.ajax_did_finish(null, data, textStatus, jqXHR);
            }).fail(self.error_retrieving);
        }).on('hidden.bs.modal', self.close);

        self.modal().modal('show');

        return false;
    };

    self.close = function() {
        self.reset_document_title();
    };

    self.ajax_did_finish = function(event, data, textStatus, jqXHR) {
        var modal_content = self.modal().find('.popover-content');

        // reset
        self.modal().html('');
        // append new content
        self.modal().html(data).on("ajax:complete", self.complete).on('ajax:success', self.ajax_did_finish).on('ajax:error', self.error_retrieving);

        self.set_title(self.modal().find(".modal-title").text());

        self.modal().find('.modal-body').scrollTop(0);
        setTimeout(function() {
            self.modal().find('.modal-body').find('input, select, textarea').first().focus();
        }, 250);
    };

    self.complete = function(event, jqXHR, textStatus) {
        if (textStatus == "error") {
            self.error_retrieving(data, textStatus);
        }
    };

    self.error_retrieving = function(event, jqXHR, data, textStatus) {
        var error = "We had a problem completing that request. Please let us know about this issue.";
        if (jqXHR.status == 401 || jqXHR.status == 422) {
            error = 'You are currently logged out.  Please <a href="'+RouteManager.route_for('new_user_session')+'">log in again</a>.';
        } else if (jqXHR.status == 403) {
            error = 'You do not have permission to access this page. Please contact your supervisor.';
        }
        self.modal().find('.modal-body').prepend("<div class=\"alert alert-block alert-danger\">" + error + "</div>");
    };

    self.set_title = function(title) {
        self.modal().find(".modal-title").html(title).toggle(title != "");
        self.update_document_title(title);
    };

    self.update_document_title = function(new_title) {
        self.parent_document_title = self.parent_document_title || document.title;
        document.title = new_title + " | ChristmasList";
    };

    self.reset_document_title = function() {
        document.title = self.parent_document_title;
        self.parent_document_title = null;
    };

}

// Modal.currently_open_modal = null;


$(document).on('ready pjax:success page:load', function() {
    $(".modal-trigger").each(function() {
        new Modal($(this)).initialize();
    });
});
