extends Area2D

var nivel = 1
var hp = 999
var velocidade = 200.0
var damage = 10
var forca_empurrao = 100
var caminhos = 1
var tamanho_ataque = 1.0
var velocidade_ataque = 4.0

var alvo = Vector2.ZERO
var alvo_array = []

var angulo = Vector2.ZERO
var reseta_pos = Vector2.ZERO

var sprite_jav_normal = preload("res://Textures/Items/Weapons/javelin_3_new.png")
var sprite_jav_ataque = preload("res://Textures/Items/Weapons/javelin_3_new_attack.png")

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var tempo_ataque = get_node("%TempoAtaque")
@onready var muda_direcao = get_node("%MudaDirecao")
@onready var reseta_tempo = get_node("%ResetaTempo")
@onready var som_ataque: AudioStreamPlayer2D = $som_ataque

signal remove_do_array(object)

func _ready() -> void:
	update_javelin()
	_on_reseta_tempo_timeout()
	
func update_javelin():
	nivel = player.javelin_nivel
	match nivel:
		1:
			hp = 999
			velocidade = 200.0
			damage = 10
			forca_empurrao = 100
			caminhos = 3
			tamanho_ataque = 1.0
			velocidade_ataque = 4.0
	
	scale = Vector2(1.0,1.0) * tamanho_ataque
	tempo_ataque.wait_time = velocidade_ataque

func _physics_process(delta):
	if alvo_array.size() > 0:
		position += angulo * velocidade * delta
	else:
		var angulo_player = global_position.direction_to(reseta_pos)
		var distancia_dif = global_position - player.global_position
		var vel_volta = 20
		if abs(distancia_dif.x) > 500 or abs(distancia_dif.y) > 500:
			vel_volta = 100
		position += angulo_player * vel_volta * delta
		rotation = global_position.direction_to(player.global_position).angle() + deg_to_rad(135)

func add_caminhos():
	som_ataque.play()
	emit_signal("remove_do_array", self)
	alvo_array.clear()
	var contador = 0
	while contador < caminhos:
		var novo_caminho = player.alvo_aleatorio()
		alvo_array.append(novo_caminho)
		contador += 1
	libera_ataque(true)
	alvo = alvo_array[0]
	process_caminho()
	
func process_caminho():
	angulo = global_position.direction_to(alvo)
	muda_direcao.start()
	var tween = create_tween()
	var novos_graus_rotacao = angulo.angle() + deg_to_rad(135)
	tween.tween_property(self,"rotation",novos_graus_rotacao,0.25).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

func libera_ataque(atq = true):
	if atq:
		collision.call_deferred("set","disabled",false)
		sprite.texture = sprite_jav_ataque
	else:
		collision.call_deferred("set","disabled",true)
		sprite.texture = sprite_jav_normal

func _on_tempo_ataque_timeout() -> void:
	add_caminhos()

func _on_muda_direcao_timeout() -> void:
	if alvo_array.size() > 0:
		alvo_array.remove_at(0)
		if alvo_array.size() > 0:
			alvo = alvo_array[0]
			process_caminho()
			som_ataque.play()
			emit_signal("remove_do_array", self)
		else:
			libera_ataque(false)
	else:
		muda_direcao.stop()
		tempo_ataque.start()
		libera_ataque(false)
		


func _on_reseta_tempo_timeout() -> void:
	var escolhe_direcao = randi() % 4
	reseta_pos = player.global_position
	match escolhe_direcao:
		0:
			reseta_pos.x += 40
		1:
			reseta_pos.x -= 40
		2:
			reseta_pos.y += 40
		3:
			reseta_pos.y -= 40
