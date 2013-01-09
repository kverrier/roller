class R.Views.VideoInfo extends Backbone.View
	initialize: ->
		_.bindAll @

		setInterval (=>
			$('.start-time').text(Window.formatTime(@model.get 'start'))
			$('.current-time').text(Window.formatTime(@model.get 'current'))
			$('.end-time').text(Window.formatTime(@model.get 'end'))

		), 33.33

		console.log 'prints'