
showing = false

-- Aviso que hay info en la pantalla principal
function showInfo()
	canvas_clean()
	
	canvas:attrColor('black')
	canvas:drawRect('fill', 500, 40, 100, 30)
	
	canvas:attrColor('white')
	canvas:attrFont('Tiresias', 15, 'bold')
	
	canvas:drawText(510, 45, '>> INFO <<')
	
	canvas:flush()
end

-- Mostrar imagen
-- drawImg(550, 0, 'resources/logo.jpg')
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


-------------------------------------------------
---     GAME
-------------------------------------------------

function newRow(zero, one, two)
	return {
		[0] = zero,
		[1] = one,
		[2] = two
	} 
end

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

function drawTile(y, x)
	drawImg(y * tileSize, x * tileSize, 'resources/'..board[y][x]..'.jpg')
end

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

function win(nroPlayer)
        return assertHorizontal(nroPlayer+10) or assertVertical(nroPlayer+10)
or assertDiagonal(nroPlayer+10)
end

function empate()
	return size(emptyTiles()) == 0
end

-------------------------------------------------
---     ArtificialI
-------------------------------------------------

function size(array)
	return table.getn(array)
end

function emptyTiles()
	result = {}
	
	for y = 0, #board do
        for x = 0, #board[0] do
        	if(canMarkIn(y, x)) then
        	    print(size(result))
        		result[size(result) + 1] = newPoint(y, x)
        	end
        end
    end
    	
	return result
end

function playIA()

    options = emptyTiles()
    
    print(size(options))
    
    math.randomseed( os.time() )
	i = math.random(1, size(options))
	
	tile = options[i]
	markIn(tile['y'], tile['x'], 2)  
	
end

-------------------------------------------------
--- HANDLE SCREENs
-------------------------------------------------

arrowsEnabled = true

function disableArrows()
	arrowsEnabled = false
end

function enableArrows()
	arrowsEnabled = true
end


-------------------------------------------------
--- WINNERS CHECK
-------------------------------------------------

--Chequea todas las posibles jugadas horizontales
function assertHorizontal(player)
    for y = 0, #board do
        asserts=true
        for x = 0, #board[0] do
	    --Es igual al player o al player seleccionado
            asserts= asserts and ( board[y][x] == player or
board[y][x] == player+10)
        end
	--Si completo una fila ya gano
        if asserts then
            return true
        end
    end
    return false
end


function assertVertical(player)
    for x = 0, #board[0] do
        asserts=true
		for y = 0, #board do
			--Es igual al player o al player seleccionado
			asserts= asserts and ( board[y][x] == player or
				board[y][x] == player+10)
		end
	--Si completo una columna ya gano
        if asserts then
            return true
        end
    end
    return false
end

function assertDiagonal(player)
    --Posibles diagonales
    posibles = {
        [0] = newRow(0,1,2),
        [1] = newRow(2,1,0)
    }
    for y = 0, #posibles do
        asserts=true
        for x = 0, #board do
			asserts= asserts and ( board[x][posibles[y][x]] ==
			player or board[x][posibles[y][x]] == player+10)
		end
	--Si completo una diagonal
        if asserts then
            return true
        end
    end
    return false
end

-------------------------------------------------
---     EVENTS
-------------------------------------------------
function isPressKey(evt)
	return (evt.class == 'key' and evt.type == 'press')
end

function areKeys(key1, key2, evt)
	return evt.key == key1 or evt.key == key2
end

function isRedKey(evt)
	return areKeys("F1", "RED", evt)
end

function isGreenKey(evt)
	return areKeys("F2", "GREEN", evt)
end

function isInfoKey(evt)
	return areKeys("F6", "INFO", evt)
end

function moveFocus(eje, corrimiento)
	oldFocus = newPoint(focus['y'], focus['x'])
	
	focus[eje] = (focus[eje] + corrimiento) % 3
	
	drawFocus()
end

function onKeyUp()
	moveFocus('y', -1)
end

function onKeyDown()
	moveFocus('y', 1)
end

function onKeyLeft()
	moveFocus('x', -1)
end

function onKeyRight()
	moveFocus('x', 1)
end

function onKeyEnter()
	if(canMark()) then
		print("MARKED")
		mark(1)
		
		--Ver si gano
		if(win(1)) then
			print("GANASTE")
			disableArrows()
		elseif empate() then
			print("EMPATE")
			disableArrows()
			return
		else
			print("JUEGA IA")
			playIA()
			if(win(2)) then
				print("PERDISTE!")
				disableArrows()
			end
		end
		
	else
		print("OCUPADO")
	end
end

keyMapEnabled = {
	['CURSOR_UP'] = onKeyUp,
	['CURSOR_DOWN'] = onKeyDown,
	['CURSOR_LEFT'] = onKeyLeft,
	['CURSOR_RIGHT'] = onKeyRight,
	['ENTER'] = onKeyEnter
}

function dummy()
end

keyMapDisabled = {
	['CURSOR_UP'] = dummy,
	['CURSOR_DOWN'] = dummy,
	['CURSOR_LEFT'] = dummy,
	['CURSOR_RIGHT'] = dummy,
	['ENTER'] = dummy
}

function handler(evt)

	if isPressKey(evt) then
		-- Ver si la funcion esta en el map
		if arrowsEnabled then
			keyMapEnabled[evt.key]()
		else
			keyMapDisabled[evt.key]()
		end
	end
end


event.register(handler)

-- showInfo()

drawBoard()






