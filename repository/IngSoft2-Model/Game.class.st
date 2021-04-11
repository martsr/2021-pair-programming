Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'gamePlayers',
		'gameBoard',
		'gameDiceCup'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> validatesAGameMustHaveAtLeastOnePlayer: aPlayer [
	aPlayer size < 1
		ifTrue: [ Error signal: 'A game must contain at least 1 player' ]
]

{ #category : #'instance creation' }
Game class >> withBoard: aBoard withPlayers: players withDice: aDiceCup [ 
^self new intializeWithBoard: aBoard withPlayers: players withDice: aDiceCup.
]

{ #category : #'instance creation' }
Game class >> withPlayers: players [
	self validatesAGameMustHaveAtLeastOnePlayer: players.
	^ self new initializeWith: players
]

{ #category : #initialization }
Game >> initializeWith: aPlayer [ 
	gamePlayers:= aPlayer.
]

{ #category : #initialization }
Game >> intializeWithBoard: aBoard withPlayers: players withDice: aDiceCup [ 
	gameBoard:= aBoard.
	gamePlayers:= players. 
	gameDiceCup:= aDiceCup.
	gameBoard setUpWith: gamePlayers.
]

{ #category : #'as yet unclassified' }
Game >> nextPlayerThrows [
	| resultOfThrow player|
	resultOfThrow:= gamePlayers first throwsWith: gameDiceCup.
	player:= gamePlayers first.
	gameBoard move: player squares: resultOfThrow.
	"Aca tengo que chequear si esta en la casilla final"
	
]

{ #category : #'as yet unclassified' }
Game >> withAmountOfPlayers [
	^gamePlayers size .
]
