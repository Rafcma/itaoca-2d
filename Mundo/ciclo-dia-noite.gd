extends CanvasModulate

@export var gradiente: GradientTexture1D

func _ready():
	var ciclo = get_tree().get_first_node_in_group("ciclo_dia")
	if ciclo:
		ciclo.connect("fase_alterada", _atualizar_cor)
		_atualizar_cor(ciclo.get_fase())

func _atualizar_cor(fase: float) -> void:
	self.color = gradiente.gradient.sample(clamp(fase, 0.0, 1.0))
