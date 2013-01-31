
lass R.Models.Video extends Backbone.Model
	defaults:
		'state': 'paused'

	initialize: ->

	validate: (attrs, options) ->
		if (attrs.end < attrs.start)
			return "can't end before it starts";
