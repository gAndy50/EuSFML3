# EUSFML 3
This is a wrapper of SFML 3 for the openEuphoria programming language. The wrapper is based off of CSFML. 

# EXAMPLE
```euphoria
include std/ffi.e

include sfml_window.e
include sfml_graphics.e
include sfml_system.e

-- video mode
sequence mode = {{800,600},32}

-- create window
atom win = sfRenderWindow_create(
	mode,
	"SFML Bounce Test",
	sfClose,
	sfWindowed,
	NULL
)

if win = 0 then
	puts(1,"Failed to create window!\n")
	abort(0)
end if

-- load texture
atom tex = sfTexture_createFromFile("sfml_logo.png", NULL)

if tex = 0 then
	puts(1,"Failed to load texture!\n")
	abort(0)
end if

-- create sprite
atom sprite = sfSprite_create(tex)
--sfSprite_setTexture(sprite, tex, 1)

-- sprite position
sequence spritePos = {200, 200}
sfSprite_setPosition(sprite, spritePos)

-- sizes
sequence winSize = {800, 600}
sequence texSize = sfTexture_getSize(tex)

-- velocity (pixels per second)
sequence velocity = {200, 150}

-- clock for delta time
atom clock = sfClock_create()

-- event handling
atom evt = allocate_struct(sfEvent)
atom evt_type = 0

while sfRenderWindow_isOpen(win) do

	-- events
	while sfRenderWindow_pollEvent(win, evt) do
		evt_type = peek_type(evt, C_INT)

		if evt_type = sfEvtClosed then
			sfRenderWindow_close(win)
		end if

		if evt_type = sfEvtKeyPressed then
			if sfKeyboard_isKeyPressed(sfKeyEscape) then
				sfRenderWindow_close(win)
			end if
		end if
	end while

	-- delta time (seconds)
	atom dt = sfTime_asSeconds(sfClock_restart(clock))

	-- move sprite (time-based)
	spritePos[1] += velocity[1] * dt
	spritePos[2] += velocity[2] * dt
	
	if dt > 0.05 then
		dt = 0.05
	end if

	-- bounce left/right
	if spritePos[1] <= 0 then
		spritePos[1] = 0
		velocity[1] = -velocity[1]
	elsif spritePos[1] + texSize[1] >= winSize[1] then
		spritePos[1] = winSize[1] - texSize[1]
		velocity[1] = -velocity[1]
	end if

	-- bounce top/bottom
	if spritePos[2] <= 0 then
		spritePos[2] = 0
		velocity[2] = -velocity[2]
	elsif spritePos[2] + texSize[2] >= winSize[2] then
		spritePos[2] = winSize[2] - texSize[2]
		velocity[2] = -velocity[2]
	end if

	sfSprite_setPosition(sprite, spritePos)

	-- render
	sfRenderWindow_clear(win, {0,0,0,255})
	sfRenderWindow_drawSprite(win, sprite, NULL)
	sfRenderWindow_display(win)

end while

-- cleanup
sfClock_destroy(clock)
sfSprite_destroy(sprite)
sfTexture_destroy(tex)
sfRenderWindow_destroy(win)
```

# LICENSE
Copyright (c) <2026> Andy P.

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
