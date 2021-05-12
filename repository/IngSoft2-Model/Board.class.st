Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'size',
		'players',
		'diceCup',
		'turn',
		'positionTracker'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> consistingOf: squares  requiring: aNumberOfLaps  by: aGroupOfPlayers  using: aDiceCup [ 
	self validatesItMustHaveAtLeastOnePlayer: aGroupOfPlayers.
	self validateMoreThanOneSquare: (squares size).
	self validatesItNeedsAtLeastOneLap: aNumberOfLaps.
	self validatesItDoesntHavePlayersWithSameName: aGroupOfPlayers.
	^self new initializeConsistingOf: squares requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup.
]

{ #category : #'instance creation' }
Board class >> ofSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup [ 
	self validatesItMustHaveAtLeastOnePlayer: aGroupOfPlayers.
	self validateMoreThanOneSquare: aNumberOfSquareBoards.
	self validatesItNeedsAtLeastOneLap: aNumberOfLaps.
	self validatesItDoesntHavePlayersWithSameName: aGroupOfPlayers.
	^self new initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup.
]

{ #category : #validation }
Board class >> validateMoreThanOneSquare: aNumberOfSquareBoards [
	aNumberOfSquareBoards < 2
		ifTrue: [ Error signal: 'A board must contain at least 2 square board' ]
]

{ #category : #validation }
Board class >> validatesItDoesntHavePlayersWithSameName: players [

	| playerNames |
	
	playerNames := players collect: [ :player | player name ].
	playerNames := playerNames asSet.
	(players size) > (playerNames size) ifTrue: [ Error signal: 'A game cannot be created with any players having repeated names' ]
]

{ #category : #validation }
Board class >> validatesItMustHaveAtLeastOnePlayer: aPlayer [
	aPlayer size < 1
		ifTrue: [ Error signal: 'A game must have at least 1 player' ]
]

{ #category : #'instance creation' }
Board class >> validatesItNeedsAtLeastOneLap: amountOfLaps [
	amountOfLaps < 1
		ifTrue: [ Error signal: 'A board requires at least one lap to be playable.' ]
]

{ #category : #'as yet unclassified' }
Board >> amountOfPlayers [
	^players size.
]

{ #category : #testing }
Board >> atSquare: aSquareBoardNumber [ 
	^ squares at: aSquareBoardNumber.
]

{ #category : #accessing }
Board >> boardSquares [
	^ squares size
]

{ #category : #initialization }
Board >> initializeConsistingOf: boardSquares requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup [ 
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	size := (boardSquares size) * aNumberOfLaps.
	turn := 1.
	squares := boardSquares.
	positionTracker := PositionsTracker of: aGroupOfPlayers inBoardSize: ((boardSquares size) / aNumberOfLaps)  requiring: aNumberOfLaps.
]

{ #category : #initialization }
Board >> initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup [ 
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	size := aNumberOfSquareBoards * aNumberOfLaps.
	turn := 1.
	squares := OrderedCollection new.
	1 to: size do:[ :squareBoardNumber | squares add: (BoardSquare withEffect: NoEffect new) ].
	positionTracker := PositionsTracker of: aGroupOfPlayers  inBoardSize: aNumberOfSquareBoards  requiring: aNumberOfLaps .
]

{ #category : #'as yet unclassified' }
Board >> intializeOfSize: aNumberOfSquareBoards requiring: laps [ 

	size := aNumberOfSquareBoards * laps.
	squares := OrderedCollection new.
	1 to: size do:[ :squareBoardNumber | squares add: (BoardSquare  withEffect: NoEffect new) ].
]

{ #category : #'as yet unclassified' }
Board >> move: player by: amountPlaces [

	| playerPosition calculatedPlayerPosition |
	
	playerPosition := positionTracker positionOf: player.
	calculatedPlayerPosition := playerPosition + amountPlaces.
	calculatedPlayerPosition <= 0	ifTrue: [ calculatedPlayerPosition := 1 ].
	positionTracker update: player withNew: calculatedPlayerPosition.
	(calculatedPlayerPosition > size) ifFalse: [ (squares at: calculatedPlayerPosition) place: player on: self ].
	
]

{ #category : #'as yet unclassified' }
Board >> moveAllPlayersToFirstSquareOfTheirLap [

	| relativePositions relativePlayerPosition |
	relativePositions := positionTracker actualPositions.
	players do: [ :player |
		relativePlayerPosition := relativePositions at: (player name).
		self move: player by: ((relativePlayerPosition - 1) * (-1)).
		 ].
]

{ #category : #'as yet unclassified' }
Board >> movePlayersBack: aNumberOfSpaces except: aPlayer [
	
	| affectedPlayers |
	
	affectedPlayers := players reject: [ :player | player = aPlayer ].
	affectedPlayers
		do: [ :player | self move: player by: (-1) * aNumberOfSpaces ]
]

{ #category : #action }
Board >> nextPlayerThrowsIn: aGame [

	| resultOfThrow player |
	
	player := players at: turn.
	resultOfThrow := player throwsWith: diceCup.
	self move: player by: resultOfThrow. 
	((positionTracker positionOf: player ) > size) ifTrue:[ aGame isNotifiedItHasFinished ]  ifFalse: [ turn := (turn rem: (players size )) + 1 ].
	
]

{ #category : #testing }
Board >> playerLaps [ 
	^positionTracker playerLaps.
	
]

{ #category : #accesing }
Board >> playerPositions [ 

 ^positionTracker actualPositions.
]

{ #category : #testing }
Board >> playerRanking [
	^ positionTracker playerRanking .
]

{ #category : #action }
Board >> setUpSquaresToApplyEffect [
	squares do: [ :square | square changeToApplyEffect ]
]

{ #category : #action }
Board >> setUpSquaresToNotApplyEffect [
	squares do: [ :square | square changeToNotApplyEffect ]
]
