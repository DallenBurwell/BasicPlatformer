extends KinematicBody2D

#TEST COMMENT
var velocity = Vector2(0, 0)
var coins = 0;
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
	get_tree().change_scene("res://Level1.tscn")


func add_coin():
	coins = coins + 1
	emit_signal("coin_collected")
	
