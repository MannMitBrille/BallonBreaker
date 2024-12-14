local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
 
function scene:create( event )
    local sceneGroup = self.view
    local buttonSound = audio.loadStream("buttonSound.wav")
    
    local ScoreText = display.newText("Score:"..score,156,700,"JI.ttf",20)
    ScoreText:setFillColor(0,0,0)
    
    transition.to( ScoreText, { time=2300, y=200, transition=easing.inOutBack } )
    
    local function RestartEventButton( event )
      if ( "ended" == event.phase ) then
        audio.play(buttonSound)
        native.requestExit()
      end
    end
    
    RestartButton = widget.newButton(
    {
      width = 150,
      height = 80,
      defaultFile = "RestartButton.png",
      overFile = "RestartButton2.png",
      onEvent = RestartEventButton
    } )
  RestartButton.x = display.contentCenterX
  RestartButton.y = 600
 
  transition.to( RestartButton, { time=2300, y=300, transition=easing.inOutBack } )
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
return scene