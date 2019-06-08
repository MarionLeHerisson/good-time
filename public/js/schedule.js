var element;
let changeBackground = function (e) {
        e.preventDefault();
        element = $(this);

        document.body.onmousedown = function(element) {
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
        }
    },

    binds = function() {
        // $('.js-schedule-cell').on('click', changeBackground);
        $('.js-schedule-cell').on('mouseover', changeBackground);
    };

$(document).ready(function () {
    binds();
});

// $(function () {
    //
    // $('#schedule').jqs();
    //
    // $("#schedule").jqs({
    //     days: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"],
    //     hour: 24,
    //     data: [
    //         {
    //             day: 0,
    //             periods: [
    //                 ["10pm", "12am"],
    //                 ["12am", "2:30am"]
    //             ]
    //         }
    //     ]
    // });
// });
