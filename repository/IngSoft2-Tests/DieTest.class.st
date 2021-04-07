Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
DieTest >> testACreatedDieWithSixFacesReturnsItsAmountOFFaces [		
	
	| aDie |
	
	aDie := Die with: 6.
	self assert: (aDie amountOfFaces) equals: 6.
]

{ #category : #tests }
DieTest >> testADieCannotHaveLessThanFourFaces [

	self
		should: [ Die with: 3 ]
		raise: Error
		withMessage: 'Die faces cannot be less than 4'
]

{ #category : #tests }
DieTest >> testADieWithTwentyFacesRollsANumberBetweenOneAndTwenty [
	
	| aDie |
	
	aDie := Die with: 20.
	self assert: (aDie roll between: 1 and: 20)
]

{ #category : #tests }
DieTest >> testDiceCupWithA20FaceDieaAndA6FaceDieRollsANumberBetweenOneAndTwentySix [
	
	| aDie aSecondDie dice aDiceCup |
	
	aDie := Die with: 6.
	aSecondDie := Die with: 20.
	dice := {aDie . aSecondDie}.
	aDiceCup := DiceCup contains: dice.
	self assert: (aDiceCup roll between: 1 and: 26).
]

{ #category : #tests }
DieTest >> testDiceCupsContainsANumberOfDice [
	
	| aDie aSecondDie dice aDiceCup |
	
	aDie := Die with: 5.
	aSecondDie := Die with: 14.
	dice := {aDie . aSecondDie}.
	aDiceCup := DiceCup contains: dice.
	self assert: aDiceCup amountOfDice equals: 2.
]

{ #category : #tests }
DieTest >> testDiceCupsMustContainAtLeastTwoDice [
	
	| aDie dice |
	aDie := Die with: 6.
	dice := { aDie }.
	
	self
		should: [ DiceCup contains: dice ]
		raise: Error
		withMessage: 'Dice cups must contain at least two dice'.
]

{ #category : #tests }
DieTest >> testDummy [
	"Un comentario super dummy"
	self assert: Dummy new isDummy
]
