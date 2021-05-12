Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'diceCup'
	],
	#classInstVars : [
		'playerNames'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #generators }
BoardTest >> generateDeterministicDiceCupWith: sequences [

	| dice |
	
	dice := OrderedCollection new.
	dice := sequences  collect: [ :sequence | DeterministicDie having: sequence ].
	diceCup := DiceCup containing: dice.
]

{ #category : #generators }
BoardTest >> generatePlayerCollectionWith: playerNames [

	players := OrderedCollection new.
	players := playerNames collect: [ :name | Player named: name ].
]

{ #category : #running }
BoardTest >> setUp [

	super setUp. 
	players := OrderedCollection new.
]

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
	
	| aBoard laps |
	
	laps := 1. 
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 1 1) #(5 1 1)).
	aBoard := Board ofSize: 20 requiring: laps by: players using: diceCup .
	self assert: (aBoard boardSquares) equals: 20.
]

{ #category : #tests }
BoardTest >> test02ABoardMustContainAtLeast1SquareBoard [
	
	| laps |
	laps := 1.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 1 1) #(5 1 1)).
	self
		should: [ Board ofSize: 0 requiring: laps by: players using: diceCup ]
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

{ #category : #tests }
BoardTest >> test09ABoarOfSizeTwentyAnd1LapHasTwentySquares [
	
	| aBoard laps |
	
	laps := 1.
	aBoard := Board ofSize: 20 requiring: laps.
	self assert: (aBoard boardSquares) equals: 20.
]

{ #category : #tests }
BoardTest >> test10ABoardRequiresAtLeast1LapToBePlayable [
	
	self
		should: [ Board ofSize: 20 requiring: 0 ]
		raise: Error
		withMessage: 'A board requires at least one lap to be playable.'.
]

{ #category : #tests }
BoardTest >> test11ABoarOfSizeTwentyAndThreeLapsHasSixtySquares [
	
	| aBoard laps |
	
	laps := 3.
	aBoard := Board ofSize: 20 requiring: laps.
	self assert: (aBoard boardSquares) equals: 60.
]

{ #category : #tests }
BoardTest >> test12ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayers [
	
	| aBoard laps |
	
	laps := 3.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Mango').
	aBoard := Board ofSize: 20 requiring: laps by: players.
	self assert: (aBoard boardSquares) equals: 60.
	self assert: (aBoard amountOfPlayers) equals: 3.
]

{ #category : #tests }
BoardTest >> test13ABoardMustHaveAtLeastOnePlayer [
	
	| laps |
	
	laps := 1.
	self
		should: [ Board ofSize: 20 requiring: laps by: { }. ]
		raise: Error
		withMessage: 'A game must have at least 1 player'.
]

{ #category : #tests }
BoardTest >> test14ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayersAndADeterminsticDiceCup [
	
	| aBoard laps |
	
	laps := 3.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWith: #(#(4 4 5 ) #(4 4 5)).
	aBoard := Board ofSize: 20 requiring: laps by: players using: diceCup.
	self assert: (aBoard boardSquares) equals: 60.
	self assert: (aBoard amountOfPlayers) equals: 3.
]

{ #category : #tests }
BoardTest >> test15ABoardCannotBeCreatedIfAnyPlayerHasARepeatedName [
	
	| laps |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia' 'Martu' 'Martu').
	self generateDeterministicDiceCupWith: #(#(5 1 1) #(5 1 1)).
	self
		should: [Board ofSize: 20 requiring: laps by: players using: diceCup ]
		raise: Error
		withMessage: 'A game cannot be created with any players having repeated names'. 
]
