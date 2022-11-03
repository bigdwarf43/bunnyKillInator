extends Control



func _ready():
	pass # Replace with function body.

func updateScore(score):
	$Label.text = "Score: "+str(Globals.score)
	$AnimationPlayer.play("scaleLabel")
