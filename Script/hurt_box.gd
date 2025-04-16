extends Area2D

@export_enum("Cooldown","HitOnce","DisableHitBox") var HurtBoxType = 0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var desabilita_timer: Timer = $DesabilitaTimer

signal hurt(damage, angulo, empurrao)

var hit_once_array = []

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("ataque"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: #hurt_box inspector está como: Cooldown
					collision_shape_2d.call_deferred("set","disable",true)
					desabilita_timer.start()
				1: #hurt_box inspector está como: HitOnce
					if hit_once_array.has(area) == false:
						hit_once_array.append(area)
						if area.has_signal("remove_do_array"):
							if not area.is_connected("remove_do_array", Callable(self,"remove_da_lista")):
								area.connect("remove_do_array", Callable(self, "remove_da_lista"))
							
					else:
						return
				2: #hurt_box inspector está como: DisableHitBox
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			var angulo = Vector2.ZERO
			var empurrao = 1
			if not area.get("angulo") == null:
				angulo = area.angulo
			if not area.get("forca_empurrao") == null:
				empurrao = area.forca_empurrao
				
			emit_signal("hurt",damage, angulo, empurrao)
			if area.has_method("acertar_inimigo"):
				area.acertar_inimigo(1)

func remove_da_lista(object):
	if hit_once_array.has(object):
		hit_once_array.erase(object)

func _on_desabilita_timer_timeout() -> void:
	collision_shape_2d.call_deferred("set","disable",true)
