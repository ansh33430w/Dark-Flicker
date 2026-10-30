extends Node2D


signal energy_changed( cur , max)
signal energy_depleted 
@export var deathscreen : CanvasLayer
@export var light :PointLight2D

var total_time = 60



var drain = 1.0

@export_group("Light")

var maxlife_energy = 3
var minlife_energy = 0
var maxlight_scale = 0.9
var minlight_scale = 0.2 


@export_group("low energy flicker")
var flickereblow_ratio =  0.25
var flicker_str = .35

@export_group("Timer Display")
var font_size = 36
var normalcolor = Color(1.0, 1.0, 1.0, 1.0)
var warningcolor = Color(0.91, 0.0, 0.0, 1.0)



var time_left :float
var dead:=false
@export var  timerlabel :Label 


func _ready() -> void:
	time_left= total_time
	_update_light()
	_update_label()
func _physics_process(delta: float) -> void:
	if dead :
		return
	time_left = max(time_left - delta , 0.0)
	_update_light()
	_update_label()
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
	energy_depleted.emit()
	if light :
		light.energy = 0.0
	await get_tree().create_timer(1.5).timeout
	deathscreen.show_death_scn()

func _update_label():
	if timerlabel ==null:
		return
	var total_sec = int(ceil(time_left))
	var min = total_sec / 60
	var sec = total_sec% 60
	
	timerlabel.text = "%02d:%02d" % [min,sec]
	
	var ratio = time_left / total_time
	if ratio < flickereblow_ratio:
		timerlabel.modulate= warningcolor
	else:
		timerlabel.modulate = normalcolor
