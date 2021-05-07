"
throwDiceCupTimes: anInteger inGame: aGame
anInteger timesRepeat: [ aGame nextPlayerThrows ].
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'diceCup'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
GameTest >> generateDeterministicDiceCupWith: sequences [

	| dice |
	
	dice := OrderedCollection new.
	dice := sequences  collect: [ :sequence | DeterministicDie having: sequence ].
	diceCup := DiceCup containing: dice.
	
]

{ #category : #'as yet unclassified' }
GameTest >> generatePlayerCollectionWith: playerNames [

	players := OrderedCollection new.
	players := playerNames collect: [ :name | Player named: name ].
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
	
	| aBoard aGame playerPositions laps |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test02APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceAndLandsOnSquare11 [
	
	| aBoard aGame playerPositions laps |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test03APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceFourTimesExceedsTheBoardSizeAndItWon [
	
	| aBoard aGame playerPositions laps |
	
	laps := 1. 
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 5}.
	self assert: (aGame playerPositions) equals: playerPositions.
	self
		should: [ aGame nextPlayerThrows ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'.
]

{ #category : #tests }
GameTest >> test04AGameWithABoardAndADiceCupShouldHaveAtLeastOnePayer [
	
	| aBoard laps |
	
	laps := 1.
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 40.
	self
		should: [ GameMandM playedOn: aBoard by: players using: diceCup requiring: laps ]
		raise: Error
		withMessage: 'A game must have at least 1 player'.
]

{ #category : #tests }
GameTest >> test05APlayerThrowsTheDeterministicDiceCupWWithTwoDiceWithTheSameSequenceFourTimesWinningTheGameAndNowTheGameCanInformThatPlayerIsTheWinner [
	
	| aBoard aGame playerPositions laps |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {('Fran' -> 5)}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame winner equals: (players at: 1).
]

{ #category : #tests }
GameTest >> test06APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceOneTimeButTheGameCannotDetermineTheWinnerBecauseTheGameIsInProgress [
	
	| aBoard aGame playerPositions laps |
	
	laps := 1. 
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11}.
	self assert: (aGame playerPositions) equals: playerPositions.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test07APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceFourTimesWinningTheGameAndNowTheGameCanInformThePlayerFinalPosition [
	
	| aBoard aGame playerPositions laps |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 5}.
	self assert: (aBoard whereIsPlayer: (players at: 1)) equals: 5.
	self assert: (aGame playerPositions) equals: playerPositions. 
]

{ #category : #tests }
GameTest >> test08ThreePlayersThrowTheDiceCupOfTheGameAndAllLandOnSquareSeven [

	| aBoard aGame playerPositions laps |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11 . 'Martu' -> 17 . 'Maia' -> 13}.
	self assert: (aGame playerPositions ) equals: playerPositions .
]

{ #category : #tests }
GameTest >> test09ThreePlayersPlayTheGameAndPlayerOneWins [

	| aBoard aGame laps |
	
	laps := 1. 
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(5 1 1) #(5 1 1)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 4 inGame: aGame.
	self assert: (aGame winner) equals: (players at: 1). 

]

{ #category : #tests }
GameTest >> test10AGameIsPlayedByThreePlayersAndTheThirdPlayerFinishesOnTheLastSquareAndTheRemainingOnesFourSquaresBehind [

	|  aBoard aGame playerPositions laps |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWith: #(#(4 4 5 ) #(4 4 5)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 6 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 17 . 'Mango' -> 17 . 'Maia' -> 1}.
	self assert: aGame winner equals:(players at: 3).
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test11AGameIsPlayedAndTheDiceCupCannotBeThrownAfterTheGameHasFinished [
	
	| aBoard aGame laps |
	
	laps := 1. 
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWith: #(#(4 4 5) #(4 4 5)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 6 inGame: aGame.
	self
		should: [ aGame nextPlayerThrows  ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'. 
]

{ #category : #tests }
GameTest >> test12AGameIsInProgressAndTheWinnerCannotBeDeterminedBecauseTheGameIsStillInProgress [
	
	| aBoard aGame laps |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWith: #(#(4 4 4) #(4 4 4)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 3 inGame: aGame.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test13AGameCannotBeCreatedIfAnyPlayerHasARepeatedName [
	
	| aBoard laps |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia' 'Martu' 'Martu').
	self generateDeterministicDiceCupWith: #(#(5 1 1) #(5 1 1)).
	aBoard := Board containing: 20.
	self
		should: [ GameMandM playedOn: aBoard by: players using: diceCup requiring: laps ]
		raise: Error
		withMessage: 'A game cannot be created with any players having repeated names'. 
]

{ #category : #tests }
GameTest >> test14NewlyCreatedGameReturnTheAmountOfLapsItsRequired [

		| aBoard laps aGame |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia' 'Martu').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self assert: (aGame amountOfLaps) equals: 1. 
]

{ #category : #tests }
GameTest >> test15VerifyAGameRequiresAtLeastOneLapToBeCreated [
	
	| aBoard laps  |
	
	laps := 0. 
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	aBoard := Board containing: 20.
	self
		should: [ GameMandM playedOn: aBoard by: players using: diceCup requiring: laps ]
		raise: Error
		withMessage: 'A game requires at least one lap to be playable.'. 
]

{ #category : #tests }
GameTest >> test16APlayerPlaysTheGameAndCompletesTwoLapsOfTheThreeLapsRequiredToWin [
	
	| aBoard laps aGame playerPositions playerLaps |
	
	laps := 3. 
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(10 11 6 3) #(10 11 6 3)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 2 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 3}.
	playerLaps := Dictionary newFrom: {'Fran' -> 2}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test17APlayerPlaysTheGameAndCompletesTheAmountOfLapsRequiredMakingHimTheWinnerAndIsPositionedOnTheFirstSquare [
	
	| aBoard laps aGame playerPositions playerLaps |
	
	laps := 1. 
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(10 8 6 3) #(10 8 6 3)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test18PlayersPlayTheGameOneWinsAndTheRestFinishWithDifferentLapsDone [
	
	| aBoard laps aGame playerPositions playerLaps |
	
	laps := 2.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWith: #(#(3 11 20) #(3 11 20)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Martu'->3 . 'Mango'->1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0 . 'Martu' -> 1 . 'Mango' -> 2}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test19AGameIsPlayedByASinglePlayerWhoWinsAndFinishesOnFirstPlaceInTheRanking [
	
	| aBoard laps aGame playerPositions nameRanking |
	
	laps := 1. 
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(10 8 6 3) #(10 8 6 3)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	nameRanking := #('Fran').
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking. 
]

{ #category : #tests }
GameTest >> test20AGameIsPlayedByThreePlayersAndWhenTheGameFinishesTheFinalRankingIsCalculated [
	
	| aBoard laps aGame playerPositions nameRanking |
	
	laps := 2.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWith: #(#(3 11 20) #(3 11 20)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Martu'->3 . 'Mango'->1}.
	nameRanking := #('Mango' 'Martu' 'Fran').
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking.
]

{ #category : #tests }
GameTest >> test21RankingForMultiplePlayersWithTwoOfThemWithSameAmountOfLapsAndSamePosition [
	
	| aBoard laps aGame playerPositions nameRanking |
	
	laps := 2.
	self generatePlayerCollectionWith: #('Fran' 'Oscar' 'Martu' 'Mango').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Oscar'->3 . 'Martu'->3 . 'Mango'->1}.
	nameRanking := #('Mango' 'Martu' 'Oscar' 'Fran').
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking.
]

{ #category : #tests }
GameTest >> test22APlayerLandsOnASquareWithNoEffectAndItsPositionDoesntChange [
	
	| aBoard laps aGame playerPositions |
	
	laps := 2.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	aBoard := Board containing: 20withEffect: NoEffect new.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 }.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test23APlayerLandsOnASquareWithSpeedUpEffectAndItsPositionIncreasesByFour [
	
	| aBoard laps aGame playerPositions |
	
	laps := 2.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	aBoard := Board containing: 20 withEffect: SpeedUpEffect new.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test24APlayerLandsOnASquareWithAtomicBombffectAndAllPlayersAreMovedToTheFirstSquareWithoutModifyingTheirLaps [
	
	| aBoard laps aGame playerPositions playerLaps |
	
	laps := 2.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(12) #(12)).
	aBoard := Board containing: 20 withEffect: AtomicBombEffect new.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test25APlayerLandsOnASquareWithAtomicBombffectAndItsPositionTheFirstSquare [
	
	| aBoard laps aGame playerPositions playerLaps |
	
	laps := 3.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWith: #(#(3 11 21) #(3 11 21 )).
	aBoard := Board containing: 20 withEffect: AtomicBombEffect new.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1.'Martu' -> 1.'Mango' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0.'Martu' -> 0.'Mango' -> 0}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1.'Martu' -> 1.'Mango' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0.'Martu' -> 1.'Mango' -> 0}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1.'Martu' -> 1.'Mango' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0.'Martu' -> 1.'Mango' -> 2}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test26APlayerLandsOnASquareWithWormHoleEffectAndItsPositionDecreasesByFour [
	
	| aBoard laps aGame playerPositions |
	
	laps := 2.
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	aBoard := Board containing: 20 withEffect: WormHoleEffect new.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->3}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test27MoreThanOnePlayerLandsOnASquareWithSpeedUpEffectAndTheirPositionsAreIncreasedByFour [
	
	| aBoard laps aGame playerPositions playerLaps |
	
	laps := 2.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(3 11 15) #(3 11 15)).
	aBoard := Board containing: 20 withEffect: SpeedUpEffect new.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11 . 'Martu'->7 . 'Maia'->15}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' ->0 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test28MoreThanOnePlayerLandsOnASquareWithSpeedUpEffectTheirPositionsAreIncreasedByFourAndOneOfThemWonBecauseItFinishedTheAmoutOflapsRequired [
	
	| aBoard laps aGame playerPositions playerLaps nameRanking |
	
	laps := 1.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(3 7 9) #(3 7 9)).
	aBoard := Board containing: 20 withEffect: SpeedUpEffect new.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11 . 'Martu'->19 . 'Maia'->3}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' ->0 . 'Martu'->0 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
	nameRanking := #('Maia' 'Martu' 'Fran').
	self assert: aGame playerRanking equals: nameRanking.
	self assert: aGame winner equals:(players at: 3).
]

{ #category : #tests }
GameTest >> test29MoreThanOnePlayerLandsOnASquareWithWormHoleEffectAndTheirPositionsAreDecreasedByFour [
	
	| aBoard laps aGame playerPositions playerLaps |
	
	laps := 2.
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(1 11 15) #(1 11 15)).
	aBoard := Board containing: 20 withEffect: WormHoleEffect new.
	aGame := GameMandM playedOn: aBoard by: players using: diceCup requiring: laps.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->19 . 'Maia'->7}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' -> 0 . 'Martu'->0 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #iteration }
GameTest >> throwDiceCupTimes: anInteger inGame: aGame [
anInteger timesRepeat: [ aGame nextPlayerThrows ].
]
