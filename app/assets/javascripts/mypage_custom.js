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

    // 画像選択時にサムネイルを切り替える
    document.querySelector('#user_avatar').onchange = changeEventHandler;
    function changeEventHandler(event) {
        var files = event.target.files;
        if(files.length == 0) return;
        var file = files[0];
        if(!file.type.match(/image/)) {
            alert("画像ファイルを選んでください");
            return;
        }
        var reader = new FileReader();
        reader.onload = (function(){
            return function(e) {
                var elem = document.querySelector('#js-user-avatar')
                elem.src = e.target.result;
            };
        })(file);
        reader.readAsDataURL(file);
    }
})
