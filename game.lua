-------------------------------------------------
---     GAME FUNCTIONS
-------------------------------------------------

--Funciones generales y variables para el juego


function newRow(zero, one, two)
	return {
		[0] = zero,
		[1] = one,
		[2] = two
	} 
end

--Retorna una nueva coordenada
function newPoint(y, x)
	return {
		['y'] = y,
		['x'] = x		
	}
end

board = {
	[0] = newRow(20,10,10),
	[1] = newRow(10,10,10),
	[2] = newRow(10,10,10),
}

focus = newPoint(0,0)
oldFocus = focus

tileSize = 100

--Dibuja un tile en la posicion y , x
function drawTile(y, x)
	drawImg(y * tileSize, x * tileSize, 'resources/'..board[y][x]..'.jpg')
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

function drawFocus()
	replaceTile(oldFocus, -10)
	replaceTile(focus, 10)
end

--Checuea si puede marcar,puede ser que la marca ya este ocupada

function canMark()
	return board[focus['y']][focus['x']] == 20
end

function canMarkIn(x, y)
	return board[x][y] == 20 or board[x][y] == 10
end

function mark(nroPlayer)
	replaceTile(focus, nroPlayer)
end

function markIn(y, x, nroPlayer)
	replaceTile(newPoint(y, x), nroPlayer)
end


