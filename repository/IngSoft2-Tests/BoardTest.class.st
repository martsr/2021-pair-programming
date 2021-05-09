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
	
	| aBoard effects |
	
	effects := OrderedCollection new.
	20 timesRepeat: [ effects add: (NoEffect new) ].
	aBoard := Board having: effects.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (NoEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (NoEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (NoEffect).
	
]

{ #category : #tests }
BoardTest >> test04ABoardCreatedWithTwentySquareBoardsWithSpeedUpEffect [
	
	| aBoard effects |
	
	effects := OrderedCollection new.
	20 timesRepeat: [ effects add: (SpeedUpEffect new) ].
	aBoard := Board having: effects.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (SpeedUpEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (SpeedUpEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (SpeedUpEffect).
	
]

{ #category : #tests }
BoardTest >> test05ABoardCreatedWithTwentySquareBoardsWithWormHoleEffect [
	
	| aBoard effects |
	
	effects := OrderedCollection new.
	20 timesRepeat: [ effects add: (WormHoleEffect new) ].
	aBoard := Board having: effects.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (WormHoleEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (WormHoleEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (WormHoleEffect).
]

{ #category : #tests }
BoardTest >> test06ABoardCreatedWithTwentySquareBoardsWithAtomicBombEffect [
	
	| aBoard effects |
	
	effects := OrderedCollection new.
	20 timesRepeat: [ effects add: (AtomicBombEffect new) ].
	aBoard := Board having: effects.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (AtomicBombEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (AtomicBombEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (AtomicBombEffect).
]

{ #category : #tests }
BoardTest >> test07ABoardCreatedWithTwentySquareBoardsWithMoonWalkEffect [
	
	| aBoard effects |

	effects := { MoonWalkEffect goingBack: 2. MoonWalkEffect goingBack: 7. MoonWalkEffect goingBack: 4. MoonWalkEffect goingBack:  2. MoonWalkEffect goingBack: 7 }.
	aBoard := Board having: effects.
	self assert: (aBoard boardSquares) equals: 5.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (MoonWalkEffect).
	self assert: (((aBoard atSquare: 3) typeOfEffect) class) equals: (MoonWalkEffect).
	self assert: (((aBoard atSquare: 5) typeOfEffect) class) equals: (MoonWalkEffect).
]

{ #category : #tests }
BoardTest >> test08ABoardCannotBeCreatedWithNoSquares [
	
	| effects |

	effects := {NoEffect new}.
	self
		should: [ Board having: effects ]
		raise: Error
		withMessage: 'A board must contain at least 2 square board'. 
]
