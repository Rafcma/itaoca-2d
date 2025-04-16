extends Area2D

@export var exp = 1

var sprite_azul = preload("res://Textures/Items/Gems/Gem_blue.png")
var sprite_verde = preload("res://Textures/Items/Gems/Gem_green.png")
var sprite_vermelho = preload("res://Textures/Items/Gems/Gem_red.png")

var alvo = null
var velocidade = 0

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var som = $som_coleta

func _ready() -> void:
	if exp < 5:
		return
	elif exp < 25:
		sprite.texture = sprite_verde
	else:
		sprite.texture = sprite_vermelho
		
func _physics_process(delta):
	if alvo != null:
		global_position = global_position.move_toward(alvo.global_position, velocidade)
		velocidade += 2 * delta

func colleta():
	som.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	return exp


func _on_som_coleta_finished() -> void:
	pass # Replace with function body.
