extends MarginContainer

signal board_size_update
signal show_numbers_update
signal hide_settings
signal background_update

onready var size_value = $M/V/M/G/SizeValue
onready var file_dialog = $M/FileDialog
onready var message_popup = $M/PopupMessage

func _on_SizeSlider_value_changed(value):
	size_value.text = str(value)
	emit_signal("board_size_update", value)


func _on_ShowNumbers_toggled(button_pressed):
	emit_signal("show_numbers_update", button_pressed)


func _on_BackButton_pressed():
	emit_signal("hide_settings")


func _on_FileButton_pressed():
		# Create an HTTP request node and connect its completion signal
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")

	# Perform the HTTP request. The URL below returns a PNG image as of writing.
	var http_error = http_request.request("https://via.placeholder.com/500")
	if http_error != OK:
		print("An error occurred in the HTTP request.")

func _http_request_completed(result, response_code, headers, body):
	var image = Image.new()
	var image_error = image.load_png_from_buffer(body)
	if image_error != OK:
		print("An error occurred while trying to display the image.")

	var texture = ImageTexture.new()
	texture.create_from_image(image)
	emit_signal("background_update", texture)
