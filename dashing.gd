#dashing
extends state

@export var running_state:state
@export var jumping_state:state
@export var idle_state:state
@export var taking_damage_state:state

@onready var dash_time: Timer = $dash_time
@onready var dash_cooldown: Timer = $dash_cooldown
@onready var dash_sound: AudioStreamPlayer2D = $dash_sound

func enter():
	super()

func process_physics(delta:float)->state:
	var direction = Input.get_axis("move_left", "move_right")
	if not direction:
		return idle_state
	if Input.is_action_just_pressed("dash") and can_dash:
		parent.velocity.x = direction * dash_speed
		if parent.velocity.x != 0:
			dash_sound.play()
		is_dashing = true
		can_dash = false
		dash_cooldown.start()
		dash_time.start()
	return null
	
func process_input(event:InputEvent)->state:
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		return running_state
	elif Input.is_action_just_pressed("jump"):
		return jumping_state
	elif Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		return idle_state
	return null
	
func process_damage(event:damage_event)->state:
	return taking_damage_state

func _on_dash_time_timeout() -> void:
	is_dashing = false

func _on_dash_cooldown_timeout() -> void:
	can_dash = true
