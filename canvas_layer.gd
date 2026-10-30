extends CanvasLayer


@export var mainmenu_scn :String

var bg_fade_time = 1.0

var content_fade_time =.5

@onready var bg: Sprite2D = $Background300x128

@onready var content: Node = $content

@onready var retry: Button = $content/Button
@onready var menu: Button = $content/Button2

@onready var label: Label = $content/Label

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	bg.modulate.a =0.0
	retry.modulate.a = 0.0
	menu.modulate.a = 0.
	label.modulate.a=0.0
	retry.disabled = true
	menu.disabled = true
	
	
func show_death_scn():
	visible = true
	get_tree().paused=true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	var tween = create_tween()
	tween.tween_property(bg,"modulate:a", 1.0, bg_fade_time)
	tween.tween_property(retry,"modulate:a",1.0,content_fade_time)
	tween.tween_property(menu,"modulate:a",1.0,content_fade_time)
	tween.tween_property(label,"modulate:a",.5,content_fade_time)
	tween.tween_callback(_enable_buttons)
	
func _enable_buttons():
	retry.disabled= false
	menu.disabled= false
	retry.grab_focus()
	
	

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	

func _on_button_2_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://s.tscn")
