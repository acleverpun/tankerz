extends Tree

onready var root = create_item()

func _ready():
	set_hide_root(true)

func populate(units):
	for unit in units:
		addItem(unit)

func addItem(unit, column = 0, parent = root):
	create_item(parent).set_text(column, unit.get_name())
