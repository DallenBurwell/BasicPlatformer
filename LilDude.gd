extends KinematicBody2D

#TEST COMMENT
var velocity = Vector2(0, 0)
var coins = 0;
var lives = 2;
const SPEED = 300;
const GRAVITY = 40;
const JUMPFORCE = -1100;

signal coin_collected

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	
	else:
		$Sprite.play("idle")
	velocity.y += GRAVITY
	
	if not is_on_floor():
		$Sprite.play("air")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, .20)


func _on_fallzone_body_entered(body):
	
	lives = lives - 1
	if lives <= 0:
		get_tree().change_scene("res://GameOver.tscn")
	else:
		get_tree().change_scene("res://Level1.tscn")
	


func add_coin():
	coins = coins + 1
	emit_signal("coin_collected")

func bounce():
	velocity.y = JUMPFORCE * .7

func loseLife(var enemyX):
	lives = lives - 1
	set_modulate(Color(1,0.3,0.3,0.4))
	velocity.y = JUMPFORCE * 0.5
	if position.x < enemyX:
		velocity.x = -800
	elif position.x > enemyX:
		velocity.x = 800
	
	Input.action_release("left")
	Input.action_release("right")
	
	$Timer.start()


func _on_Timer_timeout():
	if lives <= 0:
		get_tree().change_scene("res://GameOver.tscn")
