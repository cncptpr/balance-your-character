extends Equipment

func use(apply: Callable):
	print("Sword used")
	apply.call(stats)
