extends "State.gd"

var sprite_region = Rect2(0,0,64,32)
var collision_extents = Vector2(8,32)

func on_state_enter():
	sprite.region_rect = sprite_region
	collisionShape.shape.extents = collision_extents


func on_expand():
	player.set_state(state_expanded)
	
func on_retract():
	player.set_state(state_retracted)
