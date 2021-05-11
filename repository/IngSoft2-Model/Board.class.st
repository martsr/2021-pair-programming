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
Board class >> containing: aNumberOfSquareBoards [
	
	| squares |
	
	self validateMoreThanOneSquare: aNumberOfSquareBoards.
	squares := OrderedCollection new.
	aNumberOfSquareBoards timesRepeat: [ squares add: (NoEffect new) ].
	^ self having: squares. 
]

{ #category : #'instance creation' }
Board class >> having: squares [
	self validateMoreThanOneSquare: (squares size).
	^self new initializeHaving: squares.
]

{ #category : #'as yet unclassified' }
Board class >> ofSize: aNumberOfSquareBoards requiring: aNumberOfLaps [ 
	self validateMoreThanOneSquare: aNumberOfSquareBoards.
	self validatesItNeedsAtLeastOneLap: aNumberOfLaps.
	^ self new intializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps.
]

{ #category : #'instance creation' }
Board class >> ofSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers [ 
	self validatesItMustHaveAtLeastOnePlayer: aGroupOfPlayers.
	self validateMoreThanOneSquare: aNumberOfSquareBoards.
	self validatesItNeedsAtLeastOneLap: aNumberOfLaps.
	^self new initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers .
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
	positionTracker := PositionsTracker of: aGroupOfPlayers inBoardSize: (boardSquares size) requiring: aNumberOfLaps.
]

{ #category : #initialization }
Board >> initializeHaving: effects [
	squares := OrderedCollection new.
	1 to: (effects size) do:[ :number | squares add: (BoardSquare numbered: number withEffect: (effects at: number)) ].
]

{ #category : #initialization }
Board >> initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers [  
	turn := 1.
	players := aGroupOfPlayers.
	positionTracker := PositionsTracker of: players inBoardSize: aNumberOfSquareBoards requiring: aNumberOfLaps.
	size := aNumberOfSquareBoards * aNumberOfLaps.
	squares := OrderedCollection new.
	1 to: size do:[ :squareBoardNumber | squares add: (BoardSquare numbered: squareBoardNumber withEffect: NoEffect new) ].
]

{ #category : #initialization }
Board >> initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup [ 
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	size := aNumberOfSquareBoards * aNumberOfLaps.
	turn := 1.
	squares := OrderedCollection new.
	1 to: size do:[ :squareBoardNumber | squares add: (BoardSquare numbered: squareBoardNumber withEffect: NoEffect new) ].
	positionTracker := PositionsTracker of: aGroupOfPlayers  inBoardSize: aNumberOfSquareBoards  requiring: aNumberOfLaps .
]

{ #category : #'as yet unclassified' }
Board >> intializeOfSize: aNumberOfSquareBoards requiring: laps [ 

	size := aNumberOfSquareBoards * laps.
	squares := OrderedCollection new.
	1 to: size do:[ :squareBoardNumber | squares add: (BoardSquare numbered: squareBoardNumber withEffect: NoEffect new) ].
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
Board >> move: player by: amountPlaces in: aGame [

	| playerPosition calculatedPlayerPosition |
	
	playerPosition := positionTracker positionOf: player.
	calculatedPlayerPosition := playerPosition + amountPlaces.
	calculatedPlayerPosition <= 0	ifTrue: [ calculatedPlayerPosition := 1 ].
	positionTracker update: player withNew: calculatedPlayerPosition.
	(calculatedPlayerPosition > size) ifTrue:[ aGame isNotifiedItHasFinished ] ifFalse: [ (squares at: calculatedPlayerPosition) place: player on: self ].
	
]

{ #category : #action }
Board >> move: player by: amountPlaces in: aGame with: aPlayerIndex [

	| playerPosition newPlayerPosition calculatedPlayerPosition |
	
	"Se simplifica la logica preguntando al tracker donde esta el jugador en cuestion y se adicionan o restan lo de la tirada"
	playerPosition := self whereIsPlayer: player.
	(squares at: playerPosition) removeFromPosition: player.
	calculatedPlayerPosition := (aGame playerAbsolutePositions at: aPlayerIndex) + amountPlaces.
	calculatedPlayerPosition <= 0	ifTrue: [ calculatedPlayerPosition := 1 ].
	newPlayerPosition := (calculatedPlayerPosition rem: squares size) = 0 ifTrue: [ squares size ]
	ifFalse: [ calculatedPlayerPosition rem: squares size ].
	"La linea de abajo se cambia como un update al tracker sobre la posicion del jugador que tiro"
	aGame isNotified: player movedTo: calculatedPlayerPosition.
	"Se pregunta si se excedio o igualo la casilla maxima, si se excedio, le dice al tracker que lo ponga en la primera casilla y avisa al game, venga o no con efecto (Decision de equipo). De lo contrario, manda a hacer el placement"
	(squares at: newPlayerPosition) place: player on: aGame.
	
]

{ #category : #action }
Board >> nextPlayerThrows [

	| resultOfThrow player playerIndex |
	
	player := players at: turn.
   playerIndex := players indexOf: player.
	resultOfThrow := player throwsWith: diceCup.
	self move: player by: resultOfThrow.
	
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

{ #category : #action }
Board >> setUpWith: players on: aGame [
	"Este mensaje queda deleteado"
	players do: [ :player | (squares first) place: player on: aGame].
	self setUpSquaresToApplyEffect 
]

{ #category : #action }
Board >> whereIsPlayer: aPlayer [

	"Dudoso que siga, a chequear porque el tracker mismo se puede encargar de esta funcionalidad"
	| occupiedSquare |
	
	occupiedSquare := squares select: [ :squareBoard | squareBoard contains: aPlayer ].
	^ occupiedSquare first number
]
