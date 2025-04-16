extends CharacterBody2D

@export var hp = 10
@export var velocidade_movimento = 20.0
@export var recuperar_empurrao = 3.5 
var empurrao = Vector2.ZERO

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var som_hit: AudioStreamPlayer2D = $SomHit

var animacao_morte = preload("res://Inimigo/explosao.tscn")

signal remove_do_array(object)

func _ready():
	animation_player.play("andar")

func _physics_process(_delta):
	empurrao = empurrao.move_toward(Vector2.ZERO, recuperar_empurrao)
	var direcao = global_position.direction_to(player.global_position)
	velocity = direcao * velocidade_movimento
	velocity += empurrao
	move_and_slide()
	if direcao.x > 0.1:
		sprite_2d.flip_h = true
	elif direcao.x < -0.1:
		sprite_2d.flip_h = false

func morte():
	emit_signal("remove_do_array", self)
	var inimigo_morto = animacao_morte.instantiate()
	inimigo_morto.scale = sprite_2d.scale
	inimigo_morto.global_position = global_position
	get_parent().call_deferred("add_child", inimigo_morto)
	queue_free()

func _on_hurt_box_hurt(damage, angulo, forca_empurrao: Variant) -> void:
	hp -= damage
	empurrao = angulo * forca_empurrao
	if hp <= 0:
		morte()
	else:
		som_hit.play()
