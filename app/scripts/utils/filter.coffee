define (require, exports, module) ->
	exports.truncate = (input, len) -> input[0..len-1]
	exports.truncatewords = (input, num) -> input.split(" ")[0..num-1].join(" ")

	return exports