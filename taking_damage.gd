#taking damage
extends state

@export var running_state:state
@export var jumping_state:state
@export var dashing_state:state
@export var idle_state:state
@onready var hurt_sound: AudioStreamPlayer2D = $hurt_sound

func enter()->void:
	super()

func process_damage(event:damage_event)->state:
	if event is damage_event:
		var e = event as damage_event
		parent.health -= e.amount
		hurt_sound.play()
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		return running_state
	if Input.is_action_just_pressed("jump"):
		return jumping_state
	if not direction:
		return idle_state
	return null
