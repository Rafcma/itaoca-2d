extends Area2D

var nivel = 1
var hp = 999
var velocidade = 100.0
var damage = 5
var tamanho_ataque = 1.0
var forca_empurrao = 100


var ultimo_mov = Vector2.ZERO
var angulo = Vector2.ZERO
var angulo_menos = Vector2.ZERO
var angulo_mais = Vector2.ZERO

signal remove_do_array(object)

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	match nivel:
		1:
			hp = 999
			velocidade = 100.0
			damage = 5
			tamanho_ataque = 1.0
			forca_empurrao = 100
	
	var move_menos = Vector2.ZERO
	var move_mais = Vector2.ZERO
	match ultimo_mov:
		Vector2.UP,Vector2.DOWN:
			move_menos  = global_position + Vector2(randf_range(-1,-0.25), ultimo_mov.y)*500
			move_mais  = global_position + Vector2(randf_range(0.25,1), ultimo_mov.y)*500
		Vector2.RIGHT,Vector2.LEFT:
			move_menos  = global_position + Vector2(ultimo_mov.x, randf_range(-1,-0.25))*500
			move_mais  = global_position + Vector2(ultimo_mov.x,randf_range(0.25,1))*500
		Vector2(1,1), Vector2(-1,-1), Vector2(1,-1), Vector2(-1,1):
			move_menos  = global_position + Vector2(ultimo_mov.x, ultimo_mov.y * randf_range(0,0.75))*500
			move_mais  = global_position + Vector2(ultimo_mov.x * randf_range(0,0.75), ultimo_mov.y)*500
			
	angulo_menos = global_position.direction_to(move_menos)
	angulo_mais = global_position.direction_to(move_mais)
	
	var initial_tween = create_tween().set_parallel(true)
	initial_tween.tween_property(self, "scale", Vector2(1,1)*tamanho_ataque, 3).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	var velocidade_final = velocidade
	velocidade = velocidade/5.0
	initial_tween.tween_property(self,"velocidade", velocidade_final, 5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	initial_tween.play()
	
	
	var tween = create_tween()
	var define_angulo = randi_range(0,1)
	if define_angulo == 1:
		angulo = angulo_menos
		tween.tween_property(self, "angulo", angulo_mais,2)
		tween.tween_property(self, "angulo", angulo_menos,2)
		tween.tween_property(self, "angulo", angulo_mais,2)
		tween.tween_property(self, "angulo", angulo_menos,2)
		tween.tween_property(self, "angulo", angulo_mais,2)
		tween.tween_property(self, "angulo", angulo_menos,2)
	else:
		angulo = angulo_mais
		tween.tween_property(self, "angulo", angulo_menos,2)
		tween.tween_property(self, "angulo", angulo_mais,2)
		tween.tween_property(self, "angulo", angulo_menos,2)
		tween.tween_property(self, "angulo", angulo_mais,2)
		tween.tween_property(self, "angulo", angulo_menos,2)
		tween.tween_property(self, "angulo", angulo_mais,2)
	tween.play()

func _physics_process(delta: float) -> void:
	position += angulo * velocidade * delta
	



func _on_timer_timeout() -> void:
	emit_signal("remove_do_array")
	queue_free()
