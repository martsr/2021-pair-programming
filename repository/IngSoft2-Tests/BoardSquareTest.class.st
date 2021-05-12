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
BoardSquareTest >> test01ABoardSquareHasAnEffect [
	
	| aBoardSquare |
	
	aBoardSquare := BoardSquare withEffect: NoEffect new.
	self assert:(aBoardSquare typeOfEffect class) equals: NoEffect.
]
