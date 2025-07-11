#idle
extends state

@export var running_state:state
@export var jumping_state:state
@export var dashing_state:state

func enter()->void:
	super()
	parent.velocity.x = 0
	
func process_input(event:InputEvent)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		return running_state
	if Input.is_action_pressed("jump"):
		parent.in_air = true
		return jumping_state
	return null

func process_physics(delta:float)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		return running_state
	if not parent.was_on_floor and parent.is_on_floor() and Input.is_action_pressed("jump"):
		return jumping_state
	parent.was_on_floor = parent.is_on_floor()
	return null
	
