Class {
	#name : #PositionsTracker,
	#superclass : #Object,
	#instVars : [
		'playerPositions',
		'boardSize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionsTracker class >> of: aGroupOfPlayers inBoardOf: size [
	^ self new initializeOf: aGroupOfPlayers inBoardOf: size.
]

{ #category : #accessing }
PositionsTracker >> absolutePositionOf: player [
	| playerName playerPosition |
	playerName := player.
	playerPosition := playerPositions detect: [ :position | position currentPlayer = playerName ].
	^ playerPosition currentPosition.
]

{ #category : #accessing }
PositionsTracker >> boardPositionOf: player [
	| playerRelativePositions playerBoardPosition playerName |
	
	playerName := player.
	playerRelativePositions := self boardPositions.
	playerBoardPosition := playerRelativePositions at: playerName.
	^ playerBoardPosition.
]

{ #category : #accessing }
PositionsTracker >> boardPositions [
	| relativePositions playerNames boardPositions |
	playerNames := playerPositions collect: [ :position | position currentPlayer ].
	relativePositions := playerPositions collect: [ :position | self calculateBoardPositionFrom: (position currentPosition) ].
	boardPositions := Dictionary newFromKeys: playerNames andValues: relativePositions.
	^ boardPositions.
]

{ #category : #utility }
PositionsTracker >> calculateBoardPositionFrom: position [ 
	| boardPosition |
	boardPosition := (position rem: boardSize) = 0 ifTrue: [ boardSize ] ifFalse: [ position rem: boardSize ]. 
	^ boardPosition.
]

{ #category : #accessing }
PositionsTracker >> calculateLapFrom: position [ 

	| laps |
	
	laps := (position rem: boardSize) = 0 ifTrue: [ position // boardSize - 1 ] ifFalse: [ position // boardSize ].
	^ laps.
]

{ #category : #initialization }
PositionsTracker >> initializeOf: aGroupOfPlayers inBoardOf: size [
	
	boardSize := size.
	playerPositions := (aGroupOfPlayers collect: [ :playerName | Position of: playerName at: 1 in: 0 ]) asOrderedCollection.
]

{ #category : #accessing }
PositionsTracker >> playerLaps [
	| playerLaps playerNames laps |
	
	playerNames := playerPositions collect: [ :position | position currentPlayer ].
	laps := playerPositions collect: [ :position | position currentLap ].
	playerLaps := Dictionary newFromKeys: playerNames andValues: laps.
	^ playerLaps.
]

{ #category : #generation }
PositionsTracker >> playerRanking [
	
	| playerRanking playerRankingNames |
	
	playerRanking := playerPositions sort: [ :positionOne :positionTwo | positionOne > positionTwo ].
	playerRankingNames := playerRanking collect: [ :position | position currentPlayer ].
	^ playerRankingNames.
]

{ #category : #action }
PositionsTracker >> update: player withNew: position [
	
	| playerName lap oldPosition oldPositionIndex |
	
	playerName := player.
	lap := self calculateLapFrom: position.
	oldPosition := playerPositions detect: [ :playerPosition | playerPosition currentPlayer = playerName ].
	oldPositionIndex := playerPositions indexOf: oldPosition.
	playerPositions at: oldPositionIndex put: (Position of: playerName at: position in: lap).
]
