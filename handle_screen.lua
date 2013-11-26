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
	canvas_clean()

	board = {
		[0] = newRow(EMPTY_FOCUS,EMPTY,EMPTY),
		[1] = newRow(EMPTY,EMPTY,EMPTY),
		[2] = newRow(EMPTY,EMPTY,EMPTY)
	}

	focus = newPoint(0,0)
	oldFocus = focus
	
	enableArrows()
	
	drawBoard()
	
	showActions()
end
