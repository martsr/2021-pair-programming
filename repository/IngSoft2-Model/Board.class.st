Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'size',
		'players',
		'diceCup',
		'turn',
		'positionTracker',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> consistingOf: squares  requiring: aNumberOfLaps  by: aGroupOfPlayers  using: aDiceCup [ 
	^self new initializeConsistingOf: squares requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup.
]

{ #category : #'instance creation' }
Board class >> ofSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup [ 
	^self new initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup.
]

{ #category : #'as yet unclassified' }
Board >> amountOfLaps [
	^laps.
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
	size := boardSquares size.
	turn := 1.
	squares := boardSquares.
	laps := aNumberOfLaps.
	positionTracker := PositionsTracker of: aGroupOfPlayers inBoardSize: (boardSquares size)requiring: aNumberOfLaps.
]

{ #category : #initialization }
Board >> initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup [ 
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	size := aNumberOfSquareBoards.
	turn := 1.
	laps := aNumberOfLaps .
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
	
	playerPosition := positionTracker absolutePositionOf: player.
	calculatedPlayerPosition := playerPosition + amountPlaces.
	calculatedPlayerPosition <= 0	ifTrue: [ calculatedPlayerPosition := 1 ].
	positionTracker update: player withNew: calculatedPlayerPosition.
	(calculatedPlayerPosition > (size*laps)) ifFalse: [ (squares at: (positionTracker relativePositionOf: player)) place: player on: self ].
	
]

{ #category : #'as yet unclassified' }
Board >> moveAllPlayersToFirstSquareOfTheirLap [

	| relativePositions relativePlayerPosition |
	relativePositions := positionTracker relativePositions.
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
	((positionTracker absolutePositionOf: player ) > (size * laps)) ifTrue:[ aGame isNotifiedItHasFinished ]  ifFalse: [ turn := (turn rem: (players size )) + 1 ].
	
]

{ #category : #testing }
Board >> playerLaps [ 
	^positionTracker playerLaps.
	
]

{ #category : #accesing }
Board >> playerPositions [ 

 ^positionTracker relativePositions.
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
