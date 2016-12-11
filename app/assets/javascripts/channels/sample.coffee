App.sample = App.cable.subscriptions.create "SampleChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log data
    hoge_point = $('<div>')
    hoge_point.css('position', 'absolute')
    hoge_point.css('top', data.sample.position.y)
    hoge_point.css('left', data.sample.position.x)
    hoge_point.css('width', '10px')
    hoge_point.css('height', '10px')
    hoge_point.css('background', '#f00')
    $('body').append hoge_point

  hoge: (position) ->
    @perform 'hoge', position: position
