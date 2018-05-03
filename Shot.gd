extends Area2D

onready var game = get_node("..")

var speed = -250


func _ready():
	self.connect("body_entered", self, "on_body_entered")

func _physics_process(delta):
	position.y += speed * delta

func _on_screen_exited():
	queue_free()
	
func on_body_entered(body):
	if body.is_in_group("Brick"):
		game._on_brick_destroyed(body)
		queue_free()
