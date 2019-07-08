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

// Carte
function handleMenu() {
    // Ajouter
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

    // Appliquer une réduction
    $('.btnApplyDiscount').on('click', (e) => {
        let itemId = $(e.currentTarget).data('item');
        let itemName = $('#item-name-' + itemId).text();
        $('.productName').text(itemName);
    });


    // Modifier / Supprimer
    // Enregistrer / Annuler
    $('.js-btn-action').on('click', (e) => {

        let itemId = $(e.currentTarget).data('item');
        let btn1 = $('#edit-' + itemId);
        let btn2 = $('#delete-' + itemId);

        let itemPriceContainer = $('#item-price-' + itemId);
        let originalPrice = $('#item-original-price-' + itemId).text();

        // Modifier / Enregistrer
        if ($(e.currentTarget).hasClass('js-btn-edit')) {

            if($(e.currentTarget).data('action') === 'edit') {

                itemPriceContainer.html('<input type="text" id="newItemPrice-' + itemId + '" placeholder="' + originalPrice + '">');

                btn1.data('action', 'save');
                btn1.text('Enregistrer');

                btn2.data('action', 'cancel');
                btn2.text('Annuler');
            }
            else if($(e.currentTarget).data('action') === 'save') {
                // todo 1 : ajax

                itemPriceContainer.text(originalPrice); // todo 1 : newPrice

                btn1.data('action', 'edit');
                btn1.text('Modifier');

                btn2.data('action', 'delete');
                btn2.text('Supprimer');
            }
        }

        // Supprimer / Annuler
        if ($(e.currentTarget).hasClass('js-btn-delete')) {

            if($(e.currentTarget).data('action') === 'delete') {
                // todo 1 : ajax

                $(e.currentTarget).closest('li').attr('hidden', 'hidden');

                console.log("deleting row !");
            }
            else if($(e.currentTarget).data('action') === 'cancel') {

                itemPriceContainer.text(originalPrice);

                btn1.data('action', 'edit');
                btn1.text('Modifier');

                btn2.data('action', 'delete');
                btn2.text('Supprimer');
            }
        }
    });
}
