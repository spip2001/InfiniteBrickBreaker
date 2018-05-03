extends KinematicBody2D

export (float) var maxSpeed = 250
export (float) var acceleration = 1000
export (float) var friction = 0.9

var motion = Vector2()
var origin_y = 0
var started = false

onready var bonus_scene = preload("res://Bonus.tscn").instance()
onready var game = get_node("..")

var current_state = null

func _ready():
	origin_y = position.y
	set_state(get_node("Basic"))
	
func set_state(newState) :
	if current_state != null:
		current_state.on_state_exit()
	current_state = newState
	current_state.on_state_enter()

func _physics_process(delta):
	
	if started:
		if Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - (acceleration * delta), -maxSpeed)
		elif Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + (acceleration * delta), maxSpeed)
		else :
			motion.x *= 1 - friction
		
		motion = move_and_slide(motion)
		position.y = origin_y
		
		current_state.update(delta)
	
func on_bonus(b):
	match b.type:
		bonus_scene.TypeBonus.Expand:
			current_state.on_expand()
		bonus_scene.TypeBonus.Retract:
			current_state.on_retract()
		bonus_scene.TypeBonus.MachineGun:
			current_state.on_machine_gun()
		bonus_scene.TypeBonus.Up:
			game.deleteFirstRow()


func _on_StartTimer_timeout():
	started = true
