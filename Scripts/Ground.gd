extends StaticBody2D

onready var shakeCamera = get_tree().get_root().get_node("./Main scene/shakeCamera")

#temporary
func _on_Area2D_body_entered(body):
	if(body.name == 'Tortoise'):
		body.touchedGroundCount += 1
		body.jump()
		shakeCamera.add_trauma(0.8)
		body.changeSprite()
	
