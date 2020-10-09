
// Project: Town Breaker: Smaug Attack 
// Created: 2020-06-13

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "Town Breaker: Smaug Attack" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

Type Player
	x as float
	y as float
	sprite as float
	speed as float
	lastMove as integer
	lastMoveTime as integer
	score as integer
EndType

Type Ball
	x as float
	y as float
	sprite as float
	speed as float
	moveX as float
	moveY as float
endType

Global ball as Ball
ball.sprite=2
LoadImage(ball.sprite,"ball.png")
CreateSprite(ball.sprite,ball.sprite)

Global player as Player
player.sprite = 10
LoadImage(player.sprite,"bat.png")
CreateSprite(player.sprite,player.sprite)
SetSpriteAngle(player.sprite,-90)

Global background = 3
LoadImage(background,"mordor-background.jpg")
CreateSprite(background,background)
SetSpriteDepth(background,100)
SetSpriteSize(background,1024,768)

Global TextScore = 1
CreateText(TextScore,"0")
SetTextPosition(TextScore,920,40)
SetTextSize(TextScore,80)

initPlayer()
initBall()

do
    batControl()
    moveBall()

    Print( ScreenFPS() )
    Sync()
loop

function initPlayer()
	player.speed = 8
	player.lastMove = 0
	player.score = 0
	player.x = 512
	player.y = 620
	SetSpritePosition(player.sprite,player.x,player.y)
endfunction

function initBall()
	
	ball.x=512
	ball.y=340
	SetSpritePosition(ball.sprite,ball.x,ball.y)
	ball.moveY=1
	ball.moveX=0
	ball.speed = 4
	
endfunction

function batControl()
	if GetRawKeyState(37) = 1 OR GetRawKeyState(65) = 1
		dec player.x,player.speed
		player.lastMove = -2
		player.lastMoveTime = GetMilliseconds()
	endif
	
	if GetRawKeyState(39) = 1 OR GetRawKeyState(68) = 1
		inc player.x,Player.speed
		player.lastMove = 2
		player.lastMoveTime = GetMilliseconds()
	endif
	
	if player.x < 40
		player.x = 40
	endif
	
	if player.x > 940
		player.x = 940
	endif

	SetSpritePosition(player.sprite,player.x,player.y)
	
	if GetMilliseconds()-player.lastMoveTime > 500
			player.lastMove = 0
	endif
	
	if GetSpriteCollision(player.sprite,ball.sprite) = 1
		ball.moveY = -ball.moveY
		if player.lastMove <> 0
			ball.moveX = player.lastMove
		endif
	endif
	
endfunction

function moveBall()
	
	ball.x = ball.x + ball.moveX * ball.speed
	ball.y = ball.y + ball.moveY * ball.speed
	
	SetSpritePosition(ball.sprite,ball.x,ball.y)
	
	
	if ball.y<8
		ball.moveY = -ball.moveY
	endif
	
	if ball.y>740
		initBall()
	endif
	
	if ball.x<8 or ball.x>990
		ball.moveX = -ball.moveX
	endif

endfunction
