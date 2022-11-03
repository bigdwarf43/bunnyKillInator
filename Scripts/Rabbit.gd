extends KinematicBody2D
var rng = RandomNumberGenerator.new()
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var speed = Vector2(400,0)
var gravity =20000;

func _ready():
	rng.randomize()
	direction = getDirection()

func _physics_process(delta: float) -> void:
	#1 in 40 chance that the rabbit will change its direction
	var random_number = rng.randi_range(1, 40)
	if(random_number==2):
		direction = getDirection()
		
	#for movement
	velocity = getVelocity(direction,speed,velocity)
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

	
func getVelocity(direction,speed,velocity):
	var new_velocity = velocity
	
	new_velocity = speed*direction
	return new_velocity
	
func getDirection():
	return(
		Vector2(rng.randf_range(-2,2),0)
	)

func _on_Area2D_body_entered(body: Node) -> void:
	if(body.name == 'Tortoise'):
		Globals.score += 1
		Globals.rabbitCount -= 1
		body.jump()
		get_parent().addParticles(position)
		queue_free()
