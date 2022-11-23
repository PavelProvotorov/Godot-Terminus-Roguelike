extends Label

export (String) var ticker_text = "Ammo pack "
export (int) var num_chars_display = 20

var current_char_pos = 0
onready var text_length = ticker_text.length()

var cumulative_delta = 0
func _process(delta):
	cumulative_delta += delta
	if cumulative_delta > 0.1:
		set_ticker_text()
		cumulative_delta = 0
	
	
func set_ticker_text():
#	Set the text to the current position + some number of characters
	text = ticker_text.substr(current_char_pos, num_chars_display)
	
#	If there is overflow (meaning that "end" of the string is at a higher index than the length of the ticker text)
#	then loop back around and append the start of the text as needed
	if current_char_pos + num_chars_display > ticker_text.length():
#		print("Text overflow, looping")
		text += ticker_text.substr(0, current_char_pos + num_chars_display - ticker_text.length())

	current_char_pos += 1
# 	Mod the char position so it goes back to zero
	current_char_pos = current_char_pos % text_length
