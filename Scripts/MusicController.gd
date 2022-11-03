extends Node2D


var initiated = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func playMusic():
	if(initiated==false):
		$AudioStreamPlayer.play()
		initiated = true

