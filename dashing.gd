#dashing
extends state

@export var running_state:state
@export var jumping_state:state
@export var idle_state:state

@onready var dash_time: Timer = $dash_time
@onready var dash_cooldown: Timer = $dash_cooldown
@onready var dash_sound: AudioStreamPlayer = $dash_sound
var direction:int

func enter():
	super()
	direction = Input.get_axis("move_left", "move_right")
	if can_dash and one_dash:
		parent.velocity.x = direction * dash_speed
		if parent.velocity.x != 0:
			dash_sound.play()
		is_dashing = true
		can_dash = false
		dash_cooldown.start()
		dash_time.start()

func process_physics(delta:float)->state:
	if is_dashing:
		return null
	direction = Input.get_axis("move_left", "move_right")
	if not direction:
		return idle_state

	if not is_dashing: return running_state
	return null
func process_input(event:InputEvent)->state:
	if not is_dashing:
		var direction = Input.get_axis("move_left","move_right")
		if direction:
			return running_state
		elif Input.is_action_just_pressed("jump"):
			return jumping_state
		elif Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
			return idle_state
	return null

func _on_dash_time_timeout() -> state:
	is_dashing = false
	can_dash = false
	return running_state
func _on_dash_cooldown_timeout() -> void:
	can_dash = true
