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

{ #category : #'as yet unclassified' }
BoardTest >> calculateDistributionOf: squares [ 

	| boardSquareType noEffects wormHoleEffects speedUpEffects moonWalkEffects atomicBombEffects boardSquaresDistribution |
	
	boardSquareType := squares collect: [ :boardSquare | boardSquare effect ].
	noEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'No Effect'].
	wormHoleEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Worm Hole'].
	speedUpEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Speed Up'].
	moonWalkEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Moon Walk'].
	atomicBombEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Atomic Bomb'].
	boardSquaresDistribution := Dictionary newFrom: { 'Speed Up' -> speedUpEffects . 'Worm Hole' -> wormHoleEffects . 'Moon Walk' -> moonWalkEffects . 'Atomic Bomb' -> atomicBombEffects . 'No Effect' -> noEffects }.
	^ boardSquaresDistribution.
]

{ #category : #'as yet unclassified' }
BoardTest >> calculateDistributionOf: squares using: effectProbabilities [
	| boardSquaresDistribution totalCount sortedEffectProbabilities mostProbableEffect count |
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
						assert: effectProbability probability * squares size
						equals: count ] ]




	"boardSquaresDistribution := Dictionary new.
	effects do: [ :effect | boardSquaresDistribution at: effect put: (squares count: [ :square | (square effect) = effect]) ].
	squares := OrderedCollection new.
	sortedEffectProbabilities := effectProbabilities sort: [ :effectProbabilityOne :effectProbabilityTwo | (effectProbabilities at: effectProbabilityOne) < (effectProbabilities at: effectProbabilityTwo) ].
	mostProbableEffect := (sortedEffectProbabilities asOrderedCollection) removeLast.
	sortedEffectProbabilities do: [ :effectProbability | squares add: (BoardSquare applying:( effectProbability effect)) withOccurrences: ((boardSize * (effectProbability probability)) ceiling) ].
	remainingSquaresNumber := boardSize - (squares size).
	squares add: (BoardSquare applying: (mostProbableEffect effect)) withOccurrences: remainingSquaresNumber.
	squares shuffle. 
	^ squares.
	noEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'No Effect'].
	wormHoleEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Worm Hole'].
	speedUpEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Speed Up'].
	moonWalkEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Moon Walk'].
	atomicBombEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Atomic Bomb'].
	boardSquaresDistribution := Dictionary newFrom: { 'Speed Up' -> speedUpEffects . 'Worm Hole' -> wormHoleEffects . 'Moon Walk' -> moonWalkEffects . 'Atomic Bomb' -> atomicBombEffects . 'No Effect' -> noEffects }.
	
	^ boardSquaresDistribution."
]

{ #category : #'as yet unclassified' }
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

	| effects cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self
		should: [ EffectShuffler ofSize: 4 requiringLaps: 1 usedBy: players playingWith: deck applying: effects  ]
		raise: Error
		withMessage: 'A board must contain at least 5 square boards to satisfy the effects distribution.'.
]

