-------------------------------------------------
--- DRAW
-------------------------------------------------

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

function showResult(result)
		
	canvas:attrColor('black')
	canvas:drawRect('fill', 80, 440, 200, 30 * 2)
	
	canvas:attrColor('white')
	canvas:attrFont('Tiresias', 15, 'bold')
	
	canvas:drawText(140, 445, result)
	
	canvas:drawText(90, 475, 'ENTER para volver a jugar')
	
	canvas:flush()
end

function showActions()
	
	baseX = 420
	baseY = 345
	interlining = 30
	
	actions = {
		'INFO para salir',
		'FLECHAS para mover',
		'ENTER para marcar'
	}
	
	canvas:attrColor('black')
	canvas:attrColor(255, 0, 255, 0)
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




















