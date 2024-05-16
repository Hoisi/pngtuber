extends MenuButton

var popup = self.get_popup()

var available_devices = []


func _ready():
	popup.hide_on_checkable_item_selection = false
	popup.connect("index_pressed", toggle_checked)
	available_devices = OS.get_connected_midi_inputs()

	print("midiinputselect ready" + str(available_devices))
	Global.currentMidiDevices = available_devices  # Listen to all devices by default


func _on_about_to_popup():
	popup.clear(true)
	available_devices = OS.get_connected_midi_inputs()  # update every open

	for i in range(len(available_devices)):
		popup.add_check_item(available_devices[i])
		var already_checked = available_devices[i] in Global.currentMidiDevices

		popup.set_item_checked(i, already_checked)

	update_checked_items()


func toggle_checked(index: int):
	popup.set_item_checked(index, not popup.is_item_checked(index))
	update_checked_items()


func update_checked_items():
	var checked_items = []
	for i in range(popup.get_item_count()):
		if popup.is_item_checked(i):
			checked_items.append(popup.get_item_text(i))

	Global.currentMidiDevices = checked_items
