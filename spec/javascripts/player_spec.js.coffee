describe "RollUI", ->
	ui = null
	defaultValues = [20, 50, 90]

	beforeEach ->
		loadFixtures 'baz'
		ui = new RollerUI()

	it 'should create a div element with class roll-ctrl-slider', ->
		expect($(".roll-ctrl-slider")).toBeDefined()
		expect(ui.values()).toEqual(defaultValues)

	it 'should change start properly', ->
		[s, p, f] = defaultValues
		ui.start(45)
		expect(ui.values()).toEqual([45, p, f])

	it 'should change play properly', ->
		[s, p, f] = defaultValues
		ui.play(37)
		expect(ui.values()).toEqual([s, 37, f])

	it 'should change end properly', ->
		[s, p, f] = defaultValues
		ui.end(69)
		expect(ui.values()).toEqual([s, p, 69])

	it 'should add handlers correctly ', ->
		startHandlerCalled = false
		playHandlerCalled = false
		endHandlerCalled = false

		startHandler = -> startHandlerCalled = true
		playHandler = -> playHandlerCalled = true
		endHandler = -> endHandlerCalled = true

		ui.on 'start', 'change', startHandler
		ui.on 'play', 'change', playHandler
		ui.on 'end', 'change', endHandler

		expect(startHandlerCalled).toBeFalsy()
		expect(playHandlerCalled).toBeFalsy()
		expect(endHandlerCalled).toBeFalsy()

		ui._handlers.change.start[0]()
		expect(startHandlerCalled).toBeTruthy()
		expect(playHandlerCalled).toBeFalsy()
		expect(endHandlerCalled).toBeFalsy()
		startHandlerCalled = false

		ui._handlers.change.play[0]()
		expect(startHandlerCalled).toBeFalsy()
		expect(playHandlerCalled).toBeTruthy()
		expect(endHandlerCalled).toBeFalsy()
		playHandlerCalled = false

		ui._handlers.change.end[0]()
		expect(startHandlerCalled).toBeFalsy()
		expect(playHandlerCalled).toBeFalsy()
		expect(endHandlerCalled).toBeTruthy()

	it 'should execute handlers correctly', ->
		handlerCalled = false

		ui.on 'play', 'change', (-> handlerCalled = true)
		ui.play(35)
		expect(handlerCalled).toBeTruthy()






