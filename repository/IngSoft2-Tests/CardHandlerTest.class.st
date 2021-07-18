Class {
	#name : #CardHandlerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
CardHandlerTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
CardHandlerTest >> test01CardHandlerDealsTwoCardsToEachPlayerAtTheStart [

	| players cards deck overloadCard speedCard accelerationCard cancellationCard redoCard repeatCard cardHandler |
	players := OrderedCollection newFrom: { 'Fran' . 'Martu' . 'Mango'}.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	redoCard := RedoCard new.
	repeatCard := RepeatCard new.
	cards := OrderedCollection newFrom: { overloadCard . speedCard . accelerationCard . cancellationCard . redoCard . repeatCard }.
	deck := DeterministicDeck having: cards.
	cardHandler := CardHandler using: deck dealsTo: players.
	self assert: (cardHandler handOf: 'Fran') equals: (OrderedCollection newFrom: { overloadCard . speedCard }).
	self assert: (cardHandler handOf: 'Martu') equals: (OrderedCollection newFrom: { accelerationCard . cancellationCard }).
	self assert: (cardHandler handOf: 'Mango') equals: (OrderedCollection newFrom: { redoCard . repeatCard }).
	
	
]

{ #category : #tests }
CardHandlerTest >> test02APlayerIsDealtItsInitialHandAndAnExtraCard [

	| cards aDeck overloadCard speedCard accelerationCard cancellationCard redoCard repeatCard players cardHandler |
	players := OrderedCollection newFrom: { 'Fran' }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	redoCard := RedoCard new.
	repeatCard := RepeatCard new.
	cards := OrderedCollection newFrom: { overloadCard . speedCard . accelerationCard . cancellationCard . redoCard . repeatCard }.
	aDeck := DeterministicDeck having: cards.
	cardHandler := CardHandler using: aDeck dealsTo: players.
	self assert: (cardHandler handOf: 'Fran') equals: (OrderedCollection newFrom: { overloadCard . speedCard }).
	cardHandler dealsCardTo: (players at: 1).
	self assert: (cardHandler handOf: 'Fran') equals: (OrderedCollection newFrom: { overloadCard . speedCard . accelerationCard }).
	 
]
