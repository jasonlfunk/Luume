function showMore(elm) {
  $(elm).siblings("span.more").show();
  $(elm).siblings("span.elipse").hide();
  $(elm).hide();
}

function showLess(elm) {
  $(elm).parent().hide();
  $(elm).parent().siblings("a.more").show();
  $(elm).parent().siblings("span.elipse").show();
}


//Set up inline editable task log
$(document).ready(function() {
  inputs = $("table.task-log > tbody > tr > td > input");
  inputs.keydown(function(ev) {
    //save current value so we can undo a key press 
    $(this).attr("_lv",$(this).val()); 
  });
  inputs.keyup(function(ev) {
    if(!$(this).val().match(/^([0-9]+)?\.?[0-9]?$/)) {
      $(this).val($(this).attr("_lv"))
    }
    $(this).attr("_dirty","1");
  });

  inputs.change(function() {
    //This function is being called twice, so
    //add a dirty flag  
    if($(this).attr("_dirty") == "0")
      return;
    
    if($(this).val().match(/^[0-9]+$/))
      $(this).val($(this).val()+".0");

    if($(this).val().match(/\.$/))
      $(this).val($(this).val()+"0");

    //clean up after ourselves
    $(this).attr("_lv",null); 
    $(this).attr("_dirty","0")

    var ct = $(this).closest("table")
    var project_id = ct.attr("project_id");
    var task_id = ct.attr("task_id");
    var cr = $(this).closest("tr")
    var log_id = cr.attr("log_id");
    var actual = cr.find("td > [for=actual]").val();
    var billable = cr.find("td > [for=billable]").val();

    var that = this;
    //save somehow
    $.post("/projects/"+project_id+"/tasks/"+task_id+"/log/"+log_id+".json",
      {
        _method: 'PUT',
        actual: actual,
        billable: billable
      }, function() {
        $(that).css("background","lightgreen");
        $(that).animate({backgroundColor: "white"},1000);
      },'json'
    );
    console.log("Should save!");
  });
});
