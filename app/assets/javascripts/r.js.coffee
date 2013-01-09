window.R =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	initialize: -> #alert 'Hello from Backbone!'

$(document).ready ->
	R.initialize()

	### Slider ###
	class Slider extends Backbone.Model
		initialize: ->

	class SliderView extends Backbone.View

		initialize: ->
			_.bindAll @

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
				slide: (event, ui) =>
				stop: (event, ui) =>

			@model.bind 'change', @render

			@render()

		render: =>

			if @model.hasChanged('duration')
				$(@el).slider('option', @model.get('duration'))
			
			if @model.hasChanged('start')
				$(@el).slider('values', 0, @model.get('start'))
			
			if @model.hasChanged('current')
				$(@el).slider('values', 1, @model.get('current'))
			
			if @model.hasChanged('end')
				$(@el).slider('values', 2, @model.get('end'))

		events:
			'startHeadChange': 'updateStart'
			'playHeadChange': 'updateCurrent'
			'endChange': 'updateEnd'

		updateStart: (event, ui) ->
			@model.set {start: ui.value, current: ui.value}

		updateCurrent: (event, ui) ->
			if ui.values[0] <= ui.value <= ui.values[2]
				@model.set {current: ui.value}
			else
				@model.set {current: ui.values[0]}

		updateEnd: (event, ui) ->
			@model.set {end: ui.value, current: ui.value - 3}


	### Video ###

	class VideoController extends Backbone.Model

		defaults:
			state: 'stopped'
			start: 0
			end: 100		

	class VideoControllerView extends Backbone.View
		
		# tagName: 'div'
		# id: 'video-controls'

		initialize: ->
			_.bindAll @

			# console.log @model

			@model.bind 'change', @render

			@render()

		render: =>
			console.log @$el
			@$el.html "<div id='controller' class="#{@model.get 'state'}"></div>"
			this

		toggleState: =>
			@model.set 'changed'

		events:
			'click #controller': 'toggleState'

	sliderModel = new Slider({duration: 100, start: 40, current: 50, end: 60})
	sliderView = new SliderView({ el: $( "#slider" ), model: sliderModel })

	vidCtrl = new VideoController
	videoControllerView = new VideoControllerView({model: vidCtrl})

		