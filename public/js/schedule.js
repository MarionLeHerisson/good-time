let changeBackground = function (e) {
        console.log(e);
        let element = $(this);
        let newClass = ($('#happySwitch').is(':checked')) ? 'happy' : 'open';

        if(element.hasClass('schedule-closed')) {
            element.removeClass('schedule-closed');
            element.addClass('schedule-'+newClass);
        } else {
            if(element.hasClass('schedule-happy') && newClass === 'happy') {
                element.removeClass('schedule-happy');
                element.addClass('schedule-open');
            } else if (element.hasClass('schedule-open') && newClass === 'happy') {
                element.removeClass('schedule-open');
                element.addClass('schedule-happy');
            } else {
                element.removeClass('schedule-open');
                element.removeClass('schedule-happy');
                element.addClass('schedule-closed');
            }
        }

    },

    binds = function() {
        $('.js-schedule-cell').click(changeBackground);
    };

$(document).ready(function () {
    binds();
});


