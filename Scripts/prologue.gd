extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dialog_index = 0
var finished = true
var scene = 1
var lastSceneStart = false
var scenePhase = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$prologueMusic.play()
	startScenes()

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		$Enter.visible=false
		if(scene==9):
			set_process(false)
		startScenes()
		

func startScenes():
	if(finished==true && scene==1):
		makeVisible($Scene1, $Scene1/Bunny1, $Scene1/Label, ["' Momma always told me that i was a beautiful little bunny '"])
	if(finished==true && scene==2):
		$Scene1.visible = false
		makeVisible($Scene2, $Scene2/Bunny1, $Scene2/Label, ["' Cute fluffy absolutely adorable'"])
	if(finished==true && scene==3):
		$Scene2.visible = false
		makeVisible($Scene3, $Scene3/Bunny1, $Scene3/Label, ["' Unlike those slow green f*cks '"])
	if(finished==true && scene==4):
		$Scene3.visible = false
		makeVisible($Scene4, $Scene4/Bunny1, $Scene4/Label, ["' Clearly the race of rabbits is superior, we should rule the world, preach our ways ' "])
	if(finished==true && scene==5):
		$Scene4.visible = false
		makeVisible($Scene5, $Scene5/Bunny1, $Scene5/Label, ["The bunny got political, the tortoise had enough of this bullsh*t"])
	if(finished==true && scene==6):
		$Scene5.visible = false
		makeVisible($Scene6, $Scene6/Bunny1, $Scene6/Label, ["The rage in his eyes could be felt across all 9 realms"])
	if(finished==true && scene==7):
		$Scene6.visible = false
		makeVisible($Scene7, $Scene7/Bunny1, $Scene7/Label, ["'The bunnyKillInator will impale your children on spikes, behead your women and will bathe in your filthy blood'"])
	if(finished==true && scene==8):
		$Scene7.visible = false
		makeVisible($Scene8, $Scene8/Bunny1, $Scene8/Label, ["'The bunnyKillInator?'"])
	if(finished==true && scene==9):
		$Scene8.visible = false
		loadLastScene(1)
		$prologueMusic.stop()
		MusicController.playMusic()
		

func loadLastScene(phase):
	scenePhase = phase
	if(phase==1):
		$Scene9.visible = true
		$Scene9/Bunny1.visible = true
		$lastSceneTimer.start()
	if(phase == 2):
		$Scene9/spike.visible = true
		$shakeCamera.add_trauma(0.5)
		$lastSceneTimer.start()
	if(phase == 3):
		$Scene9/shell.visible = true
		$shakeCamera.add_trauma(0.5)
		$lastSceneTimer.start()
	if(phase == 4):
		$Scene9/mean.visible = true
		$shakeCamera.add_trauma(0.5)
		$lastSceneTimer.start()
	if(phase == 5):
		$Scene9/arms.visible = true
		$shakeCamera.add_trauma(0.5)
		$lastSceneTimer.start()
	if(phase == 6):
		$Scene9/Label.visible = true
		$shakeCamera.add_trauma(0.9)
		$lastSceneTimer.start()
	if(phase == 7):
		get_tree().change_scene("res://Scenes/Main scene.tscn")
	

func makeVisible(scene, sprite, label, message):
	finished=false
	scene.visible = true
	$Tween.interpolate_property(sprite, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	load_dialog(label,  message)
	$Tween.start()
	
func load_dialog(label, dialog):
	dialog_index = 0
	if dialog_index < dialog.size():
		label.bbcode_text = dialog[dialog_index]
		label.percent_visible = 0
		$TextTween.interpolate_property(
			label, "percent_visible", 0, 1, 1.5, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$TextTween.start()
	else:
		pass
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	pass


func _on_TextTween_tween_completed(object, key):
	finished = true
	scene+=1
	$Enter.visible = true
#	$Timer.start()



func _on_lastSceneTimer_timeout():
	loadLastScene(scenePhase+1)
