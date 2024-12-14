local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
 
function scene:create( event )
    local sceneGroup = self.view
    local params = event.params
    score = 45
    hp = 3
    speed = 7
    
    local background = display.newRect(0,100,900,1000)
    
    local BallonBreaker = display.newText("Ballon Breaker",160,400,"JI.ttf",38)
    BallonBreaker:setFillColor(0,0,0)
    
    local byMannMitBrille = display.newText("by MannMitBrille",160,400,"JI.ttf",23)
    byMannMitBrille:setFillColor(0,0,0)
    
    transition.to( BallonBreaker, { time=2300, y=10, transition=easing.inOutBack } )
    transition.to( byMannMitBrille, { time=2300, y=70, transition=easing.inOutBack } )
    
    local buttonSound = audio.loadStream("buttonSound.wav")
    
    local function handleButtonEvent( event )
      if ( "ended" == event.phase and PlayButtonFunction.y == 200 ) then
       transition.to( BallonBreaker, { time=2300, y=700, transition=easing.inOutCubic } )
       transition.to( byMannMitBrille, { time=2300, y=700, transition=easing.inOutCubic } )
       transition.to( LaggedButton, { time=2300, y=700, transition=easing.inOutCubic } )
       transition.to( PlayButtonFunction, { time=3000, y=700, transition=easing.inOutCubic} )
       transition.to( MusicButton, { time=2300, y=700, transition=easing.inOutExpo } )
       transition.to( MusicButton2, { time=2300, y=700, transition=easing.inOutExpo } )
       audio.play(buttonSound)
        
        local function listener( event )
          composer.gotoScene( "game")
        end
      timer.performWithDelay( 3000, listener )
    end
end
 
PlayButtonFunction = widget.newButton(
    {
      width = 150,
      height = 80,
      defaultFile = "PlayButton.png",
      overFile = "PlayButton2.png",
      onEvent = handleButtonEvent
    })

PlayButtonFunction.x = display.contentCenterX
PlayButtonFunction.y = 400

transition.to( PlayButtonFunction, { time=2500, y=200, transition=easing.inOutQuint  } )
MusicButton = display.newImage("MusicOn.png",250,50)
MusicButton2 = display.newImage("MusicOff.png",250,50)

MusicButton:scale(0.4, 0.4 )
MusicButton2:scale(0.4, 0.4 )

transition.to( MusicButton, { time=2300, y=370, transition=easing.inOutBack } )

MusicButton2.isVisible = false
MusicButton.id = "ball object"
MusicButton.x = display.contentCenterX

local backgroundMusic = audio.loadStream( "music.mp3", { channel=1, loops=-1} )
local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1} )
local buttonSound2 = audio.loadStream("buttonSound2.wav")

local function onObjectTouch( event )
    if ( event.phase == "began" and MusicButton.y == 370) then
      audio.play(buttonSound2)
      audio.pause( backgroundMusicChannel )
      MusicButton2.isVisible = true
      MusicButton2.y = MusicButton.y
      MusicButton2.x = display.contentCenterX
      MusicButton.y = 1000
      MusicButton.x = display.contentCenterX
    end
end
MusicButton2.id = "ball object"

local function onObjectTouch2( event )
    if ( event.phase == "began" and MusicButton2.y == 370) then
      audio.resume( backgroundMusicChannel )
      MusicButton.y = 370
      MusicButton2.isVisible = false
      audio.play(buttonSound2)
    end
end
  MusicButton:addEventListener( "touch", onObjectTouch )
  MusicButton2:addEventListener( "touch", onObjectTouch2 )
end
scene:addEventListener( "create", scene )
return scene


