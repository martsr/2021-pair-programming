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

{ #category : #accessing }
Board >> amountOfLaps [
	^laps.
]

{ #category : #accessing }
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

{ #category : #action }
Board >> move: player by: amountPlaces [

	| playerPosition calculatedPlayerPosition |
	
	playerPosition := positionTracker absolutePositionOf: player.
	calculatedPlayerPosition := playerPosition + amountPlaces.
	calculatedPlayerPosition <= 0	ifTrue: [ calculatedPlayerPosition := 1 ].
	positionTracker update: player withNew: calculatedPlayerPosition.
	(calculatedPlayerPosition > (size*laps)) ifFalse: [ (squares at: (positionTracker relativePositionOf: player)) place: player on: self ].
	
]

{ #category : #action }
Board >> moveAllPlayersToFirstSquareOfTheirLap [

	| relativePositions relativePlayerPosition |
	relativePositions := positionTracker relativePositions.
	players do: [ :player |
		relativePlayerPosition := relativePositions at: (player name).
		self move: player by: ((relativePlayerPosition - 1) * (-1)).
		 ].
]

{ #category : #action }
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

{ #category : #accessing }
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
