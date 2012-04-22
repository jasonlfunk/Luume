/* 
 This file was generated by Dashcode.  
 You may edit this file to customize your widget or web page 
 according to the license.txt file included in the project.
 */

var url = "http://www.luume.com/";
//var url = "http://0.0.0.0:3000/";
var cookie = "";

// Function: load()
// Called by HTML body element's onload event when the widget is ready to start
//
function load()
{
    dashcode.setupParts();
    $.ajaxSetup({
        crossDomain: true,
    });
    setupScreen();
    window.setInterval("setupScreen(true)",10000);
}

function setupScreen(poll) {
    console.log("setupScreen()");
    var status = handleResponse(getUserStatus())
    if(status) {
        if(status.status == null) {
            if(poll) {
                setupScreen();
                return;
            }
            var d = $("<div id='start-timer'><b>Select a task:</b><br/></div>");
            var sel = $("<select id='tasks'>");
            sel.append("<option value=''>---</option>");
            var projects = handleResponse(getProjects());
            if(projects) {
                for(k=0;k<projects.length;k++) {
                    var og = $("<optgroup value='"+projects[k]['id']+"' label='"+projects[k]['name']+"'/>");
                    var tasks = handleResponse(getProjectTasks(projects[k]['id']));
                    if(tasks) {
                        for(x=0;x<tasks.length;x++) {
                            og.append("<option value='"+tasks[x]['id']+"'>"+tasks[x]['name']+"</option>");
                        }
                    }
                    sel.append(og);
                }
            }
            d.append(sel);
            d.append("<br/><input type='button' value='Start Timer' onclick='startTimer();'/>");
            $("#front-content").html(d);
        }else{
            var d = $("<div id='stop-timer'></div>");
            d.append("<b>Currently Running:</b>"+status.status.name+" ("+status.timer+")"+"<br/>");
            d.append("<input type='button' value='Stop Timer' onclick='stopTimer("+status.status.project_id+","+status.status.id+");'/>");
            $("#front-content").html(d);
        }
    }
}

function stopTimer(project_id,task_id) {
    var res = handleResponse(stopTaskTimer(project_id,task_id));
    setupScreen();
}

function startTimer() {
    var opt = $("#tasks option:selected");
    var task_id = opt.attr("value");
    if(task_id == '') return;
    var project_id = opt.parent().attr("value");
    var res = handleResponse(startTaskTimer(project_id,task_id));
    setupScreen();
}



function handleResponse(res) {
    if(res.status == 200) {
        return $.parseJSON(res.responseText);
    } else if(res.status == 403) {
        doLogin();
        return null;
    } else if(res.status == 500) {
        showError("Sorry, an error occurred.");
        return null;
    } else {
        showError("Something went wrong ("+res.status+")");
        return null;
    }
}

function doLogin() {
    var username = widget.preferenceForKey("username");
    var password = widget.preferenceForKey("password");
    if(!(username && password)) {
        showBack();
    } else {
        login(username,password);
    }
}

//
// Function: remove()
// Called when the widget has been removed from the Dashboard
//
function remove()
{
    // Stop any timers to prevent CPU usage
    // Remove any preferences as needed
    // widget.setPreferenceForKey(null, dashcode.createInstancePreferenceKey("your-key"));
}

//
// Function: hide()
// Called when the widget has been hidden
//
function hide()
{
    // Stop any timers to prevent CPU usage
}

//
// Function: show()
// Called when the widget has been shown
//
function show()
{
    // Restart any timers that were stopped on hide
}

//
// Function: sync()
// Called when the widget has been synchronized with .Mac
//
function sync()
{
    // Retrieve any preference values that you need to be synchronized here
    // Use this for an instance key's value:
    // instancePreferenceValue = widget.preferenceForKey(null, dashcode.createInstancePreferenceKey("your-key"));
    //
    // Or this for global key's value:
    // globalPreferenceValue = widget.preferenceForKey(null, "your-key");
}

//
// Function: showBack(event)
// Called when the info button is clicked to show the back of the widget
//
// event: onClick event from the info button
//
function showBack(event)
{
    var front = document.getElementById("front");
    var back = document.getElementById("back");

    if (window.widget) {
        widget.prepareForTransition("ToBack");
    }

    front.style.display = "none";
    back.style.display = "block";

    if (window.widget) {
        setTimeout('widget.performTransition();', 0);
    }
    var username = widget.preferenceForKey("username");
    var password = widget.preferenceForKey("password");
    $("#inpEmail").val(username);
    $("#inpPassword").val(password);
}

//
// Function: showFront(event)
// Called when the done button is clicked from the back of the widget
//
// event: onClick event from the done button
//
function showFront(event)
{
    widget.setPreferenceForKey($("#inpEmail").val(),"username");
    widget.setPreferenceForKey($("#inpPassword").val(),"password");
    var front = document.getElementById("front");
    var back = document.getElementById("back");

    if (window.widget) {
        widget.prepareForTransition("ToFront");
    }

    front.style.display="block";
    back.style.display="none";

    if (window.widget) {
        setTimeout('widget.performTransition();', 0);
    }
    setupScreen();
}

if (window.widget) {
    widget.onremove = remove;
    widget.onhide = hide;
    widget.onshow = show;
    widget.onsync = sync;
}


function login(e,p) {
    $.ajax({
        url: url + "sessions.json",
        type: "POST",
        data: {
            login: e,
            password: p
        },
        complete: function(res,stat) {
            if(res.status == 200) {
                cookie = res.getResponseHeader("Set-Cookie");
                $.ajaxSetup({
                    headers: {
                        Cookie: cookie
                    }
                });
                setupScreen();
            } else if(res.status == 403) {
                showError("Invalid Username or Password");
            } else if(res.status == 500) {
               showError("Sorry, an error occurred.");
            }
        },
        dataType: 'json',
        xhrFields: {
            withCredentials: true
        }
    });
}

function startTaskTimer(project_id,task_id) {
    return $.ajax({
        url: url + "projects/"+project_id+"/tasks/"+task_id+"/start.json",
        type: "GET",
        async: false,
        dataType: 'json',
        xhrFields: {
            withCredentials: true
        }
    });

}
function stopTaskTimer(project_id,task_id) {
    return $.ajax({
        url: url + "projects/"+project_id+"/tasks/"+task_id+"/stop.json",
        type: "GET",
        async: false,
        dataType: 'json',
        xhrFields: {
            withCredentials: true
        }
    });

}

function getUserStatus() {
 return $.ajax({
        url: url + "users/status.json",
        type: "GET",
        async: false,
        dataType: 'json',
        xhrFields: {
            withCredentials: true
        }
    });
}

function getProjects() {
    return $.ajax({
        url: url + "projects.json",
        type: "GET",
        async: false,
        dataType: 'json',
        xhrFields: {
            withCredentials: true
        }
    });
}
function getProjectTasks(id) {
    return $.ajax({
        url: url + "projects/"+id+"/tasks.json",
        type: "GET",
        async: false,
        dataType: 'json',
        xhrFields: {
            withCredentials: true
        }
    });
}

function showError(msg) {
    $("div.error").remove();
    var err = $("<div class='error' style='display: none;'><div class='close'>X</div>"+msg+"</div>");
    $("#front").prepend(err);
    err.fadeIn();
    err.children("div.close").click(function() {
        $(this).parent().remove();
    });
}
