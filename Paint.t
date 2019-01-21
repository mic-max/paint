View.Set ("graphics:1280;740,offscreenonly,nocursor,position:center,center,title:Paint : Alpha 0.1")

var tool : int := 2
var c : int := 255
var size : int := 5
const menusize : int := 20

const eraser := Pic.FileNew ("bmperaser.bmp")
const pencil := Pic.FileNew ("bmppencil.bmp")
const brush := Pic.FileNew ("bmpbrush.bmp")
const pen := Pic.FileNew ("bmppen.bmp")
const plus := Pic.FileNew ("bmpplus.bmp")
const minus := Pic.FileNew ("bmpminus.bmp")

var mousex, mousey, mouseb : int
var control : array char of boolean

procedure draw
    if mouseb = 1 then
	if tool = 0 then % Erase
	    Draw.FillBox (mousex, mousey, mousex + size, mousey + size, 0)
	elsif tool = 1 then % Pencil
	    Draw.Dot (mousex, mousey, c)
	elsif tool = 2 then % Brush
	    Draw.FillOval (mousex, mousey, size, size, c)
	elsif tool = 3 then % Caligraphy Brush 1
	    Draw.Line (mousex, mousey, mousex + size, mousey + size, c)
	end if
    end if
end draw

procedure change % dragging in and out of menu still changes tool
    for i : 0 .. 3
	if mousex > i * menusize and mousex < (i + 1) * menusize and mouseb = 1 then
	    tool := i
	end if
    end for
    for j : 5 .. 6
	if mousex > j * menusize and mousex < (j + 1) * menusize and mouseb = 1 then
	    if j = 5 and size < maxx then
		size += 1
	    elsif j = 6 and size > 1 then
		size -= 1
	    end if
	end if
    end for
    for k : 8 .. 15
	if mousex > k * menusize and mousex < (k + 1) * menusize and mouseb = 1 then
	    if k = 8 then
		c := 12
	    elsif k = 9 then
		c := 41
	    elsif k = 10 then
		c := 14
	    elsif k = 11 then
		c := 2
	    elsif k = 12 then
		c := 1
	    elsif k = 13 then
		c := 128
	    elsif k = 14 then
		c := 255
	    end if
	end if
    end for
end change

procedure input
    mousewhere (mousex, mousey, mouseb)
    Input.KeyDown (control)
    if mousey >= maxy - menusize then
	change
    else
	draw
    end if
end input

procedure graphics
    for i : 0 .. 15
	Draw.Line (0, maxy, maxx, maxy, 255)
	Draw.Line (0, maxy - menusize, 300, maxy - menusize, 255)
	Draw.Line (i * menusize, maxy - menusize, i * menusize, maxy, 255)
    end for
    Pic.Draw (eraser, 2, maxy - menusize + 2, 0)
    Pic.Draw (pencil, 22, maxy - menusize + 2, 0)
    Pic.Draw (brush, 42, maxy - menusize + 2, 0)
    Pic.Draw (pen, 62, maxy - menusize + 2, 0)
    Draw.FillBox (82, maxy - menusize + 2, 98, maxy - 2, c)
    Pic.Draw (plus, 102, maxy - menusize + 2, 0)
    Pic.Draw (minus, 122, maxy - menusize + 2, 0)
    Draw.FillBox (162, maxy - menusize + 2, 178, maxy - 2, 12)
    Draw.FillBox (182, maxy - menusize + 2, 198, maxy - 2, 41)
    Draw.FillBox (202, maxy - menusize + 2, 218, maxy - 2, 14)
    Draw.FillBox (222, maxy - menusize + 2, 238, maxy - 2, 2)
    Draw.FillBox (242, maxy - menusize + 2, 258, maxy - 2, 1)
    Draw.FillBox (262, maxy - menusize + 2, 278, maxy - 2, 128)
    Draw.FillBox (282, maxy - menusize + 2, 298, maxy - 2, 255)
    View.Update
end graphics

loop
    input
    graphics
end loop
