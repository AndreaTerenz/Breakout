extends Control

signal startGame

onready var scoreLbl = $MainCont/HBoxContainer/ScoreLbl
onready var deathsLbl = $MainCont/HBoxContainer/DeathsLbl

func increaseScore() -> void:
	increaseLabel(scoreLbl, "Score: ")
	
func increaseDeaths() -> void:
	increaseLabel(deathsLbl, "Deaths: ")

func increaseLabel(l : Label, header : String) -> void:
	var current = int(l.text)
	l.text = header + str(current + 1)
	
func resetCounts() -> void:
	deathsLbl.text = "Deaths: " + str(0)
	scoreLbl.text = "Score: " + str(0)

func startBtnPressed() -> void:
	$MainCont/StartMenu.hide()
	$MainCont/HBoxContainer.show()
	emit_signal("startGame")

func quitBtnPressed() -> void:
	get_tree().quit()

func pauseBtnPressed() -> void:
	get_tree().paused = not(get_tree().paused)
