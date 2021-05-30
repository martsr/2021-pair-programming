Class {
	#name : #DeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DeckTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
DeckTest >> test01ADeckIsCreatedWithTheSixPossibleCardsAndReturnsItsSize [
	
	| cards deck |
	
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	deck := Deck having: cards.
	self assert: (deck size) equals: 6.
]

{ #category : #tests }
DeckTest >> test02ADeckMustContainAtLeastOneCard [
	
	| cards |
	
	cards := OrderedCollection new.
	self
		should: [ Deck having: cards ]
		raise: Error
		withMessage: 'A least must contain at least one card to be created'.
]

{ #category : #tests }
DeckTest >> test03ADeckIsCreatedWithTheSixPossibleCardsAndTheOverloadCardIsDrawn [
	
	| cards deck overloadCard |
	
	overloadCard := OverloadCard new.
	cards := OrderedCollection newFrom: { overloadCard . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	deck := Deck having: cards.
	self assert: (deck draw) equals: overloadCard.
]
