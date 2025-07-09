extends CharacterBody2D
class_name player

@onready var animated_sprite= $AnimatedSprite2D
@onready var state_machine: Node = $state_machine
@export var health: int
@onready var game_manager: Node = %GameManager

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	move_and_slide()
	velocity += get_gravity()*delta

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func damage():
	game_manager.damage(health)
