window.R =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	initialize: -> #alert 'Hello from Backbone!'

$(document).ready ->
	R.initialize()

	class VideoController extends Backbone.Model

		defaults:
			state: 'stopped'
			start: 0
			end: 100


	class VideoControllerView extends Backbone.View
		
		tagName: 'div'
		id: 'video-controls'

		initialize: ->
			_.bindAll @

			console.log @model

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

	vidCtrl = new VideoController
	videoControllerView = new VideoControllerView({model: vidCtrl})

		