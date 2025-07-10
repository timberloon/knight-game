#jumping
extends state

@export var running_state:state
@export var idle_state:state
@export var dashing_state:state
@onready var jump_sound: AudioStreamPlayer = $jumping_sound

func enter()->void:
	super()
	if parent.is_on_floor():
		jump()

func process_physics(delta:float)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		parent.velocity.x = direction * SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
		
		
	if can_jump and parent.coyote_running:
		parent.velocity.y = 0
		jump()
	if not can_jump and parent.is_on_floor():
		can_jump = true
		
		
	if direction:
		return running_state
	else:
		return idle_state

func process_input(event:InputEvent)->state:
	if Input.is_action_just_pressed("dash"):
		one_dash = true
		return dashing_state
	return null
	
func jump()->void:
	parent.velocity.y = jump_velocity
	parent.hit_ground = false
	parent.coyote_running = false
	can_jump = false
	jump_sound.play()
