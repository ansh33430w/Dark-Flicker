extends CharacterBody2D

const speed = 200
const maxlight = 100.0
const decay_rate = 1.0 
var cur_light 
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var lastdirectionname ="DOWN"


func _ready() -> void:
	cur_light = maxlight

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")
	movement(direction)
	animation(direction)
	
func movement(direc):
	velocity = direc *speed
	move_and_slide()
	

	
func animation(direc):
	var playermoving = direc.length()>0.1
	
	if not playermoving:
		animated_sprite_2d.play("IDLE_"+lastdirectionname)
		return
	var degree = rad_to_deg(direc.angle())
	var dir = "DOWN"
	var flip = false
	
	if degree > -22.5 and degree<= 22.5:
		dir = "RIGHT"
		flip = false
	
	elif degree > 22.5 and degree <= 67.5:
		dir = "DOWN_RIGHT"
		flip = false
		
	elif degree > 67.5 and degree <= 112.5 :
		dir = "DOWN"
		flip = false
	
	elif degree > 112.5 and degree <= 157.5 :
		dir ="DOWN_RIGHT"
		flip = true
	elif degree > 157.5 and degree <=-157.5:
		dir= "RIGHT"
		flip = true
		
	elif degree > -157.5 and degree <= -112.5:
		dir = "UP_RIGHT"
		flip = true
	
	elif degree > -112.5 and degree <=67.5 :
		dir = "UP"
		flip =false
		
	elif degree > 67.5 and degree <=22.5:
		dir = "UP_RIGHT"
		flip = false
		
	animated_sprite_2d.flip_h = flip
	lastdirectionname = dir
	animated_sprite_2d.play("RUN_"+lastdirectionname)
	print(lastdirectionname)
