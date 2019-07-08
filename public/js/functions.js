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

        myAjax('/bar/ajax', 'exportSchedule', data, (ret) => {
            let successMessage = $("#successScheduleMessage");
            successMessage.text(ret);
            successMessage.removeAttr('hidden');
        });
    }

});

/**
 * @param url		// String - The Controller to be called
 * @param action	// String - The function to be called
 * @param parameter // Array  - parameters
 * @param callback	// Callable - Called if success
 */
function myAjax(url, action, parameter, callback) {

    $.ajax({
        type: "POST",
        url: url,
        data: {
            action: action,
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
    // A D D   I T E M
    $("#saveNewItem").click(() => {
        let data = {
            name: $("#productName").val(),
            description: $("#productDescription").val(),
            price: $("#productPrice").val(),
            price_hh: $("#productPriceHh").val(),
            category: $("#productType").val(),
        };

        myAjax('/bar/ajax', 'saveNewItem', data, (ret) => {

        });
    });


    // D I S C O U N T S
    let itemId;
    let itemName;
    // Modal apply discount
    $('.btnApplyDiscount').on('click', (e) => {
        itemId   = $(e.currentTarget).data('item');
        itemName = $('#item-name-' + itemId).text();
        $('.productName').text(itemName);
    });

    // Save apply discount
    $('#btn-apply-discount').click(() => {
        let newPrice = $('#reduction').val();
        let data = {
            item_id:   itemId,
            new_price: newPrice
        };
        myAjax('/bar/ajax', 'applyDiscount', data, (ret) => {

        });
    });


    // Save create discount
    $('#btn-create-discount').click(() => {
        let category = $('#categoryTypeSelect').val();
        let newPrice = $('#reduction-new-discount').val();
        let data = {
            category: category,
            new_price: newPrice
        };
        myAjax('/bar/ajax', 'createDiscount', data, (ret) => {

        });
    });


    // I T E M S  :  Modifier / Supprimer
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

                let newPrice = $('#newItemPrice-' + itemId).value;
                let data = {
                    item_id: itemId,
                    new_price: newPrice
                };
                myAjax('/bar/ajax', 'editItem', data, (ret) => {

                    itemPriceContainer.text(newPrice);

                    btn1.data('action', 'edit');
                    btn1.text('Modifier');

                    btn2.data('action', 'delete');
                    btn2.text('Supprimer');
                });
            }
        }

        // Supprimer / Annuler
        if ($(e.currentTarget).hasClass('js-btn-delete')) {

            if($(e.currentTarget).data('action') === 'delete') {

                let data = {
                    item_id: itemId
                };

                myAjax('/bar/ajax', 'deleteItem', data, (ret) => {
                    $(e.currentTarget).closest('li').attr('hidden', 'hidden');
                });

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
