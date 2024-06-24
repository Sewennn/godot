extends Node2D

var speed = 200

func _process(delta):
	position += Vector2(cos(rotation), sin(rotation)) * speed * delta
	if position.x < -1000 or position.x > 1000 or position.y < -1000 or position.y > 1000:
		queue_free()
