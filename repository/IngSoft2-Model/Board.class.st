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
	^ self new intializeContaining: aNumberOfSquareBoards withEffect: NoEffect new. 
]

{ #category : #'instance creation' }
Board class >> containing: aNumberOfSquareBoards withEffect: anEffect [  
	self validateMoreThanOneSquare: aNumberOfSquareBoards.
	^self new intializeContaining: aNumberOfSquareBoards withEffect: anEffect. 
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
Board >> intializeContaining: aNumberOfSquareBoards withEffect: anEffect [ 
	squares := OrderedCollection new.
	1 to: aNumberOfSquareBoards do:[ :squareBoardNumber | squares add: (BoardSquare numbered: squareBoardNumber withEffect: anEffect) ].
]

{ #category : #'as yet unclassified' }
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

{ #category : #initialization }
Board >> setUpSquaresToApplyEffect [
	squares do: [ :square | square changeToApplyEffect ]
]

{ #category : #initialization }
Board >> setUpSquaresToNotApplyEffect [
	squares do: [ :square | square changeToNotApplyEffect ]
]

{ #category : #initialization }
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
