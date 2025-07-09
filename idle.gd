#idle
extends state

@export var running_state:state
@export var jumping_state:state
@export var dashing_state:state
@export var taking_damage_state:state

func enter()->void:
	super()
	parent.velocity.x = 0
	
func process_input(event:InputEvent)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		return running_state
	if Input.is_action_just_pressed("jump"):
		return jumping_state
	return null
	
func process_damage(event:damage_event)->state:
	return taking_damage_state

func process_physics(delta:float)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		return running_state
	return null