{ #category : #tests }
BoardTest >> test02ABoardMustHavePlayersWithDifferentNamesToBeGenerated [

	|  effects cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self 
		should: [ EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects ]
		raise: Error
		withMessage: 'A board cannot be generated having players with repeated names.'
]

{ #category : #tests }
BoardTest >> test03ABoardMustHaveAtLeastOnePlayerToBeGenerated [

	| effects cards |
	
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self
		should: [ EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects ]
		raise: Error
		withMessage: 'A board  must have at least 1 player in order to be generated.'
]

{ #category : #tests }
BoardTest >> test04ABoarOfSizeTwentyAnd1LapHasTwentySquares [
	
	| aBoard effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: (aBoard size) equals: 20.
]

{ #category : #tests }
BoardTest >> test05ABoardRequiresAtLeast1LapToBeGenerated [

	| effects cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self
		should: [ EffectShuffler ofSize: 20 requiringLaps: 0 usedBy: players playingWith: deck applying: effects.]
		raise: Error
		withMessage: 'A board requires at least one lap to be generated.'.
]

{ #category : #tests }
BoardTest >> test06ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayers [
	
	| aBoard  effects aRandomBoardGenerator cards |

	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfPlayers) equals: 3.
]

{ #category : #tests }
BoardTest >> test07ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayersAndADeterminsticDiceCup [
	
	| aBoard  effects aRandomBoardGenerator cards |

	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 3 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
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
	
	| aBoard effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 3 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfLaps) equals: 3.
]

{ #category : #tests }
BoardTest >> test09GenerateABoardOfSizeTwentyWithAGivenProbabilityDistribution [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 0.48 . WormHoleEffect -> 0.20 . SpeedUpEffect -> 0.20 . MoonWalkEffect -> 0.10 . AtomicBombEffect  -> 0.02 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up' -> 4 . 'Worm Hole' -> 4 . 'Moon Walk' -> 2 . 'Atomic Bomb' -> 1 . 'No Effect' -> 9 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

	 
]

{ #category : #tests }
BoardTest >> test10ABoardWithNoEffectsIsGenerated [

	| aBoard effects boardDistribution cards effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := OrderedCollection newFrom: { NoEffect new }.
	effectsDistribution := Dictionary newFrom: { (effects at: 1) -> 1 }.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: effectsDistribution.
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players. 
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { (effects at: 1) -> 20 }.
	self assert: (self calculateDistributionOf: squares using: effects) equals: boardDistribution.

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

	| aBoard effects boardDistribution cards effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { WormHoleEffect -> 1 }.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: effects.
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up'-> 0 . 'Worm Hole'-> 20 . 'Moon Walk'-> 0 . 'Atomic Bomb'-> 0 . 'No Effect'-> 0 }.
	self assert: (self calculateDistributionOf: squares ) equals: boardDistribution.

]

{ #category : #tests }
BoardTest >> test13ABoardWithAtomicBombEffectsIsGenerated [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { AtomicBombEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up'-> 0 . 'Worm Hole'-> 0 . 'Moon Walk'-> 0 . 'Atomic Bomb'-> 20 . 'No Effect'-> 0 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

]

{ #category : #tests }
BoardTest >> test14ABoardWithMoonWalkEffectsIsGenerated [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { MoonWalkEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up'-> 0 . 'Worm Hole'-> 0 . 'Moon Walk'-> 20 . 'Atomic Bomb'-> 0 . 'No Effect'-> 0 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

]

{ #category : #tests }
BoardTest >> test15ABoardIsGeneratedWithSizeFive [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 0.48 . WormHoleEffect -> 0.20 . SpeedUpEffect -> 0.20 . MoonWalkEffect -> 0.10 . AtomicBombEffect  -> 0.02 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 5 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 5.
	boardDistribution := Dictionary newFrom: { 'Speed Up' -> 1 . 'Worm Hole' -> 1 . 'Moon Walk' -> 1 . 'Atomic Bomb' -> 1 . 'No Effect' -> 1 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

	 
]

{ #category : #tests }
BoardTest >> test16ABoardIsGeneratedWithSizeHundred [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 0.48 . WormHoleEffect -> 0.20 . SpeedUpEffect -> 0.20 . MoonWalkEffect -> 0.10 . AtomicBombEffect  -> 0.02 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 100 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 100.
	boardDistribution := Dictionary newFrom: { 'Speed Up' -> 20 . 'Worm Hole' -> 20 . 'Moon Walk' -> 10 . 'Atomic Bomb' -> 2 . 'No Effect' -> 48 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

	 
]

{ #category : #tests }
BoardTest >> test17ABoardMustBeGeneratedWithTheSumOfEffectsProbabilityLessThanOneCannotBeGenerated [

	|  effects cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.3). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self 
		should: [ EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects ]
		raise: Error
		withMessage: 'A board cannot be generated with a sum of probabilities not equal to 1.'
]

{ #category : #tests }
BoardTest >> test18ABoardMustBeGeneratedWithTheSumOfEffectsProbabilityMoreThanOneCannotBeGenerated [

	|  effects cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.5). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self 
		should: [ EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects ]
		raise: Error
		withMessage: 'A board cannot be generated with a sum of probabilities not equal to 1.'
]
