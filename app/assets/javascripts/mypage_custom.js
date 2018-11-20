document.addEventListener("turbolinks:load", function(){
    // datepicker用
    $('.js-date-picker').bootstrapMaterialDatePicker({
        format : 'YYYY/MM/DD HH:mm くらい',
        shortTime: true,
        minDate : new Date(),
        year: false,
        switchOnClick: true,
        lang: "ja"
    });
})
