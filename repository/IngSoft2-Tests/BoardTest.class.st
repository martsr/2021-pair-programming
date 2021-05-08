Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
BoardTest >> test01ABoardCreatedWithTwentySquareBoardsHasTwentySquareBoards [
	
	| aBoard |
	
	aBoard := Board containing: 20.
	self assert: (aBoard boardSquares) equals: 20.
]

{ #category : #tests }
BoardTest >> test02ABoardMustContainAtLeast1SquareBoard [
	
	self
		should: [ Board containing: 0 ]
		raise: Error
		withMessage: 'A board must contain at least 2 square board'.
]

{ #category : #tests }
BoardTest >> test03ABoardCreatedWithTwentySquareBoardsWithNoEffect [
	
	| aBoard |
	
	aBoard := Board containing: 20 withEffect: NoEffect new.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (NoEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (NoEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (NoEffect).
	
]

{ #category : #tests }
BoardTest >> test04ABoardCreatedWithTwentySquareBoardsWithSpeedUpEffect [
	
	| aBoard |
	
	aBoard := Board containing: 20 withEffect: SpeedUpEffect new.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (SpeedUpEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (SpeedUpEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (SpeedUpEffect).
	
]

{ #category : #tests }
BoardTest >> test05ABoardCreatedWithTwentySquareBoardsWithWormHoleEffect [
	
	| aBoard |
	
	aBoard := Board containing: 20 withEffect: WormHoleEffect new.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (WormHoleEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (WormHoleEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (WormHoleEffect).
]

{ #category : #tests }
BoardTest >> test06ABoardCreatedWithTwentySquareBoardsWithAtomicBombEffect [
	
	| aBoard |
	
	aBoard := Board containing: 20 withEffect: AtomicBombEffect new.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (AtomicBombEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (AtomicBombEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (AtomicBombEffect).
]
