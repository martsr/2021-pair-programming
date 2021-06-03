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

{ #category : #'as yet unclassified' }
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
	
	| aBoard aGame playerPositions effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 40 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test02APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceAndLandsOnSquare11 [
	
	| aBoard aGame playerPositions  effects aRandomBoardGenerator cards | 
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test03APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceFourTimesExceedsTheBoardSizeAndItWon [
	
	| aBoard aGame playerPositions playerLaps effects aRandomBoardGenerator cards |
	

	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 40 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 5}.
	self assert: (aGame playerPositions) equals: playerPositions.
	playerLaps:= Dictionary newFrom: {'Fran' -> 1}.
	self assert: (aGame playerLaps) equals: playerLaps. 
	self
		should: [ aGame nextTurn ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'.
]

{ #category : #tests }
GameTest >> test04APlayerThrowsTheDeterministicDiceCupWWithTwoDiceWithTheSameSequenceFourTimesWinningTheGameAndNowTheGameCanInformThatPlayerIsTheWinner [
	
	| aBoard aGame playerPositions  effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 40 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	playerPositions := Dictionary newFrom: {('Fran' -> 5)}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame winner equals: (players at: 1).
]

{ #category : #tests }
GameTest >> test05APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceOneTimeButTheGameCannotDetermineTheWinnerBecauseTheGameIsInProgress [
	
	| aBoard aGame playerPositions  effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 40 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
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
	
	| aBoard aGame playerPositions effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 40 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 5}.
	self assert: (aGame playerPositions) equals: playerPositions. 
	self assert: aGame winner equals: (players at: 1).
]

{ #category : #tests }
GameTest >> test07ThreePlayersThrowTheDiceCupOfTheGameAndAllLandOnSquareSeven [

	| aBoard aGame playerPositions effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(5 8 6 3) #(5 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 40 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11 . 'Martu' -> 17 . 'Maia' -> 13}.
	self assert: (aGame playerPositions ) equals: playerPositions .
]

{ #category : #tests }
GameTest >> test08ThreePlayersPlayTheGameAndPlayerOneWins [

	| aBoard aGame  effects aRandomBoardGenerator cards |
	 
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 4 in: aGame.
	self assert: (aGame winner) equals: (players at: 1). 

]

{ #category : #tests }
GameTest >> test09AGameIsPlayedByThreePlayersAndTheThirdPlayerFinishesOnTheLastSquareAndTheRemainingOnesFourSquaresBehind [

	|  aBoard aGame playerPositions effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 4 5 ) #(4 4 5)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 6 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 17 . 'Mango' -> 17 . 'Maia' -> 1}.
	self assert: aGame winner equals: (players at: 3).
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test10AGameIsPlayedAndTheDiceCupCannotBeThrownAfterTheGameHasFinished [
	
	| aBoard aGame effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 4 5) #(4 4 5)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 6 in: aGame.
	self
		should: [ aGame nextTurn  ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'. 
]

{ #category : #tests }
GameTest >> test11AGameIsInProgressAndTheWinnerCannotBeDeterminedBecauseTheGameIsStillInProgress [
	
	| aBoard aGame effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 4 4) #(4 4 4)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test12APlayerPlaysTheGameAndCompletesTwoLapsOfTheThreeLapsRequiredToWin [
	
	| aBoard aGame playerPositions playerLaps effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(10 11 6 3) #(10 11 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 3 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 2 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 3}.
	playerLaps := Dictionary newFrom: {'Fran' -> 2}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test13APlayerPlaysTheGameAndCompletesTheAmountOfLapsRequiredMakingHimTheWinnerAndIsPositionedOnTheFirstSquare [
	
	| aBoard aGame playerPositions playerLaps effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(10 8 6 3) #(10 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test14PlayersPlayTheGameOneWinsAndTheRestFinishWithDifferentLapsDone [
	
	| aBoard aGame playerPositions playerLaps effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 20) #(3 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Martu'->3 . 'Mango'->1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0 . 'Martu' -> 1 . 'Mango' -> 2}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test15AGameIsPlayedByASinglePlayerWhoWinsAndFinishesOnFirstPlaceInTheRanking [
	
	| aBoard aGame playerPositions nameRanking effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(10 8 6 3) #(10 8 6 3)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	nameRanking := OrderedCollection newFrom: {'Fran'}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking. 
]

{ #category : #tests }
GameTest >> test16AGameIsPlayedByThreePlayersAndWhenTheGameFinishesTheFinalRankingIsCalculated [
	
	| aBoard aGame playerPositions nameRanking effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 20) #(3 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Martu'->3 . 'Mango'->1}.
	nameRanking := OrderedCollection newFrom: {'Mango' . 'Martu' . 'Fran'}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking.
]

{ #category : #tests }
GameTest >> test17APlayerLandsOnASquareWithNoEffectAndItsPositionDoesntChange [
	
	| effects aBoard aGame playerPositions aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 }.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test18PlayerLandsOnASquareWithSpeedUpEffectAndItsPositionIncreasesByFour [
	
	| effects aBoard aGame playerPositions aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { SpeedUpEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test19APlayerLandsOnASquareWithAtomicBombffectAndAllPlayersAreMovedToTheFirstSquareWithoutModifyingTheirLaps [

	| effects aBoard aGame playerPositions playerLaps aRandomBoardGenerator cards |
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(12) #(12)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { AtomicBombEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test20APlayerLandsOnASquareWithAtomicBombffectAndItsPositionTheFirstSquare [
	
	| effects aBoard aGame playerPositions playerLaps aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 21) #(3 11 21 )).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { AtomicBombEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 3 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
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
	
	| aBoard aGame playerPositions effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 11 20) #(3 11 11 20)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { WormHoleEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 1 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->3}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test22MoreThanOnePlayerLandsOnASquareWithSpeedUpEffectAndTheirPositionsAreIncreasedByFour [
	
	| effects aBoard aGame playerPositions playerLaps aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(3 11 15) #(3 11 15)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { SpeedUpEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11 . 'Martu'->7 . 'Maia'->15}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' ->0 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test23MoreThanOnePlayerLandsOnASquareWithSpeedUpEffectTheirPositionsAreIncreasedByFourAndOneOfThemWonBecauseItFinishedTheAmoutOflapsRequired [
	
	| effects aBoard aGame playerPositions playerLaps nameRanking aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(3 7 9) #(3 7 9)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { SpeedUpEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
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
	
	| effects aBoard aGame playerPositions playerLaps aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(1 11 15) #(1 11 15)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { WormHoleEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 2 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self throwDiceCupTimes: 3 in: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->19 . 'Maia'->7}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' -> 0 . 'Martu'->0 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test25MoreThanOnePlayerLandsOnASquareWithMoonWalkEffectAndAllPlayersReturnARandomNumberOfspacesBetweenOneandHalfTheBoardSize [
	
	| aBoard aGame playerPositions effects aRandomBoardGenerator cards |
	
	self generatePlayerNames: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWithSequences: #(#(4 3 1) #(4 3 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { MoonWalkEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 10 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
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

	| aBoard effects aRandomBoardGenerator cards aGame |
	
	self generatePlayerNames: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWithSequences: #(#(5 1 1) #(5 1 1)).
	cards := OrderedCollection newFrom: { OverloadCard new . SpeedCard new . AccelerationCard new . CancellationCard new . RedoCard new . RepeatCard new }.
	self generateDeckWith: cards.
	effects := Dictionary newFrom: { DrawCardEffect -> 1 }.
	aRandomBoardGenerator := EffectShuffler ofSize: 20 requiringLaps: 1 usedBy: players playingWith: deck applying: effects.
	aBoard := aRandomBoardGenerator createNew.
	aGame := GameMandM playedOn: aBoard using: diceCup.
	self assert: (aGame handOf: 'Fran') equals: (OrderedCollection newFrom: { cards at: 1 . cards at: 2 }).
	self throwDiceCupTimes: 3 in: aGame.
	self assert: (aGame handOf: 'Fran') equals: (OrderedCollection newFrom: { cards at: 1 . cards at: 2 . cards at: 3 }).
	
]

{ #category : #iteration }
GameTest >> throwDiceCupTimes: anInteger in: aGame [
	anInteger timesRepeat: [ aGame nextTurn ].
]
