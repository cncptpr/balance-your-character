@tool
class_name StatsBar extends Control

@export var stat: float:
	set(value):
		color_points(stat_to_points(value))
		stat = value

var pointNodes: Array[Sprite2D]

func stat_to_points(x: float) -> int:
	var value = (-1.0 / (pow(2.0, (0.2 * abs(x) - 2.3)))) + 5
	var rounded_value = int(round(value))
	
	if x < 0:
		return -rounded_value
	else:
		return rounded_value

func _ready() -> void:
	pointNodes = [
		$ColorRect1, 
		$ColorRect2, 
		$ColorRect3,
		$ColorRect4,
		$ColorRect5,
	]
	color_points(stat_to_points(stat))
	
func color_points(points: int) -> void:
	if pointNodes.size() == 0: return
	for i in range(pointNodes.size()):
		if i < points:
			pointNodes[i].visible = true
		elif i < -points:
			pointNodes[i].visible = true
		else:
			pointNodes[i].visible = false
	if points == 0:
		pointNodes[0].visible = true
		
		
		
