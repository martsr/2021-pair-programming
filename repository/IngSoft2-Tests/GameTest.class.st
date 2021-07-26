"
throwDiceCupTimes: anInteger inGame: aGame
anInteger timesRepeat: [ aGame nextPlayerThrows ].
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'diceCup',
		'deterministicDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #generators }
GameTest >> generateDeterministicDeckWith: gameCards [

	deterministicDeck := DeterministicDeck having: gameCards.
]

{ #category : #generators }
GameTest >> generateDeterministicDiceCupWithSequences: sequences [

	| dice |
	
	dice := OrderedCollection new.
	dice := sequences  collect: [ :sequence | DeterministicDie having: sequence ].
	diceCup := DiceCup containing: dice.
	
]

{ #category : #generators }
GameTest >> generatePlayerNames: playerNames [

	players := OrderedCollection new.
	players := playerNames.
]

{ #category : #running }
GameTest >> setUp [

	super setUp. 
	players := OrderedCollection new.
]

{ #category : #asserting }
GameTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
GameTest >> test01AtTheStartOfTheGameAllPlayersArePlacedOnTheFirstBoardSquare [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test02APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceAndLandsOnSquare11 [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares | 
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test03APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceFourTimesExceedsTheBoardSizeAndItWon [
	
	| aBoard aGame playerPositions playerLaps cards  effectShuffler squares effectsDistribution |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 5}.
	self assert: (aGame playerPositions) equals: playerPositions.
	playerLaps:= Dictionary newFrom: {'Fran' -> 1}.
	self assert: (aGame playerLaps) equals: playerLaps. 
	self should: [ aGame nextTurn ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore nor cards can be played'.
]

{ #category : #tests }
GameTest >> test04APlayerThrowsTheDeterministicDiceCupWWithTwoDiceWithTheSameSequenceFourTimesWinningTheGameAndNowTheGameCanInformThatPlayerIsTheWinner [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	playerPositions := Dictionary newFrom: {('Fran' -> 5)}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame winner equals: (players at: 1).
]

{ #category : #tests }
GameTest >> test05APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceOneTimeButTheGameCannotDetermineTheWinnerBecauseTheGameIsInProgress [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11}.
	self assert: (aGame playerPositions) equals: playerPositions.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test06APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceFourTimesWinningTheGameAndNowTheGameCanInformThePlayerFinalPosition [
	
	| aBoard aGame playerPositions  cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 5}.
	self assert: (aGame playerPositions) equals: playerPositions. 
	self assert: aGame winner equals: (players at: 1).
]

{ #category : #tests }
GameTest >> test07ThreePlayersThrowTheDiceCupOfTheGameAndAllLandOnSquareSeven [

	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11 . 'Martu' -> 17 . 'Maia' -> 13}.
	self assert: (aGame playerPositions ) equals: playerPositions .
]

{ #category : #tests }
GameTest >> test08ThreePlayersPlayTheGameAndPlayerOneWins [

	| aBoard aGame cards effectsDistribution effectShuffler squares |
	 
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	self assert: (aGame winner) equals: (players at: 1). 

]

{ #category : #tests }
GameTest >> test09AGameIsPlayedByThreePlayersAndTheThirdPlayerFinishesOnTheLastSquareAndTheRemainingOnesFourSquaresBehind [

	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 4 5 ) #(4 4 5)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 6 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 17 . 'Mango' -> 17 . 'Maia' -> 1}.
	self assert: aGame winner equals: (players at: 3).
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test10AGameIsPlayedAndTheDiceCupCannotBeThrownAfterTheGameHasFinished [
	
	| aBoard aGame cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 4 5) #(4 4 5)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 6 in: aGame.
	self
		should: [ aGame nextTurn  ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore nor cards can be played'. 
]

{ #category : #tests }
GameTest >> test11AGameIsInProgressAndTheWinnerCannotBeDeterminedBecauseTheGameIsStillInProgress [
	
	| aBoard aGame cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 4 4) #(4 4 4)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test12APlayerPlaysTheGameAndCompletesTwoLapsOfTheThreeLapsRequiredToWin [
	
	| aBoard aGame playerPositions playerLaps cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(10 11 6 3) #(10 11 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 3 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 3}.
	playerLaps := Dictionary newFrom: {'Fran' -> 2}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test13APlayerPlaysTheGameAndCompletesTheAmountOfLapsRequiredMakingHimTheWinnerAndIsPositionedOnTheFirstSquare [
	
	| aBoard aGame playerPositions playerLaps cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(10 8 6 3) #(10 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test14PlayersPlayTheGameOneWinsAndTheRestFinishWithDifferentLapsDone [
	
	| aBoard aGame playerPositions playerLaps cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 20) #(3 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Martu'->3 . 'Mango'->1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0 . 'Martu' -> 1 . 'Mango' -> 2}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test15AGameIsPlayedByASinglePlayerWhoWinsAndFinishesOnFirstPlaceInTheRanking [
	
	| aBoard aGame playerPositions nameRanking cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(10 8 6 3) #(10 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	nameRanking := OrderedCollection newFrom: {'Fran'}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking. 
]

{ #category : #tests }
GameTest >> test16AGameIsPlayedByThreePlayersAndWhenTheGameFinishesTheFinalRankingIsCalculated [
	
	| aBoard aGame playerPositions nameRanking  cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 20) #(3 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Martu'->3 . 'Mango'->1}.
	nameRanking := OrderedCollection newFrom: {'Mango' . 'Martu' . 'Fran'}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking.
]

{ #category : #tests }
GameTest >> test17APlayerLandsOnASquareWithNoEffectAndItsPositionDoesntChange [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 }.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test18PlayerLandsOnASquareWithSpeedUpEffectAndItsPositionIncreasesByFour [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect  new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test19APlayerLandsOnASquareWithAtomicBombffectAndAllPlayersAreMovedToTheFirstSquareWithoutModifyingTheirLaps [

	| aBoard aGame playerPositions playerLaps cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(12) #(12)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: AtomicBombEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test20APlayerLandsOnASquareWithAtomicBombffectAndItsPositionTheFirstSquare [
	
	| aBoard aGame playerPositions playerLaps cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 21) #(3 11 21 )).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: AtomicBombEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 3 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1.'Martu' -> 1.'Mango' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0.'Martu' -> 0.'Mango' -> 0}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1.'Martu' -> 1.'Mango' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0.'Martu' -> 1.'Mango' -> 0}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1.'Martu' -> 1.'Mango' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0.'Martu' -> 1.'Mango' -> 2}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test21APlayerLandsOnASquareWithWormHoleEffectAndItsPositionDecreasesByFour [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: WormHoleEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->3}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test22MoreThanOnePlayerLandsOnASquareWithSpeedUpEffectAndTheirPositionsAreIncreasedByFour [
	
	|aBoard aGame playerPositions playerLaps  cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 15) #(3 11 15)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11 . 'Martu'->7 . 'Maia'->15}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' ->0 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test23MoreThanOnePlayerLandsOnASquareWithSpeedUpEffectTheirPositionsAreIncreasedByFourAndOneOfThemWonBecauseItFinishedTheAmoutOflapsRequired [
	
	|aBoard aGame playerPositions playerLaps nameRanking  cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(3 7 9) #(3 7 9)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11 . 'Martu'->19 . 'Maia'->3}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' ->0 . 'Martu'->0 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
	nameRanking := OrderedCollection newFrom: {'Maia' . 'Martu' . 'Fran'}.
	self assert: aGame playerRanking equals: nameRanking.
	self assert: aGame winner equals: (players at: 3).
]

{ #category : #tests }
GameTest >> test24MoreThanOnePlayerLandsOnASquareWithWormHoleEffectAndTheirPositionsAreDecreasedByFour [
	
	| aBoard aGame playerPositions playerLaps  cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(1 11 15) #(1 11 15)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: WormHoleEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->19 . 'Maia'->7}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' -> 0 . 'Martu'->0 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test25MoreThanOnePlayerLandsOnASquareWithMoonWalkEffectAndAllPlayersReturnARandomNumberOfspacesBetweenOneandHalfTheBoardSize [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (MoonWalkEffect goingBack: 3) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->9 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	playerPositions := aGame playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := aGame playerPositions.
	self assert: ((playerPositions at: (players at: 1)) between: 1 and: 8). 
	self assert: (playerPositions  at: (players at: 2)) equals: 7.
	self assert: (playerPositions  at: (players at: 3)) equals: 1.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := aGame playerPositions.
	self assert: ((playerPositions  at: (players at: 1)) between: 1 and: 7). 
	self assert: ((playerPositions  at: (players at: 2)) between: 1 and: 6).
	self assert: (playerPositions  at: (players at: 3)) equals: 3.
	
]

{ #category : #tests }
GameTest >> test26ABoardWithOnlyDrawEffectsMakesAPlayerDrawACard [

	| aBoard cards aGame effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: DrawCardEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self assert: (aGame handOf: 'Fran') equals: (OrderedCollection newFrom: { cards at: 1 . cards at: 2 }).
	self throwDiceCupTimes: 1 in: aGame.
	self assert: (aGame handOf: 'Fran') equals: (OrderedCollection newFrom: { cards at: 1 . cards at: 2 . cards at: 3 }).
	
]

{ #category : #tests }
GameTest >> test27ASpeedCardCardIsPlayedAndItIsRemovedFromTheInvokingPlayerHandToActiveCardsAndAppliesItsEffect [

	| aBoard cards aGame effectsDistribution effectShuffler squares aPlay playerPositions aSpeedCard |
	
	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aSpeedCard := cards at: 2.
	aPlay := aSpeedCard asPlayAffecting: 'Fran' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame. 
	self assert: (aGame handOf: 'Fran') equals: (OrderedCollection newFrom: { cards at: 1 } ).
	self assert: (aGame activeCards) equals: (OrderedCollection newFrom: { cards at: 2 } ).
	playerPositions := Dictionary newFrom: {'Fran' -> 12 . 'Martu'-> 1 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test28ACardCanOnlyBePlayedWhenItIsInTheHandOfThePlayer [

	| aBoard cards aGame effectsDistribution effectShuffler squares aPlay anAccelerationCard |
	
	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	anAccelerationCard := cards at: 3.
	aPlay := anAccelerationCard asPlayAffecting: aGame by: (aGame currentPlayerThrowing).
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'A card must be in the invoking player hand to be played'. 
]

{ #category : #tests }
GameTest >> test29ACardCanOnlyBeThrownByAPlayerOfTheGame [

	| aBoard cards aGame effectsDistribution effectShuffler squares aPlay aSpeedCard |
	
	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aSpeedCard := cards at: 2.
	aPlay := aSpeedCard asPlayAffecting: 'Fran' by: 'Mirtha'.
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'The invoking player must be a participant of the game'. 
]

{ #category : #tests }
GameTest >> test30APermanentCardCanOnlyPlayedInTheTurnOfTheInvokingPlayer [

	| aBoard cards aGame effectsDistribution effectShuffler squares aPlay  anAccelerationCard |
	
	self generatePlayerNames: #('Fran' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame. 
	anAccelerationCard:= cards at: 3.
	aPlay := anAccelerationCard asPlayAffecting: aGame by: 'Martu'.
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'A permanent card can only played in the turn of the invoking player'. 
]

{ #category : #tests }
GameTest >> test31APlayerTargetedByASpeedCardMovesOneAdditionalSquareAfterThrowingTheDiceCup [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aSpeedCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	aSpeedCard := cards at: 2.
	aPlay := aSpeedCard asPlayAffecting: 'Fran' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 10 . 'Martu'-> 7 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
	
	
	
]

{ #category : #tests }
GameTest >> test32APlayerIsTargetedByMultipleEffects [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aSpeedCard anOverloadCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new  }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	aSpeedCard := cards at: 2.
	aPlay := aSpeedCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	anOverloadCard := cards at: 1.
	aPlay := anOverloadCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'-> 2}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test33APlayerTargetedByAnOverloadCardMovesBackAdditionalSquareAfterThrowingTheDiceCupMakingThePlayerNotToWin [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares  aPlay anOverloadCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 5 1) #(4 5 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	anOverloadCard := cards at: 1.
	aPlay := anOverloadCard asPlayAffecting: 'Martu' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 9 . 'Maia'-> 3}.
	self assert: aGame playerPositions equals: playerPositions.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
	
]

{ #category : #tests }
GameTest >> test34APlayerIsTargetedByAnOverloadCardButPlaysTheCancellationCardOnIt [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay targetedPlay anOverloadCard aCancellationCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	anOverloadCard := cards at: 1.
	aPlay := anOverloadCard asPlayAffecting: 'Martu' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self assert: (aGame activeCards) equals: (OrderedCollection newFrom: { cards at: 1 } ).
	self throwDiceCupTimes: 1 in: aGame.
	targetedPlay := Play madeBy: (cards at: 1) directedTo: (OrderedCollection newFrom: { 'Martu' }) calledBy: 'Fran'.
	aCancellationCard := cards at: 4.
	aPlay := aCancellationCard asPlayAffecting: targetedPlay by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self assert: (aGame activeCards) equals: (OrderedCollection new ).
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test35PlayersTargetedByAccelerationCardMoveOneAdditionalSquareAfterThrowingTheDiceCup [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares  aPlay anAccelerationCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	anAccelerationCard := cards at: 3.
	aPlay := anAccelerationCard asPlayAffecting: aGame by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 8 . 'Maia'-> 4}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 18 . 'Martu'-> 8 . 'Maia'-> 4}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test36ACancellationCardCanNotBePlayedIfTheTargetedCardIsNotActive [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay targetedPlay anOverloadCard aCancellationCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	anOverloadCard := cards at: 1.
	aPlay := anOverloadCard asPlayAffecting: 'Martu' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	targetedPlay := Play madeBy: (cards at: 2) directedTo: (OrderedCollection newFrom: { 'Martu' }) calledBy: 'Fran'.
	aCancellationCard := cards at: 4.
	aPlay := aCancellationCard asPlayAffecting: targetedPlay by: (aGame currentPlayerThrowing).
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'The targeted card by the cancellation card is not active'. 
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 5 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test37ACancellationCardCanOnlyBePlayedWhenThereAreActiveCards [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay targetedPlay aCancellationCard aSpeedCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	aSpeedCard:= cards at: 2. 
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	targetedPlay := Play madeBy: aSpeedCard directedTo: (OrderedCollection newFrom: {'Maia'}) calledBy: 'Maia'.
	aCancellationCard := cards at: 4.
	aPlay := aCancellationCard asPlayAffecting: targetedPlay by: (aGame currentPlayerThrowing).
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'Cancellation cannot be applied when there are no active permanent cards'. 
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test38APlayerThrowsAnAccelerationCardAndTheNextPlayerThrowsTheCancellationCardImmediatelyAfter [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay targetedPlay anAccelerationCard aCancellationCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . CancellationCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	anAccelerationCard := cards at: 3.
	aPlay := anAccelerationCard asPlayAffecting: aGame by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	targetedPlay := Play madeBy: anAccelerationCard directedTo: (aGame players) calledBy: 'Martu'.
	aCancellationCard := cards at: 5.
	aPlay := aCancellationCard asPlayAffecting: targetedPlay by: 'Maia'.
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test39PlayerThrowsAnAccelerationCardAndThePreviousPlayerThrowsTheCancellationCardBeforeItCanBeApplied [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay targetedPlay anAccelerationCard aCancellationCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . CancellationCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	anAccelerationCard := cards at: 3.
	aPlay := anAccelerationCard asPlayAffecting: aGame by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	targetedPlay := Play madeBy: (cards at: 3) directedTo: (aGame players) calledBy: 'Martu'.
	aCancellationCard := cards at: 2.
	aPlay := aCancellationCard asPlayAffecting: targetedPlay by: 'Fran'.
	aGame make: aPlay.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'-> 3}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test40APlayersThrowsARepeatCardAndTheSpeedUpEffectWasApplied [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aRepeatCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 2 in: aGame.
	aRepeatCard := cards at: 6.
	aPlay := aRepeatCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	playerPositions := Dictionary newFrom: {'Fran' -> 13 . 'Martu'->11 . 'Maia'->5}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 13 . 'Martu'->11 . 'Maia'->11}.
	self assert: aGame playerPositions equals: playerPositions.
	
]

{ #category : #tests }
GameTest >> test41ARepeatCardIsPlayedButSinceTheLastEffectAppliedWasNoEffectThenNoEffectIsApplied [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aRepeatCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 2 in: aGame.
	aRepeatCard := cards at: 6.
	aPlay := aRepeatCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'->3}.
	self assert: aGame playerPositions equals: playerPositions.
	
]

{ #category : #tests }
GameTest >> test42ARepeatCardIsPlayedInAnotherPlayersTurnButSinceNoOneThrewTheDiceCupNoEffectIsApplied [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aRepeatCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aRepeatCard := cards at: 6.
	aPlay := aRepeatCard asPlayAffecting: 'Maia' by: 'Maia'.
	aGame make: aPlay.
	playerPositions := Dictionary newFrom: {'Fran' -> 1 . 'Martu'-> 1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test43ARepeatCardIsAppliedAndSinceTheLastEffectWasSpeedUpItMovesFourSquaresThenRollsTheDiceAndWinsTheGame [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aRepeatCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 6) #(4 3 6)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 2 in: aGame.
	aRepeatCard := cards at: 6.
	aPlay := aRepeatCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	playerPositions := Dictionary newFrom: {'Fran' -> 13 . 'Martu'->11 . 'Maia'->5}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 13 . 'Martu'->11 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame winner equals: 'Maia'.
]

{ #category : #tests }
GameTest >> test44CardsCanNoLongerBePlayedOnceTheGameHasFinished [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aRepeatCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 6) #(4 3 6)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RepeatCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 2 in: aGame.
	aRepeatCard := cards at: 6.
	aPlay := aRepeatCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	playerPositions := Dictionary newFrom: {'Fran' -> 13 . 'Martu'->11 . 'Maia'->5}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 13 . 'Martu'->11 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame winner equals: 'Maia'.
	aRepeatCard := cards at: 5.
	aPlay := aRepeatCard asPlayAffecting: (OrderedCollection newFrom: { 'Maia' }) by: 'Maia'.
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore nor cards can be played'. 
]

{ #category : #tests }
GameTest >> test45ARedoCardIsAppliedAndSinceTheLastPlayedCardWasASpeedCardTheNewTargetedPlayerMovesOneMoreSquare [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aSpeedCard aRedoCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 6) #(4 3 6)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aSpeedCard := cards at: 2.
	aPlay := aSpeedCard asPlayAffecting: 'Fran' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 10 . 'Martu'-> 7 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
	aRedoCard := cards at: 5.
	aPlay := aRedoCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 10 . 'Martu'-> 7 . 'Maia'-> 14}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test46ARedoCardIsAppliedAndSinceTheLastPlayedCardWasAnOverloadCardTheNewTargetedPlayerMovesBackTwoSquares [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay anOverloadCard aRedoCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 6) #(4 3 6)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . RedoCard new . CancellationCard new . AccelerationCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	anOverloadCard := cards at: 1.
	aPlay := anOverloadCard asPlayAffecting: 'Martu' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	aRedoCard := cards at: 3.
	aPlay := aRedoCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 5 . 'Maia'-> 11}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test47ARedoCardIsAppliedAndSinceTheLastPlayedCardWasAnAccelerationCardTheNewTargetedPlayerMovesOneMoreSquare [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay anAccelerationCard aRedoCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 6) #(4 3 6)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	anAccelerationCard := cards at: 3.
	aPlay := anAccelerationCard asPlayAffecting: aGame by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	aRedoCard := cards at: 5.
	aPlay := aRedoCard asPlayAffecting: aGame by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 8 . 'Maia'-> 15}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test48ARedoCardIsAppliedAndSinceTheLastPlayedCardWasARepeatCardAndTheLastEffectAppliedWasASpeedUpTheNewTargetedPlayerMovesFourMoreSquares [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aRepeatCard aRedoCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 6) #(4 3 6)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . RepeatCard new . RedoCard new . CancellationCard new}.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 30 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	aRepeatCard := cards at: 4.
	aPlay := aRepeatCard asPlayAffecting: 'Martu' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	aRedoCard := cards at: 5.
	aPlay := aRedoCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 13 . 'Martu'-> 15 . 'Maia'-> 21}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test49ARedoCardIsAppliedAndSinceTheLastPlayedCardWasACancellationCardAnotherPermanentCardIsRemovedFromTheGame [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares  aPlay targetedPlay aSpeedCard anAccelerationCard aCancellationCard aRedoCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 6) #(4 3 6)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new}.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 30 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aSpeedCard := cards at: 2.
	aPlay := aSpeedCard asPlayAffecting: 'Fran' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	anAccelerationCard := cards at: 3.
	aPlay := anAccelerationCard asPlayAffecting: aGame by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	targetedPlay := Play madeBy: aSpeedCard directedTo: (OrderedCollection newFrom: { 'Fran' }) calledBy: 'Fran'.
	aCancellationCard := cards at: 4.
	aPlay := aCancellationCard asPlayAffecting: targetedPlay by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	aRedoCard := cards at: 5.
	targetedPlay := Play madeBy: anAccelerationCard directedTo: (aGame players) calledBy: 'Martu'.
	aPlay := aRedoCard asPlayAffecting: targetedPlay by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 10 . 'Martu'-> 8 . 'Maia'-> 13}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test50ARedoCardCannotBeAppliedIfNoPreviousCardsWerePlayed [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aRedoCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 6) #(4 3 6)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . RedoCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 2 in: aGame.
	aRedoCard := cards at: 5.
	aPlay := aRedoCard asPlayAffecting: 'Maia' by: (aGame currentPlayerThrowing).
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'A Redo card can not be played if no previous cards were played'. 
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'-> 13}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test51ARedoCardIsAppliedAndSinceTheLastCardAppliedWasRedoCardOfASpeedCardThisCardIsAppliedToTheNewTargetedPlayerMakingItMoveOneMoreSquare [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay aSpeedCard aRedoCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 6) #(4 3 6)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . RedoCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aSpeedCard := cards at: 2.
	aPlay := aSpeedCard asPlayAffecting: 'Fran' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	aRedoCard := cards at: 4.
	aPlay := aRedoCard asPlayAffecting: 'Martu' by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	aRedoCard := cards at: 5.
	aPlay := aRedoCard asPlayAffecting: 'Maia' by:(aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 10 . 'Martu'-> 8 . 'Maia'-> 14}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test52AReverseCardIsInaPlayerHand [

	| cards effectsDistribution effectShuffler squares aBoard aGame |
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new . ReverseCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self assert: (aGame handOf: 'Martu') equals: (OrderedCollection newFrom: { cards at: 7 . cards at: 1 }).
	
	
]

{ #category : #tests }
GameTest >> test53APlayerLandsOnAMoonWalkEffectSquareBoardThatHasTheReverseCardAppliedMakingAllThePlayerButHimMoveThreeSquaresForward [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aReverseCard aPlay playerLaps |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { ReverseCard  new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (MoonWalkEffect goingBack: 3) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aReverseCard := cards at: 1. 
	aPlay := aReverseCard asPlayAffecting: 7 by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->9. 'Martu'->1 . 'Maia'->1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0. 'Martu'->0 . 'Maia'->0}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->2. 'Martu'->7 . 'Maia'->4}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1. 'Martu'->0 . 'Maia'->0}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
	
]

{ #category : #tests }
GameTest >> test54APlayerLandsOnASpeedUpEffectSquareBoardThatHasTheReverseCardAppliedMakingHimMoveFourSquaresBack [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aReverseCard aPlay playerLaps |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { ReverseCard  new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (SpeedUpEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aReverseCard := cards at: 1. 
	aPlay := aReverseCard asPlayAffecting: 7 by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->3. 'Martu'->1 . 'Maia'->1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1. 'Martu'->0 . 'Maia'->0}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->3. 'Martu'->3 . 'Maia'->1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1. 'Martu'->0 . 'Maia'->0}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
	
]

{ #category : #tests }
GameTest >> test55APlayerLandsOnaWormHoleEffectSquareBoardThatHasTheReverseCardAppliedMakingHimMoveFourSquaresForward [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aReverseCard aPlay playerLaps |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { ReverseCard  new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (WormHoleEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aReverseCard := cards at: 1. 
	aPlay := aReverseCard asPlayAffecting: 7 by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->5. 'Martu'->1 . 'Maia'->1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0. 'Martu'->0 . 'Maia'->0}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->5. 'Martu'->1 . 'Maia'->1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0. 'Martu'->1 . 'Maia'->0}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
	
]

{ #category : #tests }
GameTest >> test56ReverseCardIsPlayedButImmediatelyAfterAnotherPlayerCancellsIt [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay targetedPlay aCancellationCard aReverseCard playerLaps |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { ReverseCard  new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (SpeedUpEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	aReverseCard := cards at: 1.
	aPlay := aReverseCard asPlayAffecting: 7 by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self assert: (aGame activeReversePlays) equals: (OrderedCollection newFrom: { cards at: 1 } ).
	self throwDiceCupTimes: 1 in: aGame.
	targetedPlay := Play madeBy: (cards at: 1) directedTo: 7 calledBy: 'Fran'.
	aCancellationCard := cards at: 4.
	aPlay := aCancellationCard asPlayAffecting: targetedPlay by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self assert: (aGame activeReversePlays) equals: (OrderedCollection new ).
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 3 . 'Martu'-> 1 . 'Maia'-> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1. 'Martu'->1 . 'Maia'->0}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
	
]

{ #category : #tests }
GameTest >> test57AReverseCardTargetMustBeGreaterThanZeroAndLessOrEqualTheBoardSize [
	
	| aBoard aGame cards effectsDistribution effectShuffler squares aReverseCard aPlay  |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { ReverseCard  new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aReverseCard := cards at: 1. 
	aPlay := aReverseCard asPlayAffecting: 11 by: (aGame currentPlayerThrowing).
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'The square number value must be greater than zero and less or equal the board size.'. 
	


]

{ #category : #tests }
GameTest >> test58ACancellationCardCanOnlyBeAppliedToAnExistingReverseCard [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay targetedPlay aCancellationCard aReverseCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { ReverseCard  new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (SpeedUpEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	aReverseCard := cards at: 1.
	aPlay := aReverseCard asPlayAffecting: 7 by: (aGame currentPlayerThrowing).
	aGame make: aPlay.
	self assert: (aGame activeReversePlays) equals: (OrderedCollection newFrom: { cards at: 1 } ).
	self throwDiceCupTimes: 1 in: aGame.
	targetedPlay := Play madeBy: (cards at: 1) directedTo: 8 calledBy: 'Fran'.
	aCancellationCard := cards at: 4.
	aPlay := aCancellationCard asPlayAffecting: targetedPlay by: (aGame currentPlayerThrowing).
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'The targeted card by the cancellation card is not active'. 
]

{ #category : #tests }
GameTest >> test59ACancellationCardCanOnlyBeAppliedToActiveReveseCards [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aPlay targetedPlay aCancellationCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { ReverseCard  new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeterministicDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (SpeedUpEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 playingWith: deterministicDeck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	targetedPlay := Play madeBy: (cards at: 1) directedTo: 8 calledBy: 'Fran'.
	aCancellationCard := cards at: 4.
	aPlay := aCancellationCard asPlayAffecting: targetedPlay by: (aGame currentPlayerThrowing).
	self
		should: [ aGame make: aPlay ]
		raise: Error
		withMessage: 'Cancellation card cannot be applied when there are no active reverse cards.'. 
]

{ #category : #iteration }
GameTest >> throwDiceCupTimes: anInteger in: aGame [
	anInteger timesRepeat: [ aGame nextTurn ].
]
