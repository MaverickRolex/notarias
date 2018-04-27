# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('#jstree-container')
    .on  'changed.jstree', (e, data) ->
      window.location.pathname = data.node.a_attr.href
    .jstree
      "plugins" : [ "changed" ]
