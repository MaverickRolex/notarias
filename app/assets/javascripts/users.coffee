# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#users-index-content").on "click", "#hide-user-mobile", (e)->
    # hide user info on mobile
    $("#user-info").addClass("d-none")
    # show users list on mobile
    $("#users-list").removeClass("d-none")
