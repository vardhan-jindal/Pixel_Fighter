extends CharacterBody2D

const BASE_SPEED := 130.0
const BASE_JUMP_VELOCITY := -350.0

var speed := BASE_SPEED
var jump_velocity := BASE_JUMP_VELOCITY

var can_jump := true
var can_move := true
var vision := 1.0

var alive := true

func _physics_process(delta: float) -> void:
	if not alive:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if can_jump and Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	if can_move:
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	else:
		velocity.x = 0

	move_and_slide()

func die():
	if not alive:
		return
	alive = false
	print("💀 Player died")
	get_tree().call_group("UI", "show_death_menu")

func sacrifice_random():
	var choices = []

	if can_jump:
		choices.append("jump")
	if can_move and speed > 50:
		choices.append("speed")
	if vision > 0.4:
		choices.append("vision")

	if choices.is_empty():
		print("Nothing left to sacrifice!")
		return

	var choice = choices.pick_random()
	match choice:
		"jump":
			can_jump = false
			print("Sacrificed jump!")
		"speed":
			speed *= 0.7
			print("Sacrificed speed!")
		"vision":
			vision *= 0.6
			get_viewport().canvas_item_modulate = Color(1, 1, 1, vision)
			print("Sacrificed vision!")

	alive = true
