// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require_tree .
//= require service

$(document).ready(function () {

class dateTime {
  constructor (time) {
    this.time = time
  }
  formatTime(){
    var timeArray = this.time.split("-")
    var year = timeArray[0]
    var month = timeArray[1]
    var endString = timeArray[2]
    var day = endString.slice(0,2)
    var time = endString.slice(3,8)
    //debugger

    return (`${month} ${day} ${year} at ${time}`)
  }
}

  $("#getApptList").on("click", getApptList)
  function getApptList(){
    var sessionValue = $("#hdnSession").data('value');
    $.get(`/users/${sessionValue}.json`, function(data) {
      data["appointments"].forEach(function(thing){
          let now = new dateTime(thing["time"])
          let apptId = thing["id"]
          $("#appointmentTime").append(`<li>${now.formatTime()} <button id="getAppt" data-id="${apptId}" >View Appointment</button></li>`)
        })
    })
  }



  //implelent addEvetnListener on all the appointments

    $("#appointmentTime").on("click", "#getAppt",function() {
      console.log("hey")
      console.log(this.dataset.id)
      $.get(`/appointments/${this.dataset.id}.json`, function(data){
        let now = new dateTime(data["time"])
        let service = data["service"]["name"]
        let price = data["service"]["price"]
        $("#appointment").append(`<p>${now.formatTime()}, ${service}, $${price}</p>`)
        console.log(`${now.formatTime()}, ${service}, ${price}`)
      })
    })

    // $.get("/appointments.json", function(data){
    //   data.forEach(function(thing){
    //       let now = new dateTime(thing["time"])
    //       let apptId = thing["id"]
    //       $("#appointmentTime").append(`<li>${now.formatTime()} <button id="getAppt" data-id="${apptId}" >View Appointment</button></li>`)
    //
    //     })


  // getAppt)
  // function getAppt(){
  //   $.get(`/appointments/${id}.json`, function(data){
  //     console.log(data)
  //   })
  // }


});
