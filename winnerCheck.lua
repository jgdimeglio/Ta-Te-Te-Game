-------------------------------------------------
--- WINNERS CHECK
-------------------------------------------------

--Cheque para verificar si el player gano
function win(nroPlayer)
        return assertHorizontal(nroPlayer+10) or assertVertical(nroPlayer+10)
or assertDiagonal(nroPlayer+10)
end

--Cheque para verificar si el player empato
function empate()
	return size(emptyTiles()) == 0
end


--Chequea todas las posibles jugadas horizontales
function assertHorizontal(player)
    for y = 0, #board do
        asserts=true
        for x = 0, #board[0] do
	    --Es igual al player o al player seleccionado
            asserts= assertsPlayer(y,x,player)
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
			asserts= assertsPlayer(y,x,player)
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

--Chequea si el player jugo en la posicion y , x
function assertsPlayer(y,x,player)
	return	 asserts and ( board[y][x] == player or
board[y][x] == player+10)
end

