# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  updateTime = ->
    $("#current-time").html(formatTime(myPlayer.getCurrentTime()))


  done = false
  timer = null
  id = $("#video_youtube_id").val()
  url = "http://gdata.youtube.com/feeds/api/videos?q="+id+"&max-results=1&v=2&alt=jsonc"
  $.getJSON url, (response) ->
    duration = response.data.items[0].duration
    $("#slider-range").slider
      orientation: "horizontal"
      range: true
      min: 0
      max: duration
      values: [ $("#video_start_time").val(), $("#video_end_time").val()]
      slide: (event, ui) ->
        clearTimeout(timer)
        $("#echo").html "" + formatTime(ui.values[0]) + " - " + formatTime(ui.values[1])
      change: sliderChange



  sliderChange = (event, ui) ->
    console.log event
    start = ui.values[0]
    end = ui.values[1]
    $("#video_start_time").val(start)
    $("#video_end_time").val(end)
    myPlayer.seekTo(start, true)
    clearTimeout(timer)
    timer = setTimeout(stopVideo, (end - start)*1000)

  $("#slider-range").slider
    orientation: "horizontal"
    range: true
    min: 0
    max: 500
    values: [ $("#video_start_time").val(), $("#video_end_time").val()]
    slide: (event, ui) ->
      clearTimeout(timer)
      $("#echo").html "" + formatTime(ui.values[0]) + " - " + formatTime(ui.values[1])
    change: sliderChange
   

  tag = document.createElement("script")
  tag.src = "//www.youtube.com/iframe_api"
  firstScriptTag = document.getElementsByTagName("script")[0]
  firstScriptTag.parentNode.insertBefore tag, firstScriptTag



  myPlayer = null
  window.onYouTubeIframeAPIReady = ->
    myPlayer = new YT.Player("player",
      height: "390"
      width: "640"
      videoId: "DE9NsrKzSq8"
      playerVars:
        'autoplay': 0
        'controls': 0
        'wmode': 'opaque'
        'showinfo': 0
        'autohide': 0
      events:
        'onReady': onPlayerReady
        'onStateChange': onPlayerStateChange
    )
    return

  window.onPlayerReady = (event) ->
    event.target.seekTo($("#video_start_time").val(), true)
    setInterval( updateTime, 200 )

    return

  window.onPlayerStateChange = (event) ->
    clearTimeout(timer)

    endTime = $("#video_end_time").val()
    timeLeft = endTime - myPlayer.getCurrentTime()

    console.log timeLeft

    if(timeLeft <= 0)
      myPlayer.seekTo($("#video_start_time").val())
    else
      if event.data is YT.PlayerState.PLAYING and not done
        console.log "Setting timeout in "+timeLeft+" secs"
        timer = setTimeout(stopVideo, timeLeft*1000)




  stopVideo = ->
    myPlayer.stopVideo()

  formatTime = (secs) -> Math.floor(secs / 60) + "m" + secs % 60 + "s"


  

  parseYoutubeUrl = (url) ->
    video_id = url.split("v=")[1]
    ampersandPosition = video_id.indexOf("&")
    video_id = video_id.substring(0, ampersandPosition)  unless ampersandPosition is -1
    video_id

  values = ($("#slider-range").slider("option", "values"))

  $("#echo").html formatTime(values[0]) + " - " + formatTime(values[1])

  $("#load-video-btn").click (event) ->
    clearTimeout(timer);
    parsed_id = parseYoutubeUrl($("#youtube_url").val())
    $("#video_youtube_id").val(parsed_id)

    start = $("#video_start_time").val()
    end   = $("#video_end_time").val()


    ytUrl = "http://www.youtube.com/v/" + parsed_id + "?version=3";
    myPlayer.loadVideoByUrl
      mediaContentUrl: ytUrl
      startSeconds: start
      # endSeconds: end
      suggestedQuality: "large"


    id = $("#video_youtube_id").val()
    url = "http://gdata.youtube.com/feeds/api/videos?q="+id+"&max-results=1&v=2&alt=jsonc"
    
    $.getJSON url, (response) ->
      duration = response.data.items[0].duration
      $("#video_start_time").val(0)
      $("#video_end_time").val(duration)


      $("#slider-range").slider
        orientation: "horizontal"
        range: true
        min: 0
        max: 500
        values: [ $("#video_start_time").val(), $("#video_end_time").val()]
        slide: (event, ui) ->
          clearTimeout(timer)
          $("#echo").html "" + formatTime(ui.values[0]) + " - " + formatTime(ui.values[1])
        change: sliderChange

  

  return







