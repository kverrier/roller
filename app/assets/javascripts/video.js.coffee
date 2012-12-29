# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
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
    alert "yolo"
    event.target.playVideo()
    return

  done = false
  window.onPlayerStateChange = (event) ->
    if event.data is YT.PlayerState.PLAYING and not done
      setTimeout stopVideo, 6000
      done = true

  stopVideo = ->
    myPlayer.stopVideo()

  formatTime = (secs) -> Math.floor(secs / 60) + "m" + secs % 60 + "s"


  sliderChange = (event, ui) ->
    $("#video_start_time").val(ui.values[0])
    $("#video_end_time").val(ui.values[1])


  $("#slider-range").slider
    orientation: "horizontal"
    range: true
    min: 0
    max: 500
    values: [10, 200]
    slide: (event, ui) ->
      $("#echo").html "" + formatTime(ui.values[0]) + " - " + formatTime(ui.values[1])
    change: sliderChange

  parseYoutubeUrl = (url) ->
    video_id = url.split("v=")[1]
    ampersandPosition = video_id.indexOf("&")
    video_id = video_id.substring(0, ampersandPosition)  unless ampersandPosition is -1
    video_id

  values = ($("#slider-range").slider("option", "values"))

  $("#echo").html formatTime(values[0]) + " - " + formatTime(values[1])

  $("#load-video-btn").click (event) ->
    parsed_id = parseYoutubeUrl($("#youtube_url").val())
    myPlayer = new YT.Player("player",
      height: "390"
      width: "640"
      videoId: parsed_id
      playerVars:
        'autoplay': 0
        'controls': 0
        'wmode': 'opaque'
        'showinfo': 0
        'autohide': 0
#        'start' : $("#video_start_time")
      events:
        'onReady': onPlayerReady
        'onStateChange': onPlayerStateChange
    )
    return





