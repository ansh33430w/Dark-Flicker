extends Node2D


signal energy_changed( cur , max)
signal energy_depleted 

@export var light :PointLight2D

var total_time = 180

var drain = 1.0

@export_group("Light")

var maxlife_energy = 3
var minlife_energy = 0
var maxlight_scale = 0.9
var minlight_scale = 0.2 


@export_group("low energy flicker")
var flickereblow_ratio =  0.25
var flicker_str = .35



var time_left :float
var dead:=false

func _ready() -> void:
	time_left= total_time
	_update_light()
func _physics_process(delta: float) -> void:
	if dead :
		return
	time_left = max(time_left - delta , 0.0)
	_update_light()
	if time_left<=0.0:
		_on_time_up()
	
func _update_light():
	if light==null:
		return
	
	var ratio = time_left / total_time
	var brigtness = maxlife_energy *ratio
	if ratio < flickereblow_ratio and ratio >0.0:
		brigtness*= 1.0 - randf() * flicker_str
	
	light.energy = brigtness
	light.texture_scale = lerp(minlight_scale,maxlight_scale,ratio)
	
	
	
func _on_time_up():
	dead = true
	if light :
		light.energy = 0.0
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()
