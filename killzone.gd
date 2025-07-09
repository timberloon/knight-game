extends Area2D

@onready var timer: Timer = $Timer
@onready var death_sound_animation: AnimationPlayer = $death_sound_animation
@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	death_sound_animation.play("death")
	body.velocity.y = -200.0
	body.get_node("CollisionShape2D").queue_free()
	game_manager.damage(0)
	timer.start()
	Engine.time_scale = 0.5
	
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
