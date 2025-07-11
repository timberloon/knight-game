#state machine
extends Node

@export var starting_state: state
var curr_state:state = null

func init(parent:player)->void:
	for child in get_children():
		child.parent = parent
		
	change_state(starting_state)
	
func change_state(new_state:state)->void:
	if curr_state:
		curr_state.exit()
	curr_state = new_state
	new_state.enter()
	
func process_physics(delta:float)->void:
	var new_state = curr_state.process_physics(delta)
	if new_state:
		change_state(new_state)
		print("changed to "+ str(new_state))
	
func process_frame(delta:float)->void:
	var new_state = curr_state.process_frame(delta)
	if new_state:
		change_state(new_state)
		print("changed to "+ str(new_state))
	
func process_input(event:InputEvent)->void:
	var new_state = curr_state.process_input(event)
	if new_state:
		change_state(new_state)
		print("changed to "+ str(new_state))
