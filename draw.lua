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




















