extends TextureButton
signal ButtonPressed
var TowerName = "Gun" 
func on_button_pressed():
	ButtonPressed.emit(TowerName)
	
	
