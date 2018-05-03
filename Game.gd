extends Node


var gameOver = false
var score = 0
var displayedScore = 0
var bricks
var newRowTimer
var brick_scene = preload("res://Brick.tscn")
var bonus_scene = preload("res://Bonus.tscn")
var scoreLabel
var brickBreakPlayer
var newRowPlayer

func _process(delta):
	displayedScore = min(displayedScore + 10, score)
	showScore()
	
	if gameOver:
		if Input.is_action_pressed("ui_accept"):
			for i in range(0, bricks.get_child_count()):
    			bricks.get_child(i).queue_free()
			_ready()
			score = 0
			displayedScore = 0
			showScore()
			get_node("UI/GameOverLabel").visible = false
			gameOver = false
			
func showScore():
	scoreLabel.text = "Score " + str(displayedScore)

func _ready():
	randomize()
	newRowTimer = get_node("NewRowTimer")
	scoreLabel = get_node("UI/ScoreLabel")
	brickBreakPlayer = get_node("BrickBreakPlayer")
	newRowPlayer = get_node("NewRowPlayer")
	bricks = get_node("Bricks")
	addRow()
	addRow()
	addRow()
	addRow()

	

func _on_Ball_out():
	gameOver = true
	newRowTimer.stop()
	get_node("GameOverPlayer").play()
	get_node("UI/GameOverLabel").visible = true
	get_node("Player").position.x = 192
	get_node("Player").set_state(get_node("Player/Basic"))
	get_node("Ball").motion = null
	get_node("Ball").speed = get_node("Ball").origin_speed
	get_node("Ball").attached = true
	
	#Suppression de tous les bonus à l'écran
	for b in get_tree().get_nodes_in_group("Bonus") :
		b.free()
	# Ainsi que de tous les tirs
	for s in get_tree().get_nodes_in_group("Shot") :
		s.free()

func addRow():
	for b in bricks.get_children():
		b.position.y += 16
	for i in range(10) :
		var b = brick_scene.instance()
		b.position.y = 32
		b.position.x = 32 * (i + 1)
		bricks.add_child(b)

func deleteFirstRow():
	for b in bricks.get_children():
		b.position.y -= 16
		if (b.position.y < 32):
			b.free()
			score += 100
	get_node("RowUpPlayer").play()
	

func _on_brick_destroyed(brick):
	brickBreakPlayer.position = brick.position
	brickBreakPlayer.play()
	score += 100
	var r = rand_range(0,1)
	if r < 0.2:
		var b = bonus_scene.instance()
		b.position = brick.position
		add_child(b)
	brick.free()


func _on_NewRowTimer_timeout():
	newRowPlayer.play()
	addRow()


func _on_Ball_dettached():
	newRowTimer.start()
