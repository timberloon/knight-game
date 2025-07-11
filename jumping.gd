#jumping
extends state

@export var running_state:state
@export var idle_state:state
@export var dashing_state:state
@onready var jump_sound: AudioStreamPlayer = $jumping_sound

func enter()->void:
	parent.in_air = true
	super()
	if parent.is_on_floor():
		jump()

func process_physics(delta:float)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		parent.velocity.x = direction * SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)


	if parent.coyote_running:
		parent.velocity.y = 0
		parent.in_air = true
		jump()
		print("coyote jump")


	if direction and parent.is_on_floor():
		parent.in_air = false
		return running_state
	elif not direction and parent.is_on_floor():
		parent.in_air = false
		return idle_state
	return null

func process_input(event:InputEvent)->state:
	if Input.is_action_just_pressed("dash"):
		one_dash = true
		return dashing_state
	return null
	
func jump()->void:
	parent.velocity.y = jump_velocity
	parent.hit_ground = false
	parent.coyote_running = false
	jump_sound.play()
