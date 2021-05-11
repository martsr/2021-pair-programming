Class {
	#name : #GameMandM,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'isFinished',
		'turn',
		'players',
		'laps',
		'playersAbsolutePositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameMandM class >> playedOn: aBoard [ 
	^self new initializePlayedOn: aBoard.
]

{ #category : #'instance creation' }
GameMandM class >> playedOn: aBoard by: players using: aDiceCup requiring: amountOfLaps [
	self validatesItMustHaveAtLeastOnePlayer: players.
	self validatesItDoesntHavePlayersWithSameName: players.
	self validatesItNeedsAtLeastOneLap: amountOfLaps.
	^ self new intializePlayedOn: aBoard by: players using: aDiceCup requiring: amountOfLaps
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

{ #category : #'instance creation' }
GameMandM class >> validatesItNeedsAtLeastOneLap: amountOfLaps [
	amountOfLaps < 1
		ifTrue: [ Error signal: 'A game requires at least one lap to be playable.' ]
]

{ #category : #accessing }
GameMandM >> board [
 ^ board. 
]

{ #category : #initialization }
GameMandM >> initializePlayedOn: aBoard [
 	board:= aBoard. 
	isFinished := false.
]

{ #category : #initialization }
GameMandM >> intializePlayedOn: aBoard by: participants using: aDiceCup requiring: amountOfLaps [
	
	board := aBoard.
	players := participants.
	diceCup := aDiceCup.
	isFinished := false.
	turn := 1.
	laps := amountOfLaps.
	playersAbsolutePositions := OrderedCollection new.
	1 to: players size do: [ :position | playersAbsolutePositions add: 1 ].
	board setUpWith: players on: self.
]

{ #category : #action }
GameMandM >> isNotified: aPlayer movedTo: newPlayerPosition [
	
	| playerIndex |
	
	playerIndex := players indexOf: aPlayer.
	playersAbsolutePositions at: playerIndex put: newPlayerPosition.
]

{ #category : #testing }
GameMandM >> isNotifiedItHasFinished [ 
	isFinished := true. 
]

{ #category : #action }
GameMandM >> nextPlayerThrows [

	| resultOfThrow player playerIndex |
	
	self verifyItisFinished.
	"Desde aca."
	player := players at: turn.
   playerIndex := players indexOf: player.
	resultOfThrow := player throwsWith: diceCup.
	"Las 3 lineas de arriba se van y esto se reemplaza con nextTurn y abajo de este comentario tiene que ir board nextPlayerThrows"
	board move: player by: resultOfThrow in: self with: playerIndex.
	self verifyNextPlayerNeedsToThrow.
	
]

{ #category : #'as yet unclassified' }
GameMandM >> nextTurn [
	
	self verifyItisFinished.
	board nextPlayerThrowsIn: self.

	
]

{ #category : #'as yet unclassified' }
GameMandM >> playerAbsolutePositions [

	^ playersAbsolutePositions copy.
]

{ #category : #testing }
GameMandM >> playerLaps [
	| playerLaps |
	playerLaps := board playerLaps.
	^ playerLaps.
]

{ #category : #accesing }
GameMandM >> playerPositions [
	 
	| playerPositions |
	playerPositions := board playerPositions .
	^playerPositions.
]

{ #category : #testing }
GameMandM >> playerRanking [

	| playerRanking |
	playerRanking := board playerRanking.
	^ playerRanking.
]

{ #category : #accessing }
GameMandM >> players [
 ^ players copy. 
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
	"Este mensaje se va porque los turnos los maneja el board de ahora en mas. El board envia un mensaje de notificacion al game en el momento que la posicion absoluta de un jugador exceda o iguale la maxima posible. 81 en board 20 laps 4"
	(playersAbsolutePositions at: turn) > (board boardSquares * laps) ifTrue: [ isFinished := true ] ifFalse: [ turn := (turn rem: (players size )) + 1 ].
]

{ #category : #accesing }
GameMandM >> winner [
	| winner playerRanking |
	
	"Esto no va a estar mas en el game, se va a poder preguntar al board que le va a preguntar al tracker quien gano"
	
	self verifyItIsInProgress.
	playerRanking := board playerRanking. 
	winner:= playerRanking at: 1.
	^ winner
]
