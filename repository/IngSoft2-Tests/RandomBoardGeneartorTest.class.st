Class {
	#name : #RandomBoardGeneartorTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'diceCup',
		'deck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
RandomBoardGeneartorTest >> calculateDistributionOf: aBoard [ 

	| boardSquaresType boardSquareType noEffects wormHoleEffects speedUpEffects moonWalkEffects atomicBombEffects boardSquaresDistribution |
	boardSquaresType := OrderedCollection new.
	1 to: (aBoard size) do: [ :position | boardSquaresType add: (aBoard atSquare: position) ].
	boardSquareType := boardSquaresType collect: [ :boardSquare | boardSquare typeOfEffect ].
	noEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'No Effect'].
	wormHoleEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Worm Hole'].
	speedUpEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Speed Up'].
	moonWalkEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Moon Walk'].
	atomicBombEffects := boardSquareType count: [ :boardSquareEffect | boardSquareEffect = 'Atomic Bomb'].
	boardSquaresDistribution := Dictionary newFrom: { 'Speed Up' -> speedUpEffects . 'Worm Hole' -> wormHoleEffects . 'Moon Walk' -> moonWalkEffects . 'Atomic Bomb' -> atomicBombEffects . 'No Effect' -> noEffects }.
	^ boardSquaresDistribution.
]

