Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
PlayerTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
PlayerTest >> test01PlayerNameShouldContainAtLeastOneCharacter [
	
	self
		should: [ Player named: '']
		raise: Error
		withMessage: 'Player name must have at least one letter'.
]

{ #category : #tests }
PlayerTest >> test02APlayerThrowsADeterministicDieCupWithTwoSixFacedDiceAndTheResultIsSix [
	
	| player aDetDie  aDiceCup aSecondDetDie |
	
	player := Player named: 'Fran'.
	aDetDie := DeterministicDie having: #(5 8 6).
	aSecondDetDie := DeterministicDie having: #(5 8 6).
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	self assert: (player throwsWith: aDiceCup) equals: 10.
]
