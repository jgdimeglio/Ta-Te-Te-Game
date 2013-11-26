-------------------------------------------------
--- DRAW
-------------------------------------------------

function showResult(result)

	canvas:attrColor('black')
	canvas:drawRect('fill', 60, 370, 300, 55 * 2)
	
	canvas:attrColor('white')
	canvas:attrFont('Tiresias', 20, 'bold')
	
	canvas:drawText(160, 395, result)
	
	canvas:drawText(90, 425, 'ENTER para volver a jugar')
	
	canvas:flush()
end

function showActions()
	
	actions = {
		'INFO para salir',
		'FLECHAS para mover',
		'ENTER para marcar'
	}
	
	baseX = 420
	baseY = 345
	interlining = 30
	
	canvas:attrColor('navy')
	
	canvas:drawRect('fill', baseX, baseY, 250, 50 * #actions)
	
	canvas:attrColor('white')
	canvas:attrFont('Tiresias', 20, 'bold')
	
	for i = 1, #actions do
		canvas:drawText(baseX+15, (baseY+30) + interlining * (i - 1), actions[i])
	end

	canvas:flush()
end

-- Mostrar imagen
function drawImg(y, x, src)
	local logo = canvas:new(src)
	canvas:compose(x, y, logo)
	canvas:flush()
end

-- Limpiar el canvas
function canvas_clean()
	canvas:attrColor(255, 0, 255, 0)
	canvas:clear()
	canvas:flush()
end


----------------------------------------------
----            GAME FUNCTIONS            ----
----------------------------------------------

--Dibuja un tile en la posicion y , x
function drawTile(y, x)
	drawImg(y * TILE_SIZE + 10, x * TILE_SIZE + 10, 'resources/'..board[y][x]..'.jpg')
end

--Dibuja el tablero
function drawBoard()
	for y = 0, #board do
		for x = 0, #(board[y]) do
			drawTile(y, x)
		end
	end	
end

function replaceTile(localFocus, corrimiento)
	x = localFocus['x']
	y = localFocus['y']
	
	board[y][x] = board[y][x] + corrimiento
	
	drawTile(y, x)
end

-- Mueve el focus de oldFocus a focus
function drawFocus()
	replaceTile(oldFocus, -EMPTY)
	replaceTile(focus, EMPTY)
end















