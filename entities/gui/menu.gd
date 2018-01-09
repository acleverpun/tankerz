extends Tree

signal select

onready var parent = get_parent()

var root

func _ready():
	set_hide_root(true)

	connect('item_activated', self, 'onDoubleClick')
	if parent.has_method('onMenuSelect'): connect('select', parent, 'onMenuSelect')

func populate(entries):
	clear()
	root = create_item()
	for entry in entries:
		addItem(entry)

func addItem(entry, column = 0, parentItem = root):
	var item = create_item(parentItem)
	item.set_text(column, entry.get_name())
	item.set_metadata(0, entry)

func onDoubleClick():
	emit_signal('select', get_selected().get_metadata(0))
