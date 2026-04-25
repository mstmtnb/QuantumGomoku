extends Node2D

const STONE_RADIUS = 14
const LINE_WIDTH = 3
const LINE_INTERVAL = 30
const BOARD_RECT = Rect2(30,30,600,600)
const BOARD_COLOR = Color8(222,160,71)

var font

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(19):
		var row = []
		for y in range(19):
			row.append(-1)
		Global.grid.append(row)
	Global.grid[5][5] == 100
	font = load("res://NotoSansJP-Bold.ttf")
	#print($"../ConfirmationDialog")
	#print($Main/Board)

func _input(event):
	if (event is InputEventMouseButton):
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if(Global.selectedGrid.x >= 0 && Global.selectedGrid.y >= 0):
				match Global.turn:
					Global.turn_enum.None:
						pass
					Global.turn_enum.Black:
						Global.grid[Global.selectedGrid.x][Global.selectedGrid.y] = Global.blackUsePoint
						Global.blackPoint -= Global.blackUsePoint
						Global.blackPoint += 70
						Global.blackUsePoint = 70
						$"../ConfirmationDialog".popup_centered()
						
					Global.turn_enum.White:
						Global.grid[Global.selectedGrid.x][Global.selectedGrid.y] = 100 - Global.whiteUsePoint
						Global.whitePoint -= Global.whiteUsePoint
						Global.whitePoint += 70
						Global.whiteUsePoint = 70
						$"../ConfirmationDialog".popup_centered()
	queue_redraw()
	
func confilm():
	for x in range(19):
		for y in range(19):
			if(1 <= Global.grid[x][y] && Global.grid[x][y] <= 99):
				var r = randi_range(1,100)
				if(Global.grid[x][y] < r):
					Global.grid[x][y] = 0
				else :
					Global.grid[x][y] = 100
	if(Global.turn == Global.turn_enum.Black):Global.turn = Global.turn_enum.White
	elif (Global.turn == Global.turn_enum.White):Global.turn = Global.turn_enum.Black
	queue_redraw()

func cancel():
	if(Global.turn == Global.turn_enum.Black):Global.turn = Global.turn_enum.White
	elif (Global.turn == Global.turn_enum.White):Global.turn = Global.turn_enum.Black
	queue_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mousePos = get_viewport().get_mouse_position()
	Global.selectedGrid = Vector2(-1,-1)
	for x in range(19):
		for y in range(19):
			if (BOARD_RECT.position.x + 30 + x * 30 - 15 <= mousePos.x and 
				mousePos.x <= BOARD_RECT.position.x + 30 + x * 30 + 15 and 
				BOARD_RECT.position.y + 30 + y * 30 - 15 <= mousePos.y and 
				mousePos.y <= BOARD_RECT.position.y + 30 + y * 30 + 15 and 
				Global.grid[x][y] == -1):
				Global.selectedGrid = Vector2(x,y)
				#print("%d:%d %d" % [x,y,grid[x][y]])
	queue_redraw()
	


func _draw() -> void:
	#碁盤盤面を描画
	draw_rect(BOARD_RECT,BOARD_COLOR,true,0,false)
	draw_rect(BOARD_RECT,Color.BLACK,false,1,false)
	
	#碁盤縦線を描画
	for n in 19:
		draw_line(Vector2(BOARD_RECT.position.x + 30 + n * LINE_INTERVAL,BOARD_RECT.position.y + 30),
				  Vector2(BOARD_RECT.position.x + 30 + n * LINE_INTERVAL,BOARD_RECT.position.y + BOARD_RECT.size.y - 30),
				  Color.BLACK)
	#碁盤横線を描画
	for n in 19:
		draw_line(Vector2(BOARD_RECT.position.x + 30,BOARD_RECT.position.y + 30 + n * LINE_INTERVAL),
				  Vector2(BOARD_RECT.position.x + BOARD_RECT.size.x - 30,BOARD_RECT.position.y + 30 + n * LINE_INTERVAL),
				  Color.BLACK)
	
	#石を描画
	for x in range(19):
		for y in range(19):
			#print("%d:%d %d" % [x,y,grid[x][y]])
			match  Global.grid[x][y]:
				-1:
					pass
				100:
					draw_circle(Vector2(BOARD_RECT.position.x + 30 +x * 30,BOARD_RECT.position.y + 30 + y * 30),
								STONE_RADIUS,Color.BLACK)
					pass
				0:
					draw_circle(Vector2(BOARD_RECT.position.x + 30 +x * 30,BOARD_RECT.position.y + 30 + y * 30),
								STONE_RADIUS,Color.WHITE)
					pass
				_:
					draw_circle(Vector2(BOARD_RECT.position.x + 30 +x * 30,BOARD_RECT.position.y + 30 + y * 30),
								STONE_RADIUS,Color.GRAY)
					draw_string(font, Vector2(BOARD_RECT.position.x + 22 +x * 30,BOARD_RECT.position.y + 36 + y * 30),
								 str(Global.grid[x][y]),HORIZONTAL_ALIGNMENT_LEFT, -1, 14,Color.BLUE)
					pass
	
	#マウス座標の石を描画
	if(Global.selectedGrid.x >= 0 and Global.selectedGrid.y >= 0):
		if(Global.turn == Global.turn_enum.Black):
			draw_circle(Vector2(BOARD_RECT.position.x + 30 + Global.selectedGrid.x * 30,BOARD_RECT.position.y + 30 + Global.selectedGrid.y * 30),
								STONE_RADIUS,Color(0,0,0,0.5))
		elif (Global.turn == Global.turn_enum.White):
			draw_circle(Vector2(BOARD_RECT.position.x + 30 + Global.selectedGrid.x * 30,BOARD_RECT.position.y + 30 + Global.selectedGrid.y * 30),
								STONE_RADIUS,Color(1,1,1,0.5))
	
	#ポイント描画を更新
	$"../Panel/PanelBlack/LabelPoint".text = str(Global.blackPoint)
	$"../Panel/PanelBlack/LabelUsePoint".text = str(Global.blackUsePoint)
	$"../Panel/PanelWhite/LabelPoint".text = str(Global.whitePoint)
	$"../Panel/PanelWhite/LabelUsePoint".text = str(Global.whiteUsePoint)
	
	#ターン表示
	if(Global.turn == Global.turn_enum.Black):
		$"../Panel/LabelTurn".text = "黒の手番です"
	if(Global.turn == Global.turn_enum.White):
		$"../Panel/LabelTurn".text = "白の手番です"
