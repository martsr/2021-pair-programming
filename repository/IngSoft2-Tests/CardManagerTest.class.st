Class {
	#name : #CardManagerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
CardManagerTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
CardManagerTest >> test01ADeckIsCreatedWithTheSixPossibleCardsAndReturnsItsSize [
	
	| cards deck |
	
	cards := OrderedCollection newFrom: {OverloadCard new. SpeedCard new. AccelerationCard new. CancellationCard new. RedoCard new. RepeatCard new}.
	deck := Deck having: cards.
	self assert: deck size equals: 6
]

{ #category : #tests }
CardManagerTest >> test02ADeckMustContainAtLeastOneCard [
	
	| cards |
	
	cards := OrderedCollection new.
	self
		should: [ Deck having: cards ]
		raise: Error
		withMessage: 'A least must contain at least one card to be created'
]

{ #category : #tests }
CardManagerTest >> test03CardManagerDealsTwoCardsTwoEachPlayerAtTheStart [

	| players cards deck cardManager overloadCard speedCard accelerationCard cancellationCard redoCard repeatCard |
	players := OrderedCollection newFrom: { 'Fran' . 'Martu' . 'Mango'}.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	redoCard := RedoCard new.
	repeatCard := RepeatCard new.
	cards := OrderedCollection newFrom: { overloadCard . speedCard . accelerationCard . cancellationCard . redoCard . repeatCard }.
	deck := Deck having: cards.
	cardManager := CardHandler using: deck dealsTo: players.
	self assert: (cardManager handOf: 'Fran') equals: (OrderedCollection newFrom: { overloadCard . speedCard }).
	self assert: (cardManager handOf: 'Martu') equals: (OrderedCollection newFrom: { accelerationCard . cancellationCard }).
	self assert: (cardManager handOf: 'Mango') equals: (OrderedCollection newFrom: { redoCard . repeatCard }).
	
	
]

{ #category : #tests }
CardManagerTest >> test04APlayerIsDealtItsInitialHandAndAnExtraCard [

	| cards aDeck cardManager overloadCard speedCard accelerationCard cancellationCard redoCard repeatCard players |
	players := OrderedCollection newFrom: { 'Fran' }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	redoCard := RedoCard new.
	repeatCard := RepeatCard new.
	cards := OrderedCollection newFrom: { overloadCard . speedCard . accelerationCard . cancellationCard . redoCard . repeatCard }.
	aDeck := Deck having: cards.
	cardManager := CardHandler using: aDeck dealsTo: players.
	self assert: (cardManager handOf: 'Fran') equals: (OrderedCollection newFrom: { overloadCard . speedCard }).
	cardManager dealsCardTo: (players at: 1).
	self assert: (cardManager handOf: 'Fran') equals: (OrderedCollection newFrom: { overloadCard . speedCard . accelerationCard }).
	 
]
