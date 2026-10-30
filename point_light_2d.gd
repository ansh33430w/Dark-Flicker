extends PointLight2D


var min = .2
var max = 1.2


func _process(delta: float) -> void:
	energy = randf_range(min,max)
