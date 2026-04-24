extends Node

signal test

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startGame()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/Panel/Label3.text = str(Global.blackPoint)
	pass
	
func startGame():
	print("test")
	Global.turn = Global.turn_enum.Black
	Global.blackPoint = 70
	Global.whitePoint = 70
	for x in range(19):
		for y in range(19):
			Global.grid[x][y] = -1
	
	pass

func updateBoard():
	pass
