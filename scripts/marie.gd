extends CharacterBody2D
class_name marie
@onready var animated_sprite_2d = $AnimatedSprite2D
var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var timer = $Timer
@onready var collision_shape_2d = $CollisionShape2D

const speed = 100
var is_alive:bool = true
var taking_damage: bool = false
var dir: Vector2
var attack_patterns = []


func _ready():
	timer.start()
	attack_patterns = [spawn_spiral_pattern, spawn_nose_pattern,spawn_single_pattern]
	
func _process(delta):
	move(delta)
	move_and_slide()
	
func move(delta):
	if is_alive:
		velocity += dir * speed * delta
	elif !is_alive:
		velocity.x = 0

func spawn_spiral_pattern():
	var angle = 0
	for i in range(20):
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.position = collision_shape_2d.position
		bullet.rotation = angle
		angle += PI / 10
		
func spawn_nose_pattern():
	var angle = 0
	for i in range(20):
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.position = collision_shape_2d.position
		bullet.rotation = angle
		angle += PI / 100
	
func spawn_single_pattern():
	for i in range(20):
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.position = collision_shape_2d.position


func _on_timer_timeout():
	print("deberia disparar")
	var chosen_attack = choose(attack_patterns)
	animated_sprite_2d.play("attack")
	chosen_attack.call()

func choose(array):
	array.shuffle()
	return array.front()

func _on_movement_timeout():
	print("deberia moverse")
	$movement.wait_time = choose([1.0,1.5,2.0])
	if is_alive:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		animated_sprite_2d.play("idle")
	
