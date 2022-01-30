extends AudioStreamPlayer2D

func play_lesgo(speed):
	if speed > (480.0 + (480.0 * (Globals.current_difficulty / 5.0))):
		play()

func play( from_position=0.0 ):
	if !playing:
		.play(from_position)
	else:
		var asp = self.duplicate(DUPLICATE_USE_INSTANCING)
		get_parent().add_child(asp)
		asp.stream = stream
		asp.play()
		yield(asp, "finished")
		asp.queue_free()
