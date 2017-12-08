$(document).ready(function(){
    thisTime = new Date();
    hours = thisTime.getHours();
    minutes = thisTime.getMinutes();
    seconds = thisTime.getSeconds();
    if (hours>12) {
        hours-=12
    }
    if(hours < 10)
        hours = '0'+hours;
    if(minutes < 10)
        minutes = '0'+minutes;
    if(seconds < 10)
        seconds = '0'+seconds;
    $('#clock-div').jsclock(hours+':'+ minutes+':'+seconds);
});