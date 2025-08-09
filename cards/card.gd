@tool
class_name Card extends Node2D

@export var equipment_scene: PackedScene:
	set(value):
		equipment_scene = value
		did_equipment_scene_change = true

var equipment: Node = null
var did_equipment_scene_change := true

# For drag & drop
var is_draggable = false
var is_inside_dropable = false
var dropable
var drag_offset: Vector2
var inital_position: Vector2

func _ready() -> void:
	set_process(true)
	inital_position = global_position
	
func _exit_tree() -> void:
	if equipment != null: equipment.queue_free()
	
func _process(delta: float) -> void:
	if did_equipment_scene_change:
		print("Updating equipment. is_editor_hint: ", Engine.is_editor_hint())
		update_equipment()

func set_pos_index(value: int):
	$Sprite2D.frame = value

func update_equipment() -> void:
	if equipment and is_instance_valid(equipment):
		print("Freeing old equipment")
		equipment.queue_free()
		equipment = null

	if equipment_scene:
		print("Instantiating new equipment")
		equipment = equipment_scene.instantiate()
		add_child(equipment)

		if Engine.is_editor_hint():
			equipment.owner = get_tree().edited_scene_root
	else:
		print("No equipment_scene assigned")

	did_equipment_scene_change = false

func _on_area_2d_mouse_entered() -> void:
	if DragingController.is_dragging: return
	DragingController.dragable = self
	scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited() -> void:
	scale = Vector2(1, 1)
	if DragingController.dragable != self: return
	DragingController.dragable = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body.is_in_group("dropable"): return
	is_inside_dropable = true
	body.scale = Vector2(1.05, 1.05)
	dropable = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if !body.is_in_group("dropable"): return
	is_inside_dropable = false
	body.scale = Vector2(1, 1)
