extends Area2D

var nivel = 1
var hp = 1
var velocidade = 100.0
var damage = 5
var forca_empurrao = 100
var tamanho_ataque = 1.0

var alvo = Vector2.ZERO
var angulo = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
signal remove_do_array(object)

func _ready():
	angulo = global_position.direction_to(alvo)
	rotation = angulo.angle() + deg_to_rad(135)
	
	match nivel:
		1:
			hp = 2
			velocidade = 100
			damage = 5
			forca_empurrao = 100
			tamanho_ataque = 1.0
	
	
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1)*tamanho_ataque,1.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play() 

func _physics_process(delta):
	position += angulo * velocidade * delta

func acertar_inimigo(carga = 1):
	hp -= carga
	if hp <= 0:
		emit_signal("remove_do_array", self)
		queue_free()

func _on_timer_timeout() -> void:
	emit_signal("remove_do_array", self)
	queue_free()
