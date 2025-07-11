extends Area2D
@onready var damage_sound: AudioStreamPlayer2D = $damage_sound
@onready var death_timer: Timer = $death_timer
@onready var cooldown: Timer = $cooldown
var playr:Node2D

var in_cooldown = false
@export var damage:int

func _on_body_entered(body: Node2D) -> void:
	playr = body
	if not in_cooldown:
		body.taking_damage = true
		body.animated_sprite.play("damage")
		body.health -= damage
		damage_sound.play()
		in_cooldown = true
		body.damage()
		cooldown.start()
		if body.health <= 0:
			body.dead = true
			damage_sound.play()
			body.animated_sprite.play("death")
			body.velocity.y = -200.0
			Engine.time_scale = 0.5
			death_timer.start()

func _on_death_timer_timeout() -> void:
		Engine.time_scale = 1
		playr.dead = false
		get_tree().reload_current_scene()

func _on_cooldown_timeout() -> void:
	in_cooldown = false
