extends StaticBody2D

var card: Node2D:
	set(value):
		if card == value: return
		if card != null: 
			self.get_tree() \
				.create_tween() \
				.tween_property(
					card, 
					"global_position", 
					card.inital_position, 
					0.2
				).set_ease(Tween.EASE_OUT)
		card = value
	get: return card
