extends Node2D

const STONE_RADIUS = 14
const LINE_WIDTH = 3
const LINE_INTERVAL = 30
const BOARD_RECT = Rect2(30,30,600,600)
const BOARD_COLOR = Color8(222,160,71)

#黒=0、白=100で石を表す。空白は-1
var grid: Array = []
var selectedGrid = Vector2(-1,-1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(19):
		var row = []
		for y in range(19):
			row.append(-1)
		grid.append(row)
	grid[4][4] = 100
	grid[4][5] = 0
	grid[4][6] = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mousePos = get_viewport().get_mouse_position()
	selectedGrid = Vector2(-1,-1)
	for x in range(19):
		for y in range(19):
			if (BOARD_RECT.position.x + 30 + x * 30 - 15 <= mousePos.x and 
				mousePos.x <= BOARD_RECT.position.x + 30 + x * 30 + 15 and 
				BOARD_RECT.position.y + 30 + y * 30 - 15 <= mousePos.y and 
				mousePos.y <= BOARD_RECT.position.y + 30 + y * 30 + 15 and 
				grid[x][y] == -1):
				selectedGrid = Vector2(x,y)
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
			match  grid[x][y]:
				-1:
					pass
				0:
					draw_circle(Vector2(BOARD_RECT.position.x + 30 +x * 30,BOARD_RECT.position.y + 30 + y * 30),
								STONE_RADIUS,Color.BLACK)
					pass
				100:
					draw_circle(Vector2(BOARD_RECT.position.x + 30 +x * 30,BOARD_RECT.position.y + 30 + y * 30),
								STONE_RADIUS,Color.WHITE)
					pass
				_:
					pass
	
	#マウス座標の石を描画
	if(selectedGrid.x >= 0 and selectedGrid.y >= 0):
		draw_circle(Vector2(BOARD_RECT.position.x + 30 + selectedGrid.x * 30,BOARD_RECT.position.y + 30 + selectedGrid.y * 30),
								STONE_RADIUS,Color.BLACK)
		pass
	
