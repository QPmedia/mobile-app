define (require, exports, module) ->
	exports.firstof = (indent, parser) ->
		for arg in @args
			value = parser.parseVariable(arg)
			if value?
				return value

	return exports
