extends Label

func _ready(): Globals.score_text = self
func update_text(): self.text = str(Globals.score)
