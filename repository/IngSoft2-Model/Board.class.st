Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boardSquare'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> containing: aNumberOfSquareBoards [
	self validateMoreThanOneBoardSquare: aNumberOfSquareBoards.
	^ self new initializeBoardWith: aNumberOfSquareBoards
]

{ #category : #validation }
Board class >> validateMoreThanOneBoardSquare: aNumberOfSquareBoards [
	aNumberOfSquareBoards < 2
		ifTrue: [ Error signal: 'A board must contain at least 2 square board' ]
]

{ #category : #accessing }
Board >> boardSquares [
	^ boardSquare size
]

{ #category : #boardAction }
Board >> finalPositionsOf: players [
	^ players collect: [ :player | self whereIsPlayer: player ]
]

{ #category : #initialization }
Board >> initializeBoardWith: aNumberofSquareBoards [
	boardSquare := OrderedCollection new.
	(1 to: aNumberofSquareBoards) do:[ :squareBoardNumber | boardSquare add: (BoardSquare numbered: squareBoardNumber) ]
]

{ #category : #boardAction }
Board >> move: player squares: amountPlaces inGame: aGame [

	| playerPosition newPlayerPosition |
	
	playerPosition := self whereIsPlayer: player.
	(boardSquare at: playerPosition) removeFromPosition: player.
	newPlayerPosition := playerPosition + amountPlaces.
	newPlayerPosition >= boardSquare size ifTrue: [ newPlayerPosition := boardSquare size ].
	(boardSquare at: newPlayerPosition) place: player.
	newPlayerPosition = 20 ifTrue: [ aGame isNotifiedPlayerInLastSquare ]
]

{ #category : #accessing }
Board >> playerAtFinalSquare [
	^ boardSquare last occupant
]

{ #category : #boardAction }
Board >> setUpWith: players [
	players do: [ :player | boardSquare first place: player ]
]

{ #category : #boardAction }
Board >> whereIsPlayer: aPlayer [

	| occupiedSquare |
	
	occupiedSquare := boardSquare select: [ :squareBoard | squareBoard contains: aPlayer ].
	^ occupiedSquare first squareNumber
]
