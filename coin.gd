extends Area2D

signal coin_collected

func _on_coin_body_entered(body):
	$AnimationPlayer.play("bounce")
	body.add_coin()
	set_collision_mask_bit(0, false)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
