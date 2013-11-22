-------------------------------------------------
--- ARTIFICIAL I
-------------------------------------------------

function size(array)
	return table.getn(array)
end

--Retorna una lista de coordenadas,en las cuales no hay jugada
function emptyTiles()
	result = {}
	
	for y = 0, #board do
        for x = 0, #board[0] do
        	if(canMarkIn(y, x)) then
        		result[size(result) + 1] = newPoint(y, x)
        	end
        end
    end
    	
	return result
end

--juega la inteligencia artificial,de forma aleatoria
function playIA()

    options = emptyTiles()
    
    print(size(options))
    
    math.randomseed( os.time() )
	i = math.random(1, size(options))
	
	tile = options[i]
	markIn(tile['y'], tile['x'], 2)  
	
end

