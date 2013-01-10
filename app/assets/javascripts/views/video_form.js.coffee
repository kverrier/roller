class R.Views.VideoForm extends Backbone.View
	initialize: ->
		_.bindAll @

		$('#video_youtube_id').val(@model.get('youtubeId'))
		$('#video_start_time').val(@model.get('start'))
		$('#video_end_time').val(@model.get('end'))

		@model.on 'change:youtubeId', => $('#video_youtube_id').val(@model.get('youtubeId'))
		@model.on 'change:start', => $('#video_start_time').val(@model.get('start'))
		@model.on 'change:end', => $('#video_end_time').val(@model.get('end'))

