Class {
	#name : #GameMandM,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'isFinished',
		'turn',
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameMandM class >> playedOn: aBoard by: players using: aDiceCup [
	self validatesItMustHaveAtLeastOnePlayer: players.
	self validatesItDoesntHavePlayersWithSameName: players.
	^ self new intializePlayedOn: aBoard by: players using: aDiceCup
]

{ #category : #validation }
GameMandM class >> validatesItDoesntHavePlayersWithSameName: players [

	| playerNames |
	
	playerNames := players collect: [ :player | player name ].
	playerNames := playerNames asSet.
	(players size) > (playerNames size) ifTrue: [ Error signal: 'A game cannot be created with any players having repeated names' ]
]

{ #category : #validation }
GameMandM class >> validatesItMustHaveAtLeastOnePlayer: aPlayer [
	aPlayer size < 1
		ifTrue: [ Error signal: 'A game must have at least 1 player' ]
]

{ #category : #initialization }
GameMandM >> intializePlayedOn: aBoard by: participants using: aDiceCup [

	board := aBoard.
	players := participants.
	diceCup := aDiceCup.
	isFinished := false.
	turn := 1.
	board setUpWith: players
]

{ #category : #notification }
GameMandM >> isNotifiedPlayerInLastSquare [
	isFinished := true.
]

{ #category : #action }
GameMandM >> nextPlayerThrows [

	| resultOfThrow player |
	
	self verifyItisFinished.
	player := players at: turn.
	resultOfThrow := player throwsWith: diceCup.
	board move: player by: resultOfThrow in: self.
	self verifyNextPlayerNeedsToThrow.
	
]

{ #category : #accesing }
GameMandM >> playerPositions [

	| numberPositions playerPositions |
	
	numberPositions := board finalPositionsOf: players.
	playerPositions := Dictionary new.
	1 to: numberPositions size do: [ :position | playerPositions at: ((players at: position) name) put: (numberPositions at: position) ].
	^playerPositions.
]

{ #category : #private }
GameMandM >> verifyItIsInProgress [
	isFinished ifFalse: [ Error signal: 'A winner cannot be determined, the game is still in progress' ]
]

{ #category : #private }
GameMandM >> verifyItisFinished [
	isFinished ifTrue: [ Error signal: 'The game has finished, dice cannot be rolled anymore' ]
]

{ #category : #private }
GameMandM >> verifyNextPlayerNeedsToThrow [
	isFinished ifFalse: [ turn := (turn rem: (players size )) + 1 ]
]

{ #category : #accesing }
GameMandM >> winner [
	self verifyItIsInProgress.
	^ board playerAtFinalSquare
]
