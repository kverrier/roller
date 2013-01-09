class R.Views.VideoView extends Backbone.View

	initialize: ->
		_.bindAll @

		$(@el).tubeplayer(
			width: 600 # the width of the player
			height: 450 # the height of the player
			allowFullScreen: "true" # true by default, allow user to go full screen
			initialVideo: @model.get 'youtubeId' # the video that is loaded into the player
			preferredQuality: "default" # preferred quality: default, small, medium, large, hd720
			onPlayerPlaying: (id) =>
				$(@el).trigger 'play'
			onPlayerPaused: =>
				$(@el).trigger 'pause'
			onStop: -> 
				$(@el).trigger 'stop'
			onSeek: (time) -> 
				$(@el).trigger 'seek'
			onMute: -> 
			onUnMute: -> 
		)

		@model.on 'change:cue', (=> $(@el).tubeplayer("seek", @model.get('cue')))

		$.tubeplayer.defaults.afterReady = ($player) =>
			setInterval (=>
				@model.set 'current', $(@el).tubeplayer("data").currentTime
			), 200

			@model.set 'duration', $(@el).tubeplayer("data").duration


	events:
		'play': 'playVideo'

	playVideo: ->
		console.log 'play trigger'


