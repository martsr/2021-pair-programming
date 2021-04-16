Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'gamePlayers',
		'gameBoard',
		'gameDiceCup',
		'gameInProgress',
		'gameTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> validatesAGameDoesntHavePlayersWithSameName: players [
	| playerNames |
	playerNames := players collect: [ :player | player name ].
	playerNames := playerNames asSet.
	(players size) > (playerNames size) ifTrue: [ Error signal: 'A game cannot be created with any players having repeated names' ].
]

{ #category : #'instance creation' }
Game class >> validatesAGameMustHaveAtLeastOnePlayer: aPlayer [
	aPlayer size < 1
		ifTrue: [ Error signal: 'A game must have at least 1 player' ]
]

{ #category : #'instance creation' }
Game class >> withBoard: aBoard withPlayers: players withDice: aDiceCup [
	self validatesAGameMustHaveAtLeastOnePlayer: players.
	self validatesAGameDoesntHavePlayersWithSameName: players.
	^ self new intializeWithBoard: aBoard withPlayers: players withDice: aDiceCup
]

{ #category : #'as yet unclassified' }
Game >> gameWinner [
	self verifyGameStillInProgress.
	^ gameBoard playerAtFinalSquare
]

{ #category : #initialization }
Game >> intializeWithBoard: aBoard withPlayers: players withDice: aDiceCup [ 
	gameBoard:= aBoard.
	gamePlayers:= players. 
	gameDiceCup:= aDiceCup.
	gameInProgress := true.
	gameTurn:= 1.
	gameBoard setUpWith: gamePlayers.
]

{ #category : #'as yet unclassified' }
Game >> isNotifiedPlayerInLastSquare [
	gameInProgress := false.
]

{ #category : #'as yet unclassified' }
Game >> nextPlayerThrows [
	| resultOfThrow player |
	self verifyGameHasFinished.
	player := gamePlayers at: gameTurn.
	resultOfThrow := player throwsWith: gameDiceCup.
	gameBoard move: player squares: resultOfThrow inGame: self.
	self verifyNextPlayerNeedsToThrow.
	
]

{ #category : #'as yet unclassified' }
Game >> playerPositions [
	| numberPositions playerPositions |
	numberPositions := gameBoard finalPositionsOf: gamePlayers.
	playerPositions := Dictionary new.
	(1 to: numberPositions size) do: [ :index | playerPositions at: ((gamePlayers at: index) name) put: (numberPositions at: index) ].
	^playerPositions.
]

{ #category : #'as yet unclassified' }
Game >> verifyGameHasFinished [
	gameInProgress
		ifFalse: [ Error signal: 'The game has finished, dice cannot be rolled anymore' ]
]

{ #category : #'as yet unclassified' }
Game >> verifyGameStillInProgress [
	gameInProgress
		ifTrue: [ Error
				signal: 'A winner cannot be determined, the game is still in progress' ]
]

{ #category : #'as yet unclassified' }
Game >> verifyNextPlayerNeedsToThrow [
	gameInProgress
		ifTrue: [ gameTurn := (gameTurn rem: (gamePlayers size )) + 1 ]
]
