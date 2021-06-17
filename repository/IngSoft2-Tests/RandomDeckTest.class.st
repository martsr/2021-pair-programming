Class {
	#name : #RandomDeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
RandomDeckTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
RandomDeckTest >> test01ADeckMustContainAtLeastOneCard [
	
	| cards |
	
	cards := OrderedCollection new.
	self
		should: [ RandomDeck having: cards ]
		raise: Error
		withMessage: 'A least must contain at least one card to be created'.
]

{ #category : #tests }
RandomDeckTest >> test02ADeckIsCreatedWithTheSixPossibleCardsAndTheOverloadCardIsDrawn [
	
	| cards randomDeck result |
	
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	randomDeck := RandomDeck having: cards.
	result := OrderedCollection new. 
	100 timesRepeat: [ result add: (randomDeck draw) ]. 
	self assert: (result anySatisfy:[:aCard | aCard = (cards at: 1)]). 
	self assert: (result anySatisfy:[:aCard | aCard = (cards at: 2)]).
	self assert: (result anySatisfy:[:aCard | aCard = (cards at: 3)]).
	self assert: (result anySatisfy:[:aCard | aCard = (cards at: 4)]).
	self assert: (result anySatisfy:[:aCard | aCard = (cards at: 5)]).
	self assert: (result anySatisfy:[:aCard | aCard = (cards at: 6)]).  
]
