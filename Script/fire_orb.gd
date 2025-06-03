extends Area2D

var hp = 999
var damage = 20
var tamanho_ataque = 1.0
var tempo_ativo = 2.0
var cooldown = 6.0
var raio = 60.0
var velocidade_angular = PI * 2

var tempo_decorrido = 0.0
var ativo = false

@export var orb_index := 0
@export var orb_total := 1

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var tempo_ataque = $TempoAtaque
@onready var som_ataque = $som_ataque

func _ready() -> void:
	hide()
	desativa_orbe()
	update_orbe()
	_on_tempo_ataque_timeout()

func update_orbe():
	var nivel = player.fire_orb_nivel
	match nivel:
		1:
			damage = 20
			tamanho_ataque = 1.0 * (1 + player.tamanho_magia)
			raio = 60.0
			orb_total = 1
		2:
			damage = 25
			tamanho_ataque = 1.1 * (1 + player.tamanho_magia)
			raio = 70.0
			orb_total = 1
		3:
			damage = 30
			tamanho_ataque = 1.2 * (1 + player.tamanho_magia)
			raio = 80.0
			orb_total = 2
		4:
			damage = 40
			tamanho_ataque = 1.4 * (1 + player.tamanho_magia)
			raio = 100.0
			orb_total = 3

	scale = Vector2.ONE * tamanho_ataque
	tempo_ataque.wait_time = cooldown

func _physics_process(delta):
	if ativo:
		tempo_decorrido += delta
		var angulo_offset = (TAU / orb_total) * orb_index
		var angulo_total = tempo_decorrido * velocidade_angular + angulo_offset
		position = player.global_position + Vector2(cos(angulo_total), sin(angulo_total)) * raio
		rotation += 5 * delta
		if tempo_decorrido >= tempo_ativo:
			desativa_orbe()

func ativa_orbe():
	ativo = true
	tempo_decorrido = 0.0
	show()
	set_process(true)
	collision.call_deferred("set", "disabled", false)
	som_ataque.play()

func desativa_orbe():
	ativo = false
	hide()
	set_process(false)
	collision.call_deferred("set", "disabled", true)
	tempo_ataque.start()

func _on_tempo_ataque_timeout():
	if orb_index == 0:
		for i in range(orb_total):
			if i == 0:
				ativa_orbe()
			else:
				var nova_orbe = preload("res://Player/Ataques/fire_orb.tscn").instantiate()
				nova_orbe.orb_index = i
				nova_orbe.orb_total = orb_total
				get_parent().add_child(nova_orbe)
				nova_orbe.ativa_orbe()

func _on_body_entered(body):
	if body.is_in_group("inimigos"):
		if body.has_method("levar_dano"):
			body.levar_dano(damage)
