Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'size',
		'players',
		'diceCup'
	],
	#category : #'IngSoft2-Model'
}

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
	^self new initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup.
]

{ #category : #validation }
Board class >> validateMoreThanOneSquare: aNumberOfSquareBoards [
	aNumberOfSquareBoards < 2
		ifTrue: [ Error signal: 'A board must contain at least 2 square board' ]
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
Board >> initializeHaving: effects [
	squares := OrderedCollection new.
	1 to: (effects size) do:[ :number | squares add: (BoardSquare numbered: number withEffect: (effects at: number)) ].
]

{ #category : #initialization }
Board >> initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers [  
	players := aGroupOfPlayers.
	size := aNumberOfSquareBoards * aNumberOfLaps.
	squares := OrderedCollection new.
	1 to: size do:[ :squareBoardNumber | squares add: (BoardSquare numbered: squareBoardNumber withEffect: NoEffect new) ].
]

{ #category : #initialization }
Board >> initializeOfSize: aNumberOfSquareBoards requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup [ 
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	size := aNumberOfSquareBoards * aNumberOfLaps.
	squares := OrderedCollection new.
	1 to: size do:[ :squareBoardNumber | squares add: (BoardSquare numbered: squareBoardNumber withEffect: NoEffect new) ].
]

{ #category : #'as yet unclassified' }
Board >> intializeOfSize: aNumberOfSquareBoards requiring: laps [ 

	size := aNumberOfSquareBoards * laps.
	squares := OrderedCollection new.
	1 to: size do:[ :squareBoardNumber | squares add: (BoardSquare numbered: squareBoardNumber withEffect: NoEffect new) ].
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
