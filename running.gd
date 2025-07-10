#running
extends state

@export var idle_state:state
@export var jump_state:state
@export var dash_state:state

func enter()->void:
	super()
	
func process_input(event:InputEvent)->state:
	if Input.is_action_just_pressed("dash"):
		one_dash = true
		return dash_state
	if Input.is_action_pressed("jump"):
		return jump_state
	if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left"):
		return idle_state 
	return null 
	
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
	if not parent.is_on_floor() and parent.coyote.is_stopped() and can_jump:
		parent.coyote.start()
	if parent.is_on_floor() and not parent.was_on_floor and Input.is_action_pressed("jump"):
		return jump_state
	parent.was_on_floor = parent.is_on_floor()
	return null
