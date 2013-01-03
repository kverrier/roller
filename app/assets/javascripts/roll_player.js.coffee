class @RollPlayer
	constructor: (youtubeUrl) ->
		try
			@youtubeID = parseYoutubeUrl(youtubeUrl)
			@duration  = getYoutubeDuration(@youtubeID)
			params = "allowScriptAccess": "always"
			atts = "id": options["player_id"]
			swfobject.embedSWF "http://www.youtube.com/apiplayer?" + "version=3&enablejsapi=1", options["container_element"], "480", "295", "9", null, null, params, atts

		catch e
			# handle error

		loadPlayer()

		tag = document.createElement("script")
		tag.src = "//www.youtube.com/iframe_api"
		firstScriptTag = document.getElementsByTagName("script")[0]
		firstScriptTag.parentNode.insertBefore tag, firstScriptTag



	parseYoutubeUrl = (url) ->
		regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/
		match = url.match(regExp)

		if match and (match[2].length is 11)
			 return match[2]
		else
			throw "invalid url"
	
	getYoutubeDuration = (id) ->
		apiUrl = "http://gdata.youtube.com/feeds/api/videos?q="+@youtubeID+"&max-results=1&v=2&alt=jsonc"
		$.getJSON apiUrl, (json_resp) ->
			if json_resp
				duration = json_resp.data.items[0].duration
			else
				throw "no JSON response data"


	window.onYouTubePlayerReady = (event) ->
		$("#player").text("changed")
		# ytplayer = document.getElementById(playerid)
		# ytplayer.playVideo()

	onYouTubePlayerReady = (playerId) ->
		ytplayer = document.getElementById("ytPlayer")
		ytplayer.cueVideoById "ylLzyHk54Z0"
		ytplayer.playVideo()
		
	loadPlayer = ->
		params = allowScriptAccess: "always"
		atts = id: "ytPlayer"
		swfobject.embedSWF "http://www.youtube.com/apiplayer?" + "version=3&enablejsapi=1&playerapiid=player1", "youtubePlayer", "480", "295", "9", null, null, params, atts

