class @RollPlayer
	constructor: (options, readyCallback) ->
		try
			@youtubeID = parseYoutubeUrl(options['youtube_url'])
			@duration  = getYoutubeDuration(@youtubeID)

			params = "allowScriptAccess": "always"
			atts = "id": options["player_id"]	
			atts = "id": "ytPlayer"
			swfobject.embedSWF("http://www.youtube.com/apiplayer?version=3&enablejsapi=1", 
				options["container_element"], "480", "295", "9", null, null, params, atts)
			@player = $("#ytPlayer")[0]

			# window.onYouTubePlayerReady = (event) ->
				# ytplayer = document.getElementById(playerid)
				# ytplayer.playVideo()
		catch e
			# handle error

	parseYoutubeUrl = (url) ->
		regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/
		match = url.match(regExp)

		if match and (match[2].length is 11)
			 return match[2]
		else
			throw new Error "invalid youtube url: " + url
	
	getYoutubeDuration = (id) ->
		apiUrl = "http://gdata.youtube.com/feeds/api/videos?q=#{@youtubeID}&max-results=1&v=2&alt=jsonc"
		$.getJSON apiUrl, (json_resp) ->
			if json_resp
				duration = 450 #json_resp.data.items[0].duration
			else
				throw new Error "no JSON response data"
	
	window.onYouTubePlayerReady = (playerId) ->
		ytplayer = $("#ytPlayer")[0]
		ytplayer.loadVideoById({'videoId': @youtubeID, 'startSeconds': 5, 'endSeconds': 60, 'suggestedQuality': 'large'})
		ytplayer.playVideo()

	# 	ytplayer = document.getElementById("ytPlayer")
	# 	ytplayer.cueVideoById "ylLzyHk54Z0"
	# 	ytplayer.playVideo()
		
	loadVideo = (videoId) ->
		params = allowScriptAccess: "always"
		atts = id: "ytPlayer"
		swfobject.embedSWF "http://www.youtube.com/apiplayer?" + "version=3&enablejsapi=1&playerapiid=player1", "youtubePlayer", "480", "295", "9", null, null, params, atts
		$("#ytPlayer")[0].loadVideoById("9bZkp7q19f0")
