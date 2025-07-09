#running
extends state

@export var idle_state:state
@export var jump_state:state
@export var dash_state:state
@export var taking_damage_state:state

func enter()->void:
	super()
	
func process_input(event:InputEvent)->state:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	if Input.is_action_just_pressed("dash"):
		return dash_state
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_left"):
		return idle_state 
	return null 
	
func process_damage(event:damage_event)->state:
	return taking_damage_state
	
func process_physics(delta:float)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if direction<0:
		parent.animated_sprite.flip_h = true
	elif direction>0:
		parent.animated_sprite.flip_h = false
	if direction:
		parent.velocity.x = direction * SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
	return null
