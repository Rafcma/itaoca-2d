extends Node2D

@export var tempo_ciclo: float = 120.0
var tempo := 0.0

signal fase_alterada(fase: float)

func _ready():
	add_to_group("ciclo_dia")

func _process(delta):
	tempo += delta
	var fase = fmod(tempo / tempo_ciclo, 2.0)
	if fase > 1.0:
		fase = 2.0 - fase
	emit_signal("fase_alterada", fase)

func get_fase() -> float:
	var fase = fmod(tempo / tempo_ciclo, 2.0)
	if fase > 1.0:
		fase = 2.0 - fase
	return fase
