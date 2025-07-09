extends Area2D

@onready var game_manager: Node = %GameManager
@onready var pickupanimation: AnimationPlayer = $pickupanimation

func _on_body_entered(body: Node2D) -> void:
	pickupanimation.play("pickup")
	game_manager.addscore()
