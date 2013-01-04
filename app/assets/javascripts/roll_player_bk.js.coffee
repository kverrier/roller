root = exports ? this

class @RollPlayerBk
	ready: false

	constructor: (options, readyCallback) ->
		@youtubeID = parseYoutubeUrl(options['youtube_url'])
		@duration  = getYoutubeDuration(@youtubeID)
		@ytplayer = null

		params = "allowScriptAccess": "always"
		atts = "id": options["player_id"]	
		atts = "id": "ytPlayer"
		swfobject.embedSWF("http://www.youtube.com/apiplayer?version=3&enablejsapi=1", 
			options["container_element"], "480", "295", "9", null, null, params, atts)

		root.onYouTubePlayerReady = (playerId) =>
			console.log 'YouTube player is ready...'
			@ytplayer = $("#ytPlayer")[0]
			@ytplayer.addEventListener("onStateChange", "@onPlayerStateChange");
			@loadVideo()
			@ready = true

	test: () ->
		'test'

	loadVideo: () =>
		if @ytplayer
			@ytplayer.cueVideoById({'videoId': @youtubeID, 'startSeconds': 5, 'endSeconds': 8, 'suggestedQuality': 'large'})
		else
			throw 'Cannot cue video with null ytplater'

	playVideo: () =>
		# if @ytplayer
		@ytplayer.playVideo()
		# else
			# throw 'Cannot play video with null ytplater'

	getPlayerState: () =>
		if @ytplayer
			@ytplayer.getPlayerState()
		else
			throw 'Cannot get state of null ytplayer'

	onPlayerStateChange = ->
		console.log "YouTube player changed state..."

	parseYoutubeUrl = (url) ->
		regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/
		match = url.match(regExp)

		if match and (match[2].length is 11)
			 return match[2]
		else
			throw "invalid youtube url: #{url}"
	
	getYoutubeDuration = (id) ->
		apiUrl = "http://gdata.youtube.com/feeds/api/videos?q=#{@youtubeID}&max-results=1&v=2&alt=jsonc"
		$.getJSON apiUrl, (json_resp) ->
			if json_resp
				duration = 450 #json_resp.data.items[0].duration
			else
				throw "no JSON response data for video_id: #{@youtubeID}"

	# 	ytplayer = document.getElementById("ytPlayer")
	# 	ytplayer.cueVideoById "ylLzyHk54Z0"
	# 	ytplayer.playVideo()
		
	# loadVideo = (videoId) ->
	# 	params = allowScriptAccess: "always"
	# 	atts = id: "ytPlayer"
	# 	swfobject.embedSWF "http://www.youtube.com/apiplayer?" + "version=3&enablejsapi=1&playerapiid=player1", "youtubePlayer", "480", "295", "9", null, null, params, atts
	# 	$("#ytPlayer")[0].loadVideoById("9bZkp7q19f0")
