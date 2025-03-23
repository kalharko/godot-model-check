extends VBoxContainer
class_name Column


func get_minimum_width() -> float:
    var minimum_width: float = 0
    for child in get_children():
        if child.custom_minimum_size.x > minimum_width:
            minimum_width = child.custom_minimum_size.x
    return minimum_width
        
