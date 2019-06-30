$(document).ready(function () {
    handleSchedule();
    handleMenu();
});

$("#exportSchedule").click(function () {

    const barRegistration = $("#bar_registration_form_schedule");

    if(barRegistration.length !== 0) {
        barRegistration.val($("#schedule").jqs('export'));
    }
    else {
        let data = $("#schedule").jqs('export');
        console.log(data.toString());

        myAjax('/bar/ajax', data, (ret) => {
            let successMessage = $("#successScheduleMessage");
            successMessage.text(ret);
            successMessage.removeAttr('hidden');
        });
    }

});

/**
 * @param url		// String - The Controller to be called
 * @param parameter // Array  - parameters
 * @param callback	// Callable - Called if success
 */
function myAjax(url, parameter, callback) {

    $.ajax({
        type: "POST",
        url: url,
        data: {
            parameter: parameter
        },
        success: callback
    });
}

function handleSchedule() {
    const barScheduleData = $("#barSchedule");
    let scheduleData = [];

    if(barScheduleData.length !== 0) {
        scheduleData = JSON.parse(barScheduleData.text());
    }

    $("#schedule").jqs({
        days: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"],
        hour: 24,
        data: scheduleData,
        periodColors: [
            ['rgba(187,187,187, 0.5)', '#bbb', '#000'],
            ['rgba(234,298,122,0.5)', '#eac67a', '#000'], // background, border, text
        ],
        periodOptions: true,
        periodTitle: '',
        periodBackgroundColor: 'rgba(187,187,187,0.5)',
        periodBorderColor: '#bbb',
        periodTextColor: '#000',
        periodRemoveButton: 'Supprimer',
        periodDuplicateButton: 'Dupliquer',
    });
}

function handleMenu() {
    $("#saveNewItem").click(() => {
        let data = {
            name: $("#productName").val(),
            description: $("#productDescription").val(),
            price: $("#productPrice").val(),
            price_hh: $("#productPriceHh").val(),
            category: $("#productType").val(),
        };

        myAjax('/bar/ajax', data, (ret) => {

        });
    });
}
