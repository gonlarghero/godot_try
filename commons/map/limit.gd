extends Node

var border_limit

func init_limit(node):
	border_limit = node.get_viewport_rect().size
	
func set_limit(node):
	node.position.x = clamp(node.position.x, 0, border_limit.x)
	node.position.y = clamp(node.position.y, 0, border_limit.y)
