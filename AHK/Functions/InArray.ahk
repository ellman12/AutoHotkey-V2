;Checks if an item is already in an array.
inArray(Value, Array) {
	for k, v in Array
		if (v == Value)
			return true
	return false
}