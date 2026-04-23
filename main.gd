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
	Global.turn = 0
	Global.blackPoint = 70
	Global.whitePoint = 70
	
	
	pass

func updateBoard():
	pass
