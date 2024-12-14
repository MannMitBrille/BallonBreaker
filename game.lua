local composer = require( "composer" )
local widget = require( "widget" )
math.randomseed(os.time())
 
local scene = composer.newScene()
 
function scene:create( event )
 
  local sceneGroup = self.view
  local params = event.params
    
    local PopSound = audio.loadStream("pop.mp3")
    
    local heart = display.newImage("Heart.png",35,600)
    heart:scale(0.3,0.3)
    local HPText = display.newText(hp,60,600,"JI.ttf",20)
    HPText:setFillColor(0,0,0)
    transition.to( heart, { time=2300, y=35, transition=easing.inOutBack } )
    
    transition.to( HPText, { time=2100, y=35, transition=easing.inOutBack } )
    
    local scoreText = display.newText(score,280,600,"JI.ttf",20)
    scoreText:setFillColor(0,0,0)
    
    transition.to( scoreText, { time=2100, y=35, transition=easing.inOutBack } )
    
    function BallonDead(event)
      if ("ended" == event.phase) then
        Ballon.y = 1000
        Ballon.x = math.random(20,290)
        score = score + 1
        scoreText.text = score
        audio.play(PopSound)
      end
    end
    
    Ballon = widget.newButton(
    {
      width = 70,
      height = 180,
      defaultFile = "ballon.png",
      onEvent = BallonDead
    })
Ballon.x = math.random(50,310)
Ballon.y = 600
    function onUpdate (event) 
      Ballon.y = Ballon.y - speed
        if Ballon.y < -400 then
        Ballon.y = 1000
        Ballon.x = math.random(10,310)
        hp = hp - 1
        HPText.text = hp
    end
    
    if score == 50 then
    speed = 15
    end

    if score == 100 then
    speed = 20
    end
  
    if score == 200 then
    speed = 25
    end
    
    if hp == 0 then
    speed = 0
    Ballon.y = 700
    
    local function listener( event )
    composer.gotoScene("gameover")
    end
   
   timer.performWithDelay( 1000, listener ) 
    end
  end
Runtime:addEventListener("enterFrame", onUpdate)
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
return scene