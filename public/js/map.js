let markers = [];
let map;

function initMap() {
    // Gives time to function to load, otherwise the map behinds just like a picture
    setTimeout(function(){

        map = new google.maps.Map(document.getElementById('barsMap'), {
            center: {lat: 48.856788, lng: 2.351077},
            zoom: 13
        });

        showAllBars();

    }, 2000);

}

function createMarker(latitude, longitude, message) {
    let marker = new google.maps.Marker({
        map: map,
        position: {lat: latitude, lng: longitude},
        title: message
    });

    markers.push(marker);

    let infowindow = new google.maps.InfoWindow({
        size: new google.maps.Size(150,50),
        content: marker.title
    });

    google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(marker.title);
        infowindow.open(map, this);
    });
}

function showAllBars() {

    let data = ['hiImEmpty'];

    myAjax('/map/ajax', 'getAllBars', data, (ret) => {
        let allBars  = JSON.parse(ret);

        for (let key in allBars) {
            let bar = allBars[key];
            createMarker(parseFloat(bar.lat), parseFloat(bar.lon), bar.name + '<br>' + bar.address + '<br>' + bar.phone);
        }
    });
}
