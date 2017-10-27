App.ci_builds = App.cable.subscriptions.create "CiBuildsChannel",
  # Called when the subscription is ready for use on the server
  connected: ->

  # Called when the subscription has been terminated by the server
  disconnected: ->

  # Called when there's incoming data on the websocket for this channel
  received: (data) ->
    console.log(data)
    if data.new_val && !data.old_val
      label = @getMonthLabel(data.new_val)
      console.log(data.new_val + ' label:' + label)
      App.main_panels.add_build(data.new_val, label)

  getMonthLabel: (build) ->
    monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    seconds = Date.parse(build.stop_time) # e.g. stop_time == 2013-02-12T21:34:01Z
    date = new Date(seconds)
    monthNames[date.getMonth()]