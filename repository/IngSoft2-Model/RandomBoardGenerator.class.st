Class {
	#name : #RandomBoardGenerator,
	#superclass : #Object,
	#instVars : [
		'laps',
		'players',
		'diceCup',
		'effects',
		'boardSize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomBoardGenerator class >> ofSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps usedBy: aGroupOfPlayers playingWith: aDiceCup applying: aGroupOfEffects [ 
	self validateMoreThanFiveSquares: aNumberOfSquareBoards.
	self validatesItDoesntHavePlayersWithSameName: aGroupOfPlayers.
	self validatesItMustHaveAtLeastOnePlayer: aGroupOfPlayers.
	self validatesItNeedsAtLeastOneLap: aNumberOfLaps.   
	self validatesProbabilitiesSumEqualsOne: aGroupOfEffects.
	^self new initializeOfSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps usedBy: aGroupOfPlayers playingWith: aDiceCup applying: aGroupOfEffects. 
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

{ #category : #validation }
RandomBoardGenerator class >> validatesProbabilitiesSumEqualsOne: effects [

	| probabilites sumOfProbabilities |
	
	probabilites := (effects values)asOrderedCollection. 
	sumOfProbabilities := probabilites inject: 0 into: [:sum :probability | sum + probability].
	(sumOfProbabilities closeTo:1) ifFalse: [ Error signal:'A board cannot be generated with a sum of probabilities not equal to 1.' ]. 

]

{ #category : #private }
RandomBoardGenerator >> createNew [

	| squares effectsClass sortedEffects mostProbableEffect remainingSquaresNumber effectValues |
	squares := OrderedCollection new.
	effectValues := self generateEffectValues.
	effectsClass := (effects keys) asOrderedCollection.
	sortedEffects := effectsClass sort: [ :effectOne :effectTwo | (effects at: effectOne) < (effects at: effectTwo) ].
	mostProbableEffect := (sortedEffects asOrderedCollection) removeLast.
	sortedEffects do: [ :effect | squares add: (BoardSquare applying: (effect applyingValue: (effectValues atRandom))) withOccurrences: ((boardSize * (effects 	at:effect)) ceiling) ].
	remainingSquaresNumber := boardSize - (squares size).
	squares add: (BoardSquare applying: (mostProbableEffect applyingValue: (effectValues  atRandom))) withOccurrences: remainingSquaresNumber.
	squares shuffle. 
	^ Board having: squares requiring: laps usedBy: players throwing: diceCup.
]

{ #category : #accessing }
RandomBoardGenerator >> generateEffectValues [

	| maxGoingBack effectValues |
	
	effectValues := OrderedCollection new.
	maxGoingBack := boardSize // 2.
	3 timesRepeat: [effectValues add: (1 to: maxGoingBack) atRandom ].
	^ effectValues
]

{ #category : #initialization }
RandomBoardGenerator >> initializeOfSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps usedBy: aGroupOfPlayers playingWith: aDiceCup applying: aGroupOfEffects [
	
	boardSize := aNumberOfSquareBoards.
	laps := aNumberOfLaps.
	players := aGroupOfPlayers.
	diceCup := aDiceCup.
	effects := aGroupOfEffects.
]
