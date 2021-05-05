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
	self validateMoreThanOneSquare: aNumberOfSquareBoards.
	^ self new initializeContaining: aNumberOfSquareBoards
]

{ #category : #validation }
Board class >> validateMoreThanOneSquare: aNumberOfSquareBoards [
	aNumberOfSquareBoards < 2
		ifTrue: [ Error signal: 'A board must contain at least 2 square board' ]
]

{ #category : #accessing }
Board >> boardSquares [
	^ squares size
]

{ #category : #initialization }
Board >> initializeContaining: aNumberofSquareBoards [
	squares := OrderedCollection new.
	1 to: aNumberofSquareBoards do:[ :squareBoardNumber | squares add: (BoardSquare numbered: squareBoardNumber) ]
]

{ #category : #'as yet unclassified' }
Board >> move: player by: amountPlaces in: aGame with: aPlayerIndex [
	
	| playerPosition newPlayerPosition calculatedPlayerPosition |
	
	playerPosition := self whereIsPlayer: player.
	(squares at: playerPosition) removeFromPosition: player.
	calculatedPlayerPosition := (aGame playerAbsolutePositions at: aPlayerIndex) + amountPlaces.
	(calculatedPlayerPosition <= 0) ifTrue: [ calculatedPlayerPosition := 1 ].
	newPlayerPosition := (calculatedPlayerPosition rem: squares size) = 0 ifTrue: [ squares size ] ifFalse: [ calculatedPlayerPosition rem: squares size ].
	(squares at: newPlayerPosition) place: player.
	aGame isNotified: player movedTo: calculatedPlayerPosition.
]

{ #category : #'as yet unclassified' }
Board >> places: aPlayer at: squareNumber [ 
	| playerPosition |
	playerPosition := self whereIsPlayer: aPlayer. 
	(squares at: playerPosition ) removeFromPosition: aPlayer.
	(squares at: squareNumber) place: aPlayer.
]

{ #category : #action }
Board >> setUpWith: players [
	players do: [ :player | squares first place: player ]
]

{ #category : #action }
Board >> whereIsPlayer: aPlayer [

	| occupiedSquare |
	
	occupiedSquare := squares select: [ :squareBoard | squareBoard contains: aPlayer ].
	^ occupiedSquare first number
]
