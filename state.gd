extends Node
class_name state

@export var animation:String
@export var movespeed:int
var parent:player

var jump_velocity = -270.0
var dash_speed = 300
var SPEED = 100

var can_jump = true
var can_dash = true
var is_dashing = false

func enter()->void:
	parent.animated_sprite.play(animation)

func exit()->void:
	pass
	
func process_input(event: InputEvent)->state:
	return null
	
func process_physics(delta:float)->state:
	return null
	
func process_frame(delta:float)->state:
	return null
	
func process_damage(event:damage_event)->state:
	return null
