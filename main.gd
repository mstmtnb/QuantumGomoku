extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startGame()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func startGame():
	print("test")
	Global.turn = 0
	pass
