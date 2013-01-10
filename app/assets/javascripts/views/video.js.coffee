class R.Views.VideoView extends Backbone.View

	initialize: ->
		_.bindAll @

		@setElement('#video')

		$(@el).tubeplayer(
			width: '100%' # the width of the player
			# height: 450 # the height of the player
			allowFullScreen: "true" # true by default, allow user to go full screen
			initialVideo: @model.get 'youtubeId' # the video that is loaded into the player
			preferredQuality: "default" # preferred quality: default, small, medium, large, hd720
			onPlayerPlaying: (id) =>
				@model.set 'state',  'playing'
				$(@el).trigger 'play'
			onPlayerPaused: =>
				@model.set 'state',  'paused'
				$(@el).trigger 'pause'
			onStop: -> 
				@model.set 'state',  'paused'
				$(@el).trigger 'stop'
			onSeek: (time) -> 
				$(@el).trigger 'seek'
			onMute: -> 
			onUnMute: -> 
			start: => @model.get 'start'
		)

		@playoutInterval = setInterval ( =>
			if @model.get("current") > @model.get("end")
				$(@el).tubeplayer("pause")
				@model.set 'cue', @model.get('start')
				@model.trigger 'change:cue'
		), 200


		@model.on 'change:cue', (=>
			$(@el).tubeplayer("seek", @model.get('cue'))
		)

		
		@model.on 'change:state', (=> 
			switch @model.get('state')
				when 'playing' then $(@el).tubeplayer('play', @model.get('play'))
				when 'paused' then $(@el).tubeplayer('pause', @model.get('play'))
		)

		$.tubeplayer.defaults.afterReady = ($player) =>
		
			setInterval (=>
				@model.set 'current', $(@el).tubeplayer("data").currentTime
			), 200

			$(@el).tubeplayer("seek", @model.get('start') )
			$(@el).tubeplayer("pause")



			@model.set 'duration', $(@el).tubeplayer("data").duration

			@model.on 'change:youtubeId', (=> 
				$(@el).tubeplayer("cue", @model.get('youtubeId'))
				@setYoutubeDuration(@model.get('youtubeId'))

				@model.set 'start', 0
				@model.set 'cue', 0
			)

	setYoutubeDuration: (id) =>
		console.log 
		apiUrl = "http://gdata.youtube.com/feeds/api/videos?q=#{@model.get('youtubeId')}&max-results=1&v=2&alt=jsonc"
		$.getJSON apiUrl, (json_resp) =>
			if json_resp
				duration = json_resp.data.items[0].duration
				console.log duration
				@model.set 'duration', duration
				@model.set 'end', duration



