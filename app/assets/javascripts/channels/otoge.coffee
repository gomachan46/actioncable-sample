App.otoge = App.cable.subscriptions.create "OtogeChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log data

    # カオスになるの目に見えててワロリンactionとかでふりわけるのかな
    if data.init
      user_result = $('<div>')
      user_result.attr('id', data.init)
      user_result.append('<h1 class="judge">')
      user_result.append('<h1><span class="combo">0</span>COMBO</h1>')
      user_result.append('<h1><span class="score">0</span>Pt</h1>')
      $('#user-results').append(user_result)
    if data.result
      console.log data.result.uuid
      $('#' + data.result.uuid).find('.judge').text(data.result.judge)
      if data.result.continuous_combo
        $('#' + data.result.uuid).find('.combo').text(String(Number($('#' + data.result.uuid).find('.combo').text()) + 1))
      else
        $('#' + data.result.uuid).find('.combo').text("0")
      $('#' + data.result.uuid).find('.score').text(String(Number($('#' + data.result.uuid).find('.score').text()) + Number(data.result.score)))
    if data.start
      $('#start').val(data.start)
    if data.finish
      $('#finish').text(data.finish.result)

  init: ->
    @perform 'init'

  judge: (judge) ->
    @perform 'judge', judge: judge

  start: ->
    @perform 'start'

  finish: ->
    @perform 'finish', my_score: Number($('.score:first').text()), rival_score: Number($('.score:last').text())
