class @Game
  YOUTUBE_ID = 'HNYkOJ-T63k'
  _game = null
  _judge = null
  _timing = [6.14,7.486,8.155,9.977,10.377,11.611,12.062,13.583,14.223,15.059,16.241,17.425,20.186,21.593,22.313,23.123,24.297,25.113,26.148,27.294,28.103,30.910,31.601,32.305,33.024,34.054,35.360,36.140,37.028,38.402,39.129,40.354,41.051,42.233,43.043,44.261,45.705,46.448,47.416,48.407,50.158,51.310,52.363,53.031,54.417,55.288,56.472,57.190,58.110,59.095,60.776, 61.993, 62.370, 63.072, 64.493, 65.111, 66.414, 67.192, 68.891, 69.209, 70.056, 71.111, 72.861, 73.263, 74.639, 75.090, 75.941, 76.472, 76.992]
  _timingIndex = 0
  _status = "init"
  _endTime = 80

  constructor : (parms)->
    enchant()
    _game = new Core(800, 600)
    _game.fps = 60
    _game.preload("login_logo.png", "login_logo_gray.png", "Nexus.wav")
    _game.start()
    _game.onload = ->
      _game.rootScene.addEventListener "enterframe", (e)->
        if _status == "init" && $("#start").val()
          user_result = $('<div>')
          user_result.attr('id', $("#start").val())
          user_result.append('<h1 class="judge">')
          user_result.append('<h1><span class="combo">0</span>COMBO</h1>')
          user_result.append('<h1><span class="score">0</span>Pt</h1>')
          $('#user-results').append(user_result)
          _game.rootScene.addEventListener "enterframe", _proccesRootSceneFrame
          _status = "playing"
          _game.assets["Nexus.wav"].play()
      _game.rootScene.addEventListener "touchstart", (e)->
        if _status == "init"
          App.otoge.start()
          _game.rootScene.addEventListener "enterframe", _proccesRootSceneFrame
          _status = "playing"
          _game.assets["Nexus.wav"].play()
      _judge = new Label()
      _judge.font = "36px Arial"
      _judge.x = 100
      _judge.y = 100
      _game.rootScene.addChild(_judge)
      shadow = new Sprite(100, 40)
      shadow.image = _game.assets["login_logo_gray.png"]
      shadow.x = 100
      shadow.y = 380
      _game.rootScene.addChild(shadow)
      App.otoge.init()

  _isNoteGenerateTiming = ->
    if _timing[_timingIndex]?
      if _game.assets["Nexus.wav"].currentTime > _timing[_timingIndex] - 1
        return true
    return false
  _generateNote = (number)->
    note = new Sprite(100, 40)
    note.image = _game.assets["login_logo.png"]
    note.number = number
    note.x = 100
    note.y = -100
    note.timing = _timing[number]
    _game.rootScene.addChild(note)
    note.tl.setTimeBased()
    note.tl.moveY(380, (_timing[number] - _game.assets["Nexus.wav"].currentTime) * 1000)
    note.addEventListener "touchstart", (e) ->
      @clearTime = _game.assets["Nexus.wav"].currentTime
      @clear = true
    note.addEventListener "enterframe", ->
      console.log("currentTime", _game.assets["Nexus.wav"].currentTime)
      console.log("timing", _timing[@number])
      if _game.assets["Nexus.wav"].currentTime > _timing[@number] + 0.3
        _game.rootScene.removeChild(@)
        _judge.text = "BAD"
        App.otoge.judge(_judge.text)
      if @clear
        @opacity -= 0.2
        @scale(@scaleX + 0.05, @scaleY + 0.05)
        if @opacity <= 0
          _game.rootScene.removeChild(@)
          if -0.05 <= @clearTime - _timing[@number] <= 0.05 then _judge.text = "COOL"
          else if -0.2 <= @clearTime - _timing[@number] <= 0.2 then _judge.text = "GOOD"
          else _judge.text = "BAD"
          App.otoge.judge(_judge.text)
  _proccesRootSceneFrame = ->
    if _status is "playing"
      if _isNoteGenerateTiming()
        _generateNote(_timingIndex)
        _timingIndex++
      if _game.assets["Nexus.wav"].currentTime >= _endTime
        _game.assets["Nexus.wav"].volume = _game.assets["Nexus.wav"].volume - 1
        if _game.assets["Nexus.wav"].volume <= 0
          App.otoge.finish()
          _game.assets["Nexus.wav"].stop()
          _status = "end"

new Game()