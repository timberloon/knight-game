#jumping
extends state

@export var running_state:state
@export var idle_state:state
@export var dashing_state:state
@export var taking_damage_state:state

@onready var jump_sound: AudioStreamPlayer2D = $jumping_sound
@onready var coyote: Timer = $coyote_timer

func enter()->void:
	super()

func process_physics(delta:float)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		parent.velocity.x = direction * SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
	if not can_jump and parent.is_on_floor():
		can_jump = true
	if Input.is_action_pressed("jump") and can_jump:
		parent.velocity.y = 0
		jump()
	if not parent.is_on_floor() and coyote.is_stopped() and can_jump:
		coyote.start()
		
	if direction:
		return running_state
	elif not direction:
		return idle_state
	return null

func process_input(event:InputEvent)->state:
	if Input.is_action_just_pressed("dash"):
		return dashing_state
	return null
	
func process_damage(event:damage_event)->state:
	return taking_damage_state
	
func jump()->void:
	parent.velocity.y = jump_velocity
	can_jump = false
	jump_sound.play()
func _on_coyote_timer_timeout() -> void:
	can_jump = false
