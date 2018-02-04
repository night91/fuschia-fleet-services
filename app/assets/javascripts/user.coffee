# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#profile-nabvar a').on "click", (event) ->
    event.preventDefault()
    id = $(this).attr("href")
    $('#user-profile > div').addClass('hidden')
    $(id).removeClass('hidden')


