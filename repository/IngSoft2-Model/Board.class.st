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

	| playerPosition newPlayerPosition calculatedPlayerPosition amountOfLaps |
	
	playerPosition := self whereIsPlayer: player.
	(squares at: playerPosition) removeFromPosition: player.
	calculatedPlayerPosition := playerPosition + amountPlaces.
	newPlayerPosition := calculatedPlayerPosition > squares size
		ifTrue: [ calculatedPlayerPosition rem: squares size ]
		ifFalse: [ calculatedPlayerPosition ].
	(squares at: newPlayerPosition) place: player.
	amountOfLaps := calculatedPlayerPosition // squares size.
	amountOfLaps > 0 ifTrue: [ aGame isNotified: player made: amountOfLaps ]
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
