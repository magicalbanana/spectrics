App.active_users = App.cable.subscriptions.create "ActiveUsersChannel",
  # Called when the subscription is ready for use on the server
  connected: ->

  # Called when the subscription has been terminated by the server
  disconnected: ->

  # Called when there's incoming data on the websocket for this channel
  received: (data) ->
    if data.old_val && !data.new_val
      App.main_panels.remove_user(data.old_val)
    else if data.new_val
      App.main_panels.new_user(data.new_val)
