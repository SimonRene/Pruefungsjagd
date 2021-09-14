extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func close():
	get_node(".").visible = false
	GameController.pause_player(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func openDesktop():
	$Monitor/ScreenInternet.visible = false
	$Monitor/ScreenDesktop.visible = true

func openInternet():
	$Monitor/ScreenDesktop.visible = false
	$Monitor/ScreenInternet.visible = true

func _on_Button_pressed():
	close()


func _on_DesktopButton_pressed():
	openDesktop()


func _on_InternetButton_pressed():
	openInternet()

