Class {
	#name : #RandomBoardGenerator,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'index'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
RandomBoardGenerator class >> ofSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps playedBy: aGroupOfPlayers using: aDiceCup usingEffects: aGroupOfEffects [ 
	self validateMoreThanFiveSquares: aNumberOfSquareBoards.
	self validatesItDoesntHavePlayersWithSameName: aGroupOfPlayers.
	self validatesItMustHaveAtLeastOnePlayer: aGroupOfPlayers.
	self validatesItNeedsAtLeastOneLap: aNumberOfLaps.   
	self validatesProbabilitiesSumEqualsOne: aGroupOfEffects.
	^self new initializeOfSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps playedBy: aGroupOfPlayers using: aDiceCup usingEffects: aGroupOfEffects. 
]

{ #category : #validation }
RandomBoardGenerator class >> validateMoreThanFiveSquares: aNumberOfSquareBoards [
	aNumberOfSquareBoards < 5
		ifTrue: [ Error signal: 'A board must contain at least 5 square boards to satisfy the effects distribution.' ]
]

{ #category : #validation }
RandomBoardGenerator class >> validatesItDoesntHavePlayersWithSameName: players [

	| playerNames |
	
	playerNames := players collect: [ :player | player name ].
	playerNames := playerNames asSet.
	(players size) > (playerNames size) ifTrue: [ Error signal: 'A board cannot be generated having players with repeated names.' ]
]

{ #category : #validation }
RandomBoardGenerator class >> validatesItMustHaveAtLeastOnePlayer: aPlayer [
	aPlayer size < 1
		ifTrue: [ Error signal: 'A board  must have at least 1 player in order to be generated.' ]
]

{ #category : #'instance creation' }
RandomBoardGenerator class >> validatesItNeedsAtLeastOneLap: amountOfLaps [
	amountOfLaps < 1
		ifTrue: [ Error signal: 'A board requires at least one lap to be generated.' ]
]

{ #category : #'as yet unclassified' }
RandomBoardGenerator class >> validatesProbabilitiesSumEqualsOne: effects [

	| probabilites sumOfProbabilities |
	
	probabilites := (effects values)asOrderedCollection. 
	sumOfProbabilities := probabilites inject: 0 into: [:sum :probability | sum + probability].
	(sumOfProbabilities closeTo:1) ifFalse: [ Error signal:'A board cannot be generated with a sum of probabilities not equal to 1.' ]. 

]

{ #category : #action }
RandomBoardGenerator >> generateMoonWalkValuesWithBoardSize: aNumberOfSquareBoards [
	| moonWalkValues maxGoingBack |
	moonWalkValues := OrderedCollection new.
	maxGoingBack := aNumberOfSquareBoards // 2. 
	3 timesRepeat: [moonWalkValues add: ((1 to: maxGoingBack) atRandom)].
	^ moonWalkValues

]

{ #category : #initialization }
RandomBoardGenerator >> initializeOfSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps playedBy: aGroupOfPlayers using: aDiceCup usingEffects: aGroupOfEffects [

	| squares effects sortedEffects mostProbableEffect remainingSquaresNumber moonWalkValues |
	
	squares := OrderedCollection new.
	moonWalkValues := self generateMoonWalkValuesWithBoardSize: aNumberOfSquareBoards .
	effects := (aGroupOfEffects keys) asOrderedCollection.
	sortedEffects := effects sort: [ :effectOne :effectTwo | (aGroupOfEffects at: effectOne) < (aGroupOfEffects at: effectTwo) ].
	mostProbableEffect := (sortedEffects asOrderedCollection) removeLast.
	sortedEffects do: [ :effect | squares add: (BoardSquare withEffect: (effect newWithParameter: (moonWalkValues atRandom))) withOccurrences: ((aNumberOfSquareBoards      * (aGroupOfEffects at:effect)) ceiling) ].
	remainingSquaresNumber := aNumberOfSquareBoards - (squares size).
	squares add: (BoardSquare withEffect: (mostProbableEffect newWithParameter: (moonWalkValues atRandom))) withOccurrences: remainingSquaresNumber.
	squares shuffle. 
	^ Board consistingOf: squares requiring: aNumberOfLaps by: aGroupOfPlayers using: aDiceCup.
]
