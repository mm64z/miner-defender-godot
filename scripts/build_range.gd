extends Area2D

var build_sites: Array[Node2D] = []

# return the first for now
func get_valid_site() -> Node2D:
	return build_sites[0]
	
func is_valid_site() -> bool:
	return build_sites.size() > 0

func _on_body_entered(body: Node2D) -> void:
	build_sites.append(body)

func _on_body_exited(body: Node2D) -> void:
	build_sites.erase(body)

func _on_area_entered(area: Area2D) -> void:
	build_sites.append(area)

func _on_area_exited(area: Area2D) -> void:
	build_sites.erase(area)
