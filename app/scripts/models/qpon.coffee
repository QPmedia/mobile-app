define (require) ->
	app      = require("app")
	Backbone = require("backbone")

	###
		no need to use something proper like esri/terraformer or whatever
	###
	class Point
		fromWKT = (wkt) ->
			re = ///
				POINT\s\( # 'POINT ('
				([\d\.]+) # longitude (float/number)
				\s        # whitespace between coords
				([\d\.]+) # latitude
				\)        # ')'
			///
			result = re.exec(wkt)
			@lat = result[2]
			@lng = result[1]
		toWKT: ->
			"POINT (#{@lng} #{@lat})"

		constructor: (coords...) ->
			# support just WKT for now
			@fromWKT(coords)
			# FIXME: find a way to distinguish between object/dict and [Geoposition]
			###
			switch typeof(coords)
				when "[Geoposition]"
					@lat = coords.coords.latitude
					@lng = coords.coords.longitude
				when "string"
					# assume WKT
					@fromWKT(coords)

				when "object"
					if coords.length is 2
						# assume (lat,lng)
						@lat = coords[0]
						@lng = coords[1]
					else
						# might be an object/dict
						@lat = coords.lat
						@lng = coords.lng
			###

	class Qpon extends Backbone.Model
		urlRoot:->"#{app.API_URL}qpon/"

		toRad: (num)->
			num*Math.PI/180.0
		distance:=>
			mp = @get("locations",null)
			return "n/a" unless app.location and mp

			s = mp.replace(/[\(\)]/g,"")
			ll = s.split(" ")
			lon1 = parseFloat(ll[1])
			lat1 = parseFloat(ll[2])

			lon2 = app.location.coords.longitude
			lat2 = app.location.coords.latitude
			R = 6371

			dLat = @toRad((lat2-lat1))
			dLon = @toRad((lon2-lon1))
			lat1 = @toRad(lat1)
			lat2 = @toRad(lat2)

			a = Math.sin(dLat/2) * Math.sin(dLat/2) +  Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2)
			c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
			d = R * c;

			return d
