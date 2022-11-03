extends Control


# Declare member variables here. Examples:
# var a = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept") and visible==true):
		_on_Button_button_down()

func _on_Button_button_down():
	
	get_parent().cleanUp()
	get_tree().reload_current_scene()
	
	
