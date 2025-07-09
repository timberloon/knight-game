extends state

@export var running_state:state
@export var jumping_state:state
@export var dashing_state:state
@export var taking_damage_state:state
@export var idle_state:state
@onready var deathtime: Timer = $deathtime



func _on_deathtime_timeout() -> void:
	pass # Replace with function body.
