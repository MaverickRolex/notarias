# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#@bindSelectUser = ->
#  # hide on mobile
#  
#
#  # select user
#  $("#users-list").on "click", ".users-list-row", (e) ->
#    e.preventDefault()
#    $.getScript "/users/#{$(e.currentTarget).attr("data-user-id")}/edit"







#@bindBatchActions = ->
#  $(".batch-action").click (e)->
#    e.preventDefault()
#    $(".users-list-row").removeClass("active")
#    startBatchAction()
#    if $(e.currentTarget).attr("data-flag") == 'delete'
#      startBatchAction()

@startBatchActions = ->
  #unbindSelectUser()
  $("#users-pool").selectable
    classes: 
      "ui-selected": "active"
    filter: " > .users-list-row"
    stop: (event, ui) ->
      if selectedUsersNodes().length == 1
        $(".batch-action-btn").addClass("d-none")
        $(".single-action-btn").removeClass("d-none")
        $.getScript "/users/#{selectedUsersIds()[0]}/edit"
      else if $(".users-list-row.ui-selected").length > 1
        $(".batch-action-btn").removeClass("d-none")
        $(".single-action-btn").addClass("d-none")
    unselected: (event, id) ->
      $("#batch-action-dropdown-btn").addClass("disabled")

  $(".batch-action-btn").click (e)->
    #e.preventDefault()
    if selectedUsersNodes().length
      $.post
        url: '/users_batch_action',
        data: { users_ids: selectedUsersIds(), batch_action: $(e.currentTarget).attr("data-action") },
        dataType: "script",
        beforeSend: setCSRFToken
          


@selectedUsersNodes = ->
  $(".users-list-row.ui-selected")

@selectedUsersIds = ->
  ids = []
  selectedUsersNodes().each (index)->
    ids.push $(this).attr('data-user-id')
  ids

@setCSRFToken = ( jqXHR, settings ) ->
  token = $('meta[name="csrf-token"]').attr('content')
  if token
    jqXHR.setRequestHeader('X-CSRF-Token', token)

#@unbindSelectUser = ->
#  $("#users-index-content").unbind("click")
#  $("#users-list").unbind("click")

$ ->
  $(document).on "click", "#hide-resource-mobile", (e) ->
    $(".resource-info").addClass("d-none");
    $(".resource-list").removeClass("d-none");

  startBatchActions()
  #bindBatchActions()