extends CharacterBody2D

const speed = 200
const maxlight = 100.0

var cur_light 
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	cur_light = maxlight
func _physics_process(delta: float) -> void:
	movement()
func movement():
	var x = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = x *speed
	move_and_slide()
	
	

	
