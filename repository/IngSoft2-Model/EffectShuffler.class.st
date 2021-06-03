Class {
	#name : #EffectShuffler,
	#superclass : #Object,
	#instVars : [
		'laps',
		'players',
		'boardSize',
		'deck',
		'effectProbabilities'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
EffectShuffler class >> ofSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps usedBy: aGroupOfPlayers playingWith: aDeck applying: aGroupOfEffects [  
	self validatesProbabilitiesSumEqualsOne: aGroupOfEffects.
	^self new initializeOfSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps usedBy: aGroupOfPlayers playingWith: aDeck applying: aGroupOfEffects. 
]

{ #category : #'instance creation' }
EffectShuffler class >> ofSize: aNumberOfSquares withGiven: effects [
	self validatesProbabilitiesSumEqualsOne: effects.
	^ self new initializeOfSize: aNumberOfSquares withGiven: effects	
]

{ #category : #validation }
EffectShuffler class >> validatesProbabilitiesSumEqualsOne: effects [

	| probabilites sumOfProbabilities |
	
	probabilites := (effects collect: [ :effect | effect probability ])asOrderedCollection. 
	sumOfProbabilities := probabilites inject: 0 into: [:sum :probability | sum + probability].
	(sumOfProbabilities closeTo:1) ifFalse: [ Error signal:'A board cannot be generated with a sum of probabilities not equal to 1.' ]. 

]

{ #category : #private }
EffectShuffler >> createNew [

	| squares effectsClass sortedEffects mostProbableEffect remainingSquaresNumber effectValues |
	squares := OrderedCollection new.
	effectValues := self generateEffectValues.
	effectsClass := (effectProbabilities keys) asOrderedCollection.
	sortedEffects := effectsClass sort: [ :effectOne :effectTwo | (effectProbabilities at: effectOne) < (effectProbabilities at: effectTwo) ].
	mostProbableEffect := (sortedEffects asOrderedCollection) removeLast.
	sortedEffects do: [ :effect | squares add: (BoardSquare applying: (effect applyingValue: (effectValues atRandom))) withOccurrences: ((boardSize * (effectProbabilities 	at:effect)) ceiling) ].
	remainingSquaresNumber := boardSize - (squares size).
	squares add: (BoardSquare applying: (mostProbableEffect applyingValue: (effectValues  atRandom))) withOccurrences: remainingSquaresNumber.
	squares shuffle. 
	^ Board having: squares requiring: laps containing: deck usedBy: players.
]

{ #category : #translating }
EffectShuffler >> generate [ 
	| squares mostProbableEffect remainingSquaresNumber sortedEffectProbabilities |
	squares := OrderedCollection new.
	sortedEffectProbabilities := effectProbabilities sort: [ :effectProbabilityOne :effectProbabilityTwo | effectProbabilityOne < effectProbabilityTwo ].
	mostProbableEffect := (sortedEffectProbabilities asOrderedCollection) removeLast.
	sortedEffectProbabilities do: [ :effectProbability | squares add: (BoardSquare applying:( effectProbability effect)) withOccurrences: ((boardSize * (effectProbability probability)) ceiling) ].
	remainingSquaresNumber := boardSize - (squares size).
	squares add: (BoardSquare applying: (mostProbableEffect effect)) withOccurrences: remainingSquaresNumber.
	squares shuffle. 
	^ squares.
]

{ #category : #accessing }
EffectShuffler >> generateEffectValues [

	| maxGoingBack effectValues |
	
	effectValues := OrderedCollection new.
	maxGoingBack := boardSize // 2.
	3 timesRepeat: [effectValues add: (1 to: maxGoingBack) atRandom ].
	^ effectValues
]

{ #category : #initialization }
EffectShuffler >> initializeOfSize: aNumberOfSquareBoards requiringLaps: aNumberOfLaps usedBy: aGroupOfPlayers playingWith: aDeck applying: aGroupOfEffects [
	
	boardSize := aNumberOfSquareBoards.
	laps := aNumberOfLaps.
	players := aGroupOfPlayers.
	deck := aDeck.
	effectProbabilities := aGroupOfEffects.
]

{ #category : #initialization }
EffectShuffler >> initializeOfSize: aNumberOfSquares withGiven: probabilites [

	boardSize := aNumberOfSquares.
	effectProbabilities := probabilites.
]
