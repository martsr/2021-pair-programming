Class {
	#name : #EffectShuffler,
	#superclass : #Object,
	#instVars : [
		'boardSize',
		'effectProbabilities'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
EffectShuffler class >> ofSize: aNumberOfSquares withGiven: effectDistributions [
	self validatesNotEmpty: effectDistributions.
	self validatesProbabilitiesSumEqualsOne: effectDistributions.
	^ self new initializeOfSize: aNumberOfSquares withGiven: effectDistributions	
]

{ #category : #validation }
EffectShuffler class >> validatesNotEmpty: effectDistributions [
	((effectDistributions size) < 1) ifTrue: [ Error signal: 'Squares cannot be generated without effect distributions' ]
]

{ #category : #validation }
EffectShuffler class >> validatesProbabilitiesSumEqualsOne: effects [

	| probabilites sumOfProbabilities |
	
	probabilites := (effects collect: [ :effect | effect probability ])asOrderedCollection. 
	sumOfProbabilities := probabilites inject: 0 into: [:sum :probability | sum + probability].
	(sumOfProbabilities closeTo:1) ifFalse: [ Error signal: 'Sum of effect probabilities must be equal to 1' ]. 

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

{ #category : #initialization }
EffectShuffler >> initializeOfSize: aNumberOfSquares withGiven: probabilites [

	boardSize := aNumberOfSquares.
	effectProbabilities := probabilites.
]
