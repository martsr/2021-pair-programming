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
GameTest >> test01ADieWithTwentyFacesRollsANumberBetweenOneAndTwenty [
	
	| aDie |
	
	aDie := Die with: 20.
	self assert: (aDie throw between: 1 and: 20)
]

{ #category : #tests }
GameTest >> test02ADieCannotHaveLessThanFourFaces [

	self
		should: [ Die with: 3 ]
		raise: Error
		withMessage: 'Die faces cannot be less than 4'
]

{ #category : #tests }
GameTest >> test03DiceCupsContainsANumberOfDice [
	
	| aDie aSecondDie dice aDiceCup |
	
	aDie := Die with: 5.
	aSecondDie := Die with: 14.
	dice := {aDie . aSecondDie}.
	aDiceCup := DiceCup contains: dice.
	self assert: aDiceCup amountOfDice equals: 2.
]

{ #category : #tests }
GameTest >> test04DiceCupWithATwentyFaceDieaAndASixFaceDieRollsANumberBetweenTwoAndTwentySix [
	
	| aDie aSecondDie dice aDiceCup |
	
	aDie := Die with: 6.
	aSecondDie := Die with: 20.
	dice := {aDie . aSecondDie}.
	aDiceCup := DiceCup contains: dice.
	self assert: (aDiceCup throw between: 2 and: 26).
]

{ #category : #tests }
GameTest >> test05DiceCupWithASingleSixFacedDieRollsANumberBetween1and6 [
	
	| aDie   aDiceCup |
	
	aDie := Die with: 6.
	aDiceCup := DiceCup containsSingle: aDie.
	self assert: (aDiceCup throw between: 1 and: 6).
]

{ #category : #tests }
GameTest >> test06DiceCupsMustContainAtLeastOneDie [
	
	| dice |
	
	dice := { }.
	
	self
		should: [ DiceCup contains: dice ]
		raise: Error
		withMessage: 'Dice cups must contain at least a die'.
		
]

{ #category : #tests }
GameTest >> test07ABoardSquareHasAValidPositionAssigned [
	
	| aBoardSquare |
	
	aBoardSquare := BoardSquare numbered: 1.
	self assert:(aBoardSquare squareNumber) equals: 1.
]

{ #category : #tests }
GameTest >> test08ABoardSquareMustBeAssignedAValueGreaterThanZero [
	
	self
		should: [ BoardSquare numbered: 0 ]
		raise: Error
		withMessage: 'A board square must be assigned a value greater than zero'.
]

{ #category : #tests }
GameTest >> test09ABoardCreatedWithTwentySquareBoardsHasTwentySquareBoards [
	
	| aBoard |
	
	aBoard := Board containing: 20.
	self assert: (aBoard boardSquares) equals: 20.
]

{ #category : #tests }
GameTest >> test10ABoardMustContainAtLeast1SquareBoard [
	
	self
		should: [ Board containing: 0 ]
		raise: Error
		withMessage: 'A board must contain at least 2 square board'.
]

{ #category : #tests }
GameTest >> test11PlayerNameShouldContainAtLeastOneCharacter [
	
	self
		should: [ Player named: '']
		raise: Error
		withMessage: 'Player name must at least contain one letter'.
]

{ #category : #tests }
GameTest >> test12ANFacedDeterministicDieAlwaysLandsOnNOver2IfTheFacesNumIsEvenOrNMinus1Over2IfFaceNumIsOdd [
	
	| aDetDie aSecondDetDie aThirdDetDie |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 12.
	aThirdDetDie := DeterministicDie with: 5.
	self assert: aDetDie throw equals: 3.
	self assert: aSecondDetDie throw equals: 6.
	self assert: aThirdDetDie throw equals: 2
]

{ #category : #tests }
GameTest >> test13ADeterministicDieCannotHaveLessThanFourFaces [

	self
		should: [ DeterministicDie  with: 3 ]
		raise: Error
		withMessage: 'A Deterministic Die  cannot have less than 4 faces'
]

{ #category : #tests }
GameTest >> test14APlayerThrowsADeterministicDieCupWithTwoSixFacedDiceAndTheResultIsSix [
	
	| player aDetDie aSecondDetDie aDiceCup |
	
	player := Player named: 'Fran'.
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	aDiceCup := DiceCup contains: {aDetDie.aSecondDetDie}.
	self assert: (player throwsWith: aDiceCup) equals: 6
]

{ #category : #tests }
GameTest >> test15AtTheStartOfTheGameAllPlayersArePlacedOnTheFirstBoardSquare [
	
	| aDetDie aSecondDetDie player aBoard aGame aDiceCup playerPositions player2 |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	player := Player named: 'Fran'.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: {player} withDice: aDiceCup.
	playerPositions := Dictionary newFrom: {'Fran' -> 1}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test16APlayerThrowsTheDeterministicDiceCupWithTwoSixFacedDiceAndLandsOnSquare7 [
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	player := Player named: 'Fran'.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: {player} withDice: aDiceCup.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 7}.
	self assert: (aGame playerPositions) equals: playerPositions.
]

{ #category : #tests }
GameTest >> test17APlayerThrowsTheDeterministicDiceCupWithTwoSixFacedDiceFourTimesExceedsTheBoardSizeButIsPlacedOnTheLastSquare [
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	player := Player named: 'Fran'.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: {player} withDice: aDiceCup.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 20}.
	self assert: (aGame playerPositions) equals: playerPositions.
	self
		should: [ aGame nextPlayerThrows ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'.
]

{ #category : #tests }
GameTest >> test18AGameWithABoardAndADiceCupShouldHaveAtLeastOnePayer [
	
	| aDetDie aSecondDetDie aDiceCup aBoard player |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	player := {}.	
	self
		should: [ Game withBoard: aBoard withPlayers: player withDice: aDiceCup ]
		raise: Error
		withMessage: 'A game must have at least 1 player'.
]

{ #category : #tests }
GameTest >> test19APlayerThrowsTheDeterministicDiceCupWithTwoSixFacedDiceFourTimesWinningTheGameAndNowTheGameCanInformThatPlayerIsTheWinner [
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	player := Player named: 'Fran'.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: {player} withDice: aDiceCup.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 20}.
	self assert: (aGame playerPositions) equals: playerPositions.
	self assert: (aGame gameWinner) equals: player. 
]

{ #category : #tests }
GameTest >> test20APlayerThrowsTheDeterministicDiceCupWithTwoSixFacedDiceOneTimeButTheGameCannotDetermineTheWinnerBecauseTheGameIsInProgress [
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	player := Player named: 'Fran'.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: {player} withDice: aDiceCup.
	self throwDiceCupTimes: 1 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 7}.
	self assert: (aGame playerPositions) equals: playerPositions.
	self
		should: [ aGame gameWinner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test21APlayerThrowsTheDeterministicDiceCupWithTwoSixFacedDiceFourTimesWinningTheGameAndNowTheGameCanInformThePlayerFinalPosition [
	
	| aDetDie aSecondDetDie player aDiceCup aBoard aGame playerPositions |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	player := Player named: 'Fran'.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: {player} withDice: aDiceCup.
	self throwDiceCupTimes: 4 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 20}.
	self assert: (aBoard whereIsPlayer: player) equals: 20.
	self assert: (aGame playerPositions) equals: playerPositions. 
]

{ #category : #tests }
GameTest >> test22ThreePlayersThrowTheDiceCupOfTheGameAndAllLandOnSquareSeven [

	| aDetDie aSecondDetDie playerOne playerTwo playerThree players aDiceCup aBoard aGame playerPositions |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Martu'.
	playerThree := Player named: 'Maia'.
	players := {playerOne. playerTwo. playerThree}.
	aDiceCup := DiceCup contains:{aDetDie.aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: players withDice: aDiceCup.
	self throwDiceCupTimes: 3 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 7 . 'Martu' -> 7 . 'Maia' -> 7}.
	self assert: (aGame playerPositions ) equals: playerPositions .
]

{ #category : #tests }
GameTest >> test23ThreePlayersPlayTheGameAndPlayerOneWins [

	| aDetDie aSecondDetDie playerOne playerTwo playerThree players aDiceCup aBoard aGame |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Martu'.
	playerThree := Player named: 'Maia'.
	players := {playerOne. playerTwo. playerThree}.
	aDiceCup := DiceCup contains:{aDetDie.aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: players withDice: aDiceCup.
	self throwDiceCupTimes: 10 inGame: aGame.
	self assert: (aGame gameWinner) equals: playerOne. 

]

{ #category : #tests }
GameTest >> test24AGameIsPlayedByThreePlayersAndTheFirstPlayerFinishesOnTheLastSquareAndTheRemainingOnesInOneSquareBehind [

	| aDetDie aSecondDetDie playerOne playerTwo playerThree players aDiceCup aBoard aGame playerPositions |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Mango'.
	playerThree := Player named: 'Maia'.
	players := {playerOne. playerTwo.playerThree}.
	aDiceCup := DiceCup contains:{aDetDie.aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: players withDice: aDiceCup.
	self throwDiceCupTimes: 10 inGame: aGame.
	playerPositions := Dictionary newFrom: {'Fran' -> 20 . 'Mango' -> 19 . 'Maia' -> 19}.
	self assert: aGame gameWinner equals: playerOne.
	self assert: aGame playerPositions equals: playerPositions.
]

{ #category : #tests }
GameTest >> test25AGameIsPlayedAndTheDiceCupCannotBeThrownAfterTheGameHasFinished [
	
	| aDetDie aSecondDetDie players aDiceCup aBoard aGame playerOne playerTwo playerThree |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Mango'.
	playerThree := Player named: 'Maia'.
	players := { playerOne . playerTwo . playerThree }.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: players withDice: aDiceCup.
	self throwDiceCupTimes: 10 inGame: aGame.
	self
		should: [ aGame nextPlayerThrows  ]
		raise: Error
		withMessage: 'The game has finished, dice cannot be rolled anymore'. 
]

{ #category : #tests }
GameTest >> test26AGameIsInProgressAndTheWinnerCannotBeDeterminedBecauseTheGameIsStillInProgress [
	
	| aDetDie aSecondDetDie players aDiceCup aBoard aGame playerOne playerTwo playerThree |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Mango'.
	playerThree := Player named: 'Maia'.
	players := { playerOne . playerTwo . playerThree }.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	aGame := Game withBoard: aBoard withPlayers: players withDice: aDiceCup.
	self throwDiceCupTimes: 9 inGame: aGame.
	self
		should: [ aGame gameWinner ]
		raise: Error
		withMessage: 'A winner cannot be determined, the game is still in progress'. 
]

{ #category : #tests }
GameTest >> test27AGameCannotBeCreatedIfAnyPlayerHasARepeatedName [
	
	| aDetDie aSecondDetDie players aDiceCup aBoard playerOne playerTwo playerThree playerFour playerFive |
	
	aDetDie := DeterministicDie with: 6.
	aSecondDetDie := DeterministicDie with: 6.
	playerOne := Player named: 'Fran'.
	playerTwo := Player named: 'Mango'.
	playerThree := Player named: 'Maia'.
	playerFour := Player named: 'Martu'.
	playerFive := Player named: 'Martu'.
	players := { playerOne . playerTwo . playerThree . playerFour . playerFive }.
	aDiceCup := DiceCup contains: {aDetDie . aSecondDetDie}.
	aBoard := Board containing: 20.
	self
		should: [ Game withBoard: aBoard withPlayers: players withDice: aDiceCup ]
		raise: Error
		withMessage: 'A game cannot be created with any players having repeated names'. 
]

{ #category : #iteration }
GameTest >> throwDiceCupTimes: anInteger inGame: aGame [
anInteger timesRepeat: [ aGame nextPlayerThrows ].
]
