extends CharacterBody2D
class_name player

@onready var animated_sprite= $AnimatedSprite2D
@onready var state_machine: Node = $state_machine
@export var health: int
@onready var game_manager: Node = %GameManager
@onready var coyote: Timer = $coyote_timer
@onready var state: state = $state

var was_on_floor = true
var coyote_running = false
var hit_ground = true

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	move_and_slide()
	velocity += get_gravity()*delta
	
	if is_on_floor():
		coyote_running = false
		hit_ground = true
		state.can_jump = true
		coyote.stop()
	else:
		if not coyote_running and hit_ground:
			coyote.start()
			coyote_running = true

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func damage():
	game_manager.damage(health)

func _on_coyote_timer_timeout() -> void:
	coyote_running = false
	
