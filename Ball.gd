extends KinematicBody2D

signal out
signal dettached
signal brick_destroyed(brick)

var attached = true
var motion = null
var player
var game
var speed = 200
var origin_speed = 200
var speed_inc = 20
var audioSP

func _ready() :
	player = get_node("../Player")
	game = get_node("..")
	audioSP = get_node("AudioStreamPlayer2D")

func _physics_process(delta):
	if attached:
		# Balle attachee au joueur
		if !game.gameOver and player.started and Input.is_action_pressed("ui_accept"):
			attached = false
			get_node("CollisionShape2D").disabled = false
			motion = Vector2(player.motion.x + rand_range(-80, 80) , -speed)
			motion = motion.normalized() * speed
			emit_signal("dettached")
		else :
			position.x = player.position.x
			position.y = player.position.y - 16
			get_node("CollisionShape2D").disabled = true

	if motion != null:
		# Balle en mouvement
		move_and_slide(motion)
		
		#Gestion des collisions
		var nbColls = get_slide_count();
		if nbColls > 0 :
			for i in range(nbColls):
				var coll = get_slide_collision(i)
				if coll != null and coll.collider != null:
					if coll.collider.is_in_group("Wall") :
						motion.x = -motion.x
						speed += speed_inc
						audioSP.play()
					elif coll.collider.is_in_group("Brick") :
						emit_signal("brick_destroyed", coll.collider)
						motion.y = -motion.y
						speed += speed_inc
					elif coll.collider.name == "Player" :
						motion.y = -motion.y
						motion.x += coll.collider.motion.x * 0.5
						speed = origin_speed + ((speed - origin_speed) / 2)
						player.get_node("AudioStreamPlayer2D").play()
					elif coll.collider.name == "Ceil" :
						motion.y = -motion.y
						speed += speed_inc
		motion = motion.normalized() * speed
		
		# Correction de la trajectoire si trop horizontal
		if abs(motion.x) > 170:
			motion.x = -170 if motion.x < 0 else 170
			motion = motion.normalized() * speed
		if abs(motion.y) < 20:
			motion.y = -80 if motion.y < 0 else 80
			motion = motion.normalized() * speed
					



func _on_screen_exited():
	emit_signal("out")
	
