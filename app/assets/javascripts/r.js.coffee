window.R =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	initialize: ->
		videoModel = new R.Models.Video({youtubeId: 'DE9NsrKzSq8', duration: 100, start: 40, cue: 45, end: 90})
		new R.Views.SliderView({ el: $( "#slider" ), model: videoModel })
		new R.Views.VideoView({ el: $( "#video" ), model: videoModel })
		new R.Views.VideoInfo({el: $( "#info" ), model: videoModel })
$(document).ready ->
	R.initialize()

