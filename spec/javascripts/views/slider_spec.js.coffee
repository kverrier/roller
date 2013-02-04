describe "slider", ->
	videoModel = null

	beforeEach(->
		loadFixtures('baz')
		videoModel = new R.Models.Video({
			youtubeId: 'DE9NsrKzSq8', 
			start: 40, 
			pendingStart: 40, 
			pendingEnd: 43, 
			cue: 40, 
			end: 43})
		new R.Views.SliderView({ el: $( "#slider" ), model: videoModel })
	)

	it 'has default slider values', ->
		expect($('#slider').slider('values', 0)).toBe(40)
		# expect($('#slider').slider('values', 1)).toBeNaN()
		expect($('#slider').slider('values', 2)).toBe(43)

	describe 'R.Models.Video.set', ->
		describe 'start', ->
			it 'updates slider start', ->
				videoModel.set('start', 10)
				expect($('#slider').slider('values', 0)).toBe(10)

			it '_ when start exceeds end'


		describe 'end', ->
			it 'updates slider start', ->
				videoModel.set('end', 90)
				expect($('#slider').slider('values', 2)).toBe(90)

	describe 'user action', ->
		describe 'start slider', ->
			it 'sets model start on start slider action', ->
				$('#slider').trigger('startHeadChange', {value: 30, values: [30, 40, 43] })	
				expect(videoModel.get('start')).toBe(30)

			it 'sets model cue on start slider action', ->
				$('#slider').trigger('startHeadChange', {value: 30, values: [30, 40, 43] })	
				expect(videoModel.get('cue')).toBe(30)

		describe 'end slider', ->
			it 'sets model end on end slider action', ->
				$('#slider').trigger('endChange', {value: 70, values: [40, 40, 70] })	
				expect(videoModel.get('end')).toBe(70)

			it 'sets model cue on start slider action', ->
				$('#slider').trigger('endChange', {value: 70, values: [40, 40, 70] })	
				expect(videoModel.get('cue')).toBe(67)

		describe 'current slider', ->
			it 'sets model cue on play slider action', ->
				$('#slider').trigger('playHeadChange', {value: 30, values: [30, 30, 43] })	
				expect(videoModel.get('play')).toBe(70)

			it 'sets model cue on start slider action', ->
				$('#slider').trigger('endChange', {value: 70, values: [40, 40, 70] })	
				expect(videoModel.get('cue')).toBe(67)






