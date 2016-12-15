class @Game
  _game = null
  _judge = null
  _timing = [
    6.443537414965988,
    7.494240362811794,
    8.655238095238097,
    9.195102040816327,
    9.769795918367347,
    10.942403628117916,
    12.039546485260772,
    13.165714285714287,
    13.717188208616783,
    14.303492063492065,
    15.45287981859411,
    16.004353741496598,
    16.54421768707483,
    17.124716553287985,
    17.711020408163268,
    18.262494331065763,
    18.82557823129252,
    19.951746031746037,
    20.53804988662132,
    21.101133786848077,
    21.675827664399097,
    21.908027210884352,
    22.256326530612245,
    22.801995464852606,
    23.38249433106576
  ]
  _timingIndex = 0
  _status = "init"
  _endTime = 30
  song = "donguri.wav"

  constructor : (parms)->
    enchant()
    _game = new Core(300, 600)
    _game.fps = 60
    _game.preload("login_logo.png", "login_logo_gray.png", song)
    _game.start()
    _game.onload = ->
      _game.rootScene.addEventListener "enterframe", (e)->
        if _status is "init" && $("#start").val()
          user_result = $('<div>')
          user_result.attr('id', $("#start").val())
          user_result.append('<h1><span class="combo">0</span>COMBO</h1>')
          user_result.append('<h1><span class="score">0</span>Pt</h1>')
          $('#user-results').append(user_result)
          _game.rootScene.addEventListener "enterframe", _proccesRootSceneFrame
          _status = "playing"
          _game.assets[song].play()
      _game.rootScene.addEventListener "touchstart", (e)->
#        console.log(_game.assets[song].currentTime)
        if _status is "init"
          App.otoge.start()
          _game.rootScene.addEventListener "enterframe", _proccesRootSceneFrame
          _status = "playing"
          _game.assets[song].play()
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
      if _game.assets[song].currentTime > _timing[_timingIndex] - 1
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
    note.tl.moveY(380, (_timing[number] - _game.assets[song].currentTime) * 1000)
    note.addEventListener "touchstart", (e) ->
      @clearTime = _game.assets[song].currentTime
      @clear = true
    note.addEventListener "enterframe", ->
      if _game.assets[song].currentTime > _timing[@number] + 0.3
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
      if _game.assets[song].currentTime >= _endTime
        _game.assets[song].volume = _game.assets[song].volume - 1
        if _game.assets[song].volume <= 0
          App.otoge.finish()
          _game.assets[song].stop()
          _status = "end"
new Game()