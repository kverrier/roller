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
				if event.originalEvent
					switch $(ui.handle).index()
						when 0 then $(@el).trigger('startHeadSlide', ui)
						when 1 then $(@el).trigger('playHeadeSlide', ui)
						when 2 then $(@el).trigger('endHeadSlide', ui)
			stop: (event, ui) =>
				if event.originalEvent
					switch $(ui.handle).index()
						when 1 then $(@el).trigger('playHeadStop', ui)

		handle = $('#slider .ui-slider-handle')

		handle.eq(0).addClass('start')
		handle.eq(1).addClass('current')
		handle.eq(2).addClass('end')

		$(@el).append($('<div></div>').addClass('ui-slider-range ui-widget-header'))

		@model.bind 'change', @render

		@userIsChangingCurrent = false

		window.setInterval ( =>
			$(@el).slider('values', 1, @model.get('current')) if !@userIsChangingCurrent ), 1000

		@render()
		@renderRange()

	render: =>

		if @model.hasChanged('duration')
			$(@el).slider('option', 'max', @model.get('duration'))
			@renderRange()


		if @model.hasChanged('start') 
			$(@el).slider('values', 0, @model.get('start'))
			@renderRange()

		if @model.hasChanged('cue')
			$(@el).slider('values', 1, @model.get('cue'))

		# if @model.hasChanged('current') and !@userIsChangingCurrent
		# 	$(@el).slider('values', 1, @model.get('current'))
		
		if @model.hasChanged('end')
			$(@el).slider('values', 2, @model.get('end'))
			@renderRange()

	renderRange: =>
			startPercent = @model.get('start') / @model.get('duration')*100 + '%'
			widthPecent = (@model.get('end') - @model.get('start')) / @model.get('duration')*100 + '%'
			$('#slider .ui-slider-range').css('left', startPercent).css('width', widthPecent)


	events:
		'startHeadChange': 'updateStart'
		'playHeadChange': 'updateCue'
		'endChange': 'updateEnd'
		'playHeadStart': 'toggleUserIsChangingCurrent'
		'playHeadStop' : 'toggleUserIsChangingCurrent'
		'startHeadSlide': 'updateStartTime'
		'endHeadSlide': 'updateEndTime'

	updateStartTime: (event, ui) =>
		@model.set('pendingStart', ui.value)

	updateEndTime: (event, ui) =>
		@model.set('pendingEnd', ui.value)

	toggleUserIsChangingCurrent: =>
		@userIsChangingCurrent = !@userIsChangingCurrent

	updateStart: (event, ui) ->
		if ui.value > ui.values[2]
			@model.set {start: ui.value[2], cue: ui.value}
		else
			@model.set {start: ui.value, cue: ui.value}

	updateCue: (event, ui) =>
		if ui.value < ui.values[0]
			@model.set {cue: ui.value}
			@model.set {current: ui.value}
			@model.set {start: ui.value}
		else if ui.value > ui.values[2]
			@model.set {cue: ui.value}
			@model.set {current: ui.value}
			@model.set {start: ui.value}
			@model.set {end: @model.get('duration')}
		else
			@model.set {cue: ui.value}
			@model.set {current: ui.value}

		# if ui.values[0] <= ui.value <= ui.values[2]
		# 	@model.set {cue: ui.value}
		# 	@model.set {current: ui.value}
		# else
		# 	@model.set {cue: ui.values[0]}
		# 	@model.set {current: ui.values[0]}

	updateEnd: (event, ui) =>
		console.log @model
		console.log 'test'
		@model.set {end: ui.value, cue: ui.value - 3}
