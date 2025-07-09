extends Area2D
@onready var damage_sound: AudioStreamPlayer2D = $damage_sound
@onready var death_timer: Timer = $death_timer
@onready var cooldown: Timer = $cooldown

var in_cooldown = false
@export var damage:int

func _on_body_entered(body: Node2D) -> void:
	if not in_cooldown:
		var e = damage_event.new(damage)
		state_machine.custom_event(e)
		in_cooldown = true
		cooldown.start()
		if body.health <= 0:
				body.get_node("CollisionShape2D").queue_free()
				body.velocity.y = -200.0
				Engine.time_scale = 0.5
				death_timer.start()

func _on_death_timer_timeout() -> void:
		Engine.time_scale = 1
		get_tree().reload_current_scene()

func _on_cooldown_timeout() -> void:
	in_cooldown = false
