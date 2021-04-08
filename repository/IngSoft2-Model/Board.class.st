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
	aNumberOfSquareBoards < 1
		ifTrue: [ Error signal: 'A board must contain at least 1 square board' ]
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
