Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squareBoards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> containing: aNumberOfSquareBoards [
	self validateMoreThanOneSquareBoard: aNumberOfSquareBoards.
	^ self new initializeWith: aNumberOfSquareBoards
]

{ #category : #'instance creation' }
Board class >> validateMoreThanOneSquareBoard: aNumberOfSquareBoards [
	aNumberOfSquareBoards < 2
		ifTrue: [ Error signal: 'A board must contain at least 2 square board' ]
]

{ #category : #'as yet unclassified' }
Board >> boardSquares [
	^squareBoards size.
]

{ #category : #initialization }
Board >> initializeWith: aNumberofSquareBoards [
	squareBoards := OrderedCollection new.
	(1 to: aNumberofSquareBoards) do: [ :squareBoardNumber | squareBoards add:(BoardSquare numbered: squareBoardNumber) ].
]

{ #category : #'as yet unclassified' }
Board >> move: player  squares: amountPlaces [ 
	| playerPosition newPlayerPosition |
	playerPosition:= self whereIsPlayer: player. 
	(squareBoards at: playerPosition )removeFromPosition: player.
	newPlayerPosition:= playerPosition + amountPlaces .
	"Aca hay que preguntar si la suma es mayor que squareBoard sixe y si es asi hay que colocar al jugador en ese lugar "
	(squareBoards at: newPlayerPosition) place: player.
	
]

{ #category : #'as yet unclassified' }
Board >> setUpWith: players [ 
players do:[:player| squareBoards first place: player ].
]

{ #category : #'as yet unclassified' }
Board >> whereIsPlayer: aPlayer [ 
	| occupiedSquare |
	occupiedSquare := squareBoards select: [:squareBoard | squareBoard contains: aPlayer].
	^ occupiedSquare first squareNumber.
]
