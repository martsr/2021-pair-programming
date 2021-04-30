"
throwDiceCupTimes: anInteger inGame: aGame
anInteger timesRepeat: [ aGame nextPlayerThrows ].
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
	
	| aDetDie aSecondDetDie player aBoard aGame aDiceCup playerPositions laps |
	
	laps := 1.
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	player := Player named: 'Fran'.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: {player} using: aDiceCup requiring: laps.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test02APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceAndLandsOnSquare11 [
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions laps |
	
	laps := 1.
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	player := Player named: 'Fran'.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: {player} using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test03APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceFourTimesExceedsTheBoardSizeButIsPlacedOnTheLastSquare [
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions laps |
	
	laps := 1. 
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	player := Player named: 'Fran'.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: {player} using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 40}.
	self assert: (aGame playerPositions) equals: playerPositions.
	self
		should: [ aGame nextPlayerThrows ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'.
]

{ #category : #tests }
GameTest >> test04AGameWithABoardAndADiceCupShouldHaveAtLeastOnePayer [
	
	| aDetDie aSecondDetDie aDiceCup aBoard player laps |
	
	laps := 1.
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 40.
	player := {}.	
	self
		should: [ GameMandM playedOn: aBoard by: player using: aDiceCup requiring: laps ]
		raise: Error
		withMessage: 'A game must have at least 1 player'.
]

{ #category : #tests }
GameTest >> test05APlayerThrowsTheDeterministicDiceCupWWithTwoDiceWithTheSameSequenceFourTimesWinningTheGameAndNowTheGameCanInformThatPlayerIsTheWinner [
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions laps |
	
	laps := 1.
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	player := Player named: 'Fran'.
	aDiceCup := DiceCup containing: {aDetDie. aSecondDetDie}.
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: {player} using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {('Fran' -> 40)}.
	self assert: aGame playerPositions equals: playerPositions.
	self assert: aGame winner equals: player
]

{ #category : #tests }
GameTest >> test06APlayerThrowsTheDeterministicDiceCupWithTwoDiceWithTheSameSequenceOneTimeButTheGameCannotDetermineTheWinnerBecauseTheGameIsInProgress [
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions laps |
	
	laps := 1. 
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	player := Player named: 'Fran'.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: {player} using: aDiceCup requiring: laps.
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
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions laps |
	
	laps := 1.
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	player := Player named: 'Fran'.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: {player} using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 40}.
	self assert: (aBoard whereIsPlayer: player) equals: 40.
	self assert: (aGame playerPositions) equals: playerPositions. 
]

{ #category : #tests }
GameTest >> test08ThreePlayersThrowTheDiceCupOfTheGameAndAllLandOnSquareSeven [

	| aDetDie aSecondDetDie playerOne playerTwo playerThree players aDiceCup aBoard aGame playerPositions laps |
	
	laps := 1.
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Martu'.
	playerThree := Player named: 'Maia'.
	players := {playerOne. playerTwo. playerThree}.
	aDiceCup := DiceCup containing: {aDetDie.aSecondDetDie}.
	aBoard := Board containing: 40.
	aGame := GameMandM playedOn: aBoard by: players using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 11 . 'Martu' -> 17 . 'Maia' -> 13}.
	self assert: (aGame playerPositions ) equals: playerPositions .
]

{ #category : #tests }
GameTest >> test09ThreePlayersPlayTheGameAndPlayerOneWins [

	| aDetDie aSecondDetDie playerOne playerTwo playerThree players aDiceCup aBoard aGame laps |
	
	laps := 1. 
	aDetDie := DeterministicDie having: #(5 1 1).
	aSecondDetDie := DeterministicDie having: #(5 1 1).
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Martu'.
	playerThree := Player named: 'Maia'.
	players := {playerOne. playerTwo. playerThree}.
	aDiceCup := DiceCup containing: {aDetDie.aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 4 inGame: aGame.
	self assert: (aGame winner) equals: playerOne. 

]

{ #category : #tests }
GameTest >> test10AGameIsPlayedByThreePlayersAndTheThirdPlayerFinishesOnTheLastSquareAndTheRemainingOnesInThreeSquareBehind [

	| aDetDie aSecondDetDie playerOne playerTwo playerThree players aDiceCup aBoard aGame playerPositions laps |
	
	laps := 1.
	aDetDie := DeterministicDie having: #(4 4 5).
	aSecondDetDie := DeterministicDie having: #(4 4 5).
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Mango'.
	playerThree := Player named: 'Maia'.
	players := {playerOne. playerTwo.playerThree}.
	aDiceCup := DiceCup containing: {aDetDie.aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 6 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 17 . 'Mango' -> 17 . 'Maia' -> 20}.
	self assert: aGame winner equals: playerThree.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test11AGameIsPlayedAndTheDiceCupCannotBeThrownAfterTheGameHasFinished [
	
	| aDetDie aSecondDetDie players aDiceCup aBoard aGame playerOne playerTwo playerThree laps |
	
	laps := 1. 
	aDetDie := DeterministicDie having: #(4 4 5).
	aSecondDetDie := DeterministicDie having: #(4 4 5).
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Mango'.
	playerThree := Player named: 'Maia'.
	players := { playerOne . playerTwo . playerThree }.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 6 inGame: aGame.
	self
		should: [ aGame nextPlayerThrows  ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'. 
]

{ #category : #tests }
GameTest >> test12AGameIsInProgressAndTheWinnerCannotBeDeterminedBecauseTheGameIsStillInProgress [
	
	| aDetDie aSecondDetDie players aDiceCup aBoard aGame playerOne playerTwo playerThree laps |
	
	laps := 1.
	aDetDie := DeterministicDie having: #(4 4 4).
	aSecondDetDie := DeterministicDie having: #(4 4 4).
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Mango'.
	playerThree := Player named: 'Maia'.
	players := { playerOne . playerTwo . playerThree }.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 3 inGame: aGame.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test13AGameCannotBeCreatedIfAnyPlayerHasARepeatedName [
	
	| aDetDie aSecondDetDie players aDiceCup aBoard playerOne playerTwo playerThree playerFour playerFive laps |
	
	laps := 1. 
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Mango'.
	playerThree := Player named: 'Maia'.
	playerFour := Player named: 'Martu'.
	playerFive := Player named: 'Martu'.
	players := { playerOne . playerTwo . playerThree . playerFour . playerFive }.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	self
		should: [ GameMandM playedOn: aBoard by: players using: aDiceCup requiring: laps ]
		raise: Error
		withMessage: 'A game cannot be created with any players having repeated names'. 
]

{ #category : #tests }
GameTest >> test14NewlyCreatedGameReturnTheAmountOfLapsItsRequired [

		| aDetDie aSecondDetDie players aDiceCup aBoard playerOne playerTwo playerThree playerFour  laps aGame |
	
	laps := 1.
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Mango'.
	playerThree := Player named: 'Maia'.
	playerFour := Player named: 'Martu'.
	players := { playerOne . playerTwo . playerThree . playerFour }.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 40. 
	aGame := GameMandM playedOn: aBoard by: players using: aDiceCup requiring: laps.
	self assert: (aGame amountOfLaps ) equals: 1. 
]

{ #category : #tests }
GameTest >> test15VerifyLapsMustBeAtLeastOne [
	
	| aDetDie aSecondDetDie players aDiceCup aBoard playerOne  laps  |
	
	laps := 0. 
	aDetDie := DeterministicDie having: #(5 8 6 3).
	aSecondDetDie := DeterministicDie having: #(5 8 6 3).
	playerOne := Player named: 'Fran'.
	players := { playerOne  }.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	self
		should: [ GameMandM playedOn: aBoard by: players using: aDiceCup requiring: laps ]
		raise: Error
		withMessage: 'A game requires at least one lap to be playable.'. 
]

{ #category : #tests }
GameTest >> test16VerifyPlayerDoesFullLapAndLandSOnTheSameSquareItBegan [
	
	| aDetDie aSecondDetDie players aDiceCup aBoard playerOne  laps aGame playerPositions |
	
	laps := 1. 
	aDetDie := DeterministicDie having: #(10 8 6 3).
	aSecondDetDie := DeterministicDie having: #(10 8 6 3).
	playerOne := Player named: 'Fran'.
	players := { playerOne  }.
	aDiceCup := DiceCup containing: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := GameMandM playedOn: aBoard by: players using: aDiceCup requiring: laps.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 20}.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #iteration }
GameTest >> throwDiceCupTimes: anInteger inGame: aGame [
anInteger timesRepeat: [ aGame nextPlayerThrows ].
]
