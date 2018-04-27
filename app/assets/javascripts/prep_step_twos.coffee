# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@increaseInput =  (inputSelector) ->
  $(inputSelector).val (i, oldval) ->
    return ++oldval

@decreaseInput = (inputSelector) ->
  $(inputSelector).val (i, oldval) ->
    return --oldval


$ ->
  $(".step_two_selector").on 'click', "#increase-male", (e)->
    increaseInput('#male-count-input')

  $(".step_two_selector").on 'click', "#decrease-male", (e)->
    decreaseInput('#male-count-input')

  $(".step_two_selector").on 'click', "#increase-female", (e)->
    increaseInput('#female-count-input')

  $(".step_two_selector").on 'click', "#decrease-female", (e)->
    decreaseInput('#female-count-input')