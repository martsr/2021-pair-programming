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
Board class >> having: squares  requiring: aNumberOfLaps  usedBy: aGroupOfPlayers  throwing: aDiceCup [ 
	^self new initializeHaving: squares  requiring: aNumberOfLaps  usedBy: aGroupOfPlayers  throwing: aDiceCup 
]

{ #category : #accessing }
Board >> absoluteSize [
	^ size * laps
]

{ #category : #accessing }
Board >> amountOfLaps [
	^ laps
]

{ #category : #accessing }
Board >> amountOfPlayers [
	^ players size
]

{ #category : #testing }
Board >> atSquare: aSquareBoardNumber [ 
	^ squares at: aSquareBoardNumber.
]

{ #category : #action }
Board >> disableEffectsDuring: anAction [
	self notifySquaresToNotApplyEffect.
	anAction value.
	self notifySquaresToApplyEffect.
]

{ #category : #action }
Board >> incrementTurn [
	turn := (turn rem: players size) + 1
]

{ #category : #initialization }
Board >> initializeHaving: boardSquares requiring: aNumberOfLaps usedBy: aGroupOfPlayers throwing: aDiceCup [ 
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	size := boardSquares size.
	turn := 1.
	squares := boardSquares.
	laps := aNumberOfLaps.
	positionTracker := PositionsTracker of: aGroupOfPlayers inBoardOf: size.
]

{ #category : #action }
Board >> move: player by: amountPlaces [

	| playerPosition calculatedPlayerPosition |
	
	playerPosition := positionTracker absolutePositionOf: player.
	calculatedPlayerPosition := playerPosition + amountPlaces.
	calculatedPlayerPosition <= 0	ifTrue: [ calculatedPlayerPosition := 1 ].
	positionTracker update: player withNew: calculatedPlayerPosition.
	(calculatedPlayerPosition > (self absoluteSize )) ifFalse: [ (squares at: (self positionOf: player)) place: player on: self ].
	
]

{ #category : #action }
Board >> moveAllPlayersToFirstSquareOfTheirLap [

	| relativePositions relativePlayerPosition |
	relativePositions := positionTracker boardPositions.
	players do: [ :playerName |
		relativePlayerPosition := relativePositions at: playerName.
		self move: playerName by: ((relativePlayerPosition - 1) * (-1)).
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
	resultOfThrow := diceCup throw.
	self move: player by: resultOfThrow.
	(positionTracker absolutePositionOf: player) > self absoluteSize ifTrue: [ aGame isNotifiedItHasFinished ] ifFalse: [ self incrementTurn ]
]

{ #category : #notification }
Board >> notifySquaresToApplyEffect [
	squares do: [ :square | square applyEffect ]
]

{ #category : #notification }
Board >> notifySquaresToNotApplyEffect [
	squares do: [ :square | square doNotApplyEffect ]
]

{ #category : #testing }
Board >> playerLaps [
	^ positionTracker playerLaps
]

{ #category : #accessing }
Board >> playerPositions [
	^ positionTracker boardPositions
]

{ #category : #testing }
Board >> playerRanking [
	^ positionTracker playerRanking
]

{ #category : #accessing }
Board >> positionOf: aPlayer [
	^ positionTracker boardPositionOf: aPlayer
]

{ #category : #accessing }
Board >> size [
	^size
]
