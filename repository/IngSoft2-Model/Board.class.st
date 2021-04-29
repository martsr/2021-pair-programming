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

{ #category : #action }
Board >> finalPositionsOf: players [
	^ players collect: [ :player | self whereIsPlayer: player ]
]

{ #category : #initialization }
Board >> initializeContaining: aNumberofSquareBoards [
	squares := OrderedCollection new.
	1 to: aNumberofSquareBoards do:[ :squareBoardNumber | squares add: (BoardSquare numbered: squareBoardNumber) ]
]

{ #category : #action }
Board >> move: player by: amountPlaces in: aGame [

	| playerPosition newPlayerPosition |
	
	playerPosition := self whereIsPlayer: player.
	(squares at: playerPosition) removeFromPosition: player.
	newPlayerPosition := playerPosition + amountPlaces.
	newPlayerPosition :=  newPlayerPosition min: squares size.
	(squares at: newPlayerPosition) place: player.
	newPlayerPosition = (squares size) ifTrue: [ aGame isNotifiedPlayerInLastSquare ]
]

{ #category : #accessing }
Board >> playerAtFinalSquare [
	^ squares last occupant
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
