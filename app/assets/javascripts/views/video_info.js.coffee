class R.Views.VideoInfo extends Backbone.View
	initialize: ->
		_.bindAll @

		setInterval (=>
			$('.start-time').text(Window.formatTime(@model.get 'pendingStart'))
			$('.current-time').text(Window.formatTime(@model.get 'current'))
			$('.end-time').text(Window.formatTime(@model.get 'pendingEnd'))

		), 33.33
