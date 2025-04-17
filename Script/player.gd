extends CharacterBody2D

var hp = 80
var velocidade_movimento = 40.0
var ultimo_mov = Vector2.UP

var experiencia = 0
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

#GUI
@onready var barra_exp = get_node("%BarraExp")
@onready var lbl_nivel = get_node("%lbl_nivel")
@onready var painel_nivel = get_node("%SobeNivel")
@onready var upgrade_opcoes = get_node("%UpgradeOpcoes")
@onready var item_opcoes = preload("res://Utilidades/item_opcoes.tscn")
@onready var som_sobe_nivel = get_node("%som_sobe_nivel")

@onready var sprite = $Sprite2D
@onready var timer_andar: Timer = $TimerAndar


func _ready() -> void:
	ataque()
	ajustar_barra(experiencia, calcula_experiencia_max())

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


func _on_puxa_exp_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		area.alvo = self

func _on_coleta_exp_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		var exp_gema = area.coleta()
		print("Collected exp_gema: ", exp_gema, " Type: ", typeof(exp_gema))
		calcula_experiencia(exp_gema)
		
func calcula_experiencia(exp_gema):
	var exp_necessario = calcula_experiencia_max()
	var valor_exp = exp_gema if typeof(exp_gema) == TYPE_INT or typeof(exp_gema) == TYPE_FLOAT else 0
	exp_coletado += valor_exp
	if experiencia + exp_coletado >= exp_necessario: #sobe de nivel
		exp_coletado -= exp_necessario - experiencia
		exp_nivel += 1
		lbl_nivel.text = str("--Nível: ", exp_nivel)
		experiencia = 0
		exp_necessario = calcula_experiencia_max()
		sobe_nivel()
	else: 
		experiencia += exp_coletado
		exp_coletado = 0
	
	ajustar_barra(experiencia,exp_necessario)

func calcula_experiencia_max():
	var exp_max = exp_nivel
	if exp_nivel < 20:
		exp_max = exp_nivel * 5
	elif exp_nivel < 40:
		exp_max = 95 * (exp_nivel - 19) * 8
	else:
		exp_max = 255 + (exp_nivel - 39) * 12
	
	return exp_max

func ajustar_barra(set_value=1,set_max_value=100):
	barra_exp.value = set_value
	barra_exp.max_value = set_max_value

func sobe_nivel():
	som_sobe_nivel.play()
	lbl_nivel.text = str("--Nível: ", exp_nivel)
	var tween = painel_nivel.create_tween()
	tween.tween_property(painel_nivel,"position", Vector2(220,50),0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	painel_nivel.visible = true
	var opcoes = 0
	var opcoes_totais = 3
	while opcoes < opcoes_totais:
		var opcao_de_escolha = item_opcoes.instantiate()
		upgrade_opcoes.add_child(opcao_de_escolha)
		opcoes +=1
	get_tree().paused = true

func upgrade_personagem(upgrade):
	var opcao_children = upgrade_opcoes.get_children()
	for i in opcao_children:
		i.queue_free()
	painel_nivel.visible = false
	painel_nivel.position = Vector2(800,50)
	get_tree().paused = false
	calcula_experiencia(0)
