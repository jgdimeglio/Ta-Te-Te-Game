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


--Informacion
EMPTY = 10 
EMPTY_FOCUS = 20
 
PLAYER1 = 11 
PLAYER2 = 12 

PLAYER1_FOCUS = 21
PLAYER2_FOCUS = 22

EMPTY_BOARD = {
	[0] = newRow(EMPTY_FOCUS,EMPTY,EMPTY),
	[1] = newRow(EMPTY,EMPTY,EMPTY),
	[2] = newRow(EMPTY,EMPTY,EMPTY)
}

TILE_SIZE = 100


--Tablero del ta te ti
board = EMPTY_BOARD

focus = newPoint(0,0)
oldFocus = focus

--Chequea si puede marcar, puede ser que la marca ya este ocupada
function canMark()
	return board[focus['y']][focus['x']] == EMPTY_FOCUS
end

function canMarkIn(x, y)
	return board[x][y] == EMPTY_FOCUS or board[x][y] == EMPTY
end

function mark(nroPlayer)
	replaceTile(focus, nroPlayer)
end

function markIn(y, x, nroPlayer)
	replaceTile(newPoint(y, x), nroPlayer)
end


