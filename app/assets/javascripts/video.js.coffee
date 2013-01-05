# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  player = new RollPlayer(
    youtube_url: "http://www.youtube.com/watch?v=DE9NsrKzSq8"
    container_element: "player"
    player_id: "ytPlayer"
    start_time: 100
    end_time: 105, ->
    $("#slider-range").on "slidechange", ->
      startTime = $("#slider-range").slider('values')[0]
      endTime   = $("#slider-range").slider('values')[1]

      $("#video_start_time").val(startTime)
      $("#video_end_time").val(endTime)
  )












