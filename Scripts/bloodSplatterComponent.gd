extends Node2D


export var bloodParticleScene: PackedScene
export var particleNum = 15
export var randomVelocity = 500.0

var bloodParticlesToMake

const bloodSpaltterSignalName = "onDeath" 

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	for parentSignal in get_parent().get_signal_list():
		if(parentSignal["name"] == bloodSpaltterSignalName):
			get_parent().connect(bloodSpaltterSignalName, self, "on_parent_death")
	rng.randomize()
	

	
func on_parent_death():
	splatter()

func splatter(particles_to_spawn:= -1):
	if(particles_to_spawn <= 0):
		particles_to_spawn = particleNum
	print("particle")
	var spawnedParticle: RigidBody2D
	
	for i in range(particles_to_spawn):
		spawnedParticle = bloodParticleScene.instance()
		
		get_tree().root.add_child(spawnedParticle)
		
		spawnedParticle.global_position = global_position
		spawnedParticle.linear_velocity = Vector2(rng.randf_range(-randomVelocity, randomVelocity), rng.randf_range(-randomVelocity, randomVelocity))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
