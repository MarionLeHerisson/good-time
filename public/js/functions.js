$(document).ready(function () {
    handleMenu();
    handleMedias();
    handleReservations();
    handleSchedule();
    handleEvents();
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

        let target = $(e.currentTarget);
        let itemId = target.data('item');
        let btn1  = $('#edit-' + itemId);
        let btn2  = $('#delete-' + itemId);

        let itemPriceContainer = $('#item-price-' + itemId);
        let originalPrice = $('#item-original-price-' + itemId).text();

        // Modifier / Enregistrer
        if (target.hasClass('js-btn-edit')) {

            if(target.data('action') === 'edit') {

                itemPriceContainer.html('<input type="text" id="newItemPrice-' + itemId + '" placeholder="' + originalPrice + '">');

                btn1.data('action', 'save');
                btn1.text('Enregistrer');

                btn2.data('action', 'cancel');
                btn2.text('Annuler');
            }
            else if(target.data('action') === 'save') {

                let newPrice = $('#newItemPrice-' + itemId).val();
                let data = {
                    item_id: itemId,
                    new_price: newPrice
                };
                myAjax('/bar/ajax', 'editItem', data, (ret) => {

                    let funcRet = JSON.parse(ret);
                    itemPriceContainer.html('');
                    itemPriceContainer.text(funcRet.new_price + ' €');

                    btn1.data('action', 'edit');
                    btn1.text('Modifier');

                    btn2.data('action', 'delete');
                    btn2.text('Supprimer');
                });
            }
        }

        // Supprimer / Annuler
        if (target.hasClass('js-btn-delete')) {

            if(target.data('action') === 'delete') {

                let data = {
                    item_id: itemId
                };

                myAjax('/bar/ajax', 'deleteItem', data, (ret) => {
                    target.closest('li').attr('hidden', 'hidden');
                });

            }
            else if(target.data('action') === 'cancel') {

                itemPriceContainer.text(originalPrice);

                btn1.data('action', 'edit');
                btn1.text('Modifier');

                btn2.data('action', 'delete');
                btn2.text('Supprimer');
            }
        }
    });
}

function handleMedias() {
    $('.media-delete').on('click', function (e) {

        let imgId = $(e.currentTarget).data('id');
        let data  = {
            id: imgId
        };

        myAjax('/bar/ajax', 'deletePicture', data, function (ret) {
            $('[data-id="'+imgId+'"]').closest('.col-md-12').attr('hidden', 'hidden');
        });
    });
}

function handleReservations() {

    $('.btn-res-accept').on('click', function (e) {
        let target = $(e.currentTarget)
        let resaId = target.data('resa');
        let data = { 'resaId': resaId };

        myAjax('/bar/ajax', 'acceptReservation', data, function (ret) {

            let btnGroup = $('#buttons-'+resaId);
            btnGroup.find('.btn-res-accept').attr('hidden', 'hidden');
            btnGroup.find('.btn-danger').removeAttr('hidden');

            $('.list-reservations-accepted').append(target.closest('li'));

            let nbAcceptedPlacement = $('#nbResAccepted');
            let nbAccepted = parseInt(nbAcceptedPlacement.text());
            nbAcceptedPlacement.text(nbAccepted + 1);

            let otherNumberPlacement = $('.nav-badge.active').find('.badge');
            otherNumberPlacement.text(parseInt(otherNumberPlacement.text()) - 1);
        });
    });

    $('.btn-res-deny').on('click', function (e) {
        let target = $(e.currentTarget)
        let resaId = target.data('resa');
        let data = { 'resaId': resaId };

        myAjax('/bar/ajax', 'denyReservation', data, function (ret) {

            let btnGroup = $('#buttons-'+resaId);
            btnGroup.find('.btn-res-accept').removeAttr('hidden');
            btnGroup.find('.btn-danger').attr('hidden', 'hidden');

            $('.list-reservations-denied').append(target.closest('li'));

            let nbDeniedPlacement = $('#nbResDenied');
            let nbDenied = parseInt(nbDeniedPlacement.text());
            nbDeniedPlacement.text(nbDenied + 1);

            let otherNumberPlacement = $('.nav-badge.active').find('.badge');
            otherNumberPlacement.text(parseInt(otherNumberPlacement.text()) - 1);
        });
    });
}

function handleEvents() {
    let now = new Date();
    let year = now.getFullYear();
    let month = now.getMonth() + 1;
    let settings = {
        language: false,
        year: year,
        month: month,
        show_previous: true,
        show_next: true,
        cell_border: false,
        today: false,
        show_days: true,
        weekstartson: 1,
        nav_icon: false, // object: prev: string, next: string
        data: false,
        ajax: false, // object: url: string, modal: boolean,
        legend: false, // object array, [{type: string, label: string, classname: string}]
        action: false, // function
        action_nav: false // function
    };

    $("#demo").zabuto_calendar(settings);
}
