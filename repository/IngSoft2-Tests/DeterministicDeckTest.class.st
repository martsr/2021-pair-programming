Class {
	#name : #DeterministicDeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DeterministicDeckTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
DeterministicDeckTest >> test02ADeckMustContainAtLeastOneCard [
	
	| cards |
	
	cards := OrderedCollection new.
	self
		should: [ DeterministicDeck having: cards ]
		raise: Error
		withMessage: 'A least must contain at least one card to be created'.
]

{ #category : #tests }
DeterministicDeckTest >> test03ADeckIsCreatedWithTheSixPossibleCardsAndTheOverloadCardIsDrawn [
	
	| cards deck overloadCard |
	
	overloadCard := OverloadCard new.
	cards := OrderedCollection newFrom: { overloadCard . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	deck := DeterministicDeck having: cards.
	self assert: (deck draw) equals: overloadCard.
]
