extends Equipment

func use(apply: Callable):
	print("Fireballlll")
	apply.call(stats)
