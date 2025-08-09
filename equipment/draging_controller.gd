extends Node2D

var dragable: Node2D = null:
	set(value):
		if is_dragging: return
		stop_dragging(dragable)
		dragable = value
		
var is_dragging = false
var drag_offset: Vector2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		print("Just clicked")
		is_dragging = true
		if dragable != null:
			drag_offset = get_global_mouse_position() - dragable.global_position
	
	if Input.is_action_pressed("click") and dragable != null:
		dragable.global_position = get_global_mouse_position() - drag_offset
	
	if Input.is_action_just_released("click"):
		is_dragging = false
		dragable = null

func stop_dragging(dragable: Node2D):
	if dragable == null: return
	var tween = get_tree().create_tween()
	if dragable.is_inside_dropable:
		tween.tween_property(dragable, "global_position", dragable.dropable.global_position, 0.2).set_ease(Tween.EASE_OUT)
		dragable.dropable.card = dragable
	else:
		tween.tween_property(dragable, "global_position", dragable.inital_position, 0.2).set_ease(Tween.EASE_OUT)
	
