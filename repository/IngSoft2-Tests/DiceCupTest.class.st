Class {
	#name : #DiceCupTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DiceCupTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
DiceCupTest >> test03DiceCupsContainsANumberOfDice [
	
	| aDie aSecondDie dice aDiceCup |
	
	aDie := RandomDie containing: 5.
	aSecondDie := RandomDie containing: 14.
	dice := {aDie . aSecondDie}.
	aDiceCup := DiceCup containing: dice.
	self assert: aDiceCup amountOfDice equals: 2.
]

{ #category : #tests }
DiceCupTest >> test04DiceCupWithATwentyFaceDieaAndASixFaceDieRollsANumberBetweenTwoAndTwentySix [
	
	| aDie aSecondDie dice aDiceCup |
	
	aDie := RandomDie containing: 6.
	aSecondDie := RandomDie containing: 20.
	dice := {aDie . aSecondDie}.
	aDiceCup := DiceCup containing: dice.
	self assert: (aDiceCup throw between: 2 and: 26).
]

{ #category : #tests }
DiceCupTest >> test05DiceCupWithASingleSixFacedDieRollsANumberBetween1and6 [
	
	| aDie   aDiceCup |
	
	aDie := RandomDie containing: 6.
	aDiceCup := DiceCup containingSingle: aDie.
	self assert: (aDiceCup throw between: 1 and: 6).
]

{ #category : #tests }
DiceCupTest >> test06DiceCupsMustContainAtLeastOneDie [
	
	| dice |
	
	dice := { }.
	
	self
		should: [ DiceCup containing: dice ]
		raise: Error
		withMessage: 'Dice cups must contain at least a die'.
		
]
