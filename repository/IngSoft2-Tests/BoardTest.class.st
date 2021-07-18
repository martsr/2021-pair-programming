Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'deterministicDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> assertDistributionOf: squares using: effectProbabilities [

	| totalCount sortedEffectProbabilities mostProbableEffect count |
	
	totalCount := 0.
	sortedEffectProbabilities := effectProbabilities sort: [ :effectProbabilityOne :effectProbabilityTwo | effectProbabilityOne < effectProbabilityTwo ].
	mostProbableEffect := (sortedEffectProbabilities asOrderedCollection) removeLast.
	sortedEffectProbabilities do: [ :effectProbability | 
			count := squares count: [ :square | square effect = effectProbability effect ].
			totalCount := totalCount + count.
			self assert: (effectProbability probability * squares size) ceiling equals: count ].
	count := squares count: [ :square | square effect = mostProbableEffect effect ].	
	self assert: count equals: squares size - totalCount
]

{ #category : #generators }
BoardTest >> generateDeterministicDeckWith: gameCards [
	
	deterministicDeck := DeterministicDeck having: gameCards.
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
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 4 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	self
		should: [ Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players]
		raise: Error
		withMessage: 'A board must contain at least 8 square boards to satisfy the effects distribution.'.
]

{ #category : #tests }
BoardTest >> test02ABoardMustHavePlayersWithDifferentNamesToBeGenerated [

	| cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	self 
		should: [ Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players ]
		raise: Error
		withMessage: 'A board cannot be created having players with repeated names.'
]

{ #category : #tests }
BoardTest >> test03ABoardMustHaveAtLeastOnePlayerToBeGenerated [

	|cards effectsDistribution effectShuffler squares |
	
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	self 
		should: [ Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players ]
		raise: Error
		withMessage: 'A board must have at least 1 player in order to be created.'
]

{ #category : #tests }
BoardTest >> test04ABoarOfSizeTwentyAnd1LapHasTwentySquares [
	
	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 20.

]

{ #category : #tests }
BoardTest >> test05ABoardRequiresAtLeast1LapToBeGenerated [

	| cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	self should: [ Board having: squares requiring: 0 playingWith: deterministicDeck usedBy: players]
		raise: Error
		withMessage: 'A board requires at least one lap to be created.'.
]

{ #category : #tests }
BoardTest >> test06ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayers [
	
	| aBoard cards effectsDistribution effectShuffler squares |

	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfPlayers) equals: 3.
]

{ #category : #tests }
BoardTest >> test07ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayersAndADeterminsticDiceCup [
	
	| aBoard  cards effectsDistribution effectShuffler squares |

	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 3 playingWith: deterministicDeck usedBy: players.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfPlayers) equals: 3.
	self assert: (aBoard amountOfLaps) equals: 3.
]

{ #category : #tests }
BoardTest >> test08ABoardOfSizeTwentyAndThreeLapHasTwentySquaresAnd3Laps [
	
	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 3 playingWith: deterministicDeck usedBy: players.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfLaps) equals: 3.
]

{ #category : #tests }
BoardTest >> test09GenerateABoardOfSizeTwentyWithAGivenProbabilityDistribution [

	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: (aBoard size) equals: 20.
	self assertDistributionOf: squares using: effectsDistribution.
	
	 
]

{ #category : #tests }
BoardTest >> test10ABoardWithNoEffectsIsGenerated [

	| aBoard cards effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 20.
	self assertDistributionOf: squares using: effectsDistribution.

]

{ #category : #tests }
BoardTest >> test11ABoardWithSpeedUpEffectsIsGenerated [

	| aBoard  cards effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 20.
	self assertDistributionOf: squares using: effectsDistribution.
	

]

{ #category : #tests }
BoardTest >> test12ABoardWithWormHoleEffectsIsGenerated [

	| aBoard cards effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: WormHoleEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 20.
	self assertDistributionOf: squares using: effectsDistribution.
	

]

{ #category : #tests }
BoardTest >> test13ABoardWithAtomicBombEffectsIsGenerated [

	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: AtomicBombEffect  new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 20.
	self assertDistributionOf: squares using: effectsDistribution.
	
]

{ #category : #tests }
BoardTest >> test14ABoardWithMoonWalkEffectsIsGenerated [

	| aBoard  cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (MoonWalkEffect goingBack: 3) with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 20.
	self assertDistributionOf: squares using: effectsDistribution.
	
]

{ #category : #tests }
BoardTest >> test15ABoardIsGeneratedWithSizeFive [

	| aBoard  cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 . EffectProbability of: SpeedUpEffect new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 8 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 8.
	self assertDistributionOf: squares using: effectsDistribution.
	
	

	 
]

{ #category : #tests }
BoardTest >> test16ABoardIsGeneratedWithSizeHundred [

	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.48.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 100 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 100.
	self assertDistributionOf: squares using: effectsDistribution.
	
	 
]

{ #category : #tests }
BoardTest >> test17ABoardContainingOnlyDrawEffectsItsGenerated [

	| aBoard  cards effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: DrawCardEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 20.
	self assertDistributionOf: squares using: effectsDistribution.
	
]

{ #category : #tests }
BoardTest >> test18ABoardWith25SqauresWithAllTheEffectsIsCreated [

	| aBoard cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (DrawCardEffect new) with: 0.10 . EffectProbability of: (NoEffect new) with: 0.38 . EffectProbability of: (WormHoleEffect new) with: 0.20 . EffectProbability of: (SpeedUpEffect new) with: 0.20 . EffectProbability of: (AtomicBombEffect new) with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	effectShuffler := EffectShuffler ofSize: 25 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	self assert: aBoard size equals: 25.
	self assertDistributionOf: squares using: effectsDistribution.
]
