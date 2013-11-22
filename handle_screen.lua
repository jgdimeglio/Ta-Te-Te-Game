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

function restartGame()
	board = {
		[0] = newRow(20,10,10),
		[1] = newRow(10,10,10),
		[2] = newRow(10,10,10),
	}

	focus = newPoint(0,0)
	oldFocus = focus
	
	enableArrows()
	
	drawBoard()
end
