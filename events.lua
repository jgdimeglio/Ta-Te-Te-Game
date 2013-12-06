-------------------------------------------------
---     EVENTS
-------------------------------------------------

function isPressKey(evt)
	return (evt.class == 'key' and evt.type == 'press')
end

function areKeys(key1, key2, evt)
	return evt.key == key1 or evt.key == key2
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
		if(win(PLAYER1)) then
			print("GANASTE")
			showResult("¡GANASTE!")
			disableArrows()
		elseif empate() then
			print("EMPATE")
			showResult("  EMPATE")
			disableArrows()
			return
		else
			print("JUEGA IA")
			playIA()
			if(win(PLAYER2)) then
				print("PERDISTE!")
				showResult("¡PERDISTE!")
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

keyMapDisabled = {
	['ENTER'] = restartGame
}

function handler(evt)
	if isInfoKey(evt) then
		return
	end

	if isPressKey(evt)   then
		-- Ver si la funcion esta en el map
		if arrowsEnabled then
 			--pcall captura el error ,si no encuentra el evento
			pcall(function ()
				keyMapEnabled[evt.key]()
			end)
		else
			pcall(function ()
				keyMapDisabled[evt.key]()
			end)
		end
	end
end

event.register(handler)

