Class {
	#name : #PositionsTracker,
	#superclass : #Object,
	#instVars : [
		'playerPositions',
		'laps',
		'boardSize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionsTracker class >> of: aGroupOfPlayers  inBoardSize: aNumberOfSquareBoards  requiring: aNumberOfLaps [  
	^ self new initializeOf: aGroupOfPlayers  inBoardSize: aNumberOfSquareBoards  requiring: aNumberOfLaps . 
]

{ #category : #accessing }
PositionsTracker >> absolutePositionOf: player [

	| playerName playerPosition |
	playerName := player name. 
	playerPosition := playerPositions at: playerName.
	^ playerPosition. 	
]

{ #category : #initialization }
PositionsTracker >> initializeOf: aGroupOfPlayers  inBoardSize: aNumberOfSquareBoards  requiring: aNumberOfLaps [ 
	| positions playersName |
	positions := OrderedCollection new. 
	positions add: 1 withOccurrences: (aGroupOfPlayers size).
	playersName := OrderedCollection new.
	playersName := aGroupOfPlayers collect: [ :player | player name ].
	playerPositions := Dictionary newFromKeys: playersName andValues: positions.
	laps := aNumberOfLaps .
	boardSize := aNumberOfSquareBoards. 
]

{ #category : #accessing }
PositionsTracker >> playerLaps [
	| playerLaps |
	playerLaps := Dictionary new. 
	playerPositions keysAndValuesDo: [:playerName :absolutePosition | playerLaps at: playerName put: (((absolutePosition rem: boardSize) = 0) ifTrue: [(absolutePosition // (boardSize)) -1] ifFalse:[ absolutePosition // boardSize ])].
	^playerLaps.
	

]

{ #category : #generation }
PositionsTracker >> playerRanking [

	|playerRanking playerNames |
	
	playerNames := playerPositions keys.
	playerRanking := playerNames sort: [ :playerOneName :playerTwoName | (playerPositions at: playerOneName ) > (playerPositions at: playerTwoName ) and: (playerOneName  > playerTwoName )].
	^playerRanking. 
]

{ #category : #accessing }
PositionsTracker >> relativePositionOf: player [

	| playerRelativePosition playerRelativePositions |
	playerRelativePositions := self relativePositions.
	playerRelativePosition := playerRelativePositions at: (player name). 
	^ playerRelativePosition. 	
]

{ #category : #accessing }
PositionsTracker >> relativePositions [

	| relativePositions |
	relativePositions := Dictionary new. 
	playerPositions keysAndValuesDo: [:playerName :absolutePosition | relativePositions at:(playerName) put: ((absolutePosition rem: boardSize ) = 0 ifTrue: [boardSize ] ifFalse: [ absolutePosition rem: boardSize]) ].
	^ relativePositions copy. 
	
]

{ #category : #action }
PositionsTracker >> update: player withNew: calculatedPlayerPosition [

	| playerName |
	playerName := player name. 
	playerPositions at: playerName put: calculatedPlayerPosition.
	
]
