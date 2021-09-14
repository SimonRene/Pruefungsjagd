extends Control




func openWebsite(name):
	closeAllWebsites()
	
	match(name):
		"Google":
			$Google.visible = true
		"GoogleSearchedPruefung":
			$GoogleSearchedPruefung.visible = true
		"GuteFrage":
			$GuteFrage.visible = true
			


func closeAllWebsites():
	# hide all available websites
	$Google.visible = false
	$GoogleSearchedPruefung.visible = false


func searchOnGoogle(searchText):
	
	if $Google/SearchArea/SearchBar.typed:
		print("Searched for: ", searchText)
	
		# open the resuts page
		openWebsite("GoogleSearchedPruefung")

func _on_GooglePageBtn_pressed():
	openWebsite("Google")


func _on_searchButton_pressed():
	var searchText = $Google/SearchArea/SearchBar.text
	searchOnGoogle(searchText)


func _on_Result02Button_pressed():
	# Prof Layton
	$GuteFrage/result02/ThoughtBox.visible = true

func _on_Result03Button_pressed():
	$GuteFrage/result03/ThoughtBox2.visible = true


func _on_Result04Button_pressed():
	if !$GuteFrage/result04/ThoughtBox3.visible:
		QuestLog.finish_a_quest(5)
		QuestLog.add_quest(10)
		GameController.finishedFirstLevel = true
		$GuteFrage/result04/ThoughtBox3.visible = true
	




func _on_Result05Button_pressed():
	$GuteFrage/result05/ThoughtBox4.visible = true


func _on_GuteFrage_pressed():
	openWebsite("GuteFrage")
