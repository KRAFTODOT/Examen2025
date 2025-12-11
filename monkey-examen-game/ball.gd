extends RigidBody2D

var mouse_offset = Vector2.ZERO #Variable that allow track physics
var is_dragging = false #Variable that allow track dragging

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_dragging = true
				mouse_offset = global_position - get_global_mouse_position() # Offset
				freeze = true # Temporarily freeze for direct control
			else:
				is_dragging = false
				freeze = false # Release freeze
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				self.queue_free() #Delete object

func _process(delta):
	if is_dragging:
		global_position = get_global_mouse_position() # Move with mouse

func _integrate_forces(state):
	if is_dragging:
		# Move the body to the mouse position, maintaining offset
		state.transform.origin = get_global_mouse_position() + mouse_offset
