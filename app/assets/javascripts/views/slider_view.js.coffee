class R.Views.SliderView extends Backbone.View

	initialize: ->
		_.bindAll @

		@current = @start

		$(@el).slider
			min: 0
			max: @model.get 'duration'
			values: [@model.get('start'), @model.get('current'), @model.get('end')]
			change: (event, ui) =>
				if event.originalEvent
					switch $(ui.handle).index()
						when 0 then $(@el).trigger('startHeadChange', ui)
						when 1 then $(@el).trigger('playHeadChange', ui)
						when 2 then $(@el).trigger('endChange', ui)
			start: (event, ui) =>
				if event.originalEvent
					switch $(ui.handle).index()
						when 1 then $(@el).trigger('playHeadStart', ui)
			slide: (event, ui) =>
			stop: (event, ui) =>
				if event.originalEvent
					switch $(ui.handle).index()
						when 1 then $(@el).trigger('playHeadStop', ui)

		handle = $('#slider .ui-slider-handle')

		handle.eq(0).addClass('start')
		handle.eq(1).addClass('current')
		handle.eq(2).addClass('end')

		@model.bind 'change', @render

		@userIsChangingCurrent = false

		window.setInterval ( =>
			$(@el).slider('values', 1, @model.get('current')) if !@userIsChangingCurrent ), 1000

		@render()

	render: =>

		if @model.hasChanged('duration')
			$(@el).slider('option', 'max', @model.get('duration'))
		
		if @model.hasChanged('start') 
			$(@el).slider('values', 0, @model.get('start'))
		
		if @model.hasChanged('cue')
			$(@el).slider('values', 1, @model.get('cue'))

		# if @model.hasChanged('current') and !@userIsChangingCurrent
		# 	$(@el).slider('values', 1, @model.get('current'))
		
		if @model.hasChanged('end')
			$(@el).slider('values', 2, @model.get('end'))

	events:
		'startHeadChange': 'updateStart'
		'playHeadChange': 'updateCue'
		'endChange': 'updateEnd'
		'playHeadStart': 'toggleUserIsChangingCurrent'
		'playHeadStop' : 'toggleUserIsChangingCurrent'

	toggleUserIsChangingCurrent: =>
		@userIsChangingCurrent = !@userIsChangingCurrent

	updateStart: (event, ui) ->
		@model.set {start: ui.value, cue: ui.value}

	updateCue: (event, ui) =>
		if ui.values[0] <= ui.value <= ui.values[2]
			@model.set {cue: ui.value}
			@model.set {current: ui.value}
		else
			@model.set {cue: ui.values[0]}
			@model.set {current: ui.values[0]}

	updateEnd: (event, ui) ->
		@model.set {end: ui.value, cue: ui.value - 3}
