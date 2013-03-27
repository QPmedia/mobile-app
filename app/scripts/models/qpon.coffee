define (require) ->
	app      = require("app")
	Backbone = require("backbone")

	class Qpon extends Backbone.Model
		urlRoot:->"#{app.API_URL}qpon/"

		distance:=>
			mp = @get("locations",null)
			return "n/a" unless app.location and mp
			s = mp.replace(/[\(\)]/g,"")
			ll = s.split(" ")
			lon1 = parseFloat(ll[1])
			lat1 = parseFloat(ll[2])

			lon2 = app.location.coords.longitude
			lat2 = app.location.coords.latitude

			R = 6371 / 100 # 100m
			d = Math.acos(Math.sin(lat1)*Math.sin(lat2) +
                  Math.cos(lat1)*Math.cos(lat2) *
                  Math.cos(lon2-lon1)) * R;

			return d