{ #category : #'as yet unclassified' }
RandomBoardGeneartorTest >> generateDeckWith: gameCards [
	
	deck := Deck having: gameCards.
]

{ #category : #generators }
RandomBoardGeneartorTest >> generateDeterministicDiceCupWithSequences: sequences [

	| dice |
	
	dice := OrderedCollection new.
	dice := sequences  collect: [ :sequence | DeterministicDie having: sequence ].
	diceCup := DiceCup containing: dice.
]

{ #category : #generators }
RandomBoardGeneartorTest >> generatePlayerNames: playerNames [

	players := OrderedCollection new.
	players := playerNames.
]

{ #category : #running }
RandomBoardGeneartorTest >> setUp [

	super setUp. 
	players := OrderedCollection new.
]

{ #category : #asserting }
RandomBoardGeneartorTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
RandomBoardGeneartorTest >> test01ABoardMustContainAtLeast5SquareBoardsToBeGenerated [

	| effects cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self
		should: [ RandomBoardGenerator ofSize: 4 requiringLaps: 1 usedBy: players playingWith: deck applying: effects  ]
		raise: Error
		withMessage: 'A board must contain at least 5 square boards to satisfy the effects distribution.'.
]

{ #category : #tests }
RandomBoardGeneartorTest >> test02ABoardMustHavePlayersWithDifferentNamesToBeGenerated [

	|  effects cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self 
		should: [ RandomBoardGenerator ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects ]
		raise: Error
		withMessage: 'A board cannot be generated having players with repeated names.'
]

{ #category : #tests }
RandomBoardGeneartorTest >> test03ABoardMustHaveAtLeastOnePlayerToBeGenerated [

	| effects cards |
	
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self
		should: [ RandomBoardGenerator ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects ]
		raise: Error
		withMessage: 'A board  must have at least 1 player in order to be generated.'
]

{ #category : #tests }
RandomBoardGeneartorTest >> test04ABoarOfSizeTwentyAnd1LapHasTwentySquares [
	
	| aBoard effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: (aBoard size) equals: 20.
]

{ #category : #tests }
RandomBoardGeneartorTest >> test05ABoardRequiresAtLeast1LapToBeGenerated [

	| effects cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self
		should: [ RandomBoardGenerator ofSize: 20 requiringLaps: 0 usedBy: players playingWith: deck applying: effects.]
		raise: Error
		withMessage: 'A board requires at least one lap to be generated.'.
]

{ #category : #tests }
RandomBoardGeneartorTest >> test06ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayers [
	
	| aBoard  effects aRandomBoardGenerator cards |

	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfPlayers) equals: 3.
]

{ #category : #tests }
RandomBoardGeneartorTest >> test07ABoardOfSizeTwentyAndThreeLapsIsPlayedByThreePlayersAndADeterminsticDiceCup [
	
	| aBoard  effects aRandomBoardGenerator cards |

	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 3 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfPlayers) equals: 3.
	self assert: (aBoard amountOfLaps) equals: 3.
]

{ #category : #tests }
RandomBoardGeneartorTest >> test08ABoardOfSizeTwentyAndThreeLapHasTwentySquaresAnd3Laps [
	
	| aBoard effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.48). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 3 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: (aBoard size) equals: 20.
	self assert: (aBoard amountOfLaps) equals: 3.
]

{ #category : #tests }
RandomBoardGeneartorTest >> test09GenerateABoardOfSizeTwentyWithAGivenProbabilityDistribution [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 0.48 . WormHoleEffect -> 0.20 . SpeedUpEffect -> 0.20 . MoonWalkEffect -> 0.10 . AtomicBombEffect  -> 0.02 }.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up' -> 4 . 'Worm Hole' -> 4 . 'Moon Walk' -> 2 . 'Atomic Bomb' -> 1 . 'No Effect' -> 9 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

	 
]

{ #category : #tests }
RandomBoardGeneartorTest >> test10ABoardWithNoEffectsIsGenerated [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up'-> 0 . 'Worm Hole'-> 0 . 'Moon Walk'-> 0 . 'Atomic Bomb'-> 0 . 'No Effect'-> 20 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

]

{ #category : #tests }
RandomBoardGeneartorTest >> test11ABoardWithSpeedUpEffectsIsGenerated [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { SpeedUpEffect -> 1 }.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up'-> 20 . 'Worm Hole'-> 0 . 'Moon Walk'-> 0 . 'Atomic Bomb'-> 0 . 'No Effect'-> 0 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

]

{ #category : #tests }
RandomBoardGeneartorTest >> test12ABoardWithWormHoleEffectsIsGenerated [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { WormHoleEffect -> 1 }.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up'-> 0 . 'Worm Hole'-> 20 . 'Moon Walk'-> 0 . 'Atomic Bomb'-> 0 . 'No Effect'-> 0 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

]

{ #category : #tests }
RandomBoardGeneartorTest >> test13ABoardWithAtomicBombEffectsIsGenerated [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { AtomicBombEffect -> 1 }.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up'-> 0 . 'Worm Hole'-> 0 . 'Moon Walk'-> 0 . 'Atomic Bomb'-> 20 . 'No Effect'-> 0 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

]

{ #category : #tests }
RandomBoardGeneartorTest >> test14ABoardWithMoonWalkEffectsIsGenerated [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { MoonWalkEffect -> 1 }.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 20.
	boardDistribution := Dictionary newFrom: { 'Speed Up'-> 0 . 'Worm Hole'-> 0 . 'Moon Walk'-> 20 . 'Atomic Bomb'-> 0 . 'No Effect'-> 0 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

]

{ #category : #tests }
RandomBoardGeneartorTest >> test15ABoardIsGeneratedWithSizeFive [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 0.48 . WormHoleEffect -> 0.20 . SpeedUpEffect -> 0.20 . MoonWalkEffect -> 0.10 . AtomicBombEffect  -> 0.02 }.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 5 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 5.
	boardDistribution := Dictionary newFrom: { 'Speed Up' -> 1 . 'Worm Hole' -> 1 . 'Moon Walk' -> 1 . 'Atomic Bomb' -> 1 . 'No Effect' -> 1 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

	 
]

{ #category : #tests }
RandomBoardGeneartorTest >> test16ABoardIsGeneratedWithSizeHundred [

	| aBoard effects boardDistribution aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 0.48 . WormHoleEffect -> 0.20 . SpeedUpEffect -> 0.20 . MoonWalkEffect -> 0.10 . AtomicBombEffect  -> 0.02 }.
	aRandomBoardGenerator := RandomBoardGenerator ofSize: 100 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	self assert: aBoard size equals: 100.
	boardDistribution := Dictionary newFrom: { 'Speed Up' -> 20 . 'Worm Hole' -> 20 . 'Moon Walk' -> 10 . 'Atomic Bomb' -> 2 . 'No Effect' -> 48 }.
	self assert: (self calculateDistributionOf: aBoard) equals: boardDistribution.

	 
]

{ #category : #tests }
RandomBoardGeneartorTest >> test17ABoardMustBeGeneratedWithTheSumOfEffectsProbabilityLessThanOneCannotBeGenerated [

	|  effects cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.3). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self 
		should: [ RandomBoardGenerator ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects ]
		raise: Error
		withMessage: 'A board cannot be generated with a sum of probabilities not equal to 1.'
]

{ #category : #tests }
RandomBoardGeneartorTest >> test18ABoardMustBeGeneratedWithTheSumOfEffectsProbabilityMoreThanOneCannotBeGenerated [

	|  effects cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: {(NoEffect -> 0.5). (WormHoleEffect -> 0.20). (SpeedUpEffect -> 0.20). (MoonWalkEffect -> 0.10). (AtomicBombEffect -> 0.02)}.
	self 
		should: [ RandomBoardGenerator ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects ]
		raise: Error
		withMessage: 'A board cannot be generated with a sum of probabilities not equal to 1.'
]
