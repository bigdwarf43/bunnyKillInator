extends KinematicBody2D
var direction: = Vector2.ZERO
export var speed = Vector2(300.0,500.0);


var deadPart1 = preload("res://Scenes/tortoiseDead1.tscn")
var deadPart2 = preload("res://Scenes/tortoiseDead2.tscn")

var touchedGroundCount = 0

func _physics_process(delta: float) -> void:
	var gravity = 20000
	var velocity = Vector2.ZERO
	
	if(Input.is_action_just_pressed("down")):
		direction.y = 1.0
	
	direction.x = getDirectionX()
	velocity = calculateMovement(velocity,speed,gravity)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	checkDeath()
	

func checkDeath():
	if touchedGroundCount == 4:
		BreakSfx.playSfx()
		var deadInst1 = deadPart1.instance()
		var deadInst2 = deadPart2.instance()
		var root = get_tree().get_root()
		deadInst1.position = position
		deadInst2.position = position
		root.add_child(deadInst1)
		root.add_child(deadInst2)
		get_parent().tortoiseDead()
		queue_free()
#		get_tree().change_scene("res://Scenes/deathScreen.tscn")

func jump():
	direction.y = -1.0

func getDirectionX():
	return(
		Input.get_action_strength("move_right")- Input.get_action_strength("move_left")
	)

func getDirectionY():
	return (
		Input.get_action_strength("down")
	)


func calculateMovement(velocity,speed,gravity):
	var new_velocity = velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time() 
	
	if(direction.y == 1.0):
		new_velocity.y = speed.y * direction.y + speed.y*getDirectionY()
	if(direction.y == -1.0):
		new_velocity.y = speed.y * direction.y 
	return new_velocity

func notJump():
	direction.y = 1.0


func changeSprite():
	if(touchedGroundCount == 1):
		$Sprite.texture = load("res://Sprites/spike2.png")
	elif(touchedGroundCount == 2):
		$Sprite.texture = load("res://Sprites/spike3.png")
	elif(touchedGroundCount == 3):
		$Sprite.texture = load("res://Sprites/deadTortoise.png")
	BreakSfx.playSfx()
	
