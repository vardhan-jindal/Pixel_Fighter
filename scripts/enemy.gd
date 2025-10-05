extends Node2D

const SPEED= 60 

var direction = 1
@onready var ray_castright_right: RayCast2D = $"RayCastright right"
@onready var ray_castright_2_left: RayCast2D = $"RayCastright2 left"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_castright_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h= true
	if ray_castright_2_left.is_colliding():
		animated_sprite_2d.flip_h= false
		direction = 1
	
	
	position.x += direction * SPEED *delta
