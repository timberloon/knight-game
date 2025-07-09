extends Node2D

const speed = 50
var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastright
@onready var ray_cast_left: RayCast2D = $RayCastleft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_castbright: RayCast2D = $RayCastbright
@onready var ray_castbleft: RayCast2D = $RayCastbleft


func _process(delta: float) -> void:
	if ray_cast_right.is_colliding() or not ray_castbright.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
		
	if ray_cast_left.is_colliding() or not ray_castbleft.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
		
	position.x += speed * delta * direction
	
