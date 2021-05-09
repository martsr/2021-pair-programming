Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares'
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

{ #category : #validation }
Board class >> validateMoreThanOneSquare: aNumberOfSquareBoards [
	aNumberOfSquareBoards < 2
		ifTrue: [ Error signal: 'A board must contain at least 2 square board' ]
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

{ #category : #action }
Board >> move: player by: amountPlaces in: aGame with: aPlayerIndex [

	| playerPosition newPlayerPosition calculatedPlayerPosition |
	
	playerPosition := self whereIsPlayer: player.
	(squares at: playerPosition) removeFromPosition: player.
	calculatedPlayerPosition := (aGame playerAbsolutePositions at: aPlayerIndex) + amountPlaces.
	calculatedPlayerPosition <= 0	ifTrue: [ calculatedPlayerPosition := 1 ].
	newPlayerPosition := (calculatedPlayerPosition rem: squares size) = 0 ifTrue: [ squares size ]
	ifFalse: [ calculatedPlayerPosition rem: squares size ].
	aGame isNotified: player movedTo: calculatedPlayerPosition.
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
	players do: [ :player | (squares first) place: player on: aGame].
	self setUpSquaresToApplyEffect 
]

{ #category : #action }
Board >> whereIsPlayer: aPlayer [

	| occupiedSquare |
	
	occupiedSquare := squares select: [ :squareBoard | squareBoard contains: aPlayer ].
	^ occupiedSquare first number
]
