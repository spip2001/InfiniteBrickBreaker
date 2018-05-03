extends Node

onready var state_expanded = get_node("../Expanded")
onready var state_basic =  get_node("../Basic")
onready var state_retracted =  get_node("../Retracted")
onready var state_machineGun =  get_node("../MachineGun")

onready var player = get_node("..")
onready var sprite = player.get_node("Sprite")
onready var collisionShape = player.get_node("CollisionShape2D")

func update(delta):
	pass
	
func on_expand():
	pass
	
func on_retract():
	pass
	
func on_machine_gun():
	state_machineGun.previousState = self
	player.set_state(state_machineGun)
	
func on_state_enter():
	pass

func on_state_exit():
	pass