extends PointLight2D

@export var intensidade_maxima: float = 1.0
var fase_atual: float = 0.0

func _ready():
	var ciclo = get_tree().get_first_node_in_group("ciclo_dia")
	if ciclo:
		ciclo.connect("fase_alterada", _atualizar_luz)
		fase_atual = ciclo.get_fase()
		_atualizar_luz(fase_atual)

func _atualizar_luz(fase: float) -> void:
	fase_atual = fase
	var intensidade = clamp(1.0 - abs(fase - 0.5) * 2.0, 0.0, 1.0)
	self.energy = intensidade * intensidade_maxima
	self.visible = self.energy > 0.1
