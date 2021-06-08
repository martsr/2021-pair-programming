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
		'deck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #generators }
GameTest >> generateDeckWith: gameCards [

	deck := Deck having: gameCards.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 5}.
	self assert: (aGame playerPositions) equals: playerPositions.
	playerLaps:= Dictionary newFrom: {'Fran' -> 1}.
	self assert: (aGame playerLaps) equals: playerLaps. 
	self should: [ aGame nextTurn ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'.
]

{ #category : #tests }
GameTest >> test04APlayerThrowsTheDeterministicDiceCupWWithTwoDiceWithTheSameSequenceFourTimesWinningTheGameAndNowTheGameCanInformThatPlayerIsTheWinner [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 40 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	self assert: (aGame winner) equals: (players at: 1). 

]

{ #category : #tests }
GameTest >> test09AGameIsPlayedByThreePlayersAndTheThirdPlayerFinishesOnTheLastSquareAndTheRemainingOnesFourSquaresBehind [

	|  aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 4 5 ) #(4 4 5)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 6 in: aGame.
	self
		should: [ aGame nextTurn  ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'. 
]

{ #category : #tests }
GameTest >> test11AGameIsInProgressAndTheWinnerCannotBeDeterminedBecauseTheGameIsStillInProgress [
	
	| aBoard aGame cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 4 4) #(4 4 4)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 3 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 }.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test18PlayerLandsOnASquareWithSpeedUpEffectAndItsPositionIncreasesByFour [
	
	|aBoard aGame playerPositions cards effectsDistribution effectShuffler squares |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect  new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: AtomicBombEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: AtomicBombEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 3 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: WormHoleEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: SpeedUpEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: WormHoleEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 2 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (MoonWalkEffect goingBack: 3) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
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
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: DrawCardEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self assert: (aGame handOf: 'Fran') equals: (OrderedCollection newFrom: { cards at: 1 . cards at: 2 }).
	self throwDiceCupTimes: 3 in: aGame.
	self assert: (aGame handOf: 'Fran') equals: (OrderedCollection newFrom: { cards at: 1 . cards at: 2 . cards at: 3 }).
	
]

{ #category : #tests }
GameTest >> test27APermanentCardIsPlayedAndItIsRemovedFromTheInvokingPlayerHandToActiveCards [

	| aBoard cards aGame effectsDistribution effectShuffler squares aCard target |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aCard := cards at: 2.
	target := OrderedCollection newFrom: { 'Maia' }.
	aGame play: aCard by: 'Fran' directedTo: target.
	self assert: (aGame handOf: 'Fran') equals: (OrderedCollection newFrom: { cards at: 1 } ).
	self assert: (aGame activeCards) equals: (OrderedCollection newFrom: { cards at: 2 } ).	
]

{ #category : #tests }
GameTest >> test28ACardCanOnlyBePlayedWhenItIsInTheHandOfThePlayer [

	| aBoard cards aGame effectsDistribution effectShuffler squares aCard target |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	aCard := cards at: 3.
	target := OrderedCollection newFrom: { 'Maia' }.
	self
		should: [ aGame play: aCard by: 'Fran' directedTo: target ]
		raise: Error
		withMessage: 'A card must be in the invoking player hand to be played'. 
]

{ #category : #tests }
GameTest >> test29APermanentCardCanOnlyPlayedInTheTurnOfTheInvokingPlayer [

	| aBoard cards aGame effectsDistribution effectShuffler squares aCard target |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame. 
	aCard := cards at: 3.
	target := OrderedCollection newFrom: { 'Fran' }.
	self
		should: [ aGame play: aCard by: 'Maia' directedTo: target ]
		raise: Error
		withMessage: 'A permanent card can only played in the turn of the invoking player'. 
]

{ #category : #tests }
GameTest >> test30APlayerTargetedByASpeedCardMovesOneAdditionalSquareAfterThrowingTheDiceCup [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aCard target |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	aCard := cards at: 1.
	target := OrderedCollection newFrom: { 'Martu' }.
	aGame play: aCard by: 'Fran' directedTo: target.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 5 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
	
	
	
]

{ #category : #tests }
GameTest >> test31APlayerTargetedByAnOverloadCardMovesBackAdditionalSquareAfterThrowingTheDiceCupMakingThePlayerNotToWin [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aCard target |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 5 1) #(4 5 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	aCard := cards at: 1.
	target := OrderedCollection newFrom: { 'Martu' }.
	aGame play: aCard by: 'Fran' directedTo: target.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 9 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
	
]

{ #category : #tests }
GameTest >> test32APlayerIsTargetedByMultipleEffects [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aCard target |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new  }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	aCard := cards at: 2.
	target := OrderedCollection newFrom: { 'Maia' }.
	aGame play: aCard by: 'Fran' directedTo: target.
	self throwDiceCupTimes: 1 in: aGame.
	aCard := cards at: 1.
	aGame play: aCard by: 'Martu' directedTo: target.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'-> 2}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test33PlayersTargetedByAccelerationCardMoveOneAdditionalSquareAfterThrowingTheDiceCup [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	aCard := cards at: 3.
	aGame play: aCard directedToAllBy: 'Martu'.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 8 . 'Maia'-> 4}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test34APlayerTargetedByASpeedCardMovesOneAdditionalSquareAfterThrowingTheDiceCup [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aCard |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	self throwDiceCupTimes: 1 in: aGame.
	aCard := cards at: 3.
	aGame play: aCard directedToAllBy: 'Martu'.
	self throwDiceCupTimes: 4 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 18 . 'Martu'-> 15 . 'Maia'-> 4}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test35APlayerTargetedByASpeedCardMovesOneAdditionalSquareAfterThrowingTheDiceCup [
	
	| aBoard aGame playerPositions cards effectsDistribution effectShuffler squares aCard target |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: (NoEffect new) with: 1}.
	effectShuffler := EffectShuffler ofSize: 10 withGiven: (effectsDistribution copy).
	squares := effectShuffler generate.
	aBoard := Board having: squares requiring: 1 containing: deck usedBy: players.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	aCard := cards at: 1.
	target := OrderedCollection newFrom: { 'Martu' }.
	aGame play: aCard by: 'Fran' directedTo: target.
	self throwDiceCupTimes: 1 in: aGame.
	aCard := cards at: 4.
	target := OrderedCollection newFrom: { cards at: 1 }.
	aGame play: aCard by: 'Martu' directedTo: target affecting: 'Martu'.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 9 . 'Martu'-> 7 . 'Maia'-> 1}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #iteration }
GameTest >> throwDiceCupTimes: anInteger in: aGame [
	anInteger timesRepeat: [ aGame nextTurn ].
]
