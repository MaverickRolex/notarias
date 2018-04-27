# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#from-tree')
    .on 'changed.jstree', (e, data) ->
      window.from_segment = data.node.li_attr["segment-id"]
    .jstree
      "plugins" : [ "changed" ]

  $('#to-tree')
    .on 'changed.jstree', (e, data) ->
      window.to_segment = data.node.li_attr["segment-id"]
    .jstree
      "plugins" : [ "changed" ]

  $('#transfer-users-select').click (e)->
    e.preventDefault()
    if window.from_segment && window.to_segment
      window.location = $(e.currentTarget).attr("data-transfer-path").split("?")[0] + "?from_id=#{window.from_segment}&to_id=#{window.to_segment}"
    else if !window.from_segment
      $.notify("Por favor elija de donde transferir ususarios", { globalPosition: "top center" });
    else if !window.to_segment
      $.notify("Por favor elija hacia donde transferir ususarios", { globalPosition: "top center" });

  $(".user-transfer-list-item").click (e) ->
    e.preventDefault()
    $(e.currentTarget).toggleClass("active")

  $("#transfer-users-link").click (e) ->
    e.preventDefault()
    $.post $(e.currentTarget).attr("data-path"),
      { users_ids: $.map $(".user-transfer-list-item.active"), (val, i)-> $(val).attr("user-id") },
      ((a, b, c) ->
        console.log(a)
        console.log b
        console.log c
      ),
      "script"
      