document.addEventListener("turbolinks:load", function(){
    // datepicker用
    $('.js-date-picker').bootstrapMaterialDatePicker({
        format : 'YYYY/MM/DD HH:mm くらい',
        shortTime: true,
        minDate : new Date(),
        year: false,
        switchOnClick: true,
        lang: "ja",
        cancelText: '戻る'
    });

    // 画像選択時にサムネイルを切り替える
    if (document.querySelector('#user_avatar') != undefined) {
        document.querySelector('#user_avatar').onchange = function(event) {
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
    }

    // 過去のもくもくからデータを引っ張ってくる時のモーダルの処理
    $('#js-selectFromPastMokumoku').on('click', function (e) {
        let id = document.querySelector('#selectFromPastMokumokuModal input[name="mokumoku"]:checked').value
        let title = $(document.querySelector('#selectFromPastMokumokuModal input[name="mokumoku"]:checked')).data("title")
        let body = $(document.querySelector('#selectFromPastMokumokuModal input[name="mokumoku"]:checked')).data("body")
        let area_id = $(document.querySelector('#selectFromPastMokumokuModal input[name="mokumoku"]:checked')).data("area_id")

        $("#mokumoku_title").val(title);
        $("#mokumoku_body").val(body);
        $("#mokumoku_area_id").val(area_id);
    });
    // モーダルを閉じる時に発火するイベント。キャンセルの時も動くので注意。
    $('#selectFromPastMokumokuModal').on('hidden.bs.modal', function (e) {
        // 何もしない
    })
})
