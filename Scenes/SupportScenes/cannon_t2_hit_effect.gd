extends AnimatedSprite2D


func _ready():
	play("DeathEffect")

func _on_hit_scan_impact_finished():
	queue_free()
