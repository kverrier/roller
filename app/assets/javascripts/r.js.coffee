window.R =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	initialize: ->
		videoModel = new R.Models.Video({youtubeId: 'DE9NsrKzSq8', start: 40, cue: 40, end: 43})
		new R.Views.SliderView({ el: $( "#slider" ), model: videoModel })
		new R.Views.VideoView({ el: $( "#video" ), model: videoModel })
		new R.Views.VideoInfo({el: $( "#info" ), model: videoModel })
		new R.Views.VideoControls({model: videoModel})
		new R.Views.VideoForm({model: videoModel})
		new R.Views.VideoLoader({model: videoModel})


$(document).ready ->
	R.initialize()

