Class {
	#name : #BoardGenerator,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'index'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
BoardGenerator class >> ofSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps playedBy: aGroupOfPlayers using: aDiceCup usingEffects: aGroupOfEffects [ 
	^self new initializeOfSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps playedBy: aGroupOfPlayers using: aDiceCup usingEffects: aGroupOfEffects. 
]

{ #category : #initialization }
BoardGenerator >> initializeOfSize: aNumberOfSquareBoards  requiringLaps: aNumberOfLaps  playedBy: aGroupOfPlayers  using: aDiceCup usingEffects: aGroupOfEffects [

	| squares effects sortedEffects mostProbableEffect boardSize remainingSquaresNumber |
	
	squares := OrderedCollection new.
	effects := aGroupOfEffects keys.
	sortedEffects := effects sort: [ :effectOne :effectTwo | (aGroupOfEffects at: effectOne) < (aGroupOfEffects at: effectTwo) ].
	mostProbableEffect := (sortedEffects asOrderedCollection) removeLast.
	sortedEffects do: [ :effect | squares add: (BoardSquare withEffect: (effect newWithParameter: 2)) withOccurrences: (((aNumberOfSquareBoards * aNumberOfLaps) * (aGroupOfEffects at: effect)) ceiling) ].
	boardSize := aNumberOfLaps * aNumberOfSquareBoards.
	remainingSquaresNumber := boardSize - (squares size).
	squares add: (BoardSquare withEffect: (mostProbableEffect newWithParameter: 2)) withOccurrences: remainingSquaresNumber.
	squares shuffle. 
	^ Board consistingOf: squares requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup.
]
