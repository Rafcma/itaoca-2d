extends Area2D

@export var damage = 1
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var desabilita_timer_hitbox: Timer = $desabilita_timer_hitbox

func tempdisable():
	collision_shape_2d.call_deferred("set","disable",true)
	desabilita_timer_hitbox.start()

func _on_desabilita_timer_hitbox_timeout() -> void:
	collision_shape_2d.call_defered("set","disable",true)
