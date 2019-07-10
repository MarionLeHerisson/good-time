/****** GOOGLE ADDRESS API ******/

let placeSearch;
let autocomplete;

function initAutocomplete() {
    // Create the autocomplete object, restricting the search to geographical location types.
    if($('#address_form_completeAddress').val() != undefined) {
        console.log("yay babyyyy");
        autocomplete = new google.maps.places.Autocomplete(
            /** @type {!HTMLInputElement} */(document.getElementById('address_form_completeAddress')),
            {types: ['geocode']});
        autocomplete.addListener('place_changed', fillInAddress);
    } else console.log("oh nooooooo");
}

function fillInAddress() {
    console.log("fillInAddress");
    let place = undefined;
    // Get the place details from the autocomplete object.
    if(autocomplete != undefined) {
        place = autocomplete.getPlace();
    }

    // Get each component of the address from the place details
    // and fill the corresponding field on the form.

    console.log(place);
    if(place !== undefined) {
        $('#address_form_num').val(place.address_components[0].long_name);
        $('#address_form_street').val(place.address_components[1].long_name);
        $('#address_form_city').val(place.address_components[2].long_name);
        $('#address_form_postCode').val(place.address_components[6].long_name);
        $('#address_form_latitude').val(place.geometry.location.lat());
        $('#address_form_longitude').val(place.geometry.location.lng());
    }
}

// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var geolocation = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };
            var circle = new google.maps.Circle({
                center: geolocation,
                radius: position.coords.accuracy
            });
            autocomplete.setBounds(circle.getBounds());
        });
    }
}
