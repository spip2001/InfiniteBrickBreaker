extends Area2D

signal bonus(b)

enum TypeBonus {MachineGun, Expand, Up, Retract}

var type = 0
var speed = 100

func _ready():
	var player = get_node("../Player")
	type = randi() %  TypeBonus.size()
	get_node("Sprite_" + str(type)).visible = true
	self.connect("body_entered", self, "on_body_entered")
	self.connect("bonus", player, "on_bonus")
	get_node("VisibilityNotifier2D").connect("screen_exited", self, "on_screen_exited")

func _physics_process(delta):
	position.y += speed * delta
	
func on_body_entered(body):
	if body.name == "Player":
		emit_signal("bonus", self)
		queue_free()

func on_screen_exited():
	queue_free()
