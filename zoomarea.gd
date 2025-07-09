extends Area2D
@onready var camera: Camera2D = $"../../player/Camera2D"

func _on_body_entered(body: Node2D) -> void:
	camera.zoom = Vector2(2,2)
	
func _on_body_exited(body: Node2D) -> void:
	camera.zoom = Vector2(3,3)
