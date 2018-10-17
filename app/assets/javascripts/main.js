$(document).on('turbolinks:load', function(){
    var url = '/flats/'+ gon.id + '.json';
    $('#calendar').fullCalendar({
      height: 750,

      eventSources: [

      // your event source
      {
        url: url,
        color: 'red',     // an option!
        textColor: 'black' // an option!
      }

      // any other event sources...

      ]
      // put your options and callbacks here
    })
});

$(document).on('turbolinks:load', function(){
    $('.input-daterange input').datepicker({
      format: 'yyyy-mm-dd'
    });
});

$(document).on('change','.submit-on-change',function(){
  $("#filter_category").val($("#filter_cat").val());
  $("#filter_direction").val($("#filter_decriment").val());
  $(".search > form").submit();
});

$(document).on('change','.form-on-change',function(){

});
