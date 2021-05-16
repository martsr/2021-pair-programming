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

{ #category : #generators }
GameTest >> generateDeterministicDiceCupWith: sequences [

	| dice |
	
	dice := OrderedCollection new.
	dice := sequences  collect: [ :sequence | DeterministicDie having: sequence ].
	diceCup := DiceCup containing: dice.
	
]

{ #category : #generators }
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
	
	| aBoard aGame playerPositions effects |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 40 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test02APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceAndLandsOnSquare11 [
	
	| aBoard aGame playerPositions  effects |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test03APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceFourTimesExceedsTheBoardSizeAndItWon [
	
	| aBoard aGame playerPositions playerLaps effects |
	

	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 40 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 4 inGame: aGame.
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
	
	| aBoard aGame playerPositions  effects |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 40 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {('Fran' -> 5)}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame winner equals: ((players at: 1)name).
]

{ #category : #tests }
GameTest >> test05APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceOneTimeButTheGameCannotDetermineTheWinnerBecauseTheGameIsInProgress [
	
	| aBoard aGame playerPositions  effects |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 40 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11}.
	self assert: (aGame playerPositions) equals: playerPositions.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test06APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceFourTimesWinningTheGameAndNowTheGameCanInformThePlayerFinalPosition [
	
	| aBoard aGame playerPositions effects |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 40 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 5}.
	self assert: (aGame playerPositions) equals: playerPositions. 
	self assert: aGame winner equals: ((players at: 1) name).
]

{ #category : #tests }
GameTest >> test07ThreePlayersThrowTheDiceCupOfTheGameAndAllLandOnSquareSeven [

	| aBoard aGame playerPositions  effects |
	
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(5 8 6 3) #(5 8 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 40 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11 . 'Martu' -> 17 . 'Maia' -> 13}.
	self assert: (aGame playerPositions ) equals: playerPositions .
]

{ #category : #tests }
GameTest >> test08ThreePlayersPlayTheGameAndPlayerOneWins [

	| aBoard aGame  effects |
	 
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(5 1 1) #(5 1 1)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 4 inGame: aGame.
	self assert: (aGame winner) equals: (players at: 1) name. 

]

{ #category : #tests }
GameTest >> test09AGameIsPlayedByThreePlayersAndTheThirdPlayerFinishesOnTheLastSquareAndTheRemainingOnesFourSquaresBehind [

	|  aBoard aGame playerPositions  effects |
	
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWith: #(#(4 4 5 ) #(4 4 5)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 6 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 17 . 'Mango' -> 17 . 'Maia' -> 1}.
	self assert: aGame winner equals:(players at: 3) name .
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test10AGameIsPlayedAndTheDiceCupCannotBeThrownAfterTheGameHasFinished [
	
	| aBoard aGame effects |
	
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWith: #(#(4 4 5) #(4 4 5)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 6 inGame: aGame.
	self
		should: [ aGame nextTurn  ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'. 
]

{ #category : #tests }
GameTest >> test11AGameIsInProgressAndTheWinnerCannotBeDeterminedBecauseTheGameIsStillInProgress [
	
	| aBoard aGame effects |
	
	self generatePlayerCollectionWith: #('Fran' 'Mango' 'Maia').
	self generateDeterministicDiceCupWith: #(#(4 4 4) #(4 4 4)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 3 inGame: aGame.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test12APlayerPlaysTheGameAndCompletesTwoLapsOfTheThreeLapsRequiredToWin [
	
	| aBoard aGame playerPositions playerLaps effects |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(10 11 6 3) #(10 11 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 3 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 2 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 3}.
	playerLaps := Dictionary newFrom: {'Fran' -> 2}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test13APlayerPlaysTheGameAndCompletesTheAmountOfLapsRequiredMakingHimTheWinnerAndIsPositionedOnTheFirstSquare [
	
	| aBoard aGame playerPositions playerLaps effects |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(10 8 6 3) #(10 8 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test14PlayersPlayTheGameOneWinsAndTheRestFinishWithDifferentLapsDone [
	
	| aBoard aGame playerPositions playerLaps effects |
	
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWith: #(#(3 11 20) #(3 11 20)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 2 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Martu'->3 . 'Mango'->1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 0 . 'Martu' -> 1 . 'Mango' -> 2}.
	self assert: aGame playerLaps equals: playerLaps.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test15AGameIsPlayedByASinglePlayerWhoWinsAndFinishesOnFirstPlaceInTheRanking [
	
	| aBoard aGame playerPositions nameRanking effects |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(10 8 6 3) #(10 8 6 3)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	nameRanking := #('Fran').
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking. 
]

{ #category : #tests }
GameTest >> test16AGameIsPlayedByThreePlayersAndWhenTheGameFinishesTheFinalRankingIsCalculated [
	
	| aBoard aGame playerPositions nameRanking effects |
	
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWith: #(#(3 11 20) #(3 11 20)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 2 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Martu'->3 . 'Mango'->1}.
	nameRanking := #('Mango' 'Martu' 'Fran').
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking.
]

{ #category : #tests }
GameTest >> test17RankingForMultiplePlayersWithTwoOfThemWithSameAmountOfLapsAndSamePosition [
	
	| aBoard aGame playerPositions nameRanking effects |
	
	self generatePlayerCollectionWith: #('Fran' 'Oscar' 'Martu' 'Mango').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 2 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 . 'Oscar'->3 . 'Martu'->3 . 'Mango'->1}.
	nameRanking := #('Mango' 'Martu' 'Oscar' 'Fran').
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerRanking equals: nameRanking.
]

{ #category : #tests }
GameTest >> test18APlayerLandsOnASquareWithNoEffectAndItsPositionDoesntChange [
	
	| effects aBoard aGame playerPositions |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	effects := Dictionary newFrom: { NoEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 2 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->7 }.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test19PlayerLandsOnASquareWithSpeedUpEffectAndItsPositionIncreasesByFour [
	
	| effects aBoard aGame playerPositions |
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	effects := Dictionary newFrom: { SpeedUpEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 2 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test20APlayerLandsOnASquareWithAtomicBombffectAndAllPlayersAreMovedToTheFirstSquareWithoutModifyingTheirLaps [

	| effects aBoard aGame playerPositions playerLaps |
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(12) #(12)).
	effects := Dictionary newFrom: { AtomicBombEffect  -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 2 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	playerLaps := Dictionary newFrom: {'Fran' -> 1}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test21APlayerLandsOnASquareWithAtomicBombffectAndItsPositionTheFirstSquare [
	
	| effects aBoard aGame playerPositions playerLaps |
	
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Mango').
	self generateDeterministicDiceCupWith: #(#(3 11 21) #(3 11 21 )).
	effects := Dictionary newFrom: { AtomicBombEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 3 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
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
GameTest >> test22APlayerLandsOnASquareWithWormHoleEffectAndItsPositionDecreasesByFour [
	
	| aBoard aGame playerPositions effects|
	
	self generatePlayerCollectionWith: #('Fran').
	self generateDeterministicDiceCupWith: #(#(3 11 11 20) #(3 11 11 20)).
	effects := Dictionary newFrom: { WormHoleEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->3}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test23MoreThanOnePlayerLandsOnASquareWithSpeedUpEffectAndTheirPositionsAreIncreasedByFour [
	
	| effects aBoard aGame playerPositions playerLaps |
	
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(3 11 15) #(3 11 15)).
	effects := Dictionary newFrom: { SpeedUpEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 2 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11 . 'Martu'->7 . 'Maia'->15}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' ->0 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test24MoreThanOnePlayerLandsOnASquareWithSpeedUpEffectTheirPositionsAreIncreasedByFourAndOneOfThemWonBecauseItFinishedTheAmoutOflapsRequired [
	
	| effects aBoard aGame playerPositions playerLaps nameRanking |
	
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(3 7 9) #(3 7 9)).
	effects := Dictionary newFrom: { SpeedUpEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->11 . 'Martu'->19 . 'Maia'->3}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' ->0 . 'Martu'->0 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
	nameRanking := #('Maia' 'Martu' 'Fran').
	self assert: aGame playerRanking equals: nameRanking.
	self assert: aGame winner equals: ((players at: 3) name).
]

{ #category : #tests }
GameTest >> test25MoreThanOnePlayerLandsOnASquareWithWormHoleEffectAndTheirPositionsAreDecreasedByFour [
	
	| effects aBoard aGame playerPositions playerLaps |
	
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(1 11 15) #(1 11 15)).
	effects := Dictionary newFrom: { WormHoleEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 20 requiringLaps: 2 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->1 . 'Martu'->19 . 'Maia'->7}.
	self assert: aGame playerPositions equals: playerPositions.
	playerLaps := Dictionary newFrom: {'Fran' -> 0 . 'Martu'->0 . 'Maia'->1}.
	self assert: aGame playerLaps equals: playerLaps.
]

{ #category : #tests }
GameTest >> test26MoreThanOnePlayerLandsOnASquareWithMoonWalkEffectAndAllPlayersReturnARandomNumberOfspacesBetweenOneandHalfTheBoardSize [
	
	| aBoard aGame playerPositions effects |
	
	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Maia').
	self generateDeterministicDiceCupWith: #(#(4 3 1) #(4 3 1)).
	effects := Dictionary newFrom: { MoonWalkEffect -> 1 }.
	aBoard := RandomBoardGenerator ofSize: 10 requiringLaps: 1 playedBy: players using: diceCup usingEffects: effects.
	aGame := GameMandM playedOn: aBoard.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' ->9 . 'Martu'->1 . 'Maia'->1}.
	self assert: aGame playerPositions equals: playerPositions.
	playerPositions := aGame playerPositions.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := aGame playerPositions.
	self assert: ((playerPositions  at: ((players at: 1) name)) between: 1 and: 8). 
	self assert: (playerPositions  at: ((players at: 2) name)) equals: 7.
	self assert: (playerPositions  at: ((players at: 3) name)) equals: 1.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := aGame playerPositions.
	self assert: ((playerPositions  at: ((players at: 1) name)) between: 1 and: 7). 
	self assert: ((playerPositions  at: ((players at: 2) name)) between: 1 and: 6).
	self assert: (playerPositions  at: ((players at: 3) name)) equals: 3.
]

{ #category : #iteration }
GameTest >> throwDiceCupTimes: anInteger inGame: aGame [
	anInteger timesRepeat: [ aGame nextTurn ].
]
