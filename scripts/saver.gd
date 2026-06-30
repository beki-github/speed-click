extends Node

const SAVE_PATH = "user://highscore.json"

var highscore: int = 0

func save_highscore(new_score: int) -> void:
	# Update our variable
	highscore = new_score
	
	# 1. Create a dictionary to hold the data
	var data = {
		"highscore": highscore
	}
	
	# 2. Convert to JSON string
	var json_string = JSON.stringify(data)
	
	# 3. Save to file
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(json_string)
	file.close()
	print("Highscore saved: ", highscore)

func load_highscore() -> int:
	# 1. Check if file exists
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found, returning 0.")
		return 0
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	
	
	
	var data = JSON.parse_string(json_string)
	
	if data is Dictionary:
		highscore = data.get("highscore", 0)
		return highscore
		
	return 0
