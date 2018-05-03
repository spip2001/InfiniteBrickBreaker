extends "res://State.gd"

var sprite_region = Rect2(192,0,64,32)
var collision_extents = Vector2(8,32)
var shot_scene = preload("res://Shot.tscn")

onready var machineGunTimer = get_node("MachineGunTimer")
onready var shootAudioPlayer = get_node("ShootAudioPlayer")

var shootDelay = 0.2
var lastShot = 10
var previousState = null



func update(delta):
	lastShot += delta
	if Input.is_action_pressed("ui_accept") and lastShot > shootDelay:
		lastShot = 0
		shootAudioPlayer.play()
		
		# Tir de gauche
		var shot1 = shot_scene.instance()
		shot1.position.y = player.position.y
		shot1.position.x = player.position.x - 22
		get_node("../..").add_child(shot1)
		# Tir de droite
		var shot2 = shot_scene.instance()
		shot2.position.y = player.position.y
		shot2.position.x = player.position.x + 22
		get_node("../..").add_child(shot2)

func on_state_enter():
	machineGunTimer.start()
	sprite.region_rect = sprite_region
	collisionShape.shape.extents = collision_extents
	
func on_state_exit():
	machineGunTimer.stop()

func _on_MachineGunTimer_timeout():
	player.set_state(previousState)
