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
	
	| aBoard  laps size squares |
	
	laps := 1.
	size := 20.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	squares := OrderedCollection new.
	 1 to: (size*laps) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: NoEffect new) ].
	aBoard := Board consistingOf: squares requiring: laps by: players using: diceCup.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (NoEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (NoEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (NoEffect).
	
]

{ #category : #tests }
BoardTest >> test04ABoardCreatedWithTwentySquareBoardsWithSpeedUpEffect [
	
	| laps size squares aBoard |
	laps := 1.
	size := 20.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	squares := OrderedCollection new.
	1 to: (size*laps) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: SpeedUpEffect new) ].
	aBoard := Board consistingOf: squares requiring: laps by: players using: diceCup.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (SpeedUpEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (SpeedUpEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (SpeedUpEffect).
	
]

{ #category : #tests }
BoardTest >> test05ABoardCreatedWithTwentySquareBoardsWithWormHoleEffect [
	
	| laps size squares aBoard |
	laps := 1.
	size := 20.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	squares := OrderedCollection new.
	1 to: (size*laps) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: WormHoleEffect new) ].
	aBoard := Board consistingOf: squares requiring: laps by: players using: diceCup.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (WormHoleEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (WormHoleEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (WormHoleEffect).
]

{ #category : #tests }
BoardTest >> test06ABoardCreatedWithTwentySquareBoardsWithAtomicBombEffect [
	
	| laps size squares aBoard |
	laps := 1.
	size := 20.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	squares := OrderedCollection new.
	1 to: (size*laps) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: AtomicBombEffect new) ].
	aBoard := Board consistingOf: squares requiring: laps by: players using: diceCup.
	self assert: (aBoard boardSquares) equals: 20.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (AtomicBombEffect).
	self assert: (((aBoard atSquare: 10) typeOfEffect) class) equals: (AtomicBombEffect).
	self assert: (((aBoard atSquare: 20) typeOfEffect) class) equals: (AtomicBombEffect).
]

{ #category : #tests }
BoardTest >> test07ABoardCreatedWithTwentySquareBoardsWithMoonWalkEffect [
	
	| laps squares aBoard  |
	laps := 1.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(4 3 1) #(4 3 1)).
	squares := { BoardSquare withEffect: (MoonWalkEffect goingBack: 2) . BoardSquare withEffect: (MoonWalkEffect goingBack: 4) . BoardSquare withEffect: (MoonWalkEffect goingBack: 3) . BoardSquare withEffect: (MoonWalkEffect goingBack: 2) . BoardSquare withEffect: (MoonWalkEffect goingBack: 4) . BoardSquare withEffect: (MoonWalkEffect goingBack: 3) . BoardSquare withEffect: (MoonWalkEffect goingBack: 2) . BoardSquare withEffect: (MoonWalkEffect goingBack: 4) . BoardSquare withEffect: (MoonWalkEffect goingBack: 3) . BoardSquare withEffect: (MoonWalkEffect goingBack: 2)}.
	aBoard := Board consistingOf: squares requiring: laps by: players using: diceCup.
	self assert: (aBoard boardSquares) equals: 10.
	self assert: (((aBoard atSquare: 1) typeOfEffect) class) equals: (MoonWalkEffect).
	self assert: (((aBoard atSquare: 3) typeOfEffect) class) equals: (MoonWalkEffect).
	self assert: (((aBoard atSquare: 5) typeOfEffect) class) equals: (MoonWalkEffect).
]

{ #category : #tests }
BoardTest >> test09ABoarOfSizeTwentyAnd1LapHasTwentySquares [
	
	| aBoard laps size squares |
	
	laps := 1.
	size := 20.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	squares := OrderedCollection new.
	1 to: (size) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: NoEffect new) ].
	aBoard := Board consistingOf: squares requiring: laps by: players using: diceCup.
	self assert: (aBoard boardSquares) equals: 20.
]

{ #category : #tests }
BoardTest >> test10ABoardRequiresAtLeast1LapToBePlayable [

	| laps size squares |
	
	laps := 0.
	size := 20.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	squares := OrderedCollection new.
	1 to: (size) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: NoEffect new) ].
	self
		should: [ Board consistingOf: squares requiring: laps by: players using: diceCup ]
		raise: Error
		withMessage: 'A board requires at least one lap to be playable.'.
]

{ #category : #tests }
BoardTest >> test11ABoarOfSizeTwentyAndThreeLapsHasSixtySquares [
	
	| aBoard laps size squares |
	
	laps := 3.
	size := 20.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	squares := OrderedCollection new.
	1 to: (size*laps) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: NoEffect new) ].
	aBoard := Board consistingOf: squares requiring: laps by: players using: diceCup.
	self assert: (aBoard boardSquares) equals: 60.
]

{ #category : #tests }
BoardTest >> test12ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayers [
	
	| aBoard laps size squares |
	
	laps := 3.
	size := 20.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	squares := OrderedCollection new.
	1 to: (size*laps) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: NoEffect new) ].
	aBoard := Board consistingOf: squares requiring: laps by: players using: diceCup.
	self assert: (aBoard boardSquares) equals: 60.
	self assert: (aBoard amountOfPlayers) equals: 1.
]

{ #category : #tests }
BoardTest >> test13ABoardMustHaveAtLeastOnePlayer [
	
	| laps size squares |
	
	laps := 3.
	size := 20.
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	squares := OrderedCollection new.
	1 to: (size*laps) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: NoEffect new) ].
	self
		should: [ Board consistingOf: squares requiring: laps by: {}using: diceCup ]
		raise: Error
		withMessage: 'A game must have at least 1 player'.
]

{ #category : #tests }
BoardTest >> test14ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayersAndADeterminsticDiceCup [
	
	| aBoard laps size squares |
	
	laps := 3.
	size := 20.
	self generatePlayerCollectionWith: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWith: #(#(4 4 5) #(4 4 5)).
	squares := OrderedCollection new.
	1 to: (size* laps) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: NoEffect new) ].
	aBoard := Board consistingOf: squares requiring: laps by: players using: diceCup .
	self assert: (aBoard boardSquares) equals: 60.
	self assert: (aBoard amountOfPlayers) equals: 3.
]

{ #category : #tests }
BoardTest >> test15ABoardCannotBeCreatedIfAnyPlayerHasARepeatedName [
	
	| laps size squares |
	
	laps := 1.
	size := 20.
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia' 'Martu' 'Martu').
	self generateDeterministicDiceCupWith: #(#(5 1 1) #(5 1 1)).
	squares := OrderedCollection new.
	1 to: (size* laps) do: [ :squareBoardNumber | squares add: (BoardSquare withEffect: NoEffect new) ].
	self
		should: [Board consistingOf: squares requiring: laps by: players using: diceCup ]
		raise: Error
		withMessage: 'A game cannot be created with any players having repeated names'. 
]
