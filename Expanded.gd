extends "State.gd"

onready var audioPlayer = get_node("ExpandAudioPlayer")
onready var audioPlayer2 = get_node("../Retracted/RetractAudioPlayer")

var sprite_region = Rect2(64,0,96,32)
var collision_extents = Vector2(8,48)

func on_state_enter():
	audioPlayer.play()
	sprite.region_rect = sprite_region
	collisionShape.shape.extents = collision_extents

func on_state_exit():
	audioPlayer2.play()
	
func on_retract():
	player.set_state(state_basic)
