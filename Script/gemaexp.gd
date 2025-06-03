extends Area2D

@export var experiencia = 1

var sprite_azul = preload("res://Textures/Items/Gems/gema-exp-azul.png")
var sprite_verde = preload("res://Textures/Items/Gems/gema-exp-verde.png")
var sprite_vermelho = preload("res://Textures/Items/Gems/gema-exp-vermelha.png")

var alvo = null
var velocidade = -1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var som = $som_coleta
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("andar")
	if experiencia < 5:
		return
	elif experiencia < 15:
		sprite.texture = sprite_vermelho
	else:
		sprite.texture = sprite_verde

func _physics_process(delta):
	if alvo != null:
		global_position = global_position.move_toward(alvo.global_position, velocidade)
		velocidade += 2 * delta

func coleta():
	som.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	return experiencia

func _on_som_coleta_finished() -> void:
	queue_free()
