class R.Views.VideoLoader extends Backbone.View

	initialize: ->
		_.bindAll @

		@el = '#video-loader'

		@setElement(@el)

	events:
		'click .load': 'updateYoutubeId'

	updateYoutubeId: ->
		@model.set 'youtubeId', @parseYoutubeUrl($('#youtube_url').val())


	parseYoutubeUrl: (url) ->
		video_id = url.split("v=")[1]
		ampersandPosition = video_id.indexOf("&")
		video_id = video_id.substring(0, ampersandPosition)  unless ampersandPosition is -1
		video_id