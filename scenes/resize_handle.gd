extends Button
class_name ResizeHandle
# Responsabilities
# @respo: send resize messages


# Signals
signal column_resized(width_left: float, width_right: float)

# References
var left_column: Column
var right_column: Column


func _ready() -> void:
    var index: int = get_index()
    for child in get_parent().get_children():
        if child.get_index() + 1 == index:
            left_column = child
        elif child.get_index() - 1 == index:
            right_column = child


func _process(delta: float) -> void:
    if !button_pressed:
        return

    var mouse_x: float = get_global_mouse_position().x
    if mouse_x < left_column.global_position.x + left_column.get_minimum_width():
        return
    if mouse_x > right_column.global_position.x + right_column.custom_minimum_size.x - right_column.get_minimum_width():
        return

    var delta_x: float = mouse_x - self.global_position.x

    left_column.custom_minimum_size.x += delta_x
    right_column.custom_minimum_size.x -= delta_x
