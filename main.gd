extends Node

signal test

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startGame()
	$Panel/PanelBlack/ButtonPlus10.pressed.connect(_on_button_pressed.bind(1))
	$Panel/PanelBlack/ButtonPlus1.pressed.connect(_on_button_pressed.bind(2))
	$Panel/PanelBlack/ButtonMinus1.pressed.connect(_on_button_pressed.bind(3))
	$Panel/PanelBlack/ButtonMinus10.pressed.connect(_on_button_pressed.bind(4))
	$Panel/PanelWhite/ButtonPlus10.pressed.connect(_on_button_pressed.bind(5))
	$Panel/PanelWhite/ButtonPlus1.pressed.connect(_on_button_pressed.bind(6))
	$Panel/PanelWhite/ButtonMinus1.pressed.connect(_on_button_pressed.bind(7))
	$Panel/PanelWhite/ButtonMinus10.pressed.connect(_on_button_pressed.bind(8))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func startGame():
	Global.turn = Global.turn_enum.Black
	Global.blackPoint = 70
	Global.whitePoint = 70
	for x in range(19):
		for y in range(19):
			Global.grid[x][y] = -1
	$Board.queue_redraw()

func turnChange():
	pass

func updateBoard():
	pass


func _on_button_plus_10_button_down() -> void:
	
	Global.blackUsePoint += 10
	if(Global.blackUsePoint > 90):
		Global.blackUsePoint = 90
	$Board.queue_redraw()

func _on_button_pressed(index):
	#print(str(index))
	match  index:
		1:
			Global.blackUsePoint += 10
		2:
			Global.blackUsePoint += 1
		3:
			Global.blackUsePoint -= 10
		4:
			Global.blackUsePoint -= 1
		5:
			Global.whiteUsePoint += 10
		6:
			Global.whiteUsePoint += 1
		7:
			Global.whiteUsePoint -= 10
		8:
			Global.whiteUsePoint -= 1
	
	if(Global.blackUsePoint < 10):Global.blackUsePoint = 10
	if(Global.blackUsePoint > 90):Global.blackUsePoint = 90
	if(Global.whiteUsePoint < 10):Global.whiteUsePoint = 10
	if(Global.whiteUsePoint > 90):Global.whiteUsePoint = 90
	
	if(Global.blackUsePoint > Global.blackPoint):Global.blackUsePoint = Global.blackPoint
	if(Global.whiteUsePoint > Global.whitePoint):Global.whiteUsePoint = Global.whitePoint
	
	$Board.queue_redraw()
