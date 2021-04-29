Class {
	#name : #BoardSquareTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardSquareTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
BoardSquareTest >> test07ABoardSquareHasAValidPositionAssigned [
	
	| aBoardSquare |
	
	aBoardSquare := BoardSquare numbered: 1.
	self assert:(aBoardSquare number) equals: 1.
]

{ #category : #tests }
BoardSquareTest >> test08ABoardSquareMustBeAssignedAValueGreaterThanZero [
	
	self
		should: [ BoardSquare numbered: 0 ]
		raise: Error
		withMessage: 'A board square must be assigned a value greater than zero'.
]
