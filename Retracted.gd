extends "res://State.gd"

onready var audioPlayer = get_node("RetractAudioPlayer")
onready var audioPlayer2 = get_node("../Expanded/ExpandAudioPlayer")

var sprite_region = Rect2(160,0,32,32)
var collision_extents = Vector2(8,16)

func on_state_enter():
	audioPlayer.play()
	sprite.region_rect = sprite_region
	collisionShape.shape.extents = collision_extents
	
func on_expand():
	player.set_state(state_basic)
	
func on_state_exit():
	audioPlayer2.play()
	