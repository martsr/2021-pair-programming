Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
GameTest >> testABoardCreatedWithTwentySquareBoardsHasTwentySquareBoards [
	
	| aBoard |
	
	aBoard := Board containing: 20.
	self assert: (aBoard boardSquares) equals: 20.
]

{ #category : #tests }
GameTest >> testABoardMustContainAtLeast1SquareBoard [
	
	self
		should: [ Board containing: 0 ]
		raise: Error
		withMessage: 'A board must contain at least 1 square board'.
]

{ #category : #tests }
GameTest >> testABoardSquareHasAValidPositionAssigned [
	
	| aBoardSquare |
	
	aBoardSquare := BoardSquare numbered: 1.
	self assert:(aBoardSquare squareNumber) equals: 1.
]

{ #category : #tests }
GameTest >> testACreatedDieWithSixFacesReturnsItsAmountOFFaces [		
	
	| aDie |
	
	aDie := Die with: 6.
	self assert: (aDie amountOfFaces) equals: 6.
]

{ #category : #tests }
GameTest >> testADieCannotHaveLessThanFourFaces [

	self
		should: [ Die with: 3 ]
		raise: Error
		withMessage: 'Die faces cannot be less than 4'
]

{ #category : #tests }
GameTest >> testADieWithTwentyFacesRollsANumberBetweenOneAndTwenty [
	
	| aDie |
	
	aDie := Die with: 20.
	self assert: (aDie roll between: 1 and: 20)
]

{ #category : #tests }
GameTest >> testASquareBoardMustBeAssignedAValueGreaterThanZero [
	
	self
		should: [ BoardSquare numbered: 0 ]
		raise: Error
		withMessage: 'A board square must be assigned a value greater than zero'.
]

{ #category : #tests }
GameTest >> testDiceCupWithATwentyFaceDieaAndASixFaceDieRollsANumberBetweenTwoAndTwentySix [
	
	| aDie aSecondDie dice aDiceCup |
	
	aDie := Die with: 6.
	aSecondDie := Die with: 20.
	dice := {aDie . aSecondDie}.
	aDiceCup := DiceCup contains: dice.
	self assert: (aDiceCup roll between: 2 and: 26).
]

{ #category : #tests }
GameTest >> testDiceCupsContainsANumberOfDice [
	
	| aDie aSecondDie dice aDiceCup |
	
	aDie := Die with: 5.
	aSecondDie := Die with: 14.
	dice := {aDie . aSecondDie}.
	aDiceCup := DiceCup contains: dice.
	self assert: aDiceCup amountOfDice equals: 2.
]

{ #category : #tests }
GameTest >> testDiceCupsMustContainAtLeastOneDie [
	
	| dice |
	
	dice := { }.
	
	self
		should: [ DiceCup contains: dice ]
		raise: Error
		withMessage: 'Dice cups must contain at least a die'.
]

{ #category : #tests }
GameTest >> testDummy [
	"Un comentario super dummy"
	self assert: Dummy new isDummy
]
