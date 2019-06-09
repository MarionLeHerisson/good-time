$(document).ready(function () {
    $("#schedule").jqs({
        days: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"],
        hour: 24,
        data: [
            {
                day: 0,
                periods: [
                    ["20:00", "00:00"],
                ]
            }, {
                day: 3,
                periods: [
                    ["00:00", "08:30"],
                ]
            }
        ],
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
});

$("#export").click(function () {
    $("#result").val($("#schedule").jqs('export'));
});
