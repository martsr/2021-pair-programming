Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'diceCup',
		'deck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> calculateDistributionOf: squares using: effectProbabilities [
	| totalCount sortedEffectProbabilities mostProbableEffect count |
	totalCount := 0.
	sortedEffectProbabilities := effectProbabilities sort: [ :effectProbabilityOne :effectProbabilityTwo | effectProbabilityOne < effectProbabilityTwo ].
	mostProbableEffect := sortedEffectProbabilities asOrderedCollection
		last.
	effectProbabilities
		do: [ :effectProbability | 
			count := squares
				count: [ :square | square effect = effectProbability effect ].
			effectProbability = mostProbableEffect
				ifTrue: [ self assert: count equals: squares size - totalCount ]
				ifFalse: [ totalCount := totalCount + count.
					self
						assert: (effectProbability probability * squares size) ceiling
						equals: count ] ]
]

{ #category : #generators }
BoardTest >> generateDeckWith: gameCards [
	
	deck := Deck having: gameCards.
]

{ #category : #generators }
BoardTest >> generateDeterministicDiceCupWithSequences: sequences [

	| dice |
	
	dice := OrderedCollection new.
	dice := sequences  collect: [ :sequence | DeterministicDie having: sequence ].
	diceCup := DiceCup containing: dice.
]

{ #category : #generators }
BoardTest >> generatePlayerNames: playerNames [

	players := OrderedCollection new.
	players := playerNames.
]

{ #category : #running }
BoardTest >> setUp [

	super setUp. 
	players := OrderedCollection new.
]

{ #category : #asserting }
BoardTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
BoardTest >> test01ABoardMustContainAtLeast5SquareBoardsToBeGenerated [

	| cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 4 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	self
		should: [ Board having: squares requiring: 2 containing: deck usedBy: players]
		raise: Error
		withMessage: 'A board must contain at least 5 square boards to satisfy the effects distribution.'.
]

{ #category : #tests }
BoardTest >> test02ABoardMustHavePlayersWithDifferentNamesToBeGenerated [

	| cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	self 
		should: [ Board having: squares requiring: 1 containing: deck usedBy: players ]
		raise: Error
		withMessage: 'A board cannot be generated having players with repeated names.'
]

{ #category : #tests }
BoardTest >> test03ABoardMustHaveAtLeastOnePlayerToBeGenerated [

	|cards effectsDistribution effectShuffler squares |
	
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	self 
		should: [ Board having: squares requiring: 1 containing: deck usedBy: players ]
		raise: Error
		withMessage: 'A board  must have at least 1 player in order to be generated.'
]

{ #category : #tests }
BoardTest >> test04ABoarOfSizeTwentyAnd1LapHasTwentySquares [
	
	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 20.

]

{ #category : #tests }
BoardTest >> test05ABoardRequiresAtLeast1LapToBeGenerated [

	| cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	self should: [ Board having: squares requiring: 0 containing: deck usedBy: players]
		raise: Error
		withMessage: 'A board requires at least one lap to be generated.'.
]

{ #category : #tests }
BoardTest >> test06ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayers [
	
	| aBoard cards effectsDistribution effectShuffler squares |

	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfPlayers) equals: 3.
]

{ #category : #tests }
BoardTest >> test07ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayersAndADeterminsticDiceCup [
	
	| aBoard  cards effectsDistribution effectShuffler squares |

	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 3 containing: deck usedBy: players.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfPlayers) equals: 3.
	self assert: (aBoard amountOfLaps) equals: 3.
]

{ #category : #tests }
BoardTest >> test07InternalTest [
	| aBoard  cards effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 0.5 . EffectProbability of: WormHoleEffect new with: 0.5}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 40.
	self calculateDistributionOf: squares using: effectsDistribution.
]

{ #category : #tests }
BoardTest >> test08ABoardOfSizeTwentyAndThreeLapHasTwentySquaresAnd3Laps [
	
	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 3 containing: deck usedBy: players.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfLaps) equals: 3.
]

{ #category : #tests }
BoardTest >> test09GenerateABoardOfSizeTwentyWithAGivenProbabilityDistribution [

	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: (aBoard size) equals: 20.
	self calculateDistributionOf: squares using: effectsDistribution.
	
	 
]

{ #category : #tests }
BoardTest >> test10ABoardWithNoEffectsIsGenerated [

	| aBoard cards effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 20.
	self calculateDistributionOf: squares using: effectsDistribution.

]

{ #category : #tests }
BoardTest >> test11ABoardWithSpeedUpEffectsIsGenerated [

	| aBoard  cards effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 20.
	self calculateDistributionOf: squares using: effectsDistribution.
	

]

{ #category : #tests }
BoardTest >> test12ABoardWithWormHoleEffectsIsGenerated [

	| aBoard cards effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 20.
	self calculateDistributionOf: squares using: effectsDistribution.
	

]

{ #category : #tests }
BoardTest >> test13ABoardWithAtomicBombEffectsIsGenerated [

	| aBoard effects boardDistribution aRandomBoardGenerator cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: AtomicBombEffect  new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 20.
	self calculateDistributionOf: squares using: effectsDistribution.
	
]

{ #category : #tests }
BoardTest >> test14ABoardWithMoonWalkEffectsIsGenerated [

	| aBoard  cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (MoonWalkEffect new initializeGoingBack: 3) with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 20.
	self calculateDistributionOf: squares using: effectsDistribution.
	
]

{ #category : #tests }
BoardTest >> test15ABoardIsGeneratedWithSizeFive [

	| aBoard  cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 5 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 5.
	self calculateDistributionOf: squares using: effectsDistribution.
	
	

	 
]

{ #category : #tests }
BoardTest >> test16ABoardIsGeneratedWithSizeHundred [

	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 100 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 100.
	self calculateDistributionOf: squares using: effectsDistribution.
	
	 
]

{ #category : #tests }
BoardTest >> test17ABoardMustBeGeneratedWithTheSumOfEffectsProbabilityLessThanOneCannotBeGenerated [

	|  cards effectsDistribution  |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.3.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 	initializeGoingBack: 3) with: 0.10}.
	self 
		should: [ EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy) ]
		raise: Error
		withMessage: 'A board cannot be generated with a sum of probabilities not equal to 1.'
]

{ #category : #tests }
BoardTest >> test18ABoardMustBeGeneratedWithTheSumOfEffectsProbabilityMoreThanOneCannotBeGenerated [

	|  cards effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
		effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.5.EffectProbability of: WormHoleEffect  new with: 0.20 		.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect new 		initializeGoingBack: 3) with: 0.10}.
	self 
		should: [ EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy) ]
		raise: Error
		withMessage: 'A board cannot be generated with a sum of probabilities not equal to 1.'
]
