#jumping
extends state

@export var running_state:state
@export var idle_state:state
@export var dashing_state:state
@onready var jump_sound: AudioStreamPlayer2D = $jumping_sound

func enter()->void:
	super()

func process_physics(delta:float)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		parent.velocity.x = direction * SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
		
	if can_jump and parent.is_on_floor():
		parent.velocity.y = 0
		jump()
	if not can_jump and parent.is_on_floor():
		can_jump = true
	if not parent.is_on_floor() and parent.coyote.is_stopped() and can_jump:
		parent.coyote.start()
	return null

func process_input(event:InputEvent)->state:
	if Input.is_action_just_pressed("dash"):
		return dashing_state
	return null
	
func jump()->void:
	parent.velocity.y = jump_velocity
	can_jump = false
	jump_sound.play()

func _on_coyote_timer_timeout() -> void:
	can_jump = false
