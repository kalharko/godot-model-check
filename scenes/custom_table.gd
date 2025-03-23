extends HBoxContainer
class_name CustomTable
# Responsabilities
# @respo: set columns width at ready
# @respo: set columns width when ResizeHandle is draged


# References
var columns: Array[VBoxContainer] = []
var handles: Array[ResizeHandle] = []


func _ready() -> void:
	# References
	for child in get_children():
		if child is VBoxContainer:
			columns.append(child)

	# Subscibe to resize signals
	for child in get_children():
		if child is ResizeHandle:
			child.column_resized.connect(_on_column_resized)
			handles.append(child)

	# compute default column width
	var handle_width_sum: float = 0
	for handle in handles:
		handle_width_sum += handle.size.x
	var default_column_width: float = (self.size.x - handle_width_sum) / columns.size()

	# set initial column width	
	for column in columns:
		column.custom_minimum_size.x = default_column_width


func _on_column_resized(width_left: float, width_right: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
