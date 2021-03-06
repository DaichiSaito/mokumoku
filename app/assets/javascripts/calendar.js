document.addEventListener("turbolinks:load", function(){
    $('#calendar').empty();
    $('#calendar').fullCalendar({
        locale: "ja",
        eventLimit: true, // allow "more" link when too many events
        eventLimitClick:'popover',
        events: function(start, end, timezone, callback) {
            $.ajax({
                url: '/mypage/dashboards/schedule',
                dataType: 'json',
                data: {
                    // our hypothetical feed requires UNIX timestamps
                    start: start.unix(),
                    end: end.unix(),
                }
            })
                .done((data, textStatus, jqXHR) => {
                    var events = [];
                    data.events.forEach(function(event) {
                        events.push({
                            title: event.title,
                            start: event.start, // will be parsed
                            url: event.url,
                        })
                    })
                    callback(events);
                })
                .fail((jqXHR, textStatus, errorThrown) => {
                    alert('エラーです。\nページを再読み込みしても解消されない場合はお問い合わせください。')
                })
                .always(() => {

                });
        }
    });
});
