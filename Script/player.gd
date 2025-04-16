extends CharacterBody2D

var hp = 80
var velocidade_movimento = 40.0
var ultimo_mov = Vector2.UP

var exp = 0
var exp_nivel = 1
var exp_coletado = 0

#Ataques
var lanca_de_gelo = preload("res://Player/Ataques/lanca_de_gelo.tscn")
var tornado = preload("res://Player/Ataques/tornado.tscn")
var javelin = preload("res://Player/Ataques/javelin.tscn")

#Nodes dos Ataques
@onready var tempo_lg = get_node("%TempoLG")
@onready var tempo_atq_lg = get_node("%TempoAtqLG")
@onready var tempo_tornado = get_node("%TempoTornado")
@onready var tempo_atq_trnd = get_node("%TempoAtqTrnd")
@onready var javelin_base = get_node("%JavelinBase")

#Lança de Gelo
var lancagelo_municao = 0
var lancagelo_municao_base = 1
var lancagelo_velocidade_ataque = 1.5
var lancagelo_nivel = 0

#Tornado
var tornado_municao = 0
var tornado_municao_base = 5
var tornado_velocidade_ataque = 3
var tornado_nivel = 0

#Javelin
var javelin_municao = 3
var javelin_nivel = 1

#Relação com Inimigo
var inimigo_perto = []

@onready var sprite = $Sprite2D
@onready var timer_andar: Timer = $TimerAndar

func _ready() -> void:
	ataque()

func _process(_delta):
	movimento()

func movimento():
	var x_mov = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	var y_mov = Input.get_action_strength("baixo") - Input.get_action_strength("cima")
	var mov = Vector2(x_mov, y_mov)
	if mov.x > 0:
		sprite.flip_h = true
	elif mov.x < 0:
		sprite.flip_h = false
	
	if mov != Vector2.ZERO:
		ultimo_mov = mov
		if timer_andar.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			timer_andar.start()
	
	velocity = mov.normalized() * velocidade_movimento
	move_and_slide()

func ataque():
	if lancagelo_nivel > 0:
		tempo_lg.wait_time = lancagelo_velocidade_ataque
		if tempo_lg.is_stopped():
			tempo_lg.start()
	if tornado_nivel > 0:
		tempo_tornado.wait_time = tornado_velocidade_ataque
		if tempo_tornado.is_stopped():
			tempo_tornado.start()
	if javelin_nivel > 0:
		spawn_javelin()

func _on_hurt_box_hurt(damage, _angulo, _empurrao):
	hp -= damage
	print(hp)


func _on_tempo_lg_timeout() -> void:
	lancagelo_municao += lancagelo_municao_base
	tempo_atq_lg.start()

func _on_tempo_atq_lg_timeout() -> void:
	if lancagelo_municao > 0:
		var lancadegelo_ataque = lanca_de_gelo.instantiate()
		lancadegelo_ataque.position = position
		lancadegelo_ataque.alvo = alvo_aleatorio()
		lancadegelo_ataque.nivel = lancagelo_nivel
		add_child(lancadegelo_ataque)
		lancagelo_municao -= 1
		if lancagelo_municao > 0:
			tempo_atq_lg.start()
		else:
			tempo_atq_lg.stop()
			
func _on_tempo_tornado_timeout() -> void:
	tornado_municao += tornado_municao_base
	tempo_atq_trnd.start()

func _on_tempo_atq_trnd_timeout() -> void:
	if tornado_municao > 0:
		var tornado_ataque = tornado.instantiate()
		tornado_ataque.position = position
		tornado_ataque.ultimo_mov = ultimo_mov
		tornado_ataque.nivel = tornado_nivel
		add_child(tornado_ataque)
		tornado_municao -= 1
		if tornado_municao > 0:
			tempo_atq_trnd.start()
		else:
			tempo_atq_trnd.stop()

func spawn_javelin():
	var javelin_total = javelin_base.get_child_count()
	var calc_spawns = javelin_municao - javelin_total
	while calc_spawns > 0:
		var javelin_spawn = javelin.instantiate()
		javelin_spawn.global_position = global_position
		javelin_base.add_child(javelin_spawn)
		calc_spawns -= 1

func alvo_aleatorio():
	if inimigo_perto.size() > 0:
		return inimigo_perto.pick_random().global_position
	else:
		return Vector2.UP

func _on_area_detecta_inimigo_body_entered(body: Node2D) -> void:
	if not inimigo_perto.has(body):
		inimigo_perto.append(body)

func _on_area_detecta_inimigo_body_exited(body: Node2D) -> void:
	if inimigo_perto.has(body):
		inimigo_perto.erase(body)
