class @RollPlayer
    constructor: (options, readyCallback) ->
        @youtubeID = parseYoutubeUrl(options['youtube_url'])
        @duration  = getYoutubeDuration(@youtubeID)
       
        $videoContainter = $("#"+options['container_element'])

        $videoContainter.tubeplayer(
            width: 600 # the width of the player
            height: 450 # the height of the player
            allowFullScreen: "true" # true by default, allow user to go full screen
            initialVideo: @youtubeID # the video that is loaded into the player
            preferredQuality: "default" # preferred quality: default, small, medium, large, hd720
            onPlay: (id) -> 
            onPause: -> 
            onStop: -> 
            onSeek: (time) -> 
            onMute: -> 
            onUnMute: -> 
        )

        ### Executes when YouTube video player is ready ###
        $.tubeplayer.defaults.afterReady = ($player) =>
            options['start_time'] ?= 0
            options['end_time'] ?= $videoContainter.tubeplayer("data").duration
            @startTime = options['start_time']
            @endTime   = options['end_time']

            $("#slider").slider
                orientation: "horizontal"
                min: 0
                value: @startTime
                max: $videoContainter.tubeplayer("data").duration
                slide: (event, ui) ->
                change: (event, ui) -> 
                start: (event, ui) ->
                stop: (event, ui) ->

            $("#slider-range").slider
                orientation: "horizontal"
                range: true
                min: 0
                values: [@startTime, @endTime]
                max: $videoContainter.tubeplayer("data").duration
                slide: (event, ui) =>
                    @startTime = ui.values[0]
                    @endTime   = ui.values[1]
                change: (event, ui) ->
                start: (event, ui) ->
                stop: (event, ui) ->

            ### Set up listeners for player head ###
            updatePlayheadTimer = null

            $("#slider").on "slidestart", ->
                clearInterval(updatePlayheadTimer)

            $("#slider").on "slidestop", ->
                seekToTime = $("#slider").slider("value")
                $videoContainter.tubeplayer("seek", seekToTime)
                updatePlayheadTimer = window.setInterval (->
                    seektime = $videoContainter.tubeplayer("data").currentTime
                    $("#slider").slider('value', seektime)
                ), 1000

            updatePlayheadTimer = window.setInterval (->
                seektime = $videoContainter.tubeplayer("data").currentTime
                $("#slider").slider('value', seektime)
            ), 1000

            window.setInterval ( =>
                if $videoContainter.tubeplayer("data").currentTime < @startTime
                    $videoContainter.tubeplayer("seek", @startTime)
                if $videoContainter.tubeplayer("data").currentTime > @endTime
                    $videoContainter.tubeplayer("pause")
                    $videoContainter.tubeplayer("seek", @endTime - 1)
            ), 1000

            ### Fire ready callback ###
            readyCallback()

        ### Set up buttons for controlling the video ###
        $(".play").click ->
            $("#youtube-player-container").tubeplayer "play"

        $(".pause").click ->
            $("#youtube-player-container").tubeplayer "pause"

        $(".stop").click ->
            $("#youtube-player-container").tubeplayer "stop"

        $(".mute").click ->
            $("#youtube-player-container").tubeplayer "mute"

        $(".unmute").click ->
            $("#youtube-player-container").tubeplayer "unmute"

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
    

