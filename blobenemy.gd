extends KinematicBody2D

var hspeed = 60
var velocity = Vector2()
export var direction = -1
export var detect_edge = true

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$DetectFloor.position.x = $CollisionShape2D.shape.get_extents().x * direction #Determines which side to place raycast on enemy
	$DetectFloor.enabled = detect_edge


func _physics_process(delta):
	if is_on_wall() or not $DetectFloor.is_colliding() and detect_edge and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$DetectFloor.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y += 20
	
	velocity.x = hspeed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_TopChecker_body_entered(body):
	
	if body.name == "LilDude":
		$AnimatedSprite.play("squashed")
		hspeed = 0
		set_collision_layer_bit(4, false)
		set_collision_mask_bit(0, false)
		$TopChecker.set_collision_layer_bit(4, false)
		$TopChecker.set_collision_mask_bit(0, false)
		$SideChecker.set_collision_layer_bit(4, false)
		$SideChecker.set_collision_mask_bit(0, false)
		$Timer.start()


func _on_SideChecker_body_entered(body):
	if body.name == "LilDude":
		print("ouchhhh")
		get_tree().change_scene("res://Level1.tscn")


func _on_Timer_timeout():
	queue_free()
